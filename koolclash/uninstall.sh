#! /bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh

if [ -d "$KSROOT/koolclash" ]; then
    echo_date '停止 KoolClash 以更新。注意更新完成以后 KoolClash 不会自动恢复，需要手动启动 Clash！'
    sleep 2
    sh $KSROOT/scripts/koolclash_control.sh stop >/dev/null 2>&1
    sleep 2
fi

rm -rf $KSROOT/koolclash
rm -rf $KSROOT/scripts/koolclash_*
rm -rf $KSROOT/init.d/S99koolclash.sh
rm -rf $KSROOT/bin/clash-*
rm -rf $KSROOT/webs/Module_koolclash.asp
rm -rf $KSROOT/webs/koolclash
rm -rf $KSROOT/webs/res/icon-koolclash*
rm -rf $KSROOT/webs/res/koolclash_*

rm -rf /tmp/luci-*

dbus remove softcenter_module_koolclash_description
dbus remove softcenter_module_koolclash_install
dbus remove softcenter_module_koolclash_name
dbus remove softcenter_module_koolclash_title
dbus remove softcenter_module_koolclash_version

dbus remove koolclash_enable
