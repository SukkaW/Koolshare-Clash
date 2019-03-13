#!/bin/sh

wget https://github.com/Dreamacro/clash-dashboard/archive/gh-pages.zip
unzip gh-pages.zip
rm -rf koolclash/webs/koolclash && mkdir -p koolclash/webs/koolclash
cp -rf clash-dashboard-gh-pages/* koolclash/webs/koolclash
rm -rf gh-pages.zip
rm -rf clash-dashboard-gh-pages
