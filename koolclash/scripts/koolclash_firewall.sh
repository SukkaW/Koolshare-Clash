#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
eval $(dbus export koolclash_)
# From Koolshare DMZ Plugin
lan_ip=$(uci get network.lan.ipaddr)
wan_ip=$(ubus call network.interface.wan status | grep \"address\" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

case $2 in
white)
    dbus set koolclash_firewall_chromecast=$3
    dbus set koolclash_firewall_whiteip_base64=$4
    http_response 'ok'
    ;;
default)
    # 0 不通过 Clash; 1 通过 Clash
    dbus set koolclash_firewall_default_mode=$3
    # ['80443', '80,443'],
    # ['1',     '常用端口'],
    # ['all',   '全部端口'],
    # ['0',     '自定义端口']
    dbus set koolclash_firewall_default_port_mode=$4
    dbus set koolclash_firewall_default_port_user=$5
    http_response 'ok'
    ;;
esac
