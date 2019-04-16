# 使用教程

## 上传 Clash 配置文件

KoolClash 提供了两种配置文件上传方式，直接上传和提交托管订阅。

在「Clash 配置上传」选择 Clash 配置文件并点击右侧的「上传」即可上传 Clash 配置文件到 KoolClash 中。

![](/img/usage-2.png)

KoolClash 也已经支持自动从托管配置自动下载更新 Clash 配置文件，在「Clash 托管配置 URL」中输入 Clash 托管配置的 URL 地址，然后点击「更新 Clash 托管配置」的按钮，KoolClash 会自动记忆你填入的 Clash 托管配置的 URL，并开始从这个 URL 下载 Clash 配置文件。

?> KoolClash 托管配置功能尚不支持自动更新，需要手动到 KoolClash 后台点击更新。

!> KoolClash 的托管配置 URL 以明文保存在 dbus 中，可以被任意 Koolshare 的插件或脚本通过不止一种方法读取！因此务必谨慎使用此功能！

## 设置 Clash 自定义 DNS 配置

如果你当前没有上传 Clash 配置文件、或者没有添加 Clash 托管配置 URL 并下载，KoolClash 将不允许你添加 自定义 DNS 配置。

当你上传了一个 Clash 配置文件、或提交了托管配置更新，KoolClash 会自动检查你上传的 Clash 配置文件有没有包含合法的 DNS 配置。如果 KoolClash 检测到你当前 Clash 配置文件中没有包含合法的 DNS 配置，KoolClash 会强制你你添加 自定义 DNS 配置：

![](/img/usage-0.png)

> 「合法的 DNS 配置」包括
> - `dns.enable = true`
> - `dns.enhanced-mode = redir-host`

以下是一个推荐的 自定义 DNS 配置 的示范：

```yaml
dns:
  enable: true
  listen: 0.0.0.0:53
  enhanced-mode: redir-host
  nameserver:
    - 119.29.29.29
    - 119.28.28.28
    - 223.6.6.6
    - 223.5.5.5
    - tls://dns.rubyfish.cn:853
  fallback:
    - tls://8.8.4.4:853
    - tls://1.0.0.1:853
```

当你提交过自定义 DNS 配置以后，下次你上传 没有包含合法的 DNS 配置 的 Clash 配置文件时，KoolClash 会自动将你提交过的 自定义 DNS 配置 合并到 Clash 配置文件中。你还可以通过重新提交新的 自定义 DNS 配置 以更新 Clash 配置文件中的 DNS 配置。

如果你上传的 Clash 配置文件已经 包含合法的 DNS 配置，此时 KoolClash 不需要你添加自定义 DNS 配置也能运行。

![](/img/usage-4.png)

此时你可以勾选「DNS 配置开关」并提交 自定义 DNS 配置，KoolClash 会用你提交的 自定义 DNS 配置 来覆盖 Clash 配置文件中已有的 DNS 配置。

?> 在 `0.14.1-beta` 版本之前，无论你是否提交过 自定义 DNS 配置，当你通过上传或者更新托管配置的方式提交一个 包含合法 DNS 配置的 Clash 配置文件时，KoolClash 都不会用自定义 DNS 配置文件进行覆盖。你需要勾选「DNS 配置开关」并重新提交 自定义 DNS 配置。

?> 从 `0.14.1-beta` 开始，如果你曾经使用 自定义 DNS 配置覆盖过 Clash 配置文件中的 DNS 配置文件，那么在你下次提交一个 包含合法 DNS 配置的 Clash 配置文件时，KoolClash 将自动用 自定义 DNS 配置 进行覆盖。

## ~~修改 dnsmasq 监听端口~~

?> 从 KoolClash `0.10.0-beta` 版本开始，KoolClash 会自动修改 Clash 将 DNS Server 运行在 23453 端口上，并将 LEDE/OpenWrt 中内置的 dnsmasq 设置转发 DNS 查询请求到 Clash 上。因此用户不再需要修改 dnsmasq 监听的端口就可以直接使用 KoolClash。

!> 这一部分内容是关于 KoolClash 旧版本的。如果你在使用更新版本的 KoolClash，将不需要执行下述操作！

Clash 的规则依赖 Clash 接管 DNS 解析。在 `0.10.0-beta` 版本以前，KoolClash 选择由 Clash 直接接管 DNS，所以在使用 KoolClash 之前需要修改 LEDE/OpenWrt 中 dnsmasq 监听的端口：在「网络 - DHCP/DNS - 服务器设置 - 高级设置」中，找到「DNS 服务器端口」，修改为除了 53 以外任何不冲突的端口，「保存并应用」。

![](/img/usage-1.png)

## Clash 外部控制

在上传 Clash 配置文件以后，KoolClash 将会修改配置文件中 `external-controller` 字段、设置为 `[LAN IP]:6170`。这使得 KoolClash 启动的 Clash 进程可以被属于路由器所在的局域网段的设备控制。你也可以在「Clash 外部控、制」处修改 Clash 外部控制监听的 IP。

![](/img/usage-5.png)

!> KoolClash 提供修改 Clash `external-controller` Host 的功能。如果你不知道修改这一项的作用，请保留默认配置。

## 启动 Clash

上传 Clash 配置文件以后，在「运行状态」页面点击「启动/重启 Clash」启动 Clash。

?> 如果 KoolClash 没有检测到 Clash 配置文件、或者 Clash 配置文件语法不规范、或者 Clash 配置文件中没有合法的 DNS 配置，都会导致无法启动；如果 Clash 进程无法运行，可能是由于提交的 Clash 配置文件存在问题，此时 KoolClash 会自动中断启动流程并回滚一切操作，而你应该去检查 Clash 配置文件。

!> 无论是启动、重启、停止 Clash，或 KoolClash 中断或阻止了 Clash 的启动，你都应该等待插件页面提示信息的倒计时结束、页面自动刷新以后再执行操作。

KoolClash 启动以后，你可以通过检查「Clash 运行状态」和「IP 地址检查 & 网站访问检查」来判断代理运行状态。你可以通过「Clash 外部控制」中「访问 Clash 面板」或在浏览器中访问 `http://[LAN IP]/koolclash/index.html` 来访问 Clash 面板，在面板中可以切换节点、测试节点延时和查看 Clash 日志。

!> 首次访问 Clash 面板时会要求你提交外部控制设置。请严格按照 KoolClash 在插件页面中给出的外部控制设置参数进行填写！

## Clash 访问控制

### IP/CIDR 白名单

设置不通过 Clash 的 IP/CIDR 外网地址，一行一个。

?> KoolClash 的 IP/CIDR 白名单已经包含所有局域网 IP 段和保留 IP 段，无需在这里重复提交。

### Chromecast

启用 Chromecast 功能后，将会劫持使用 UDP 协议发往不位于当前 LAN 网段的 53 端口的所有请求、并转发给 Clash，最终返回 Clash 给出的解析结果（即劫持常规 DNS 解析）。

!> Clash 的 DNS 工作原理和传统 DNS、抗污染 DNS、KoolSS 的 DNS 不同，不能当做抗污染 DNS 使用，不要轻易使用该功能！

### 默认主机设置

设置 **目标端口** 的流量是否经过 Clash。

- 默认模式：设置匹配到的流量是否经过 Clash
- 目标端口：
  - 80,443：匹配目标端口为 80 和 443 的流量
  - 常用端口：匹配目标端口为 RFC 中规定的 HTTP 协议的端口和 FTP、SSH 端口的流量
  - 全部端口：匹配所有流量
  - 自定义端口：自定义需要匹配的目标端口；多个端口 **使用空格分割**

## 附加功能

### Clash 看门狗

KoolClash 实现的 Clash 进程守护工具。启用后 KoolClash 会每 20 秒检查一次 Clash 进程是否存在，如果 Clash 进程丢失则会自动重新启动 Clash 进程。

!> 注意！Clash 尚不支持保存节点选择状态！重新启动 Clash 进程可能会导致节点变动，因此务必谨慎启用该功能！

### GeoIP 数据库

Clash 使用由 [MaxMind](https://www.maxmind.com/) 提供的 [GeoLite2](https://dev.maxmind.com/geoip/geoip2/geolite2/) 解析 Geo-IP 规则。在这里可以查看当前使用的 IP 数据库版本并进行更新。


