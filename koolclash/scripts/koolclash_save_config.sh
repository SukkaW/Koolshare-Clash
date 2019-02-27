#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

if [ -f /tmp/upload/clash.config.yml ]; then
    echo_date "开始上传配置！"
    mkdir -p $KSROOT/koolclash/config/
    cp /tmp/upload/clash.config.yml $KSROOT/koolclash/config/config.yml
else
    echo_date "没有找到上传的配置文件！退出恢复！"
    exit 1
fi

echo_date "设置 redir-port 和 allow-lan 属性"
sed -i '/^redir-port:/ d' $KSROOT/koolclash/config/config.yml
sed -i '/^allow-lan:/ d' $KSROOT/koolclash/config/config.yml

echo 'redir-port: 23456' | tee -a $KSROOT/koolclash/config/config.yml
echo 'allow-lan: true' | tee -a $KSROOT/koolclash/config/config.yml

hasdns=$(cat $KSROOT/koolclash/config/config.yml | grep "dns:")
if [[ "$hasdns" != "dns:" ]]; then
    cat $KSROOT/koolclash/config/dns.yml | tee -a $KSROOT/koolclash/config/config.yml
fi

rm -rf /tmp/upload/clash.config.yml

http_response 'Success!'
