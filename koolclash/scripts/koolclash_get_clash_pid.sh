#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

pid=`pidof clash-linux-amd64`
date=`echo_date`

if [ -n "$pid" ];then
    http_response "<span style='color: green'>$date Clash 进程运行正常！(PID: $pid)</span>"
else
    http_response "<span style='color: red'>$date Clash 进程未在运行！</span>"
fi