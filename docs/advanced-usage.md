# 进阶用法

## 搭配 smartdns 使用

[SmartDNS](https://pymumu.github.io/smartdns/) 是一个递归 DNS 服务器，通过同时向上游多个 DNS 服务器发起解析请求，并对每个解析结果的 IP 进行 TCP 握手，得到延时最短的 IP。使用 smartdns 可以极大的加快上网速度（减少 HTTP 延时）并从一定程度上缓解 DNS 污染。
SmartDNS 提供 ipk 安装包和 Luci 界面，支持在 OpenWRT 上使用。如果在 Koolshare OpenWRT 上安装 SmartDNS，可能需要安装 `OpenSSL 1.0.2`。旧版本的 OpenSSL 下载指南和 SmartDNS ipk 下载请前往 SmartDNS 的 [GitHub Release 页面](https://github.com/pymumu/smartdns/releases)

安装完 SmartDNS 后，Luci 界面可以从 `服务 - SmartDNS` 进入。如何配置 SmartDNS 请参考 SmartDNS 的文档和 README，此处不再赘述。

!> 注意，在设置 SmartDNS 时，一定要将 SmartDNS 的工作模式（在最新版 SmartDNS Luci 中显示为 `重定向`）设置为 **none**！在这里 SmartDNS 仅作为 Clash DNS 的上游，**不可以** 作为整个路由器的 DNS 或者 dnsmasq 的上游使用！

在启用 SmartDNS 以后，修改 Clash 配置文件、或者通过 KoolClash 的编辑 `自定义 DNS` 的方式，将 `dns.nameserver` 修改为仅一个 `LAN IP:6053`（LAN IP 是你的旁路网关的 IP，6053 是 SmartDNS 的默认运行端口。请根据自己的实际情况进行修改），如果没有必要（所在地的 DNS 污染不非常严重）可以不设置 `dns.fallback` 以加快上网速度。
