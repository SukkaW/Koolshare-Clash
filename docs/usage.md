# 使用教程

## 上传 Clash 配置文件

KoolClash 提供了两种配置文件上传方式，直接上传和提交托管订阅。

?> KoolClash 不支持 Clash 配置文件的编写或生成，只支持上传和托管订阅更新。一是因为我想要降低 KoolClash 的维护难度，二是目前已经有很多完善的工具可以轻易生成或是转换 Clash 配置文件了。如果你实在无法自行生成 Clash 配置文件，可以购买支持 Clash 并提供 Clash 托管订阅的商业性质的公共代理服务（如 rixCloud 和 DlerCloud）。

在「配置文件」页面的「Clash 配置上传」选择 Clash 配置文件并点击右侧的「上传」即可上传 Clash 配置文件到 KoolClash 中。

![](/img/usage-2.png)

KoolClash 也支持自动从托管配置自动下载更新 Clash 配置文件，在「Clash 托管配置 URL」中输入 Clash 托管配置的 URL 地址，然后点击「更新 Clash 托管配置」的按钮，KoolClash 会自动记忆你填入的 Clash 托管配置的 URL，并开始从这个 URL 下载 Clash 配置文件。

?> KoolClash 托管配置功能尚不支持自动更新，你需要手动到 KoolClash 后台点击更新。

当你上传了新的 Clash 配置文件后，KoolClash 将会修改你的 Clash 配置文件：

- 将 `allow-lan` 设置为 `true`
- 将 `redir-port` 设置为 `23456`
- 将 `external-ui` 设置为 Clash 控制面板所在的绝对路径（仅限于 KoolClash 0.17.0-beta 之后的版本）
- 修改 `external-controller`，详情请查看本页文档的「Clash 外部控制」部分。

## 设置 Clash 自定义 DNS 配置

如果你当前没有上传 Clash 配置文件、或者没有添加 Clash 托管配置 URL 并下载，KoolClash 将不允许你添加 自定义 DNS 配置。

当你上传了一个 `Clash 配置文件`、或提交了托管配置更新，KoolClash 会自动检查你上传的 `Clash 配置文件` 有没有包含 `合法的 DNS 配置`。如果 KoolClash 检测到你当前 `Clash 配置文件` 中没有包含 `合法的 DNS 配置`，KoolClash 会强制你你添加 `自定义 DNS 配置`：

![](/img/usage-0.png)

> `合法的 DNS 配置` 包括
> - `dns.enable = true`
> - `dns.enhanced-mode = redir-host`（KoolClash 0.16.2 及其之前的版本）
> - `dns.enhanced-mode = fake-ip`（KoolClash 0.16.2 之后的版本）

?> 为了保证兼容性，当上传了一个 `dns.enhanced-mode` 为 `redir-host` 的 `Clash 配置文件` 时，KoolClash 会自动将 `dns.enhanced-mode` 修改为 `fake-ip`，并将该 `Clash 配置文件` 视为包含 `合法的 DNS 配置`。

以下是一个 **适用于 KoolClash 0.16.2 及其之前的版本** 的推荐的 `自定义 DNS 配置` 的示范：

```yaml
dns:
  enable: true
  listen: 0.0.0.0:53
  enhanced-mode: fake-ip
  nameserver:
    - 119.29.29.29
    - 119.28.28.28
    - 223.6.6.6
    - 223.5.5.5
    - tls://dns.rubyfish.cn:853
  fallback:
    - tls://dns.rubyfish.cn:853
    - tls://8.8.4.4:853
    - tls://1.0.0.1:853
```

以下是一个 **适用于 KoolClash 0.16.2 之后的版本** 的推荐的 `自定义 DNS 配置` 的示范：

```yaml
dns:
  enable: true
  ipv6: false
  listen: 0.0.0.0:53
  enhanced-mode: fake-ip
  nameserver:
    - 119.29.29.29
    - 119.28.28.28
    - 182.254.116.116
```

> 注：以上三个 IP 均为腾讯公共 DNS 的 IP

?> 使用 Fake IP 以后，DNS 污染问题不严重的地区（绝大部分地区）可不设置 fallback 组。如有必要，建议仅在 fallback 组中添加一条 `tls://dns.rubyfish.cn:853` 即可。

KoolClash 会自动记忆你提交的 `自定义 DNS 配置`，并把 `自定义 DNS 配置` 和你上传的 `Clash 配置文件` 以覆盖的方式合并。并且在下次你上传没有包含 `合法的 DNS 配置` 的 `Clash 配置文件` 时，KoolClash 会自动将你提交过的 `自定义 DNS 配置` 以覆盖的方式合并到 `Clash 配置文件` 中。你还可以通过重新提交新的 `自定义 DNS 配置` 以更新现有 `Clash 配置文件` 中的 DNS 配置。

如果你上传的 `Clash 配置文件`已经包含 `合法的 DNS 配置`，此时 KoolClash 不需要你添加 `自定义 DNS 配置` 也能运行。

![](/img/usage-4.png)

此时你可以勾选「DNS 配置开关」并提交 `自定义 DNS 配置`，KoolClash 会用你提交的 `自定义 DNS 配置` 来覆盖现有的 `Clash 配置文件` 中已有的 DNS 配置。

?> 在 `0.14.1-beta` 版本之前，无论你是否提交过 `自定义 DNS 配置`，当你通过上传或者更新托管配置的方式提交一个包含 `合法的 DNS 配置` 的 `Clash 配置文件` 时，KoolClash 都不会用 `自定义 DNS 配置` 覆盖你上传的 `Clash 配置文件` 中的 DNS 配置。你需要重新勾选「DNS 配置开关」并重新提交 `自定义 DNS 配置`。

?> 从 `0.14.1-beta` 开始，如果你曾经使用 `自定义 DNS 配置` 覆盖过现有 `Clash 配置文件` 中的 DNS 配置，那么在你下次提交一个包含 `合法的 DNS 配置` 的 `Clash 配置文件` 时，KoolClash 将自动用 `自定义 DNS 配置` 覆盖你上传的 `Clash 配置文件` 中的 DNS 配置。

不论你上传的 `Clash 配置文件` 包含 `合法的 DNS 配置`、还是你使用 `自定义 DNS 配置` 以覆盖的方式合并进 `Clash 配置文件`，KoolClash 均会修改你的 Clash 配置文件：

- 将 `dns.listen` 修改为 `0.0.0.0:23453`
- 将 `dns.enhanced-mode` 修改为 `fake-ip`（仅限于 KoolClash 0.16.2 之后的版本）
- 将 `dns.fake-ip-range` 修改为 `198.18.0.1/16`（仅限于 KoolClash 0.16.2 之后的版本）

## ~~修改 dnsmasq 监听端口~~

?> 从 KoolClash `0.10.0-beta` 版本开始，KoolClash 会自动修改 Clash 将 DNS Server 运行在 23453 端口上，并将 LEDE/OpenWrt 中内置的 dnsmasq 设置转发 DNS 查询请求到 Clash 上。因此用户不再需要修改 dnsmasq 监听的端口就可以直接使用 KoolClash。

?> 从 KoolClash `0.17.0-beta` 版本开始，KoolClash 会自动修改 Clash 将 DNS Server 运行在 23453 端口上，同时不再令 dnsmasq 转发 DNS 查询请求转发给 Clash DNS。

!> 这一部分内容是关于 KoolClash 旧版本的。如果你在使用 `0.10.0-beta` 及更新版本的 KoolClash，将不需要执行下述操作！

Clash 的规则依赖 Clash 接管 DNS 解析。在 `0.10.0-beta` 版本以前，KoolClash 选择由 Clash 直接接管 DNS，所以在使用 KoolClash 之前需要修改 LEDE/OpenWrt 中 dnsmasq 监听的端口：在「网络 - DHCP/DNS - 服务器设置 - 高级设置」中，找到「DNS 服务器端口」，修改为除了 53 以外任何不冲突的端口，「保存并应用」。

![](/img/usage-1.png)

## Clash 外部控制

在上传 Clash 配置文件以后，KoolClash 将会修改配置文件中 `external-controller` 字段、设置为 `[LAN IP]:6170`。Clash 进程在启动时会在这个地址监听一个 RESTful API Server 用于控制 Clash（比如搭配 Clash 控制面板使用）。
由于 KoolClash 将其设置为 KoolClash 所在设备的 LAN IP，这使得当前网段下的设备都可以控制 Clash。

![](/img/usage-5.png)

!> KoolClash 提供修改 Clash `external-controller` Host 的功能，这可以用于修改 RESTFul API Server 监听的网段。如果你不知道修改这一项的作用，请保留默认配置（LAN IP）。KoolClash 会记忆你提交的自定义 Host，并在下次上传 Clash 配置文件时将你提交的 Host 写入 `external-controller`。如果你提交了一个空的 Host 配置，KoolClash 将会把 Host 配置恢复为默认（LAN IP）。

## 启动 Clash

?> 从 KoolClash `0.17.0-beta` 版本开始，KoolClash 使用了 Clash DNS 的 `fake-ip`，实现了与 Surge 增强模式类似的代理网关。因此 KoolClash 将不适合安装在主路由上使用，因为这会导致主路由下所有设备的所有流量均经过 Clash。建议将 KoolClash 作为旁路网关使用，并只为需要使用 Clash 的设备修改网关和 DNS。

!> 从 KoolClash `0.17.0-beta` 版本开始，KoolClash 将会占用 `198.18.0.0/16` 和 `198.19.0.0/16` 用于 Fake IP 和 Fake DNS，请确保这两个 IP 段没有被占用。

上传 Clash 配置文件以后，在「运行状态」页面点击「启动/重启 Clash」启动 Clash。

?> 如果 KoolClash 没有检测到 Clash 配置文件、或者 Clash 配置文件中没有合法的 DNS 配置，都会直接导致无法启动；如果 Clash 进程无法运行，可能是由于提交的 Clash 配置文件存在语法问题，此时 KoolClash 会自动中断启动流程并回滚一切操作，而你应该去检查 Clash 配置文件。

!> 无论是启动、重启、停止 Clash 进程，或因为某些原因 KoolClash 中断、阻止了 Clash 的启动，你都应该等待插件页面提示信息的倒计时结束、页面自动刷新以后再执行进一步操作。

KoolClash 启动以后，你可以通过检查「Clash 运行状态」和「IP 地址检查 & 网站访问检查」来判断代理运行状态。你可以通过「Clash 外部控制」中「访问 Clash 面板」或在浏览器中访问 `http://[LAN IP]:6170/ui/` 来访问 Clash 面板，在面板中可以切换节点、测试节点延时和查看 Clash 日志。

!> 首次访问 Clash 面板时会要求你填写外部控制设置。请严格按照 KoolClash 在插件页面中给出的外部控制设置参数填写 `Host` 和 `端口`！

?> `secret` 应和你在 Clash 配置文件中的 `secret` 一致；如果 Clash 配置文件中没有设置 `secret`，可以不在 Clash 面板中填写。

## 修改联网设备的网络设置

!> 这一部分内容是关于 KoolClash 新版本的。如果你在使用早于 `0.17.0-beta` 版本的 KoolClash，将不需要执行下述操作！

启动 KoolClash 后，修改你的设备的网络设置，将网关设置为你安装 KoolClash 的设备的 LAN IP，将 DNS 修改为 `198.19.0.0/24` 中的任何 1~2 个 IP。

?> 直接把主 DNS 改成 `198.19.0.1`、备 DNS 改成 `198.19.0.2` 就行。

!> 如果 DNS 被修改为网关 IP 或其它 DNS，设备的流量仍然会经过 Clash，但 Clash 的域名规则将无法生效，同时设备也会被暴露在 DNS 污染的风险下。

除了手动为需要的设备修改 DNS 和网关，你也可以直接修改当前局域网内 DHCP Server（通常是你的主路由）的配置、为所有设备统一下发网关和 DNS。

修改完毕以后，你的设备就可以通过 KoolClash 上网了。

!> 当你停止 KoolClash 以后，应当立刻将各个设备的 DNS 设置恢复到之前的状态。如果在停止 KoolClash 并修改了设备的 DNS 设置以后，该设备还是无法恢复联网，请刷新设备的 DNS 缓存。

----

执行完以上步骤后，你应当已经可以通过 Clash 上网。接下来介绍 Clash 其它功能的使用方法。

## Clash 访问控制

### IP/CIDR 白名单

设置不通过 Clash 的 IP/CIDR 外网地址，一行一个。

?> KoolClash 的 IP/CIDR 白名单已经包含所有局域网 IP 段和保留 IP 段，无需在这里重复提交。

### ~~Chromecast~~

?> 从 KoolClash `0.17.0-beta` 版本开始，KoolClash 使用 Clash 的 Fake-IP 和 KoolClash 自己实现的 Fake-DNS，不再提供 Chromecast 功能。

!> 这一部分内容是关于 KoolClash 旧版本的。如果你在使用 `0.17.0-beta` 及更新版本的 KoolClash，将不能执行下述操作！

启用 Chromecast 功能后，将会劫持使用 UDP 协议发往不位于当前 LAN 网段的 53 端口的所有请求、并转发给 Clash，最终返回 Clash 给出的解析结果（即劫持常规 DNS 解析）。

!> Clash 的 DNS 工作原理和传统 DNS、抗污染 DNS、KoolSS 的 DNS 不同，不能当做抗污染 DNS 使用，不要轻易使用该功能！

### ~~默认主机设置~~

?> 从 KoolClash `0.17.0-beta` 版本开始，KoolClash 使用 Fake-IP 模式运行，使用 iptables 的方式实现访问控制已经毫无意义。从 KoolClash `0.17.1-beta` 版本开始，KoolClash 正式去除了访问控制功能。你应该通过编写 Clash 配置文件的方式实现访问控制。

!> 这一部分内容是关于 KoolClash 旧版本的。如果你在使用 `0.17.0-beta` 及更新版本的 KoolClash，将不能执行下述操作！

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

?> 不建议使用手动用自己的 IP 数据库替换内置的 GeoLite 数据库。点击「更新 IP 数据库」以后将会被新下载的 GeoLite 数据库覆盖。
