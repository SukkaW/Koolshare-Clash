<title>KoolShare Clash 插件</title>
<content>
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="/js/tomato.js"></script>
    <script type="text/javascript" src="/js/advancedtomato.js"></script>
    <script type="text/javascript" src="/layer/layer.js"></script>
    <style type="text/css">
        .box,
        #clash_tabs {
            min-width: 720px;
        }

        .koolclash-divider {
            content: '|';
            margin: 0 5px;
        }

        .koolclash-btn-container {
            padding: 4px;
            padding-left: 8px;
        }

        hr {
            opacity: 1;
            border: 1px solid #ddd;
            margin: 1rem 0;
        }

    </style>
    <div class="box">
        <div class="heading">
            <a style="padding-left: 0; color: #0099FF" href="https://koolclash.js.org" target="_blank">KoolClash</a>
            <a href="#/soft-center.asp" class="btn" style="float: right; margin-right: 5px; border-radius:3px; margin-top: 0px;">返回</a>
            <!--<a href="https://github.com/koolshare/ledesoft/blob/master/v2ray/Changelog.txt" target="_blank"
                class="btn btn-primary" style="float:right;border-radius:3px;margin-right:5px;margin-top:0px;">更新日志</a>-->
            <!--<button type="button" id="updateBtn" onclick="check_update()" class="btn btn-primary" style="float:right;border-radius:3px;margin-right:5px;margin-top:0px;">检查更新 <i class="icon-upgrade"></i></button>-->
        </div>
        <div class="content">
            <div class="col" style="line-height:30px;">
                <p>Clash 是一个基于规则的代理程序，兼容 Shadowsocks、V2Ray 等协议，拥有像 Surge 一样强大的代理规则。</p>
                <p>KoolClash 是 Clash 在 Koolshare OpenWrt 上的客户端</p>

                <p style="margin-top: 10px"><a href="https://github.com/Dreamacro/clash">Clash on GitHub</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="https://github.com/SukkaW/Koolshare-Clash" target="_blank">KoolClash on GitHub</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="https://koolclash.js.org" target="_blank">KoolClash 使用文档</a></p>
            </div>
        </div>
    </div>

    <div class="box">
        <div class="heading" style="color: red">
            ！！请注意！！
        </div>
        <div class="content">
            <div class="col" style="line-height:30px; color: brown">
                <p>在使用 Clash 之前，请务必仔细阅读 <a href="https://koolclash.js.org" target="_blank">KoolClash 的使用文档！!</a>
            </div>
        </div>
    </div>

    <div class="box">
        <div class="heading">KoolClash 运行状态</div>

        <div class="content">
            <!-- ### KoolClash 运行状态 ### -->
            <div id="koolclash-field"></div>
            <div class="koolclash-btn-container">
                <button type="button" id="koolclash-btn-save-config" onclick="restartClash()" class="btn btn-primary">启动/重启 Clash</button>
                <button type="button" id="koolclash-btn-save-config" onclick="stopClash()" class="btn">停止 Clash</button>
            </div>
        </div>
    </div>

    <div class="box">
        <div class="heading">KoolClash 配置</div>

        <div class="content">
            <!-- ### KoolClash 运行配置设置 ### -->
            <div id="koolclash-config"></div>
            <div class="koolclash-btn-container">
                <button type="button" id="koolclash-btn-save-config" onclick="saveRemoteConfigUrl()" class="btn btn-primary">提交 Clash 托管配置 URL</button>
                <button type="button" id="koolclash-btn-save-config" onclick="updateRemoteConfig()" class="btn btn-primary">更新 Clash 配置</button>
                <p style="margin-top: 4px"><small>「更新 Clash 配置」将会从「Clash 托管配置 URL」下载最新的托管配置文件并生效「Clash 运行配置」。</small></p>
            </div>
        </div>
    </div>

    <script>
        let KoolClash = {
            defaultConfig: `
port: 8888
socks-port: 8889
redir-port: 23456
allow-lan: true
mode: Rule
log-level: info
external-controller: '0.0.0.0:6170'
dns:
  enable: true
  listen: 0.0.0.0:53
  enhanced-mode: redir-host
  nameserver:
    - 119.29.29.29
    - 223.5.5.5
    - tls://dns.rubyfish.cn:853
  fallback:
    - tls://dns.google
    - tls://1dot1dot1dot1.cloudflare-dns.com
`,
        };




        $('#koolclash-field').forms([
            {
                title: '<b>Clash 运行状态</b>',
                text: '<span id="_koolclash_status" name="koolclash_status" color="#1bbf35">正在获取 Clash 进程状态...</span>'
            },
            {
                title: '&nbsp;',
                text: '<p>查看代理运行状态请访问 <a href="https://ip.skk.moe/?from=koolclash_plugin" target="_blank">IP.SKK.MOE</a> 查看自己的 IP</p>'
            },
            {
                title: '<b>Clash 面板</b>',
                text: '<p><a href="https://clashx.skk.moe" target="_blank">Clash Dashboard</a>（请 <span style="font-weight: bold">务必使用 Chrome 浏览器</span> 访问）</p>'
            },
        ]);

        $('#koolclash-config').forms([
            {
                title: '<b>Clash 托管配置 URL</b>',
                name: 'koolclash-remote-config-url',
                type: 'text',
                value: '', // Clash.remote_config_url || '';
                style: `width:100%`,
                placeholder: 'https://example.com/clash'
            },
            {
                title: `<b>Clash 运行配置</b>`,
                name: 'koolclash-config-headeer',
                type: 'textarea',
                value: Base64.decode(dbus.ss_isp_website_web) || KoolClash.defaultConfig,
                style: 'width: 100%; height: 300px;'
            },
        ]);
    </script>
    <div id="msg_warring" class="alert alert-warning icon" style="display:none;"></div>
    <div id="msg_success" class="alert alert-success icon" style="display:none;"></div>
    <div id="msg_error" class="alert alert-error icon" style="display:none;"></div>
</content>
