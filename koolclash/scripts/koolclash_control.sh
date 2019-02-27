#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval $(dbus export koolclash_)
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

start_clash() {
    # 设置 iptables
    iptables -t nat -A PREROUTING -p tcp --dport 22 -j ACCEPT
    iptables -t nat -A PREROUTING -p tcp -j REDIRECT --to-ports 23456

    sleep 1

    /etc/init.d/dnsmasq restart

    sleep 2

    [ ! -L "/etc/rc.d/S99koolclash.sh" ] && ln -sf $KSROOT/init.d/S99koolclash.sh /etc/rc.d/S99koolclash.sh

    dbus set koolclash_enable=1

    # 启动 Clash 进程
    clash-linux-amd64 -d $KSROOT/koolclash/config/
}

stop_clash() {
    # 清除 iptables
    iptables -t nat -D PREROUTING -p tcp --dport 22 -j ACCEPT
    iptables -t nat -D PREROUTING -p tcp -j REDIRECT --to-ports 23456

    sleep 1

    # 关闭 Clash 进程
    if [ -n "$(pidof clash-linux-amd64)" ]; then
        echo_date 关闭 Clash 进程...
        killall clash-linux-amd64
    fi

    /etc/init.d/dnsmasq restart

    sleep 2

    rm -rf /etc/rc.d/S99koolclash.sh >/dev/null 2>&1
    dbus set koolclash_enable=0
}

write_nat_start() {
    echo_date 添加nat-start触发事件...
    uci -q batch <<-EOT
	  delete firewall.ks_koolclash
	  set firewall.ks_koolclash=include
	  set firewall.ks_koolclash.type=script
	  set firewall.ks_koolclash.path=/koolshare/scripts/dmz_config.sh
	  set firewall.ks_koolclash.family=any
	  set firewall.ks_koolclash.reload=1
	  commit firewall
	EOT
}

remove_nat_start() {
    echo_date 删除nat-start触发...
    uci -q batch <<-EOT
	  delete firewall.ks_koolclash
	  commit firewall
	EOT
}

# used by rc.d and firewall include
case $1 in
start)
    if [ "$koolclash_enable" == "1" ]; then
        if [ ! -f $KSROOT/koolclash/config/config.yml ]; then
            stop_clash
            remove_nat_start
        else
            hasdns=$(cat $KSROOT/koolclash/config/config.yml | grep "dns:")
            if [[ "$hasdns" != "dns:" ]]; then
                stop_clash
                remove_nat_start
            else
                stop_clash
                remove_nat_start
                sleep 2
                write_nat_start
                start_clash
            fi

        fi
    else
        stop_clash
        remove_nat_start
    fi
    ;;
stop)
    stop_clash
    remove_nat_start
    ;;
*)
    if [ -z "$2" ]; then
        echo 'Hello, KoolClash!'
        sleep 1
    fi
    ;;
esac

# used by httpdb
case $2 in
start)
    if [ ! -f $KSROOT/koolclash/config/config.yml ]; then
        http_response 'noconfig'
        stop_clash
        remove_nat_start
    else
        hasdns=$(cat $KSROOT/koolclash/config/config.yml | grep "dns:")
        if [[ "$hasdns" != "dns:" ]]; then
            http_response 'nodns'
            stop_clash
            remove_nat_start
        else
            remove_nat_start
            http_response 'success'
            stop_clash
            sleep 1
            write_nat_start
            start_clash
        fi
    fi
    ;;
stop)
    remove_nat_start
    http_response 'success'
    stop_clash
    ;;
esac
