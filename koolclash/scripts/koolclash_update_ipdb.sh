#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

mkdir -p $KSROOT/koolclash/ipdb

curl=$(which curl)
wget=$(which wget)

ipdb_url="https://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz"

rm -rf /tmp/upload/koolclash_log.txt && touch /tmp/upload/koolclash_log.txt
sleep 1

if [ "x$wget" != "x" ] && [ -x $wget ]; then
    command="$wget --no-check-certificate $ipdb_url -O $KSROOT/koolclash/ipdb.tar.gz"
elif [ "x$curl" != "x" ] && [ test -x $curl ]; then
    command="$curl -k --compressed $ipdb_url -o $KSROOT/koolclash/ipdb.tar.gz"
else
    echo_date "没有找到 wget 或 curl，无法更新 IP 数据库！" >>/tmp/upload/koolclash_log.txt
    http_response 'nodl'
    exit 1
fi

echo_date "开始下载最新 IP 数据库..." >>/tmp/upload/koolclash_log.txt
$command

echo_date "下载完成，开始解压" >>/tmp/upload/koolclash_log.txt
tar zxvf $KSROOT/koolclash/ipdb.tar.gz -C $KSROOT/koolclash/ipdb

chmod 644 $KSROOT/koolclash/ipdb/GeoLite2-Country_*/*
version=$(ls $KSROOT/koolclash/ipdb | grep 'GeoLite2-Country' | sed "s|GeoLite2-Country_||g")

cp -rf $KSROOT/koolclash/ipdb/GeoLite2-Country_*/GeoLite2-Country.mmdb $KSROOT/koolclash/config/Country.mmdb

echo_date "更新 IP 数据库至 $version 版本" >>/tmp/upload/koolclash_log.txt
dbus set koolclash_ipdb_version=$version

echo_date "清理临时文件..." >>/tmp/upload/koolclash_log.txt
rm -rf $KSROOT/koolclash/ipdb.tar.gz
rm -rf $KSROOT/koolclash/ipdb

echo_date "IP 数据库更新完成！" >>/tmp/upload/koolclash_log.txt

sleep 1

echo "XU6J03M6" >>/tmp/upload/koolclash_log.txt

http_response 'ok'
exit 0
