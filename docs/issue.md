# 已知问题

- ~~不支持开机启动：KoolClash 目前采用直接启动 Clash 的方式，开机启动时可能会导致阻塞。所以 KoolClash 默认的开机启动的操作是关闭 Clash。这会导致你的路由器重启以后可能会影响到你的互联网使用（无法进行域名解析），你需要重新启用 Clash。~~
- ~~同样因为 KoolClash 目前采用直接启动 Clash 的方式，在使用 KoolClash 时还可能存在和其它酷软插件的冲突问题。~~
- 更新 KoolClash 时会自动停止 Clash、并且不会自动恢复。需要更新后手动重新启动 Clash。
- iptables 操作也有可能存在问题，因此你在使用 Clash 时有可能被锁在路由器外面。不过 KoolClash 在操作 iptables 时有放行 22 端口、不影响 SSH 登陆。可以通过这两条命令删除 KoolClash 添加的 iptables 规则：

```bash
iptables -t nat -F koolclash && iptables -t nat -X koolclash
```

- ~~如果你修改了 dnsmasq 监听的端口，在卸载 KoolClash 以后别忘了改回 53。~~
- 因为 KoolClash 仍然不稳定，建议使用独立的设备（如果你是通过虚拟机跑软路由，则新建一个虚拟机独立运行）、调整网络拓扑来运行 KoolClash。
- ~~上传 Clash 配置文件之前需要修改一下 `external-controller` 监听的 IP，推荐为 `[LEDE/OpenWrt IP]:[端口]`。KoolClash 以后会增加对外部控制器相关配置的修改。KoolClash 默认会在上传 Clash 配置文件、更新托管时将配置文件修改为将 `external-controller` 监听在 LAN IP 上。以后会修改为开放自定义。~~
- KoolClash 判断用户上传的配置文件中 是否有 DNS 字段 其实是 ~~非常~~ 比较傻瓜的。建议用户自己在上传配置前自行检查配置文件中的 DNS 设置。
- Clash 的透明代理存在问题——客户端获得的 IP 地址和代理服务器实际连接的地址可能完全不同，并且客户端获得的 IP 可能也完全不会被用到。这意味着 KoolClash 可能并不是最好的透明代理方案，需要取舍。
