#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

if [ -f /tmp/upload/clash.config.yml ]; then
    echo_date "开始上传配置！"
    mkdir -p $KSROOT/koolclash/config/
    cp /tmp/upload/clash.config.yml $KSROOT/koolclash/config/origin.yml
else
    echo_date "没有找到上传的配置文件！退出恢复！"
    exit 1
fi

rm -rf /tmp/upload/clash.config.yml

echo_date "设置 redir-port 和 allow-lan 属性"
sed -i '/^redir-port:/ d' $KSROOT/koolclash/config/origin.yml
sed -i '/^allow-lan:/ d' $KSROOT/koolclash/config/origin.yml

echo 'redir-port: 23456' | tee -a $KSROOT/koolclash/config/origin.yml
echo 'allow-lan: true' | tee -a $KSROOT/koolclash/config/origin.yml

cp $KSROOT/koolclash/config/origin.yml $KSROOT/koolclash/config/config.yml

hasdns=$(cat $KSROOT/koolclash/config/config.yml | grep "dns:")
fallbackdns=$(cat $KSROOT/koolclash/config/dns.yml)
if [[ "$hasdns" != "dns:" ]]; then
    if [ ! -n "$fallbackdns" ]; then
        http_response 'nofallbackdns'
    else
        cat $KSROOT/koolclash/config/dns.yml | tee -a $KSROOT/koolclash/config/config.yml
        http_response 'success'
    fi
fi
