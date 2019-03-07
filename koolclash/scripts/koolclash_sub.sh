#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
eval $(dbus export koolclash_)
# From Koolshare DMZ Plugin
lan_ip=$(uci get network.lan.ipaddr)
wan_ip=$(ubus call network.interface.wan status | grep \"address\" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

fallbackdns=$(cat $KSROOT/koolclash/config/dns.yml)

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

    if [ $(yq r $KSROOT/koolclash/config/origin.yml port) == "null" ]; then
        rm -rf $KSROOT/koolclash/config/origin.yml
        cp $KSROOT/koolclash/config/origin-backup.yml $KSROOT/koolclash/config/origin.yml
        rm -rf $KSROOT/koolclash/config/origin-backup.yml
        http_response 'fail'
    else
        rm -rf $KSROOT/koolclash/config/origin-backup.yml

        echo_date "设置 redir-port 和 allow-lan 属性"
        # 覆盖配置文件中的 redir-port 和 allow-lan 的配置
        yq w -i $KSROOT/koolclash/config/origin.yml redir-port 23456
        yq w -i $KSROOT/koolclash/config/origin.yml allow-lan true

        echo_date "设置 Clash 外部控制器监听 ${lan_ip}:6170"
        yq w -i $KSROOT/koolclash/config/origin.yml external-controller ${lan_ip}:6170

        sed -i '/^\-\-\-$/ d' $KSROOT/koolclash/config/origin.yml
        sed -i '/^\.\.\.$/ d' $KSROOT/koolclash/config/origin.yml

        cp $KSROOT/koolclash/config/origin.yml $KSROOT/koolclash/config/config.yml

        # 判断是否存在 DNS 字段、DNS 是否启用、DNS 是否使用 redir-host 模式
        if [ $(yq r $KSROOT/koolclash/config/config.yml dns.enable) == 'true' ] && [ $(yq r $KSROOT/koolclash/config/config.yml dns.enhanced-mode) == 'redir-host' ]; then
            # 先将 Clash DNS 设置监听 53，以后作为 dnsmasq 的上游以后需要改变端口
            yq w -i $KSROOT/koolclash/config/config.yml dns.listen "0.0.0.0:53"
            echo_date "Clash 配置文件上传成功！"
            http_response 'success'
        else
            echo_date "在 Clash 配置文件中没有找到 DNS 配置！"
            if [ ! -n "$fallbackdns" ]; then
                echo_date "没有找到后备 DNS 配置！请前往「配置文件」提交后备 DNS 配置！"
                http_response 'nofallbackdns'
            else
                echo_date "找到后备 DNS 配置！合并到 Clash 配置文件中..."
                # 将后备 DNS 配置以覆盖的方式与 config.yml 合并
                yq m -x -i $KSROOT/koolclash/config/config.yml $KSROOT/koolclash/config/dns.yml

                # 先将 Clash DNS 设置监听 53，以后作为 dnsmasq 的上游以后需要改变端口
                yq w -i $KSROOT/koolclash/config/config.yml dns.listen "0.0.0.0:53"

                echo_date "Clash 配置文件上传成功！"
                http_response 'success'
            fi
        fi
    fi
    ;;
esac
