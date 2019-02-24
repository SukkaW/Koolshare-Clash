#! /bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh

sleep 1

cp -rf /tmp/koolclash/bin/* $KSROOT/bin/

cp -rf /tmp/koolclash/init.d/* $KSROOT/init.d/
cp -rf /tmp/koolclash/webs/* $KSROOT/webs/
cp /tmp/koolclash/install.sh $KSROOT/scripts/koolclash_install.sh
cp /tmp/koolclash/uninstall.sh $KSROOT/scripts/uninstall_koolclash.sh

rm -rf $KSROOT/koolclash
rm -rf $KSROOT/scripts/koolclash_*
rm -rf $KSROOT/webs/Module_koolclash.asp
rm -rf $KSROOT/bin/clash-*
rm -rf $KSROOT/webs/res/icon-koolclash*

rm -rf /tmp/luci-*

dbus remove softcenter_module_koolclash_description
dbus remove softcenter_module_koolclash_install
dbus remove softcenter_module_koolclash_name
dbus remove softcenter_module_koolclash_title
dbus remove softcenter_module_koolclash_version
