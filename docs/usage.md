# 使用教程

启动 KoolClash 插件以后，Clash 会开始监听 53 端口作为 DNS。你应该前往 OpenWrt/LEDE 的「网络 - DHCP/DNS」，在「高级设置」中将「DNS 服务器端口」修改为除了 53 以外的任何不冲突的端口（如 5353、53535）。

KoolClash 没有实现自动更新 Clash 配置的功能，需要通过「更新 Clash 配置」手动更新。