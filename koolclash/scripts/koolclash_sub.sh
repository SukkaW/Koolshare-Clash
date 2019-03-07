#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
eval $(dbus export koolclash_)
# From Koolshare DMZ Plugin
lan_ip=$(uci get network.lan.ipaddr)
wan_ip=$(ubus call network.interface.wan status | grep \"address\" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

case $2 in
del)
    dbus remove koolclash_suburl
    http_response 'ok'
    ;;

update)
    dbus set koolclash_suburl=$3
    curl=$(which curl)

    cp $KSROOT/koolclash/config/origin.yml $KSROOT/koolclash/config/origin-backup.yml
    rm -rf $KSROOT/koolclash/config/origin.yml

    if [ "x$curl" != "x" ] && [ -x $curl ]; then
        $curl --compressed $3 -o $KSROOT/koolclash/config/origin.yml
    else
        http_response 'nocurl'
        exit 1
    fi

    hasconfig=$(cat $KSROOT/koolclash/config/origin.yml | grep "port")

    if [ ! -n "$hasconfig" ]; then
        rm -rf $KSROOT/koolclash/config/origin.yml
        cp $KSROOT/koolclash/config/origin-backup.yml $KSROOT/koolclash/config/origin.yml
        rm -rf $KSROOT/koolclash/config/origin-backup.yml
        http_response 'fail'
    else
        rm -rf $KSROOT/koolclash/config/origin-backup.yml

        echo_date "设置 redir-port 和 allow-lan 属性"
        sed -i '/^redir-port:/ d' $KSROOT/koolclash/config/origin.yml
        sed -i '/^allow-lan:/ d' $KSROOT/koolclash/config/origin.yml
        sed -i '/^external-controller:/ d' $KSROOT/koolclash/config/origin.yml

        echo '' | tee -a $KSROOT/koolclash/config/origin.yml
        echo 'redir-port: 23456' | tee -a $KSROOT/koolclash/config/origin.yml
        echo 'allow-lan: true' | tee -a $KSROOT/koolclash/config/origin.yml
        echo "external-controller: ${lan_ip}:6170" | tee -a $KSROOT/koolclash/config/origin.yml

        sed -i '/^\-\-\-$/ d' $KSROOT/koolclash/config/origin.yml
sed -i '/^\.\.\.$/ d' $KSROOT/koolclash/config/origin.yml

        cp $KSROOT/koolclash/config/origin.yml $KSROOT/koolclash/config/config.yml

        hasdns=$(cat $KSROOT/koolclash/config/config.yml | grep "dns:")
        fallbackdns=$(cat $KSROOT/koolclash/config/dns.yml)
        if [[ "$hasdns" != "dns:" ]]; then
            if [ ! -n "$fallbackdns" ]; then
                http_response 'nofallbackdns'
            else
                echo '' | tee -a $KSROOT/koolclash/config/config.yml
                cat $KSROOT/koolclash/config/dns.yml | tee -a $KSROOT/koolclash/config/config.yml
                http_response 'success'
            fi
        else
            http_response 'success'
        fi
    fi
    ;;
esac
