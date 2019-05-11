<h1 align="center">
    <img src="https://koolclash.js.org/img/koolclash.png" alt="Clash" width="120">
    <br>KoolClash
</h1>

<p align="center">
A rule based custom proxy for Koolshare OpenWrt/LEDE based on <a href="https://github.com/Dreamacro/clash" target="_blank">Clash</a>.
<br>
<a href="https://koolclash.js.org">Documentation(zh-Hans)</a> |
<a href="https://github.com/SukkaW/Koolshare-Clash/releases">Download</a>
</p>

<p align="center">
    <!--<a href="https://travis-ci.org/SukkaW/KoolShare-Clash">
        <img src="https://img.shields.io/travis/SukkaW/KoolShare-Clash.svg?style=flat-square" alt="Travis-CI">
    </a>-->
    <a href="https://github.com/SukkaW/Koolshare-Clash/releases" target="_blank">
        <img src="https://img.shields.io/github/release/SukkaW/Koolshare-Clash/all.svg?style=flat-square">
    </a>
    <a href="https://github.com/Dreamacro/clash" target="_blank">
        <img src="https://img.shields.io/badge/Clash-0.14.0-1c4070.svg?style=flat-square"/>
    </a>
    <a href="https://github.com/SukkaW/Koolshare-Clash/blob/master/LICENSE">
        <img src="https://img.shields.io/github/license/sukkaw/koolshare-clash.svg?style=flat-square"/>
    </a>
</p>

<p align="center">
    <img src="https://i.loli.net/2019/04/16/5cb5e4b579a44.png">
</p>

> KoolClash is for `Koolshare OpenWrt/LEDE x86_64`. Use [Clash for OpenWrt](https://github.com/frainzy1477/clash/) if you are running original OpenWrt.

## Keywords

- [Clash](https://github.com/Dreamacro/clash) : A multi-platform & rule-base tunnel
- **[KoolClash](https://koolclash.js.org) : This project, a rule based custom proxy for [Koolshare OpenWrt/LEDE](http://koolshare.cn/forum-97-1.html) based on Clash.**

## Features

- HTTP/HTTPS and SOCKS protocol
- Surge like configuration
- GeoIP rule support
- Support Vmess/Shadowsocks/Socks5
- Support for Netfilter TCP redirect

Besides those features that Clash have, KoolClash has more:

- Install clash and upload config to [Koolshare OpenWrt/LEDE X86](https://firmware.koolshare.cn/LEDE_X64_fw867/)
- ~~Transparent proxy for all of your devices~~
- Surge Enhanced Mode like proxy gateway

## Installation

Download latest `koolshare.tar.gz` from [GitHub Release](https://github.com/SukkaW/Koolshare-Clash/releases), and then upload to Koolshare OpenWrt/LEDE Soft Center as offline installation.

Read the [detailed installation instructions (written in Chinese)](https://koolclash.js.org/#/install) for more details.

## Build

```bash
$ git clone https://github.com/SukkaW/Koolshare-Clash.git
$ cd Koolshare-Clash
$ ./build # Get usage information
$ ./build pack # Build the package
$ ./build ipdb # Update Country.mmdb to latest
$ ./build dashboard # Update clash-dashboard to latest
```

## Clash on Other Platforms

- [Clash for Windows](https://github.com/Fndroid/clash_for_windows_pkg) : A Windows GUI based on Clash
- [clashX](https://github.com/yichengchen/clashX) : A rule based custom proxy with GUI for Mac base on clash
- [ClashA](https://github.com/ccg2018/ClashA) : An Android GUI for Clash
- [Clash for OpenWrt](https://github.com/frainzy1477/clash) : A rule based custom proxy for OpenWrt based on Clash.

## Contributions

[Report a Bug](https://github.com/SukkaW/Koolshare-Clash/issues/new/choose) | [Improve Documentations](https://github.com/SukkaW/Koolshare-Clash/tree/master/docs) | [Fork & Open a New PR](https://github.com/SukkaW/Koolshare-Clash/fork)

All kinds of contributions (enhancements, new features, documentation & code improvements, issues & bugs reporting) are welcome.

## License

KoolClash is released under the GPL-3.0 License - see the [LICENSE](https://github.com/SukkaW/Koolshare-Clash/blob/master/LICENSE) file for details.

Also, this project includes [GeoLite2](https://dev.maxmind.com/geoip/geoip2/geolite2/) data created by [MaxMind](https://www.maxmind.com).

## Sponsors

[![Dler Cloud](https://img.vim-cn.com/7e/dbc9122a41f7eadbab889a9037ef6232cbea51.png)](https://dlercloud.org)

## Maintainer

**KoolClash** © [Sukka](https://github.com/SukkaW), Released under the [GPL-3.0]([./LICENSE](https://github.com/SukkaW/Koolshare-Clash/blob/master/LICENSE)) License.<br>
Authored and maintained by [Sukka](https://github.com/SukkaW) with help from contributors ([list](https://github.com/SukkaW/Koolshare-Clash/contributors)).

> [Personal Website](https://skk.moe) · [Blog](https://blog.skk.moe) · GitHub [@SukkaW](https://github.com/SukkaW) · Telegram Channel [@SukkaChannel](https://t.me/SukkaChannel) · Twitter [@isukkaw](https://twitter.com/isukkaw) · Keybase [@sukka](https://keybase.io/sukka)
