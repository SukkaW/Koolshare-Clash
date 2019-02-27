#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

touch $KSROOT/koolclash/config/dns.yml

echo $2 | base64 -d | tee $KSROOT/koolclash/config/dns.yml

rm -rf $KSROOT/koolclash/config/config.yml
cp $KSROOT/koolclash/config/origin.yml $KSROOT/koolclash/config/config.yml

hasdns=$(cat $KSROOT/koolclash/config/config.yml | grep "dns:")

if [[ "$hasdns" != "dns:" ]]; then
    cat $KSROOT/koolclash/config/dns.yml | tee -a $KSROOT/koolclash/config/config.yml
fi

http_response 'success'
