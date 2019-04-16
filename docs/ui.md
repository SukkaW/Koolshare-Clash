# 界面介绍

## 运行状态

![](/img/ui-1.png)

- KoolClash 管理：可以获取 Clash 进程的运行状态、并控制 Clash 进程的 启动/重启 和 停止。
- IP 地址检查 和 网站访问检查：和 KoolSS 等插件的检查不同，这里的检查是通过浏览器发起的，并不是在路由器上测试。

?> IP 地址检查 和 网站访问检查 由于浏览器缓存、TCP 连接保存等问题，可能存在更新较慢、判断不准的问题，不要完全依赖其的判断。

- Clash 外部控制：在这里你可以看到 Clash 的 `external-controller` 参数，并且可以设置 Clash 外部控制监听的 IP、访问 Clash 面板。

## 配置文件

![](/img/ui-2.png)

- KoolClash 配置文件：你可以手动上传 Clash 配置文件或提交 Clash 托管配置的 URL。
- DNS 配置：Clash 的 DNS 设置。

## 访问控制

![](/img/ui-3.png)

- IP/CIDR 白名单：不通过 Clash 的 IP/CIDR 外网地址，一行一个
- Chromecast 开关：是否劫持局域网内的 DNS 请求到 Clash

- 默认主机设置：Clash 全局代理控制

## 附加功能

![](/img/ui-4.png)

- Clash 看门狗：Clash 进程守护开关
- GeoIP 数据库：查看当前 IP 数据库版本和更新

## 操作日志

输出 KoolClash 的操作日志。

## 调试工具

点击「获取 KoolClash 调试信息」后可以打印去敏后的调试信息，在向开发者反馈问题时附上调试日志可以帮助开发者更好的定位问题。
