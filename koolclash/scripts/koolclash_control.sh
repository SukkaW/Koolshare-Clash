#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval $(dbus export koolclash_)
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
lan_ip=$(uci get network.lan.ipaddr)

ONSTART=$(ps -l | grep $PPID | grep -v grep | grep "S99koolss")

get_lan_cidr() {
    netmask=$(uci get network.lan.netmask)
    # Assumes there's no "255." after a non-255 byte in the mask
    local x=${netmask##*255.}
    set -- 0^^^128^192^224^240^248^252^254^ $(((${#netmask} - ${#x}) * 2)) ${x%%.*}
    x=${1%%$3*}
    suffix=$(($2 + (${#x} / 4)))
    prefix=$(uci get network.lan.ipaddr | cut -d "." -f1,2,3)
    echo $prefix.0/$suffix
}

#--------------------------------------------------------------------------
restore_dnsmasq_conf() {
    # delete server setting in dnsmasq.conf
    #pc_delete "server=" "/etc/dnsmasq.conf"
    #pc_delete "all-servers" "/etc/dnsmasq.conf"
    #pc_delete "no-resolv" "/etc/dnsmasq.conf"
    #pc_delete "no-poll" "/etc/dnsmasq.conf"

    echo_date "删除 KoolClash 的 dnsmasq 配置..."
    rm -rf /tmp/dnsmasq.d/koolclash.conf
}

restore_start_file() {
    echo_date "删除 KoolClash 的防火墙配置"

    uci -q batch <<-EOT
	  delete firewall.ks_koolclash
	  commit firewall
	EOT
}

kill_process() {
    # 关闭 Clash 进程
    if [ -n "$(pidof clash)" ]; then
        echo_date "关闭 Clash 进程..."
        killall clash
    fi
}

create_dnsmasq_conf() {
    touch /tmp/dnsmasq.d/koolclash.conf
    echo_date "修改 dnsmasq 配置使 dnsmasq 将所有的 DNS 请求转发给 Clash"
    echo "no-resolv" >>/tmp/dnsmasq.d/koolclash.conf
    echo "server=127.0.0.1#23453" >>/tmp/dnsmasq.d/koolclash.conf
    echo "cache-size=0" >>/tmp/dnsmasq.d/koolclash.conf
}

restart_dnsmasq() {
    # Restart dnsmasq
    echo_date "重启 dnsmasq"
    /etc/init.d/dnsmasq restart >/dev/null 2>&1
}

#--------------------------------------------------------------------------------------
auto_start() {
    # nat start
    echo_date "添加 KoolClash 防火墙规则"
    uci -q batch <<-EOT
	  delete firewall.ks_koolclash
	  set firewall.ks_koolclash=include
	  set firewall.ks_koolclash.type=script
	  set firewall.ks_koolclash.path=/koolshare/scripts/koolclash_control.sh
	  set firewall.ks_koolclash.family=any
	  set firewall.ks_koolclash.reload=1
	  commit firewall
	EOT

    if [ -L "/etc/rc.d/S99koolclash.sh" ]; then
        rm -rf /etc/rc.d/S99koolclash.sh
    fi
    ln -sf $KSROOT/init.d/S99koolclash.sh /etc/rc.d/S99koolclash.sh
}

#--------------------------------------------------------------------------------------
start_clash_process() {
    echo_date "启动 Clash"
    start-stop-daemon -S -q -b -m \
        -p /tmp/run/koolclash.pid \
        -x /koolshare/bin/clash \
        -- -d $KSROOT/koolclash/config/
}

#--------------------------------------------------------------------------
flush_nat() {
    echo_date "删除 KoolClash 添加的 iptables 规则"

    iptables -t nat -D PREROUTING -p tcp -j koolclash >/dev/null 2>&1
    iptables -t mangle -D PREROUTING -p tcp -j koolclash >/dev/null 2>&1

    nat_indexs=$(iptables -nvL PREROUTING -t nat | sed 1,2d | sed -n '/clash/=' | sort -r)
    for nat_index in $nat_indexs; do
        iptables -t nat -D PREROUTING $nat_index >/dev/null 2>&1
    done

    mangle_indexs=$(iptables -nvL PREROUTING -t mangle | sed 1,2d | sed -n '/clash/=' | sort -r)
    for mangle_index in $mangle_indexs; do
        iptables -t mangle -D PREROUTING $mangle_index >/dev/null 2>&1
    done

    # flush iptables rules
    iptables -t nat -F koolclash >/dev/null 2>&1 && iptables -t nat -X koolclash >/dev/null 2>&1
    iptables -t mangle -F koolclash >/dev/null 2>&1 && iptables -t mangle -X koolclash >/dev/null 2>&1

    echo_date "停用 Chromecast（劫持 DNS）功能"
    # flush chromecast
    chromecast_nu=$(iptables -t nat -L PREROUTING -v -n --line-numbers | grep "dpt:53" | awk '{print $1}')
    iptables -t nat -D PREROUTING $chromecast_nu >/dev/null 2>&1

    #flush_ipset
    echo_date "删除 KoolClash 添加的 ipsets 名单"
    ipset -F koolclash_white >/dev/null 2>&1 && ipset -X koolclash_white >/dev/null 2>&1
    #ipset -F koolclash_black >/dev/null 2>&1 && ipset -X koolclash_black >/dev/null 2>&1
}

#--------------------------------------------------------------------------
creat_ipset() {
    echo_date "创建 ipset 名单"
    ipset -! create koolclash_white nethash && ipset flush koolclash_white
    #ipset -! create koolclash_black nethash && ipset flush koolclash_black
}

#--------------------------------------------------------------------------
add_white_black_ip() {
    # black ip/cidr
    #ip_tg="149.154.0.0/16 91.108.4.0/22 91.108.56.0/24 109.239.140.0/24 67.198.55.0/24"
    #for ip in $ip_tg; do
    #    ipset -! add koolclash_black $ip >/dev/null 2>&1
    #done

    # white ip/cidr
    echo_date '应用局域网 IP 白名单'
    ip_lan="0.0.0.0/8 10.0.0.0/8 100.64.0.0/10 127.0.0.0/8 169.254.0.0/16 172.16.0.0/12 192.168.0.0/16 224.0.0.0/4 240.0.0.0/4 $lan_ip"
    for ip in $ip_lan; do
        ipset -! add koolclash_white $ip >/dev/null 2>&1
    done

    if [ ! -z $koolclash_firewall_whiteip_base64 ]; then
        ip_white=$(echo $koolclash_firewall_whiteip_base64 | base64_decode | sed '/\#/d')
        echo_date '应用 IP/CIDR 白名单'
        for ip in $ip_white; do
            ipset -! add koolclash_white $ip >/dev/null 2>&1
        done
    fi
}

#--------------------------------------------------------------------------
chromecast() {
    chromecast_nu=$(iptables -t nat -L PREROUTING -v -n --line-numbers | grep "dpt:53" | awk '{print $1}')
    is_right_lanip=$(iptables -t nat -L PREROUTING -v -n --line-numbers | grep "dpt:53" | grep "$lan_ip")
    if [ $koolclash_firewall_chromecast == "true" ]; then
        if [ -z "$chromecast_nu" ]; then
            iptables -t nat -A PREROUTING -p udp -s $(get_lan_cidr) --dport 53 -j DNAT --to $lan_ip >/dev/null 2>&1
            echo_date '启用 Chromecast（劫持 DNS）'
        else
            if [ -z "$is_right_lanip" ]; then
                echo_date '启用 Chromecast（劫持 DNS）'
                iptables -t nat -D PREROUTING $chromecast_nu >/dev/null 2>&1
                iptables -t nat -A PREROUTING -p udp -s $(get_lan_cidr) --dport 53 -j DNAT --to $lan_ip >/dev/null 2>&1
            else
                echo_date '检测到 DNS 劫持功能已经启用'
            fi
        fi
    else
        echo_date '不启用 Chromecast（劫持 DNS）功能'
    fi
}

get_mode_name() {
    case "$1" in
    0)
        echo "不通过 Clash"
        ;;
    1)
        echo "通过 Clash"
        ;;
    esac
}

get_default_port_name() {
    case "$1" in
    80443)
        echo "80, 443"
        ;;
    1)
        echo "常用 HTTP 协议端口"
        ;;
    all)
        echo "全部端口"
        ;;
    0)
        echo "自定义口"
        ;;
    esac
}

lan_access_control() {
    common_http_port="21 22 80 8080 8880 2052 2082 2086 2095 443 2053 2083 2087 2096 8443"

    if [ "$koolclash_firewall_default_mode" == "1" ]; then
        case $koolclash_firewall_default_port_mode in
        80443)
            echo_date "【全部主机】仅转发【80,443】端口的流量到 Clash，剩余端口直连"
            iptables -t nat -A koolclash -p tcp --dport 80 -j REDIRECT --to-ports 23456
            iptables -t nat -A koolclash -p tcp --dport 443 -j REDIRECT --to-ports 23456
            ;;
        1)
            echo_date "【全部主机】仅转发【常用 HTTP 端口】端口的流量到 Clash，剩余端口直连"
            for i in $common_http_port; do
                iptables -t nat -A koolclash -p tcp --dport $i -j REDIRECT --to-ports 23456
            done
            ;;
        all)
            echo_date "【全部主机】转发【所有端口】端口的流量到 Clash"
            iptables -t nat -A koolclash -p tcp -j REDIRECT --to-ports 23456
            ;;
        0)
            echo_date "【全部主机】转发【以下端口】端口的流量到 Clash，剩余端口直连"
            echo_date $(echo $koolclash_firewall_default_port_user | base64 -d)

            custom_port=$(echo $koolclash_firewall_default_port_user | base64 -d)
            for i in $custom_port; do
                iptables -t nat -A koolclash -p tcp --dport $i -j REDIRECT --to-ports 23456
            done
            ;;
        *)
            echo_date "【全部主机】转发【所有端口】端口的流量到 Clash"
            iptables -t nat -A koolclash -p tcp -j REDIRECT --to-ports 23456
            ;;
        esac
    elif [ "$koolclash_firewall_default_mode" == "0" ]; then
        case $koolclash_firewall_default_port_mode in
        80443)
            echo_date "【全部主机】仅【80,443】端口直连，剩余端口的流量转发到 Clash"
            iptables -t nat -A koolclash -p tcp --dport 80 -j RETURN
            iptables -t nat -A koolclash -p tcp --dport 443 -j RETURN
            iptables -t nat -A koolclash -p tcp -j REDIRECT --to-ports 23456
            ;;
        1)
            echo_date "【全部主机】仅【常用 HTTP 端口】端口直连，剩余端口的流量转发到 Clash"
            for i in $common_http_port; do
                iptables -t nat -A koolclash -p tcp --dport $i -j RETURN
            done
            iptables -t nat -A koolclash -p tcp -j REDIRECT --to-ports 23456
            ;;
        all)
            echo_date "【全部主机】【所有端口】端口均直连"
            iptables -t nat -A koolclash -p tcp -j RETURN
            ;;
        0)
            echo_date "【全部主机】【以下端口】端口全部直连，剩余端口的流量转发到 Clash"
            echo_date $(echo $koolclash_firewall_default_port_user | base64 -d)

            custom_port=$(echo $koolclash_firewall_default_port_user | base64 -d)
            for i in $custom_port; do
                iptables -t nat -A koolclash -p tcp --dport $i -j RETURN
            done
            iptables -t nat -A koolclash -p tcp -j REDIRECT --to-ports 23456
            ;;
        *)
            echo_date "【全部主机】【所有端口】端口均直连"
            iptables -t nat -A koolclash -p tcp -j RETURN
            ;;
        esac
    else
        echo_date "【全部主机】转发【所有端口】端口的流量到 Clash"
        iptables -t nat -A koolclash -p tcp -j REDIRECT --to-ports 23456
    fi
}

#--------------------------------------------------------------------------
apply_nat_rules() {
    #----------------------BASIC RULES---------------------
    echo_date "写入 iptables 规则"
    #-------------------------------------------------------
    # 局域网黑名单（不走ss）/局域网黑名单（走ss）
    # 其余主机默认模式
    # iptables -t nat -A koolclash -j $(get_action_chain $ss_acl_default_mode)

    iptables -t nat -N koolclash
    iptables -t nat -A PREROUTING -p tcp -j koolclash

    # IP Whitelist
    # 包括路由器本机 IP
    iptables -t nat -A koolclash -m set --match-set koolclash_white dst -j ACCEPT
    # Free 22 SSH
    iptables -t nat -A koolclash -p tcp --dport 22 -j ACCEPT
    #iptables -t nat -A koolclash -p tcp -m set --match-set koolclash_black dst -j REDIRECT --to-ports 23456
    # Redirect all tcp traffic to 23456
    lan_access_control
}

# =======================================================================================================
load_nat() {
    echo_date "开始加载 nat 规则!"
    #flush_nat
    creat_ipset
    add_white_black_ip
    apply_nat_rules
    chromecast
}

start_koolclash() {
    # get_status >> /tmp/ss_start.txt
    # used by web for start/restart; or by system for startup by S99koolss.sh in rc.d
    echo_date --------------------- KoolClash: Clash on Koolshare OpenWrt ---------------------
    [ -n "$ONSTART" ] && echo_date 路由器开机触发 KoolClash 启动！ || echo_date web 提交操作触发 KoolClash 启动！
    echo_date ---------------------------------------------------------------------------------
    # stop first
    restore_dnsmasq_conf
    flush_nat
    restore_start_file
    kill_process
    echo_date ---------------------------------------------------------------------------------
    create_dnsmasq_conf
    auto_start
    start_clash_process

    sleep 2
    if [ ! -n "$(pidof clash)" ]; then
        # 停止 KoolClash
        echo_date '【Clash 进程没有启动！Clash 配置文件可能存在错误，也有可能是其它原因！】'
        echo_date '【即将关闭 KoolClash 并还原所有操作】'
        echo_date ------------------------------- KoolClash 启动中断 -------------------------------
        sleep 2
        restore_dnsmasq_conf
        restart_dnsmasq
        flush_nat
        restore_start_file
        kill_process
        dbus set koolclash_enable=0
        echo_date ------------------------------- KoolClash 停止完毕 -------------------------------
        echo_date ------------------ 请不要关闭或者刷新页面！倒计时结束时会自动刷新！ ------------------
        exit 1
    fi

    load_nat
    restart_dnsmasq
    dbus set koolclash_enable=1
    echo_date ------------------------------- KoolClash 启动完毕 -------------------------------
}

stop_koolclash() {
    echo_date --------------------- KoolClash: Clash on Koolshare OpenWrt ---------------------
    restore_dnsmasq_conf
    restart_dnsmasq
    flush_nat
    restore_start_file
    kill_process
    dbus set koolclash_enable=0
    echo_date ------------------------------- KoolClash 停止完毕 -------------------------------
}

# used by rc.d and firewall include
case $1 in
start)
    if [ "$koolclash_enable" == "1" ]; then
        if [ ! -f $KSROOT/koolclash/config/config.yml ]; then
            echo_date "没有找到 Clash 的配置文件！自动停止 Clash！"
            stop_koolclash
            echo "XU6J03M6"
        else
            if [ $(yq r $KSROOT/koolclash/config/config.yml dns.enable) == 'true' ] && [ $(yq r $KSROOT/koolclash/config/config.yml dns.enhanced-mode) == 'redir-host' ]; then
                echo_date "KoolClash 执行开机自动启动"
                start_koolclash
                echo "XU6J03M6"
            else
                echo_date "没有找到 DNS 配置或 DNS 配置不合法！自动停止 Clash！"
                stop_koolclash
                echo "XU6J03M6"
            fi
        fi
    else
        echo_date "KoolClash 开机自动关闭"
        stop_koolclash
        echo "XU6J03M6"
    fi
    ;;
stop)
    echo_date "关闭 KoolClash"
    stop_koolclash
    echo "XU6J03M6"
    ;;
start_after_install)
    if [ ! -f $KSROOT/koolclash/config/config.yml ]; then
        echo_date "没有找到 Clash 的配置文件，中断启动并回滚操作！"
        stop_koolclash
    else
        if [ $(yq r $KSROOT/koolclash/config/config.yml dns.enable) == 'true' ] && [ $(yq r $KSROOT/koolclash/config/config.yml dns.enhanced-mode) == 'redir-host' ]; then
            start_koolclash
        else
            echo_date "没有找到 DNS 配置或 DNS 配置不合法，中断启动并回滚操作！"
            stop_koolclash
        fi
    fi
    ;;
*)
    if [ -z "$2" ]; then
        if [ "$koolclash_enable" == "1" ]; then
            if [ ! -f $KSROOT/koolclash/config/config.yml ]; then
                echo_date "没有找到 Clash 的配置文件！自动停止 Clash！"
                stop_koolclash
                echo "XU6J03M6"
            else
                if [ $(yq r $KSROOT/koolclash/config/config.yml dns.enable) == 'true' ] && [ $(yq r $KSROOT/koolclash/config/config.yml dns.enhanced-mode) == 'redir-host' ]; then
                    echo_date "KoolClash 执行开机自动启动"
                    start_koolclash
                    echo "XU6J03M6"
                else
                    echo_date "没有找到 DNS 配置或 DNS 配置不合法！自动停止 Clash！"
                    stop_koolclash
                    echo "XU6J03M6"
                fi
            fi
        else
            echo_date "KoolClash 开机自动关闭"
            stop_koolclash
            echo "XU6J03M6"
        fi
    fi
    ;;
esac

# used by httpdb
case $2 in
start)
    touch /tmp/upload/koolclash_log.txt
    if [ ! -f $KSROOT/koolclash/config/config.yml ]; then
        echo_date "【没有找到 Clash 的配置文件！自动停止 Clash！】" >/tmp/upload/koolclash_log.txt
        http_response 'noconfig'
        stop_koolclash >>/tmp/upload/koolclash_log.txt
        echo_date ------------------ 请不要关闭或者刷新页面！倒计时结束时会自动刷新！ ------------------ >>/tmp/upload/koolclash_log.txt
        echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
    else
        if [ $(yq r $KSROOT/koolclash/config/config.yml dns.enable) == 'true' ] && [ $(yq r $KSROOT/koolclash/config/config.yml dns.enhanced-mode) == 'redir-host' ]; then
            http_response 'success'
            start_koolclash >/tmp/upload/koolclash_log.txt
            echo_date ------------------ 请不要关闭或者刷新页面！倒计时结束时会自动刷新！ ------------------ >>/tmp/upload/koolclash_log.txt
            echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
        else
            echo_date "【没有找到正确的 DNS 配置或 Clash 配置文件存在错误！自动停止 Clash！】" >/tmp/upload/koolclash_log.txt
            http_response 'nodns'
            stop_koolclash >>/tmp/upload/koolclash_log.txt
            echo_date ------------------ 请不要关闭或者刷新页面！倒计时结束时会自动刷新！ ------------------ >>/tmp/upload/koolclash_log.txt
            echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
        fi
    fi
    ;;
stop)
    http_response 'success'
    stop_koolclash >/tmp/upload/koolclash_log.txt
    echo_date ------------------ 请不要关闭或者刷新页面！倒计时结束时会自动刷新！ ------------------ >>/tmp/upload/koolclash_log.txt
    echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
    ;;
esac
