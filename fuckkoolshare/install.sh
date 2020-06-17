#! /bin/sh
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

echo_date "====== Koolshare 软件中心离线安装限制 解除 ======"
echo_date "              Made by Sukka <https://skk.moe>"
echo_date "* 开始解除 Koolshare 软件中心离线安装限制"

sed -i 's/\tdetect_package/\t# detect_package/g' $KSROOT/scripts/ks_tar_install.sh

echo_date "* 限制解除完成！"
echo_date "* 你将会看见 Koolshare 软件中心提示安装失败，这是正常现象！"

exit 1
