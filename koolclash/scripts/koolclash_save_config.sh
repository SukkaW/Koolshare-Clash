#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

touch $KSROOT/koolclash/config/config.yml

clash_config=$(echo $2 | base64 -d)

echo $clash_config > $KSROOT/koolclash/config/config.yml

http_response 'Success!'
