#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
source $KSROOT/bin/helper.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
eval $(dbus export koolclash_)

lan_ip=$(uci get network.lan.ipaddr)
wan_ip=$(ubus call network.interface.wan status | grep \"address\" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

if [ ! -n "$2" ]; then
    dbus remove koolclash_api_host
    ext_control_ip=$lan_ip
else
    dbus set koolclash_api_host=$2
    ext_control_ip=$2
fi

yq w -i $KSROOT/koolclash/config/config.yml external-controller "$ext_control_ip:6170"

http_response "$external_controller@$secret"
