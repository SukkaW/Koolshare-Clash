#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
eval $(dbus export koolclash_)

touch $KSROOT/koolclash/config/dns.yml

echo $2 | base64 -d | tee $KSROOT/koolclash/config/dns.yml

fallbackdns=$(cat $KSROOT/koolclash/config/dns.yml)

rm -rf $KSROOT/koolclash/config/config.yml
cp $KSROOT/koolclash/config/origin.yml $KSROOT/koolclash/config/config.yml

if [ "$koolclash_dnsmode" == "1" ] && [ "$3" == "1" ]; then
    # Clash 配置文件存在且 DNS 配置合法，不显示 DNS 配置输入，此时 dnsmode 为 1
    # 但是用户想要用自己的 DNS 配置覆盖
    if [ ! -n "$fallbackdns" ]; then
        # 你不是想覆盖 DNS 配置么怎么提交个空的上来？
        echo_date "没有找到自定义 DNS 配置！请前往「配置文件」提交 DNS 配置！"
        http_response 'nofallbackdns'
    else
        echo_date "删除 Clash 配置文件中原有的 DNS 配置"
        yq d -i $KSROOT/koolclash/config/config.yml dns

        echo_date "将提交的自定义 DNS 设置覆盖 Clash 配置文件..."
        # 将后备 DNS 配置以覆盖的方式与 config.yml 合并
        yq m -x -i $KSROOT/koolclash/config/config.yml $KSROOT/koolclash/config/dns.yml

        # 先将 Clash DNS 设置监听 23453，以后作为 dnsmasq 的上游以后需要改变端口
        yq w -i $KSROOT/koolclash/config/config.yml dns.listen 0.0.0.0:23453
        # 强制生效 DNS 配置，修改 dnsmode 为 2
        dbus set koolclash_dnsmode=2
        echo_date "后备 DNS 设置提交成功！"
        http_response 'success'
    fi
elif [ "$koolclash_dnsmode" == "2" ] && [ "$3" == "0" ]; then
    # 用户已经要用自己的 DNS 配置覆盖，dnsmode 为 2
    # 但是取消勾选了 DNS 配置文件的勾，是想要还原原始 Clash 配置文件
    rm -rf $KSROOT/koolclash/config/config.yml
    cp $KSROOT/koolclash/config/origin.yml $KSROOT/koolclash/config/config.yml
    yq w -i $KSROOT/koolclash/config/config.yml dns.listen 0.0.0.0:23453
    dbus set koolclash_dnsmode=1
    echo_date "自定义 DNS 设置提交成功！"
    http_response 'success'
elif [ "$koolclash_dnsmode" == "2" ] && [ "$3" == "1" ]; then
    # 用户已经要用自己的 DNS 配置覆盖，dnsmode 为 2
    if [ ! -n "$fallbackdns" ]; then
        # 看来你是想还原原始 Clash 配置文件同时还删除自定义 DNS 配置
        rm -rf $KSROOT/koolclash/config/config.yml
        cp $KSROOT/koolclash/config/origin.yml $KSROOT/koolclash/config/config.yml
        yq w -i $KSROOT/koolclash/config/config.yml dns.listen 0.0.0.0:23453
        dbus set koolclash_dnsmode=1
        echo_date "自定义 DNS 设置提交成功！"
        http_response 'success'
    else
        # 你应该是想更新一下自定义 DNS 配置
        echo_date "删除 Clash 配置文件中原有的 DNS 配置"
        yq d -i $KSROOT/koolclash/config/config.yml dns

        echo_date "将提交的自定义 DNS 设置覆盖 Clash 配置文件..."
        # 将后备 DNS 配置以覆盖的方式与 config.yml 合并
        yq m -x -i $KSROOT/koolclash/config/config.yml $KSROOT/koolclash/config/dns.yml

        # 先将 Clash DNS 设置监听 23453，以后作为 dnsmasq 的上游以后需要改变端口
        yq w -i $KSROOT/koolclash/config/config.yml dns.listen 0.0.0.0:23453
        # 强制生效 DNS 配置，修改 dnsmode 为 2
        dbus set koolclash_dnsmode=2
        echo_date "后备 DNS 设置提交成功！"
        http_response 'success'
    fi
elif [ "$koolclash_dnsmode" == "3" ]; then
    # 你这是要提交自定义 DNS 配置来完善你上传的 Clash 配置文件
    if [ ! -n "$fallbackdns" ]; then
        # 本来你 Clash 配置就没有 DNS 配置了，你还提交个空的干嘛？
        echo_date "没有找到自定义 DNS 配置！请前往「配置文件」提交后备 DNS 配置！"
        http_response 'nofallbackdns'
    else
        echo_date "删除 Clash 配置文件中原有的 DNS 配置"
        yq d -i $KSROOT/koolclash/config/config.yml dns

        echo_date "将提交的后备 DNS 设置合并到 Clash 配置文件中..."
        # 将后备 DNS 配置以覆盖的方式与 config.yml 合并
        yq m -x -i $KSROOT/koolclash/config/config.yml $KSROOT/koolclash/config/dns.yml

        # 先将 Clash DNS 设置监听 53，以后作为 dnsmasq 的上游以后需要改变端口
        yq w -i $KSROOT/koolclash/config/config.yml dns.listen 0.0.0.0:23453

        echo_date "后备 DNS 设置提交成功！"
        http_response 'success'
    fi
elif [ "$koolclash_dnsmode" == "4" ]; then
    # 你已经提交了自定义 DNS 配置了，想要更新一下自定义配置
    if [ ! -n "$fallbackdns" ]; then
        # 你不是想更新吗，你还提交个空的干嘛？
        echo_date "没有找到自定义 DNS 配置！请前往「配置文件」提交后备 DNS 配置！"
        http_response 'nofallbackdns'
    else
        echo_date "删除 Clash 配置文件中原有的 DNS 配置"
        yq d -i $KSROOT/koolclash/config/config.yml dns

        echo_date "将提交的后备 DNS 设置合并到 Clash 配置文件中..."
        # 将后备 DNS 配置以覆盖的方式与 config.yml 合并
        yq m -x -i $KSROOT/koolclash/config/config.yml $KSROOT/koolclash/config/dns.yml

        # 先将 Clash DNS 设置监听 53，以后作为 dnsmasq 的上游以后需要改变端口
        yq w -i $KSROOT/koolclash/config/config.yml dns.listen 0.0.0.0:23453

        echo_date "后备 DNS 设置提交成功！"
        http_response 'success'
    fi
fi
