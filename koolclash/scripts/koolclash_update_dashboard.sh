#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

curl=$(which curl)
wget=$(which wget)

dash_url="https://codeload.github.com/Dreamacro/clash-dashboard/zip/gh-pages"

if [ "x$wget" != "x" ] && [ -x $wget ]; then
    command="$wget --no-check-certificate $dash_url -O $KSROOT/koolclash/dashboard.zip"
elif [ "x$curl" != "x" ] && [ test -x $curl ]; then
    command="$curl -k --compressed $dash_url -o $KSROOT/koolclash/dashboard.zip"
else
    http_response 'nodl'
    exit 1
fi

$command && unzip $KSROOT/koolclash/dashboard.zip -d $KSROOT/koolclash/clash-dashboard-gh-pages/

rm -rf $KSROOT/webs/koolclash/*
mkdir -p $KSROOT/webs/koolclash

cp -rf $KSROOT/koolclash/clash-dashboard-gh-pages/* $KSROOT/webs/koolclash/ && rm -rf $KSROOT/koolclash/dashboard.zip && rm -rf $KSROOT/koolclash/clash-dashboard-gh-pages && http_response 'ok' && exit 0
http_response 'fail'
rm -rf $KSROOT/koolclash/dashboard.zip && rm -rf $KSROOT/koolclash/clash-dashboard-gh-pages
exit 1
