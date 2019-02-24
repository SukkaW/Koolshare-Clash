#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

touch $KSROOT/koolclash/config/config.yml

config=$(cat $KSROOT/koolclash/config/config.yml | base64)

http_response ${config}
