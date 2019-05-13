# 更新与卸载

## 更新

?> 如果你正在使用 `Pre-release` 版本的 KoolClash，你可能需要卸载当前的版本之后重新安装 `Release` 版本。

!> 在更新之前，先阅读「更新迁移指导」！

KoolClash 在每次用户访问插件界面时都会检查 KoolClash 的版本信息。如果检测到当前安装的 KoolClash 和最新发布的 KoolClash 版本号不符（不论当前用户安装了旧版本、或者是未发布的内测版本的 KoolClash），则会提示用户可以前往 GitHub Release 页面检查是否有新版本发布。

![](/img/update.png)

在 GitHub Release 下载了新版本 KoolClash 的安装包 `koolclash.tar.gz`，前往「koolshare Openwrt 软件中心」使用「离线安装」执行安装即可更新。

!> 如果 KoolClash 更新时 Clash 进程仍在运行，KoolClash 会先停止 Clash 之后再继续安装。在更新 KoolClash 时，软件中心可能会出现「软件中心异常」的红字提示，这是正常现象、KoolClash 安装进程仍在继续，请不要刷新或关闭页面、务必等待安装完成！

## 更新迁移指导

### 升级至 0.10.0-beta

?> 如果你正在试图从早于 `0.10.0-beta` 版本的 KoolClash 升级至 `0.10.0-beta` 及其之后的版本，你需要执行以下操作。

你需要卸载当前的、早于 `0.10.0-beta` 版本的 KoolClash 之后，重新安装 `0.10.0-beta` 或者之后的版本。

### 升级至 0.17.0-beta 和

?> 如果你正在试图从早于 `0.16.2` 版本的 KoolClash 升级至 `0.17.0-beta` 及其之后的版本，你需要执行以下操作。

!> 从 `0.17.0-beta` 版本开始，KoolClash 不再适合安装在主路由上，建议将 KoolClash 安装在旁路网关上使用！

如果你正在运行早于 `0.16.2` 及其以前版本的 KoolClash，你需要卸载当前的版本之后重新安装 `0.17.0-beta` 及其之后的版本。
你还需要修改你的 Clash 配置文件，将 `dns.enhanced-mode` 字段值修改为 `fake-ip`；在 Clash 进程启动后修改连接网络的设备的 DNS 为 `198.19.0.1` 和 `198.19.0.2` 才可以正常使用 KoolClash。具体参见更新后的 [使用教程](usage)。

## 卸载

!> 卸载 KoolClash 之前，必须先停止 Clash 进程！

在「koolshare Openwrt 软件中心」找到 KoolClash，直接点击「卸载」即可。KoolClash 卸载后软件中心页面会自动刷新。
