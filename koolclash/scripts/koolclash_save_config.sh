#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'

# 从 DMZ 插件抄来的获取 LAN/WAN IP
lan_ip=$(uci get network.lan.ipaddr)
wan_ip=$(ubus call network.interface.wan status | grep \"address\" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
# fallback dns
fallbackdns=$(cat $KSROOT/koolclash/config/dns.yml)

# 检测是否能够读取面板上传的 Clash
if [ -f /tmp/upload/clash.config.yml ]; then
    echo_date "开始上传配置！"
    mkdir -p $KSROOT/koolclash/config/
    # 将上传的文件复制到 Config 目录中
    cp /tmp/upload/clash.config.yml $KSROOT/koolclash/config/origin.yml
else
    echo_date "没有找到上传的配置文件！退出！"
    http_response 'notfound'
    exit 1
fi
# 删除 tmp 目录中上传的配置文件
rm -rf /tmp/upload/clash.config.yml

echo_date "设置 redir-port 和 allow-lan 属性"
# 覆盖配置文件中的 redir-port 和 allow-lan 的配置
yq w $KSROOT/koolclash/config/origin.yml redir-port 23456
yq w $KSROOT/koolclash/config/origin.yml allow-lan true

echo_date "设置 Clash 外部控制器监听 ${lan_ip}:6170"
yq w $KSROOT/koolclash/config/origin.yml external-controller ${lan_ip}:6170

cp $KSROOT/koolclash/config/origin.yml $KSROOT/koolclash/config/config.yml

# 判断是否存在 DNS 字段、DNS 是否启用、DNS 是否使用 redir-host 模式
if [ $(yq r $KSROOT/koolclash/config/config.yml dns.enable) == 'true' && $(yq r $KSROOT/koolclash/config/config.yml dns.enhanced-mode) == 'redir-host' ]; then
    # 先将 Clash DNS 设置监听 53，以后作为 dnsmasq 的上游以后需要改变端口
    yq w $KSROOT/koolclash/config/dns.yml dns.listen 0.0.0.0:53
    echo_date "Clash 配置文件上传成功！"
    http_response 'success'
else
    echo_date "在 Clash 配置文件中没有找到 DNS 配置！"
    if [ ! -n "$fallbackdns" ]; then
        echo_date "没有找到后备 DNS 配置！请前往「配置文件」提交后备 DNS 配置！"
        http_response 'nofallbackdns'
    else
        echo_date "找到后备 DNS 配置！合并到 Clash 配置文件中..."
        # 将后备 DNS 配置以覆盖的方式与 config.yml 合并
        yq m -x $KSROOT/koolclash/config/config.yml $KSROOT/koolclash/config/dns.yml

        # 先将 Clash DNS 设置监听 53，以后作为 dnsmasq 的上游以后需要改变端口
        yq w $KSROOT/koolclash/config/dns.yml dns.listen 0.0.0.0:53

        echo_date "Clash 配置文件上传成功！"
        http_response 'success'
    fi
fi
