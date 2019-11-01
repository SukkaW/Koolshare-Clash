#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

eval $(dbus export koolclash_)

lan_ip=$(ubus call network.interface.lan status | jsonfilter -e '@["ipv4-address"][0].address')
#wan_ip=$(ubus call network.interface.wan status | grep \"address\" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
koolshare_version=$(cat /etc/banner | grep Openwrt)

clash_version=$($KSROOT/bin/clash -v)

fallbackdns=$(cat $KSROOT/koolclash/config/dns.yml | base64 | xargs)

if [ ! -f $KSROOT/koolclash/config/config.yaml ]; then
    clash_allow_lan=''
    clash_ext_controller=''
    clash_redir=''
    clash_dns_enable=''
    clash_dns_ipv6=''
    clash_dns_mode=''
    clash_dns_listen=''
else
    clash_allow_lan=$(yq r /koolshare/koolclash/config/config.yaml allow-lan)
    clash_ext_controller=$(yq r /koolshare/koolclash/config/config.yaml external-controller)
    clash_redir=$(yq r /koolshare/koolclash/config/config.yaml redir-port)
    clash_dns_enable=$(yq r /koolshare/koolclash/config/config.yaml dns.enable)
    clash_dns_ipv6=$(yq r /koolshare/koolclash/config/config.yaml dns.ipv6)
    clash_dns_mode=$(yq r /koolshare/koolclash/config/config.yaml dns.enhanced-mode)
    clash_dns_listen=$(yq r /koolshare/koolclash/config/config.yaml dns.listen)
fi

iptables_mangle=$(iptables -nvL PREROUTING -t mangle | sed 1,2d | grep 'clash' | base64 | base64 | xargs)
iptables_nat=$(iptables -nvL PREROUTING -t nat | sed 1,2d | grep 'clash' | base64 | base64 | xargs)
iptables_mangle_clash=$(iptables -nvL koolclash -t mangle | sed 1,2d | base64 | base64 | xargs)
iptables_nat_clash=$(iptables -nvL koolclash -t nat | sed 1,2d | base64 | base64 | xargs)
iptables_mangle_clash_dns=$(iptables -nvL koolclash_dns -t mangle | sed 1,2d | base64 | base64 | xargs)
iptables_nat_clash_dns=$(iptables -nvL koolclash_dns -t nat | sed 1,2d | base64 | base64 | xargs)

white_ip=$(ipset list koolclash_white | base64 | xargs)

chromecast_nu=$(iptables -t nat -L PREROUTING -v -n --line-numbers | grep "dpt:53" | base64 | xargs)

clash_process=$(ps | grep clash | grep -v grep | base64 | xargs)

clash_config_dir=$(ls -lh /koolshare/koolclash/config | base64 | xargs)

http_response "{ \\\"lan_ip\\\": \\\"${lan_ip}\\\", \\\"koolshare_version\\\": \\\"$koolshare_version\\\", \\\"clash_allow_lan\\\": \\\"$clash_allow_lan\\\", \\\"clash_ext_controller\\\": \\\"$clash_ext_controller\\\", \\\"clash_dns_enable\\\": \\\"$clash_dns_enable\\\", \\\"clash_dns_ipv6\\\": \\\"$clash_dns_ipv6\\\", \\\"clash_dns_mode\\\": \\\"$clash_dns_mode\\\", \\\"clash_dns_listen\\\": \\\"$clash_dns_listen\\\", \\\"fallbackdns\\\": \\\"$fallbackdns\\\", \\\"iptables_mangle\\\": \\\"$iptables_mangle\\\", \\\"iptables_nat\\\": \\\"$iptables_nat\\\", \\\"iptables_mangle_clash\\\": \\\"$iptables_mangle_clash\\\", \\\"iptables_nat_clash\\\": \\\"$iptables_nat_clash\\\", \\\"iptables_mangle_clash_dns\\\": \\\"$iptables_mangle_clash_dns\\\", \\\"iptables_nat_clash_dns\\\": \\\"$iptables_nat_clash_dns\\\", \\\"clash_redir\\\": \\\"$clash_redir\\\", \\\"firewall_white_ip\\\": \\\"$white_ip\\\", \\\"chromecast_nu\\\": \\\"$chromecast_nu\\\", \\\"clash_process\\\": \\\"$clash_process\\\", \\\"clash_config_dir\\\": \\\"$clash_config_dir\\\", \\\"clash_version\\\": \\\"$clash_version\\\"}"
