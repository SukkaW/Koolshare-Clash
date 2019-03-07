#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

touch $KSROOT/koolclash/config/dns.yml

echo $2 | base64 -d | tee $KSROOT/koolclash/config/dns.yml

fallbackdns=$(cat $KSROOT/koolclash/config/dns.yml)

rm -rf $KSROOT/koolclash/config/config.yml
cp $KSROOT/koolclash/config/origin.yml $KSROOT/koolclash/config/config.yml

# 判断是否存在 DNS 字段、DNS 是否启用、DNS 是否使用 redir-host 模式
if [ $(yq r $KSROOT/koolclash/config/config.yml dns.enable) == 'true' ] && [ $(yq r $KSROOT/koolclash/config/config.yml dns.enhanced-mode) == 'redir-host' ]; then
    # 先将 Clash DNS 设置监听 53，以后作为 dnsmasq 的上游以后需要改变端口
    yq w -i $KSROOT/koolclash/config/config.yml dns.listen 0.0.0.0:53
    echo_date "后备 DNS 设置提交成功！"
    http_response 'success'
else
    echo_date "在 Clash 配置文件中没有找到 DNS 配置！"
    if [ ! -n "$fallbackdns" ]; then
        echo_date "没有找到后备 DNS 配置！请前往「配置文件」提交后备 DNS 配置！"
        http_response 'nofallbackdns'
    else
        echo_date "删除 Clash 配置文件中原有的 DNS 配置"
        yq d -i $KSROOT/koolclash/config/config.yml dns

        echo_date "将提交的后备 DNS 设置合并到 Clash 配置文件中..."
        # 将后备 DNS 配置以覆盖的方式与 config.yml 合并
        yq m -x -i $KSROOT/koolclash/config/config.yml $KSROOT/koolclash/config/dns.yml

        # 先将 Clash DNS 设置监听 53，以后作为 dnsmasq 的上游以后需要改变端口
        yq w -i $KSROOT/koolclash/config/config.yml dns.listen 0.0.0.0:53

        echo_date "后备 DNS 设置提交成功！"
        http_response 'success'
    fi
fi
