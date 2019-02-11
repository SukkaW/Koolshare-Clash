#! /bin/sh
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval `dbus export clash`
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'