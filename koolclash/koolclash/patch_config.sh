#!/bin/sh
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
eval $(dbus export clash)
CONFIG_TMP=/tmp/koolclash/remote/config.yml
LOG_FILE=/tmp/koolclash/clash_log.txt
LOCK_FILE=/tmp/koolclash/clash_online_update.lock
NO_DEL=1

remove_config_header() {
    sed -i '/^port:/ d' $CONFIG_TMP
    sed -i '/^socks-port:/ d' $CONFIG_TMP
    sed -i '/^redir-port:/ d' $CONFIG_TMP
    sed -i '/^allow-lan:/ d' $CONFIG_TMP
    sed -i '/^mode:/ d' $CONFIG_TMP
    sed -i '/^log-level:/ d' $CONFIG_TMP
    sed -i '/^external-controller:/ d' $CONFIG_TMP
}
