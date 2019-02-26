# 关于 KoolClash 插件

<small>From Developer of KoolClash</small>

您好。

如果您看到这条信息，很有可能是您的一位用户在向您（商业性质的公共代理服务提供商的运营者）提交技术支持申请，并在申请中附上了本文。

基于以上假设，我猜测您的服务提供了基于 Surge 或 Clash 的托管配置。

您的用户向你提交技术请求，则是因为 KoolClash 插件在介绍中提及用户使用 KoolClash 插件可能存在违反您制订的服务条款与条件的行为。本文介绍 KoolClash 一些技术细节，并对上述提到的行为进行解释。

如果您不知道什么是 Clash，您可以参看 [Clash 项目的 GitHub](https://github.com/Dreamacro/clash)。但是简单来说，Clash 就是一种基于规则的多平台代理客户端——截止至我写完本文时——兼容 Shadowsocks 和 V2Ray 的协议。

OpenWrt 作为一个 Linux 类发行版、专门用于路由器的固件。Koolshare OpenWRT 是由 Koolshare 论坛释出的修改版 OpenWRT 路由器固件、增加了 Koolshare 特有的软件中心功能，可以很方便地通过图形化界面配置插件。而 KoolClash 就是为 Koolshare OpenWRT 开发的的插件，目的是让 Clash 运行在 Koolshare OpenWRT 平台上。


为了 KoolClash 的运行需要，KoolClash 会修改 Clash 配置的以下内容：

- 透明代理端口 - 以确保不会和现有端口冲突
- 外部控制监听 - 以确保路由器域外依然可以访问 Clash 的控制端口
- 是否允许局域网连接 - 在路由器适用的 KoolClash 插件应为该路由器下所有设备提供代理
- DNS 配置 - 使用 Clash 进行透明代理时需要使用 Clash 接管 DNS
- 以及其他不涉及代理组、域名、IP、Geolocation，但涉及 Clash 本身运行设定的配置

如上所阐述，KoolClash 不会修改 涉及代理组的相关设定（包括但不限于服务器、连接端口、密码、加密和混淆方式等）、不会修改 涉及规则组的相关设定（包括但不限于域名、IP、Geolocation 等）。

据我所知，一些商业性质的公共代理服务提供商制订了条款与条件，规定如果用户更改了服务商提供的托管配置将会被视为自动放弃 SLA 和技术支持服务。KoolClash 直接修改托管配置的行为可能会违反相关条款。以上便是 KoolClash 对 可能存在的违反部分商业性质的公共代理服务提供商制订的条款与条件的行为 的说明。

如果您认为您的用户通过 KoolClash 使用您的服务会违反您制订的条款与条件，您应该向您的用户作出说明，并由您的用户选择是否放弃他的权利。如果您认为 KoolClash 的行为不构成违反您制订的条款与条件，您应该维护您的用户的权利。

顺颂商祺。
