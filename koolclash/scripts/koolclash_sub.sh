#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
eval $(dbus export koolclash_)
# From Koolshare DMZ Plugin
lan_ip=$(uci get network.lan.ipaddr)
wan_ip=$(ubus call network.interface.wan status | grep \"address\" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')

fallbackdns=$(cat $KSROOT/koolclash/config/dns.yml)

# 如果没有外部监听控制就使用 LAN IP:6170
if [ ! -n "$koolclash_api_host" ]; then
    dbus remove koolclash_api_host
    ext_control_ip=$lan_ip
else
    ext_control_ip=$koolclash_api_host
fi

case $2 in
del)
    dbus remove koolclash_suburl
    http_response 'ok'
    ;;

update)
    url=$(echo "$3" | base64 -d)
    if [ "$url" == "" ]; then
        # 你提交个空的上来干嘛？是不是想删掉？
        dbus remove koolclash_suburl
        http_response 'ok'
    else
        dbus set koolclash_suburl="$url"
        curl=$(which curl)

        cp $KSROOT/koolclash/config/origin.yml $KSROOT/koolclash/config/origin-backup.yml
        rm -rf $KSROOT/koolclash/config/origin.yml

        if [ "x$curl" != "x" ] && [ -x $curl ]; then
            $curl -L --compressed "$url" -o $KSROOT/koolclash/config/origin.yml
            sed -i '/^\-\-\-$/ d' $KSROOT/koolclash/config/origin.yml
            sed -i '/^\.\.\.$/ d' $KSROOT/koolclash/config/origin.yml
        else
            http_response 'nocurl'
            cp $KSROOT/koolclash/config/origin-backup.yml $KSROOT/koolclash/config/origin.yml
            exit 1
        fi

        if [ "$(yq r $KSROOT/koolclash/config/origin.yml port | sed 's|[0-9]||g')" == "" ]; then
            # 下载成功了
            rm -rf $KSROOT/koolclash/config/origin-backup.yml

            echo_date "设置 redir-port 和 allow-lan 属性"
            # 覆盖配置文件中的 redir-port 和 allow-lan 的配置
            yq w -i $KSROOT/koolclash/config/origin.yml redir-port 23456
            yq w -i $KSROOT/koolclash/config/origin.yml allow-lan true

            yq w -i $KSROOT/koolclash/config/origin.yml external-controller "$ext_control_ip:6170"

            cp $KSROOT/koolclash/config/origin.yml $KSROOT/koolclash/config/config.yml

            # 判断是否存在 DNS 字段、DNS 是否启用、DNS 是否使用 redir-host 模式
            if [ $(yq r $KSROOT/koolclash/config/config.yml dns.enable) == 'true' ] && [ $(yq r $KSROOT/koolclash/config/config.yml dns.enhanced-mode) == 'redir-host' ]; then
                if [ "$koolclash_dnsmode" == "2" ] && [ -n "$fallbackdns" ]; then
                    # dnsmode 是 2 应该用自定义 DNS 配置进行覆盖
                    echo_date "删除 Clash 配置文件中原有的 DNS 配置"
                    yq d -i $KSROOT/koolclash/config/config.yml dns

                    echo_date "将提交的自定义 DNS 设置覆盖 Clash 配置文件..."
                    # 将后备 DNS 配置以覆盖的方式与 config.yml 合并
                    yq m -x -i $KSROOT/koolclash/config/config.yml $KSROOT/koolclash/config/dns.yml
                    dbus set koolclash_dnsmode=2
                else
                    # 可能 dnsmode 是 2 但是没有自定义 DNS 配置；或者本来之前就是 1
                    dbus set koolclash_dnsmode=1
                fi

                # 先将 Clash DNS 设置监听 53，以后作为 dnsmasq 的上游以后需要改变端口
                yq w -i $KSROOT/koolclash/config/config.yml dns.listen "0.0.0.0:23453"
                echo_date "Clash 配置文件上传成功！"
                http_response 'success'
            else
                echo_date "在 Clash 配置文件中没有找到 DNS 配置！"
                if [ ! -n "$fallbackdns" ]; then
                    echo_date "没有找到后备 DNS 配置！请前往「配置文件」提交后备 DNS 配置！"
                    # 设置 DNS Mode 为 3
                    dbus set koolclash_dnsmode=3
                    http_response 'nofallbackdns'
                else
                    echo_date "找到后备 DNS 配置！合并到 Clash 配置文件中..."

                    dbus set koolclash_dnsmode=4
                    # 将后备 DNS 配置以覆盖的方式与 config.yml 合并
                    echo_date "删除 Clash 配置文件中原有的 DNS 配置"
                    yq d -i $KSROOT/koolclash/config/config.yml dns
                    yq m -x -i $KSROOT/koolclash/config/config.yml $KSROOT/koolclash/config/dns.yml

                    # 先将 Clash DNS 设置监听 53，以后作为 dnsmasq 的上游以后需要改变端口
                    yq w -i $KSROOT/koolclash/config/config.yml dns.listen "0.0.0.0:23453"

                    echo_date "Clash 配置文件上传成功！"
                    http_response 'success'
                fi
            fi
        else
            # 下载失败了
            rm -rf $KSROOT/koolclash/config/origin.yml
            cp $KSROOT/koolclash/config/origin-backup.yml $KSROOT/koolclash/config/origin.yml
            rm -rf $KSROOT/koolclash/config/origin-backup.yml
            http_response 'fail'
        fi
    fi
    ;;
esac
