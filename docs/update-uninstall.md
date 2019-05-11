# 更新与卸载

## 更新

?> 如果你正在使用 `Pre-release` 版本的 KoolClash，你可能需要卸载当前的版本之后重新安装 `Release` 版本。

?> 如果你正在运行早于 `0.10.0-beta` 版本的 KoolClash，你需要卸载当前的版本之后重新安装 `0.10.0-beta` 及其之后的版本。

?> 如果你正在运行早于 `0.16.2` 及其以前版本的 KoolClash，你需要卸载当前的版本之后重新安装 `0.17.0-beta` 及其之后的版本；你还需要修改你的 Clash 配置文件为 `fake-ip`。

KoolClash 在每次用户访问插件界面时都会检查 KoolClash 的版本信息。如果检测到当前安装的 KoolClash 和最新发布的 KoolClash 版本号不符（不论当前用户安装了旧版本、或者是未发布的内测版本的 KoolClash），则会提示用户可以前往 GitHub Release 页面检查是否有新版本发布。

![](/img/update.png)

在 GitHub Release 下载了新版本 KoolClash 的安装包 `koolclash.tar.gz`，前往「koolshare Openwrt 软件中心」使用「离线安装」执行安装即可更新。

!> 如果 KoolClash 更新时 Clash 进程仍在运行，KoolClash 会先停止 Clash 之后再继续安装。在更新 KoolClash 时，软件中心可能会出现「软件中心异常」的红字提示，这是正常现象、KoolClash 安装进程仍在继续，请不要刷新或关闭页面、务必等待安装完成！

## 卸载

!> 卸载 KoolClash 之前，必须先停止 Clash 进程！

在「koolshare Openwrt 软件中心」找到 KoolClash，直接点击「卸载」即可。KoolClash 卸载后软件中心页面会自动刷新。
