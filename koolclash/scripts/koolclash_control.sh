#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

if [ ! -f "$KSROOT/koolclash/config/status" ]; then
    touch $KSROOT/koolclash/config/status
    echo '0' >$KSROOT/koolclash/config/status
    clash_status="0"
else
    clash_status=$(cat "$KSROOT/koolclash/config/status")
fi

stop_clash() {
    # 清除 iptables
    iptables -t nat -F KOOLCLASH

    # 关闭 Clash 进程
    if [ -n "$(pidof clash-linux-amd64)" ]; then
        echo_date 关闭 Clash 进程...
        killall clash-linux-amd64
    fi

    echo '0' >$KSROOT/koolclash/config/status
}

start_clash() {
    # 启动 Clash 进程
    clash-linux-amd64 -d /koolshare/koolclash/config/

    # 设置 iptables
    iptables -t nat -N KOOLCLASH
    iptables -t nat -A KOOLCLASH -p tcp --dport 22 -j ACCEPT
    iptables -t nat -A KOOLCLASH -p tcp -j REDIRECT --to-ports 23456
    iptables -t nat -I PREROUTING -p tcp -j KOOLCLASH

    echo '1' >$KSROOT/koolclash/config/status
}

creat_start_up() {
    [ ! -L "/etc/rc.d/S99koolclash.sh" ] && ln -sf $KSROOT/init.d/S99koolclash.sh /etc/rc.d/S99koolclash.sh
}

del_start_up() {
    rm -rf /etc/rc.d/S99koolclash.sh >/dev/null 2>&1
}

write_nat_start() {
    echo_date 添加nat-start触发事件...
    uci -q batch <<-EOT
	  delete firewall.ks_koolclash
	  set firewall.ks_koolclash=include
	  set firewall.ks_koolclash.type=script
	  set firewall.ks_koolclash.path=/koolshare/scripts/koolclash_control.sh
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
    if [ "$clash_status" == "1" ]; then
        remove_nat_start
        del_start_up
        stop_clash
        sleep 2
        start_clash
        creat_start_up
        write_nat_start
    else
        remove_nat_start
        del_start_up
        stop_clash
    fi
    ;;
stop)
    remove_nat_start
    stop_clash
    del_start_up
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
    http_response 'y'
    remove_nat_start
    del_start_up
    stop_clash
    sleep 2
    start_clash
    creat_start_up
    write_nat_start
    ;;
stop)
    remove_nat_start
    del_start_up
    stop_clash
    http_response 'n'
    ;;
esac
