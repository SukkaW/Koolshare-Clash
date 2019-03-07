#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh

lan_ip=$(uci get network.lan.ipaddr)
wan_ip=$(ubus call network.interface.wan status | grep \"address\" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

pid=$(pidof clash)
date=$(echo_date)

if [ ! -f $KSROOT/koolclash/config/config.yml ]; then
    secret=''
else
    secret=$(yq r /koolshare/koolclash/config/origin.yml secret)
fi

if [ -n "$pid" ]; then
    text="<span style='color: green'>$date Clash 进程运行正常！(PID: $pid)</span>"
else
    text="<span style='color: red'>$date Clash 进程未在运行！</span>"
fi

http_response "$text@$lan_ip@$secret"