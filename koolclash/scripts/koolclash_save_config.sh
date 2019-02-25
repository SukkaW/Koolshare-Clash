#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

if [ -f /tmp/upload/clash.config.yml ]; then
    echo_date "开始上传配置！"
    mkdir -p $KSROOT/koolclash/config/
    cp /tmp/upload/clash.config.yml $KSROOT/koolclash/config/config.yml
else
    echo_date "没有找到上传的证书备份文件！退出恢复！"
    exit 1
fi

echo_date "设置 redir-port 和 allow-lan 属性"
sed -i '/^redir-port:/ d' $KSROOT/koolclash/config/config.yml
sed -i '/^allow-lan:/ d' $KSROOT/koolclash/config/config.yml

echo '' | tee -a $KSROOT/koolclash/config/config.yml.tmp2
echo 'redir-port: 23456' | tee -a $KSROOT/koolclash/config/config.yml
echo 'allow-lan: true' | tee -a $KSROOT/koolclash/config/config.yml

rm -rf /tmp/upload/clash.config.yml

http_response 'Success!'
