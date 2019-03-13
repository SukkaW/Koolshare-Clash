#!/bin/sh

wget https://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz -O ipdb.tar.gz
mkdir -p geolite
tar zxvf ipdb.tar.gz -C geolite
chmod 644 geolite/GeoLite2-Country_*/*
cp -rf geolite/GeoLite2-Country_*/GeoLite2-Country.mmdb koolclash/koolclash/config/Country.mmdb
rm -rf ipdb.tar.gz
rm -rf geolite
