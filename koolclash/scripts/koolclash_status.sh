#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval $(dbus export koolclash_)

#lan_ip=$(uci get network.lan.ipaddr)
#wan_ip=$(ubus call network.interface.wan status | grep \"address\" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

pid=$(pidof clash)
date=$(echo_date)

if [ ! -f $KSROOT/koolclash/config/config.yml ]; then
    host=''
    secret=''
else
    host=$(yq r /koolshare/koolclash/config/config.yml external-controller)
    secret=$(yq r /koolshare/koolclash/config/config.yml secret)
fi

if [ ! -f $KSROOT/koolclash/config/config.yml ]; then
    # 没有找到 Clash 配置文件，不显示 DNS 配置输入，dnsmode 为 0
    dbus set koolclash_dnsmode=0
    dnsmode=0
elif [ $koolclash_dnsmode = 2 ]; then
    # Clash 配置文件存在且 DNS 配置合法，但是用户选择了自定义 DNS 配置，显示 DNS 配置输入，dnsmode 为 2
    dnsmode=2
elif [ $(yq r $KSROOT/koolclash/config/origin.yml dns.enable) == 'true' ] && [ $(yq r $KSROOT/koolclash/config/origin.yml dns.enhanced-mode) == 'redir-host' ]; then
    # Clash 配置文件存在且 DNS 配置合法，不显示 DNS 配置输入，dnsmode 为 1
    dbus set koolclash_dnsmode=1
    dnsmode=1
elif [ ! -f $KSROOT/koolclash/config/dns.yml ]; then
    dbus set koolclash_dnsmode=3
    # Clash 配置文件存在但 DNS 配置不存在或者不合法，并且没有提交独立 DNS 配置，显示 DNS 配置输入，dnsmode 为 3
    dnsmode=3
else
    dbus set koolclash_dnsmode=4
    # Clash 配置文件存在但 DNS 配置不存在或者不合法，但是已经提交独立 DNS 配置，显示 DNS 配置输入，dnsmode 为 4
    dnsmode=4
fi

if [ -n "$pid" ]; then
    text="<span style='color: green'>$date Clash 进程运行正常！(PID: $pid)</span>"
else
    text="<span style='color: red'>$date Clash 进程未在运行！</span>"
fi

http_response "$text@$dnsmode@$host@$secret"
