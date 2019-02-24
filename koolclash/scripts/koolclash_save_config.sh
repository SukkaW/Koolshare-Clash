#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

touch $KSROOT/koolclash/config/config.yml.tmp1
touch $KSROOT/koolclash/config/config.yml.tmp2

echo $2 | tee $KSROOT/koolclash/config/config.yml.tmp1

base64 -d $KSROOT/koolclash/config/config.yml.tmp1 | tee $KSROOT/koolclash/config/config.yml.tmp2

sed -i '/^redir-port:/ d' $KSROOT/koolclash/config/config.yml.tmp2
sed -i '/^allow-lan:/ d' $KSROOT/koolclash/config/config.yml.tmp2

echo '' | tee -a $KSROOT/koolclash/config/config.yml.tmp2
echo 'redir-port: 23456' | tee -a $KSROOT/koolclash/config/config.yml.tmp2
echo 'allow-lan: true' | tee -a $KSROOT/koolclash/config/config.yml.tmp2

cp -rf $KSROOT/koolclash/config/config.yml.tmp2 $KSROOT/koolclash/config/config.yml

rm -rf $KSROOT/koolclash/config/config.yml.tmp1
rm -rf $KSROOT/koolclash/config/config.yml.tmp2

http_response 'Success!'
