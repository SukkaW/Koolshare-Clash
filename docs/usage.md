# 使用教程

启动 KoolClash 插件以后，Clash 会开始监听 53 端口作为 DNS。你应该前往 OpenWrt/LEDE 的「网络 - DHCP/DNS」，在「高级设置」中将「DNS 服务器端口」修改为除了 53 以外的任何不冲突的端口（如 5353、53535）。

KoolClash 没有实现自动更新 Clash 配置的功能，需要通过「更新 Clash 配置」手动更新。

```yaml
# HTTP 代理端口（必填）
port: 8888

# SOCKS5 代理端口（必填）
socks-port: 8889

# 透明代理端口
# KoolClash 在保存配置时会将其覆盖为 23456
redir-port: 23456

# 是否允许局域网设备连接
# KoolClash 在保存配置时会将其覆盖为 true
allow-lan: true

# Clash 运行模式（必填）
# Rule / Global/ Direct
mode: Rule

# Clash 输出日志等级（必填）
# info / warning / error / debug / silent
# 建议日常使用时 silent，不输出任何日志以避免内存溢出
log-level: silent

# Clash RESTful API 监听
# 建议设置成 0.0.0.0 以便路由器外网域也可以使用
external-controller: 0.0.0.0:6170

# Clash RESTful API 使用的 Secret（可选项）
# secret: ""

# DNS 设置
dns:
  enable: true
  listen: 0.0.0.0:53
  enhanced-mode: redir-host
  # 当访问一个域名时，Clash 会向 nameserver 与 fallback 列表内的所有服务器并发请求，得到域名对应的 IP 地址
  # Clash 将选取 nameserver 列表内解析最快的结果
  nameserver:
    - 119.29.29.29
    - 119.28.28.28
    - 223.6.6.6
    - 223.5.5.5
    - tls://dns.rubyfish.cn:853
  # 若 nameserver 列表内的服务器返回的解析结果中，IP 地址属于 国外，那么 Clash 将选择 fallback 列表内，解析最快的结果
  fallback:
    - tls://dns.google
    - tls://1dot1dot1dot1.cloudflare-dns.com

# (1) 如果您为了确保 DNS 解析结果无污染，请仅保留列表内以 tls:// 开头的 DNS 服务器，但是通常对于国内没有太大必要
# (2) 如果您不在乎可能解析到污染的结果，更加追求速度。请将 nameserver 列表的服务器插入至 fallback 列表内，并移除重复项
# (3) 在 Clash 的 DNS 支持 dns2docks 之前，不建议在 fallback 中使用常规方式进行解析（即直接配置 IP）
```

「更新 Clash 配置」将会从「Clash 托管配置 URL」下载最新的托管配置文件。

只有当上传的 Clash 或者下载的托管配置 Clash 配置中没有 dns 配置时才会提交 DNS 配置才会生效。