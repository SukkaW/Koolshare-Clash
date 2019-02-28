#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

mkdir -p $KSROOT/koolclash/ipdb

curl=$(which curl)
wget=$(which wget)

ipdb_url="https://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz"

if [ -f $KSROOT/koolclash/config/Country.mmdb ]; then
    rm -f /tmp/QQWry.Dat || exit 1
fi

if [ "x$wget" != "x" ] && [ -x $wget ]; then
    command="$wget --no-check-certificate $ipdb_url -O $KSROOT/koolclash/ipdb.tar.gz"
elif [ "x$curl" != "x" ] && [ test -x $curl ]; then
    command="$curl -k --compressed $ipdb_url -o $KSROOT/koolclash/ipdb.tar.gz"
else
    http_response 'nodl'
    exit 1
fi

$command && tar zxvf $KSROOT/koolclash/ipdb.tar.gz -C $KSROOT/koolclash/ipdb

chmod 644 $KSROOT/koolclash/ipdb/GeoLite2-Country_*/* && cp -rf $KSROOT/koolclash/ipdb/GeoLite2-Country_*/GeoLite2-Country.mmdb $KSROOT/koolclash/config/Country.mmdb && sleep 2 && rm -rf $KSROOT/koolclash/ipdb.tar.gz && rm -rf $KSROOT/koolclash/ipdb && http_response 'ok' && exit 0
http_response 'fail'
rm -rf $KSROOT/koolclash/ipdb.tar.gz && rm -rf $KSROOT/koolclash/ipdb
exit 1
