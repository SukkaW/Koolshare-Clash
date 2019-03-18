#!/bin/sh /etc/rc.common
#
# Copyright (C) 2015 OpenWrt-dist
# Copyright (C) 2016 fw867 <ffkykzs@gmail.com>
# Copyright (C) 2016 sadog <sadoneli@gmail.com>
# Copyright (C) 2018 SukkaW <https://skk.moe>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

START=99
STOP=15

source /koolshare/scripts/base.sh
eval $(dbus export koolclash_)
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

start() {
    touch /tmp/upload/koolclash_log.txt
    if [ "$koolclash_enable" == "1" ]; then
        sh /koolshare/scripts/koolclash_control.sh start >/tmp/upload/koolclash_log.txt
        echo_date "KoolClash 开机启动成功" >>/tmp/upload/koolclash_log.txt
        echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
    else
        echo_date "KoolClash 开机没有启动" >/tmp/upload/koolclash_log.txt
        echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
    fi
}

stop() {
    touch /tmp/upload/koolclash_log.txt
    sh /koolshare/scripts/koolclash_control.sh stop >/tmp/upload/koolclash_log.txt
    echo_date "KoolClash 成功停止" >>/tmp/upload/koolclash_log.txt
    echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt
}
