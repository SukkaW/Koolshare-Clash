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
    # 关闭 Clash 进程
    if [ -n "$(pidof clash-linux-amd64)" ]; then
        echo_date 关闭 Clash 进程...
        killall clash-linux-amd64
    fi
    # 清除 iptables
    iptables -t nat -D PREROUTING -p tcp --dport 22 -j ACCEPT
    iptables -t nat -D PREROUTING -p tcp -j REDIRECT --to-ports 8887
    iptables -t nat -D PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 53

    echo '0' >$KSROOT/koolclash/config/status
}

start_clash() {
    stop_clash

    # 启动 Clash 进程
    clash-linux-amd64 -d /koolshare/koolclash/config/

    [ ! -L "/etc/rc.d/S99koolclash.sh" ] && ln -sf $KSROOT/init.d/S99koolclash.sh /etc/rc.d/S99koolclash.sh
    # 设置 iptables
    iptables -t nat -A PREROUTING -p tcp --dport 22 -j ACCEPT
    iptables -t nat -A PREROUTING -p tcp -j REDIRECT --to-ports 8887
    iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 53

    echo '1' >$KSROOT/koolclash/config/status
}

# used by rc.d and firewall include
case $1 in
start)
    if [ "$clash_status" == "1" ]; then
        start_clash
    else
        stop_clash
    fi
    ;;
stop)
    stop_clash
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
    start_clash
    ;;
stop)
    stop_clash
    http_response 'n'
    ;;
esac
