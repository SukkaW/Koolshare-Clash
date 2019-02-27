#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

touch $KSROOT/koolclash/config/dns.yml

dns=$(cat $KSROOT/koolclash/config/dns.yml | base64)

http_response ${dns}
