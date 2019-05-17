<title>KoolClash - Clash for Koolshare OpenWrt/LEDE</title>
<content>
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="/res/koolclash_base64.js"></script>
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
            border: 1px solid #ccc;
            margin: 1rem 0;
        }

        #koolclash-ip .ip-title {
            font-weight: bold;
            color: #444;
        }

        #koolclash-ip .sk-text-success {
            color: #32b643
        }

        #koolclash-ip .sk-text-error {
            color: #e85600
        }

        #koolclash-ip p {
            margin: 2px 0;
        }

        #koolclash-btn-upload {
            margin-bottom: 8px;
            margin-left: 4px;
        }

        #koolclash-btn-submit-watchdog {
            margin-bottom: 5px;
            margin-left: 8px;
        }

        #koolclash-dns-msg {
            font-size: 85%;
            margin-top: 8px
        }

        #koolclash-config-dns {
            margin-top: 16px;
        }

        #_koolclash_config_suburl {
            width: 61.8%;
        }

        #koolclash-version-msg {
            font-size: 14px;
        }

        fieldset .help-block {
            margin: 0;
        }

        label {
            cursor: default;
        }

        label.koolclash-nav-label {
            padding: 0;
            cursor: pointer;
        }

        .koolclash-nav-radio {
            display: none;
        }

        .koolclash-nav-tab {
            display: block;
            padding: 0 15px;
            height: 40px;
            font-weight: normal;
            line-height: 40px;
            text-shadow: 0 1px 0 rgba(255, 255, 255, 0.2);
            transition: all 100ms ease;
            -webkit-transition: all 100ms ease;
            text-decoration: none;
            outline: 0;
        }

        .koolclash-nav-tab:hover {
            z-index: 999;
            color: #777777;
            background: rgba(0, 0, 0, 0.05);
            border-bottom: 2px solid rgba(0, 0, 0, 0.05);
            text-decoration: none;
        }


        #koolclash-nav-overview:checked~.nav-tabs .koolclash-nav-overview>.koolclash-nav-tab,
        #koolclash-nav-config:checked~.nav-tabs .koolclash-nav-config>.koolclash-nav-tab,
        #koolclash-nav-firewall:checked~.nav-tabs .koolclash-nav-firewall>.koolclash-nav-tab,
        #koolclash-nav-additional:checked~.nav-tabs .koolclash-nav-additional>.koolclash-nav-tab,
        #koolclash-nav-log:checked~.nav-tabs .koolclash-nav-log>.koolclash-nav-tab,
        #koolclash-nav-debug:checked~.nav-tabs .koolclash-nav-debug>.koolclash-nav-tab {
            border-bottom: 2px solid #f36c21;
            background: transparent;
            z-index: 999;
            color: #777777;
        }

        .tab-content>* {
            display: none;
        }

        #koolclash-nav-overview:checked~.tab-content>#koolclash-content-overview,
        #koolclash-nav-config:checked~.tab-content>#koolclash-content-config,
        #koolclash-nav-firewall:checked~.tab-content>#koolclash-content-firewall,
        #koolclash-nav-additional:checked~.tab-content>#koolclash-content-additional,
        #koolclash-nav-log:checked~.tab-content>#koolclash-content-log,
        #koolclash-nav-debug:checked~.tab-content>#koolclash-content-debug {

            display: block;
        }

        #_koolclash_log {
            max-width: 100%;
            min-width: 100%;
            margin: 0;
            min-height: 300px;
            max-height: 500px;
            font-family: Consolas, "Panic Sans", "DejaVu Sans Mono", Monaco, "Bitstream Vera Sans Mono", 'Andale Mono', Menlo, monospace !important;
        }

        #_koolclash_debug_info {
            max-width: 100%;
            min-width: 100%;
            margin: 0;
            min-height: 600px;
            font-family: Consolas, "Panic Sans", "DejaVu Sans Mono", Monaco, "Bitstream Vera Sans Mono", 'Andale Mono', Menlo, monospace !important;
        }

        table.line-table tr:nth-child(even) {
            background: rgba(0, 0, 0, 0.04)
        }

        table.line-table tr:hover {
            background: #D7D7D7
        }

        table.line-table tr:hover .progress {
            background: #D7D7D7
        }

        /*#koolclash-acl-default-panel {
            margin-top: 16px;
        }*/

    </style>
    <script>
        if (typeof softcenter === undefined) {
            let softcenter = 0;
        } else {
            softcenter = 0;
        }
    </script>

    <div class="box">
        <div class="heading">
            <a style="padding-left: 0; color: #0099FF; font-size: 20px;" href="https://koolclash.js.org" target="_blank">KoolClash - Clash for Koolshare OpenWrt/LEDE</a>
            <a href="#/soft-center.asp" class="btn" style="float: right; margin-right: 5px; border-radius:3px; margin-top: 0px;">返回</a>
            <br>
            <span id="koolclash-version-msg"></span>
            <!--<a href="https://github.com/koolshare/ledesoft/blob/master/v2ray/Changelog.txt" target="_blank"
                class="btn btn-primary" style="float:right;border-radius:3px;margin-right:5px;margin-top:0px;">更新日志</a>-->
            <!--<button type="button" id="updateBtn" onclick="check_update()" class="btn btn-primary" style="float:right;border-radius:3px;margin-right:5px;margin-top:0px;">检查更新 <i class="icon-upgrade"></i></button>-->
        </div>
        <div class="content">
            <div class="col" style="line-height: 30px;">
                <p style="margin-top: 4px">Clash 是一个基于规则的代理程序，兼容 Shadowsocks、Vmess 等协议，拥有像 Surge 一样强大的代理规则。</p>
                <p>KoolClash 是 Clash 在 Koolshare OpenWrt 上的客户端。</p>

                <p style="margin-top: 12px"><a href="https://github.com/Dreamacro/clash">Clash on GitHub</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="https://koolclash.js.org" target="_blank">KoolClash 使用文档</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="https://github.com/SukkaW/Koolshare-Clash/releases" target="_blank">KoolClash 更新日志</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="https://github.com/SukkaW/Koolshare-Clash" target="_blank">KoolClash on GitHub</a></p>
            </div>
        </div>
    </div>


    <input class="koolclash-nav-radio" id="koolclash-nav-overview" type="radio" name="nav-tab" checked>
    <input class="koolclash-nav-radio" id="koolclash-nav-config" type="radio" name="nav-tab">
    <input class="koolclash-nav-radio" id="koolclash-nav-firewall" type="radio" name="nav-tab">
    <input class="koolclash-nav-radio" id="koolclash-nav-additional" type="radio" name="nav-tab">
    <input class="koolclash-nav-radio" id="koolclash-nav-log" type="radio" name="nav-tab">
    <input class="koolclash-nav-radio" id="koolclash-nav-debug" type="radio" name="nav-tab">

    <div id="msg_success" class="alert alert-success icon" style="display: none;"></div>
    <div id="msg_error" class="alert alert-error icon" style="display: none;"></div>
    <div id="msg_warning" class="alert alert-warning icon" style="display: none;"></div>

    <ul class="nav nav-tabs">
        <li>
            <label class="koolclash-nav-overview koolclash-nav-label" for="koolclash-nav-overview">
                <div class="koolclash-nav-tab">
                    <i class="icon-info"></i>
                    运行状态
                </div>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-config koolclash-nav-label" for="koolclash-nav-config">
                <div class="koolclash-nav-tab">
                    <i class="icon-system"></i>
                    配置文件
                </div>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-firewall koolclash-nav-label" for="koolclash-nav-firewall">
                <div class="koolclash-nav-tab">
                    <i class="icon-lock"></i>
                    访问控制
                </div>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-additional koolclash-nav-label" for="koolclash-nav-additional">
                <div class="koolclash-nav-tab">
                    <i class="icon-wake"></i>
                    附加功能
                </div>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-log koolclash-nav-label" for="koolclash-nav-log">
                <div class="koolclash-nav-tab">
                    <i class="icon-hourglass"></i>
                    操作日志
                </div>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-debug koolclash-nav-label" for="koolclash-nav-debug">
                <div class="koolclash-nav-tab">
                    <i class="icon-warning"></i>
                    调试工具
                </div>
            </label>
        </li>
    </ul>
    <div class="tab-content">
        <div id="koolclash-content-overview">
            <div class="box">
                <div class="heading">KoolClash 管理</div>

                <div class="content">
                    <!-- ### KoolClash 运行状态 ### -->
                    <div id="koolclash-field"></div>
                    <div class="koolclash-btn-container">
                        <button type="button" id="koolclash-btn-start-clash" onclick="KoolClash.restart()" class="btn btn-success">启动/重启 Clash</button>
                        <button type="button" id="koolclash-btn-stop-clash" onclick="KoolClash.stop()" class="btn btn-danger">停止 Clash</button>
                    </div>
                </div>
            </div>

            <div id="koolclash-ip" class="box">
                <div class="heading" style="padding-right: 20px;">
                    <div style="display: flex;">
                        <div style="width: 61.8%">IP 地址检查</div>
                        <div style="width: 31.2%">网站访问检查</div>
                    </div>
                </div>

                <div class="content">
                    <!-- ### KoolClash IP ### -->
                    <div style="display: flex;">
                        <div style="width: 61.8%">
                            <p><span class="ip-title">IPIP&nbsp;&nbsp;国内</span>:&nbsp;<span id="ip-ipipnet"></span></p>
                            <p><span class="ip-title">淘宝&nbsp;&nbsp;国内</span>:&nbsp;<span id="ip-taobao"></span>&nbsp;<span id="ip-taobao-ipip"></span></p>
                            <p><span class="ip-title">IP.SB&nbsp;海外</span>:&nbsp;<span id="ip-ipsb"></span>&nbsp;<span id="ip-ipsb-geo"></span></p>
                            <p><span class="ip-title">IPAPI&nbsp;海外</span>:&nbsp;<span id="ip-ipapi"></span>&nbsp;<span id="ip-ipapi-geo"></span></p>
                        </div>
                        <div style="width: 38.2%">
                            <p><span class="ip-title">百度搜索</span>&nbsp;:&nbsp;<span id="http-baidu"></span></p>
                            <p><span class="ip-title">网易云音乐</span>&nbsp;:&nbsp;<span id="http-163"></span></p>
                            <p><span class="ip-title">GitHub</span>&nbsp;:&nbsp;<span id="http-github"></span></p>
                            <p><span class="ip-title">YouTube</span>&nbsp;:&nbsp;<span id="http-youtube"></span></p>
                        </div>
                    </div>
                    <p><span style="float: right">Powered by <a href="https://ip.skk.moe" target="_blank">ip.skk.moe</a></span></p>
                </div>
            </div>

            <div class="box">
                <div class="heading" style="padding-bottom: 4px">Clash 外部控制</div>
                <div class="content">
                    <!-- ### KoolClash 面板 ### -->
                    <div id="koolclash-dashboard-info"></div>

                    <div class="koolclash-btn-container">
                        <button class="btn btn-primary" onclick="window.open(`http:\/\/${window.location.hostname.replace('%3', '')}:6170/ui/`, 'newwindow', '')">访问 Clash 面板</button>
                        <button type="button" id="koolclash-btn-submit-control" onclick="KoolClash.submitExternalControl();" class="btn">提交外部控制设置</button>
                    </div>
                </div>
            </div>

        </div>
        <div id="koolclash-content-config">
            <div class="box">
                <div class="heading">KoolClash 配置文件</div>

                <div class="content">
                    <!-- ### KoolClash 运行配置设置 ### -->
                    <div id="koolclash-config"></div>
                    <div class="koolclash-btn-container">
                        <button type="button" id="koolclash-btn-update-sub" onclick="KoolClash.updateRemoteConfig();" class="btn">更新 Clash 托管配置</button>
                        <button type="button" id="koolclash-btn-del-suburl" onclick="KoolClash.deleteSuburl();" class="btn btn-danger">删除托管 URL（保留 Clash 配置）</button>
                    </div>
                </div>
            </div>
            <div class="box">
                <div class="heading">自定义 DNS 配置</div>
                <div class="content">
                    <!-- ### KoolClash DNS 设置 ### -->
                    <div id="koolclash-config-dns"></div>
                    <div class="koolclash-btn-container">
                        <button type="button" id="koolclash-btn-save-dns-config" onclick="KoolClash.submitDNSConfig();" class="btn btn-primary">提交 DNS 配置</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="koolclash-content-firewall">
            <div class="box">
                <div class="heading" style="margin-top: -15px;"></div>
                <div class="content">
                    <div id="koolclash-firewall-ipset"></div>
                    <div class="koolclash-btn-container">
                        <button type="button" id="koolclash-btn-submit-white-ip" onclick="KoolClash.acl.submitWhiteIP();" class="btn btn-primary">提交</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="koolclash-content-log">
            <div class="box">
                <div class="heading">KoolClash 操作日志</div>
                <div class="content">
                    <textarea class="as-script" name="koolclash_log" id="_koolclash_log" readonly wrap="off" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                </div>
            </div>
        </div>
        <div id="koolclash-content-debug">
            <div class="box">
                <div class="heading">KoolClash 调试工具</div>
                <div class="content">
                    <p>KoolClash 的调试工具，可以输出 KoolClash 的相关信息、参数。在反馈 KoolClash 的使用问题时附上相关信息可以帮助开发者更好的定位问题。</p>

                    <button type="button" id="koolclash-btn-debug" onclick="KoolClash.debugInfo();" class="btn btn-danger" style="margin-top: 6px; margin-bottom: 12px">获取 KoolClash 调试信息</button>

                    <textarea class="as-script" name="koolclash_debug_info" id="_koolclash_debug_info" readonly wrap="off" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
                </div>
            </div>
        </div>
        <div id="koolclash-content-additional">
            <div class="box">
                <div class="heading">Clash 看门狗</div>
                <div class="content">
                    <p>KoolClash 实现的 Clash 进程守护工具，每 20 秒检查一次 Clash 进程是否存在，如果 Clash 进程丢失则会自动重新拉起。</p>
                    <p style="color:red; margin-top: 8px">注意！Clash 不支持保存节点选择状态！Clash 进程重新启动后节点可能会变动，因此务必谨慎启用该功能！</p>
                    <div id="koolclash-watchdog-panel" style="margin-top: 16px"></div>
                </div>
            </div>
            <div class="box">
                <div class="heading">GeoIP 数据库</div>
                <div class="content">
                    <p>Clash 使用由 <a href="https://www.maxmind.com/" target="_blank">MaxMind</a> 提供的 <a href="https://dev.maxmind.com/geoip/geoip2/geolite2/" target="_blank">GeoLite2</a> IP 数据库解析 GeoIP 规则</p>
                    <div id="koolclash-ipdb-panel" style="margin-top: 8px"></div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // IP 检查
        var IP = {
            get: (url, type) =>
                fetch(url, { method: 'GET' }).then((resp) => {
                    if (type === 'text')
                        return Promise.all([resp.ok, resp.status, resp.text(), resp.headers]);
                    else {
                        return Promise.all([resp.ok, resp.status, resp.json(), resp.headers]);
                    }
                }).then(([ok, status, data, headers]) => {
                    if (ok) {
                        let json = {
                            ok,
                            status,
                            data,
                            headers
                        }
                        return json;
                    } else {
                        throw new Error(JSON.stringify(json.error));
                    }
                }).catch(error => {
                    throw error;
                }),
            parseIPIpip: (ip, elID) => {
                IP.get(`https://api.skk.moe/network/parseIp/ipip/${ip}`, 'json')
                    .then(resp => {
                        let x = '';
                        for (let i of resp.data) {
                            x += (i !== '') ? `${i} ` : '';
                        }

                        document.getElementById(elID).innerHTML = x;
                        //document.getElementById(elID).innerHTML = `${resp.data.country} ${resp.data.regionName} ${resp.data.city} ${resp.data.isp}`;
                    })
            },
            getIpipnetIP: () => {
                IP.get(`https://myip.ipip.net?${+(new Date)}`, 'text')
                    .then(resp => document.getElementById('ip-ipipnet').innerHTML = resp.data.replace('当前 IP：', '').replace('来自于：', ''));
            },
            getTaobaoIP: (data) => {
                document.getElementById('ip-taobao').innerHTML = data.ip;
                IP.parseIPIpip(data.ip, 'ip-taobao-ipip');
            },
            getIpsbIP: (data) => {
                document.getElementById('ip-ipsb').innerHTML = data.address;
                document.getElementById('ip-ipsb-geo').innerHTML = `${data.country} ${data.province} ${data.city} ${data.isp.name}`
            },
            getIpApiIP: () => {
                IP.get(`https://api.ipify.org/?format=json&id=${+(new Date)}`, 'json')
                    .then(resp => {
                        document.getElementById('ip-ipapi').innerHTML = resp.data.ip;
                        return resp.data.ip;
                    })
                    .then(ip => {
                        IP.parseIPIpip(ip, 'ip-ipapi-geo');
                    })
            },
        };
        // 将淘宝的 jsonp 回调给 IP 函数
        window.ipCallback = (data) => IP.getTaobaoIP(data);
        // 网站访问检查
        var HTTP = {
            checker: (domain, cbElID) => {
                let img = new Image;
                let timeout = setTimeout(() => {
                    img.onerror = img.onload = null;
                    img = null;
                    document.getElementById(cbElID).innerHTML = '<span class="sk-text-error">连接超时</span>'
                }, 5000);

                img.onerror = () => {
                    clearTimeout(timeout);
                    document.getElementById(cbElID).innerHTML = '<span class="sk-text-error">无法访问</span>'
                }

                img.onload = () => {
                    clearTimeout(timeout);
                    document.getElementById(cbElID).innerHTML = '<span class="sk-text-success">连接正常</span>'
                }

                img.src = `https://${domain}/favicon.ico?${+(new Date)}`
            },
            runcheck: () => {
                HTTP.checker('www.baidu.com', 'http-baidu');
                HTTP.checker('s1.music.126.net/style', 'http-163');
                HTTP.checker('github.com', 'http-github');
                HTTP.checker('www.youtube.com', 'http-youtube');
            }
        };

        var KoolClash = {
            // KoolClash.renderUI()
            // 创建 KoolClash 界面
            renderUI: () => {
                var inputWidth = `min-width: 220px; max-width: 220px`;
                $('#koolclash-field').forms([
                    {
                        title: '<b>Clash 进程状态</b>',
                        text: '<span id="koolclash_status" name="koolclash_status" color="#1bbf35">正在获取 Clash 进程状态...</span>'
                    },
                    {
                        title: '<b>Clash 看门狗进程状态</b>',
                        text: '<span id="koolclash_watchdog_status" name="koolclash_watchdog_status" color="#1bbf35">正在获取 Clash 看门狗进程状态...</span>'
                    },
                ]);
                $('#koolclash-dashboard-info').forms([
                    {
                        title: '<b>Host</b>',
                        name: 'koolclash_dashboard_host',
                        type: 'text',
                        value: ''
                    },
                    {
                        title: '<b>端口</b>',
                        text: '6170'
                    },
                    {
                        title: '<b>密钥</b>',
                        text: 'Clash 配置文件中的 secret'
                    },
                ]);
                $('#koolclash-config').forms([
                    {
                        title: '<b>Clash 配置上传</b>',
                        suffix: '<input type="file" id="koolclash-file-config" size="50"><button id="koolclash-btn-upload" type="button" onclick="KoolClash.submitClashConfig();" class="btn btn-primary">上传配置文件</button>'
                    },
                    {
                        title: '<b>Clash 托管配置 URL</b><br><small>请注意！务必谨慎使用该功能！</small>',
                        name: 'koolclash_config_suburl',
                        type: 'text',
                        value: window.dbus.koolclash_suburl || '',
                        placeholder: 'https://api.example.com/clash'
                    },
                ]);
                $('#koolclash-config-dns').forms([
                    {
                        title: '<b>DNS 配置开关</b>',
                        name: 'koolclash-dns-config-switch',
                        type: 'checkbox'
                    },
                    {
                        title: '&nbsp;',
                        text: '<p id="koolclash-dns-msg" style="margin-top: 10px; margin-bottom: 6px"></p>'
                    },
                    {
                        title: '',
                        name: 'koolclash-config-dns',
                        type: 'textarea',
                        value: '正在加载存储的 Clash DNS Config 配置...',
                        style: 'width: 100%; height: 200px;'
                    },
                ]);
                $('#koolclash-firewall-ipset').forms([
                    {
                        title: '<b>IP/CIDR 白名单</b><br><br><p style="color: #999">不通过 Clash 的 IP/CIDR 外网地址，一行一个，例如：<br>119.29.29.29<br>210.2.4.0/24</p>',
                        name: 'koolclash_firewall_white_ipset',
                        type: 'textarea',
                        value: Base64.decode(window.dbus.koolclash_firewall_whiteip_base64 || '') || '',
                        style: 'width: 80%; height: 150px;'
                    },
                ]);

                $('#koolclash-watchdog-panel').forms([
                    {
                        title: 'Clash 看门狗开关',
                        name: 'koolclash-select-watchdog',
                        type: 'select',
                        options: [
                            ['0', '禁用'],
                            ['1', '开启']
                        ],
                        suffix: '<button type="button" id="koolclash-btn-submit-watchdog" onclick="KoolClash.submitWatchdog();" class="btn btn-primary">提交</button>',
                        value: window.dbus.koolclash_watchdog_enable || '0',
                    },
                ]);
                $('#koolclash-ipdb-panel').forms([
                    {
                        title: '<b>当前 IP 数据库版本</b>',
                        name: 'koolclash-ipdb-version',
                        text: `${window.dbus.koolclash_ipdb_version || '没有获取到版本信息'}<button type="button" id="koolclash-btn-update-ipdb" onclick="KoolClash.updateIPDB()" class="btn btn-success" style="margin-left: 16px; margin-top: -6px; ">更新 IP 数据库</button>`,
                    },
                ]);

                /*if (document.getElementById('_koolclash-acl-default-port').value === '0') {
                    $('#_koolclash-acl-default-port-user').show();
                } else {
                    $('#_koolclash-acl-default-port-user').hide();
                }*/

                $('.koolclash-nav-log').on('click', KoolClash.getLog);
            },
            // 选择 Tab
            // 注意选择的方式是使用 input 的 ID
            selectTab: (inputId) => {
                for (let i of document.getElementsByClassName('koolclash-nav-radio')) {
                    i.removeAttribute('checked');
                }
                document.getElementById(inputId).click();
            },
            checkUpdate: () => {
                let installed = '',
                    remote = '';
                // 获取本地版本号
                $.ajax({
                    type: "GET",
                    cache: false,
                    url: "/res/koolclash_.version",
                    success: (resp) => {
                        installed = resp;
                        document.getElementById('koolclash-version-msg').innerHTML = `当前安装版本&nbsp;:&nbsp;${installed}`;
                        // 获取远端版本号
                        $.ajax({
                            type: "GET",
                            cache: false,
                            url: "https://koolclash.js.org/koolclash_version",
                            success: (resp) => {
                                remote = resp;
                                document.getElementById('koolclash-version-msg').innerHTML = `当前安装版本&nbsp;:&nbsp;${installed}&nbsp;&nbsp;/&nbsp;&nbsp;最新发布版本&nbsp;:&nbsp;${remote}`;

                                if (installed !== remote) {
                                    document.getElementById('koolclash-version-msg').innerHTML = `当前安装版本&nbsp;:&nbsp;${installed}&nbsp;&nbsp;|&nbsp;&nbsp;最新发布版本&nbsp;:&nbsp;${remote}<br>发现「当前安装版本」与「最新发布版本」版本号不同，可能是 KoolClash 有新版本发布，请前往 <a href="https://github.com/SukkaW/Koolshare-Clash/releases" target="_blank" style="padding: 0; color: navy">GitHub Release</a> 查看更新日志`;
                                }
                            }
                        });
                    },
                    error: () => {
                        document.getElementById('koolclash-version-msg').innerHTML = `检测版本失败！`
                    }
                });


                document.getElementById('koolclash-version-msg').innerHTML = `当前安装版本&nbsp;:&nbsp;<span id="koolclash-version-installed"></span>&nbsp;&nbsp;|&nbsp;&nbsp;最新发布版本&nbsp;:&nbsp;<span id="koolclash-version-remote"></span>`;
            },
            defaultDNSConfig: `# 没有找到保存的 Clash 自定义 DNS 配置，推荐使用以下的配置
dns:
  enable: true
  ipv6: false
  listen: 0.0.0.0:53
  enhanced-mode: fake-ip
  nameserver:
    - 119.28.28.28
    - 119.29.29.29
    - 223.5.5.5
    - tls://dns.rubyfish.cn:853
  fallback:
    - tls://1.0.0.1:853
    - tls://8.8.4.4:853
`,
            // getClashStatus
            // 获取 Clash 进程 PID
            getClashStatus: () => {
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_status.sh",
                        "params": [],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (softcenter === 1) {
                            return false;
                        }

                        let data = resp.result.split('@'),
                            pid_text = data[0],
                            pid_watchdog_text = data[1],
                            dnsmode = data[2],
                            control_data = data[3],
                            secret = data[4],
                            fallbackdns = data[6];

                        if (fallbackdns === '') {
                            document.getElementById('_koolclash-config-dns').innerHTML = KoolClash.defaultDNSConfig;
                        } else {
                            document.getElementById('_koolclash-config-dns').innerHTML = Base64.decode(fallbackdns || '') || KoolClash.defaultDNSConfig;
                        }

                        let control_host = control_data.split(':')[0],
                            control_port = control_data.split(':')[1];

                        control_host = (control_host.length === 0) ? `请先上传 Clash 配置文件！` : control_host;
                        document.getElementById('koolclash_status').innerHTML = pid_text;
                        document.getElementById('koolclash_watchdog_status').innerHTML = pid_watchdog_text;
                        document.getElementById('_koolclash_dashboard_host').value = control_host;

                        /*
                         * 0 没有找到 config.yml
                         * 1 origin.yml DNS 配置合法
                         * 2 origin.yml DNS 配置合法 但是用户想要自定义 DNS
                         * 3 origin.yml DNS 配置不合法而且没有 dns.yml
                         * (4) origin.yml DNS 配置不合法但是有 dns.yml
                         */
                        if (dnsmode === '0') {
                            document.getElementById('_koolclash-dns-config-switch').checked = false;
                            document.getElementById('_koolclash-dns-config-switch').setAttribute('disabled', '');
                            $('#koolclash-btn-save-dns-config').hide();
                            $('#_koolclash-config-dns').hide();
                            document.getElementById('koolclash-dns-msg').innerHTML = `请先上传 Clash 配置文件！`
                        } else if (dnsmode === '1') {
                            document.getElementById('_koolclash-dns-config-switch').checked = false;
                            $('#koolclash-btn-save-dns-config').hide();
                            $('#_koolclash-config-dns').hide();
                            document.getElementById('koolclash-dns-msg').innerHTML = `Clash 配置文件存在且 DNS 配置合法。如果想覆盖 Clash 配置文件中的 DNS 配置请勾选上面的单选框`
                        } else if (dnsmode === '2') {
                            document.getElementById('_koolclash-dns-config-switch').checked = true;
                            $('#koolclash-btn-save-dns-config').show();
                            $('#_koolclash-config-dns').show();
                            document.getElementById('koolclash-dns-msg').innerHTML = `已经使用下面的 DNS 配置覆盖 Clash 配置文件中的 DNS 配置`
                        } else if (dnsmode === '3') {
                            document.getElementById('_koolclash-dns-config-switch').checked = true;
                            document.getElementById('_koolclash-dns-config-switch').setAttribute('disabled', '');
                            $('#koolclash-btn-save-dns-config').show();
                            $('#_koolclash-config-dns').show();
                            document.getElementById('koolclash-dns-msg').innerHTML = `Clash 配置文件存在，但配置文件中不存在 DNS 配置或配置不合法。请在下面提交 DNS 配置！`
                        } else {
                            document.getElementById('_koolclash-dns-config-switch').checked = true;
                            document.getElementById('_koolclash-dns-config-switch').setAttribute('disabled', '');
                            $('#koolclash-btn-save-dns-config').show();
                            $('#_koolclash-config-dns').show();
                            document.getElementById('koolclash-dns-msg').innerHTML = `Clash 配置文件存在，但原始配置文件中不存在 DNS 配置或配置不合法，已经生效下面的 DNS 配置`
                        }
                    },
                    error: () => {
                        if (softcenter === 1) {
                            return false;
                        }
                        document.getElementById('koolclash_status').innerHTML = `<span style="color: red">获取 Clash 进程运行状态失败！请刷新页面重试`;
                        document.getElementById('koolclash_watchdog_status').innerHTML = `<span style="color: red">获取 Clash 看门狗进程运行状态失败！请刷新页面重试`;
                    }
                });
            },
            checkIP: () => {
                IP.getIpipnetIP();
                IP.getIpApiIP();
                HTTP.runcheck();
            },
            disableAllButton: () => {
                let btnList = document.getElementsByTagName('button');
                for (let i of btnList) {
                    i.setAttribute('disabled', '');
                }
            },
            enableAllButton: () => {
                let btnList = document.getElementsByTagName('button');
                for (let i of btnList) {
                    i.removeAttribute('disabled');
                }
            },
            submitExternalControl: () => {
                KoolClash.disableAllButton();

                let id = parseInt(Math.random() * 100000000);
                let postData = JSON.stringify({
                    id,
                    "method": "koolclash_save_control.sh",
                    "params": [`${document.getElementById('_koolclash_dashboard_host').value}`],
                    "fields": ""
                });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        document.getElementById('koolclash-btn-submit-control').innerHTML = '外部控制 IP 设置成功！页面将会自动刷新！';
                        setTimeout(() => {
                            window.location.reload();
                        }, 3000)
                    },
                    error: () => {
                        document.getElementById('koolclash-btn-submit-control').innerHTML = '外部控制 IP 设置失败！';
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            document.getElementById('koolclash-btn-submit-control').innerHTML = '提交外部控制设置';
                        }, 3000)
                    }
                });
            },
            submitClashConfig: () => {
                KoolClash.disableAllButton();
                document.getElementById('koolclash-btn-upload').innerHTML = '正在上传 Clash 配置...';

                let formData = new FormData();
                formData.append('clash.config.yml', $('#koolclash-file-config')[0].files[0]);
                $.ajax({
                    url: '/_upload',
                    type: 'POST',
                    async: true,
                    cache: false,
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: (resp) => {
                        document.getElementById('koolclash-btn-upload').innerHTML = '正在上传 Clash 配置...';
                        (() => {
                            let id = parseInt(Math.random() * 100000000),
                                postData = JSON.stringify({
                                    id,
                                    "method": "koolclash_save_config.sh",
                                    "params": [],
                                    "fields": ""
                                });

                            $.ajax({
                                type: "POST",
                                cache: false,
                                url: "/_api/",
                                data: postData,
                                dataType: "json",
                                success: (resp) => {
                                    if (resp.result === 'notfound') {
                                        document.getElementById('koolclash-btn-upload').innerHTML = '上传的配置文件找不到了！请重试！';
                                        setTimeout(() => {
                                            KoolClash.enableAllButton();
                                            document.getElementById('koolclash-btn-upload').innerHTML = '上传配置文件';
                                        }, 3000)
                                    } else if (resp.result === 'nofallbackdns') {
                                        document.getElementById('koolclash-btn-upload').innerHTML = '在配置文件中没有找到 DNS 设置，请在下面添加 DNS 配置！';
                                        // KoolClash.selectTab('koolclash-nav-config')
                                        document.getElementById('koolclash-btn-upload').classList.remove('btn-primary');
                                        document.getElementById('koolclash-btn-upload').classList.add('btn-danger');
                                        document.getElementById('koolclash-btn-save-dns-config').removeAttribute('disabled');
                                        document.getElementById('_koolclash-dns-config-switch').checked = true;
                                        document.getElementById('_koolclash-dns-config-switch').setAttribute('disabled', '');
                                        $('#_koolclash-config-dns').show();
                                        $('#koolclash-btn-save-dns-config').show();
                                        document.getElementById('koolclash-dns-msg').innerHTML = `Clash 配置文件存在，但配置文件中不存在 DNS 配置或配置不合法，请在下面提交 DNS 配置`;
                                    } else {
                                        document.getElementById('koolclash-btn-upload').innerHTML = 'Clash 配置上传成功，页面将自动刷新<span id="koolclash-wait-time"></span>';
                                        KoolClash.tminus(5);
                                        setTimeout(() => {
                                            window.location.reload();
                                        }, 5000)
                                    }
                                },
                                error: () => {
                                    document.getElementById('koolclash-btn-upload').innerHTML = '配置文件上传失败！';

                                    setTimeout(() => {
                                        KoolClash.enableAllButton();
                                        document.getElementById('koolclash-btn-upload').innerHTML = '上传配置文件';
                                    }, 3000)
                                }
                            });
                        })();
                    },
                    error: () => {
                        if (softcenter === 1) {
                            return false;
                        }
                        document.getElementById('koolclash-btn-save-config').innerHTML = '配置文件上传失败，请重试';

                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            document.getElementById('koolclash-btn-upload').innerHTML = '上传配置文件';
                        }, 4000)
                    }
                });
            },
            tminus: (second) => {
                setInterval(() => {
                    second--;
                    document.getElementById('koolclash-wait-time').innerHTML = `（${second}）`;
                }, 1000);
            },
            submitDNSConfig: () => {
                KoolClash.disableAllButton();
                document.getElementById('koolclash-btn-save-dns-config').innerHTML = '正在提交...';
                let id = parseInt(Math.random() * 100000000),
                    postData,
                    checked;

                if (document.getElementById('_koolclash-dns-config-switch').checked) {
                    checked = '1';
                } else {
                    checked = '0'
                }

                postData = JSON.stringify({
                    id,
                    "method": "koolclash_save_dns_config.sh",
                    "params": [`${Base64.encode(document.getElementById('_koolclash-config-dns').value.replace('# 没有找到保存的 Clash 自定义 DNS 配置，推荐使用以下的配置\n', ''))}`, checked],
                    "fields": ""
                });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'nofallbackdns') {
                            document.getElementById('koolclash-btn-save-dns-config').innerHTML = '不能提交空的 DNS 配置！';
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                document.getElementById('koolclash-btn-save-dns-config').innerHTML = '提交 Clash 自定义 DNS 设置';
                            }, 4000)
                        } else {
                            document.getElementById('koolclash-btn-save-dns-config').innerHTML = '提交成功！页面将会自动刷新！<span id="koolclash-wait-time"></span>';
                            KoolClash.tminus(5);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        }
                    },
                    error: () => {
                        document.getElementById('koolclash-btn-save-dns-config').innerHTML = '提交失败！请重试';
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            document.getElementById('koolclash-btn-save-dns-config').innerHTML = '提交 Clash 自定义 DNS 设置';
                        }, 4000)
                    }
                });
            },
            restart: () => {
                KoolClash.disableAllButton();
                document.getElementById('msg_warning').innerHTML = `正在启动 Clash，请不要刷新或关闭页面！`;
                $('#msg_warning').show();

                setTimeout(() => {
                    KoolClash.selectTab('koolclash-nav-log');
                    KoolClash.getLog();
                }, 100);

                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_control.sh",
                        "params": ['start'],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    async: true,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'nofile') {
                            $('#msg_warning').hide();
                            document.getElementById('msg_error').innerHTML = `关键文件缺失，Clash 无法启动！<span id="koolclash-wait-time"></span>`;
                            document.getElementById('msg_warning').innerHTML = `请不要刷新或关闭页面，务必等待页面自动刷新！`;
                            $('#msg_error').show();
                            $('#msg_warning').show();
                            KoolClash.tminus(5);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        } else if (resp.result === 'nodns') {
                            $('#msg_warning').hide();
                            document.getElementById('msg_error').innerHTML = `在 Clash 配置文件中没有找到正确的 DNS 设置或 Clash 配置文件存在语法错误！请在页面自动刷新之后(重新)上传 Clash 配置文件！<span id="koolclash-wait-time"></span>`;
                            document.getElementById('msg_warning').innerHTML = `请不要刷新或关闭页面，务必等待页面自动刷新！`;
                            $('#msg_error').show();
                            $('#msg_warning').show();
                            KoolClash.tminus(5);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        } else {
                            $('#msg_warning').hide();
                            document.getElementById('msg_success').innerHTML = `Clash 即将启动成功！<span id="koolclash-wait-time"></span>`;
                            document.getElementById('msg_warning').innerHTML = `请不要刷新或关闭页面，务必等待页面自动刷新！`;
                            $('#msg_success').show();
                            $('#msg_warning').show();
                            KoolClash.tminus(5);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        }
                    },
                    error: () => {
                        document.getElementById('msg_error').innerHTML = `Clash (可能)启动失败！请在页面自动刷新之后检查 Clash 运行状态！<span id="koolclash-wait-time"></span>`;
                        document.getElementById('msg_warning').innerHTML = `请不要刷新或关闭页面，务必等待页面自动刷新！`;
                        $('#msg_error').show();
                        $('#msg_warning').show();
                        KoolClash.selectTab('koolclash-nav-log');
                        KoolClash.tminus(5);
                        setTimeout(() => {
                            window.location.reload();
                        }, 5000)
                    }
                });
            },
            stop: () => {
                KoolClash.disableAllButton();
                document.getElementById('msg_warning').innerHTML = `正在关闭 Clash，请不要刷新或关闭页面！`;
                $('#msg_warning').show();

                setTimeout(() => {
                    KoolClash.selectTab('koolclash-nav-log');
                    KoolClash.getLog();
                }, 100);

                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_control.sh",
                        "params": ['stop'],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    async: true,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        $('#msg_warning').hide();
                        document.getElementById('msg_success').innerHTML = `Clash 即将关闭！<span id="koolclash-wait-time"></span>`;
                        document.getElementById('msg_warning').innerHTML = `请不要刷新或关闭页面，务必等待页面自动刷新！`;
                        $('#msg_success').show();
                        $('#msg_warning').show();
                        KoolClash.tminus(5);
                        setTimeout(() => {
                            window.location.reload();
                        }, 5000)
                    },
                    error: () => {
                        $('#msg_warning').hide();
                        document.getElementById('msg_error').innerHTML = `Clash (可能)关闭失败！请在页面自动刷新之后检查 Clash 运行状态！<span id="koolclash-wait-time"></span>`;
                        document.getElementById('msg_warning').innerHTML = `请不要刷新或关闭页面，务必等待页面自动刷新！`;
                        $('#msg_error').show();
                        $('#msg_warning').show();
                        KoolClash.tminus(5);
                        setTimeout(() => {
                            window.location.reload();
                        }, 5000)
                    }
                });
            },
            deleteSuburl: () => {
                KoolClash.disableAllButton();
                document.getElementById('koolclash-btn-del-suburl').innerHTML = `正在删除 Clash 托管配置 URL`;
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_sub.sh",
                        "params": ['del'],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        document.getElementById('koolclash-btn-del-suburl').innerHTML = `删除成功！`;
                        document.getElementById('_koolclash_config_suburl').value = '';

                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            document.getElementById('koolclash-btn-del-suburl').innerHTML = '删除托管 URL（保留 Clash 配置）';
                        }, 2500)
                    },
                    error: () => {
                        document.getElementById('koolclash-btn-del-suburl').innerHTML = `删除失败！`;

                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            document.getElementById('koolclash-btn-del-suburl').innerHTML = '删除托管 URL（保留 Clash 配置）';
                        }, 2500)
                    }
                });
            },
            updateRemoteConfig: () => {
                KoolClash.disableAllButton();
                document.getElementById('koolclash-btn-update-sub').innerHTML = `正在下载最新托管配置`;
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_sub.sh",
                        "params": ['update', `${Base64.encode(document.getElementById('_koolclash_config_suburl').value)}`],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'nocurl') {
                            document.getElementById('koolclash-btn-update-sub').innerHTML = `你的路由器中没有 curl，不能更新！`;
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                document.getElementById('koolclash-btn-update-sub').innerHTML = '更新 Clash 托管配置';
                            }, 3500)
                        } else if (resp.result === 'fail') {
                            document.getElementById('koolclash-btn-update-sub').innerHTML = `Clash 托管配置下载失败！已经自动恢复到旧的配置文件！`;
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                document.getElementById('koolclash-btn-update-sub').innerHTML = '更新 Clash 托管配置';
                            }, 4000)
                        } else if (resp.result === 'nofallbackdns') {
                            document.getElementById('koolclash-btn-update-sub').innerHTML = '在托管配置中没有找到 DNS 设置，请在下面添加 DNS 配置！';
                            document.getElementById('_koolclash-dns-config-switch').checked = true;
                            document.getElementById('_koolclash-dns-config-switch').setAttribute('disabled', '');
                            $('#_koolclash-config-dns').show();
                            $('#koolclash-btn-save-dns-config').show();
                            document.getElementById('koolclash-btn-save-dns-config').removeAttribute('disabled');
                            document.getElementById('koolclash-dns-msg').innerHTML = `Clash 托管配置文件已经更新，但托管配置中不存在 DNS 配置或配置不合法，请在下面提交 DNS 配置`;
                        } else {
                            document.getElementById('koolclash-btn-update-sub').innerHTML = 'Clash 配置更新成功，页面将自动刷新<span id="koolclash-wait-time"></span>';
                            KoolClash.tminus(5);
                            setTimeout(() => {
                                window.location.reload();
                            }, 5000)
                        }
                    },
                    error: () => {
                        document.getElementById('koolclash-btn-update-sub').innerHTML = `Clash 托管配置更新失败！`;

                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            document.getElementById('koolclash-btn-update-sub').innerHTML = '更新 Clash 托管配置';
                        }, 2500)
                    }
                });
            },
            updateIPDB: () => {
                KoolClash.disableAllButton();
                document.getElementById('koolclash-btn-update-ipdb').innerHTML = `开始下载最新 IP 解析库并更新`;
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        "id": id,
                        "method": "koolclash_update_ipdb.sh",
                        "params": [],
                        "fields": ""
                    });

                setTimeout(() => {
                    KoolClash.selectTab('koolclash-nav-log');
                    KoolClash.getLog();
                }, 100);

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'nodl') {
                            document.getElementById('koolclash-btn-update-ipdb').innerHTML = `你的路由器中既没有 curl 也没有 wget，不能下载更新！`;
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                document.getElementById('koolclash-btn-update-ipdb').innerHTML = '更新 IP 数据库';
                            }, 5500)
                        } else {
                            document.getElementById('koolclash-btn-update-ipdb').innerHTML = `IP 解析库更新成功！页面将自动刷新<span id="koolclash-wait-time"></span>`;
                            KoolClash.tminus(3);
                            setTimeout(() => {
                                window.location.reload();
                            }, 3000)
                        }
                    },
                    error: () => {
                        document.getElementById('koolclash-btn-update-ipdb').innerHTML = `IP 解析库更新失败！`;
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            document.getElementById('koolclash-btn-update-ipdb').innerHTML = '更新 IP 数据库';
                        }, 3000)
                    }
                });
            },
            getLog: () => {
                if (typeof _responseLen === undefined) {
                    let _responseLen = 0;
                } else {
                    _responseLen = 0;
                }

                let noChange = 0;

                $.ajax({
                    url: '/_temp/koolclash_log.txt',
                    type: 'GET',
                    cache: false,
                    dataType: 'text',
                    success: (response) => {
                        var retArea = E("_koolclash_log");
                        if (response.search("XU6J03M6") !== -1) {
                            retArea.value = response.replace("XU6J03M6", " ");
                            retArea.scrollTop = retArea.scrollHeight;
                            return true;
                        }
                        if (_responseLen === response.length) {
                            noChange++;
                        } else {
                            noChange = 0;
                        }
                        if (noChange > 8000) {
                            KoolClash.selectTab('koolclash-nav-overview');
                            return false;
                        } else {
                            setTimeout(() => {
                                KoolClash.getLog();
                            }, 100);
                        }
                        retArea.value = response.replace("XU6J03M6", " ");
                        retArea.scrollTop = retArea.scrollHeight;
                        _responseLen = response.length;
                    },
                    error: () => {
                        E("_koolclash_log").value = "获取日志失败！";
                        return false;
                    }
                });
            },
            debugInfo: () => {
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_debug.sh",
                        "params": [""],
                        "fields": ""
                    });

                fetch(`/_api/`, {
                    body: postData,
                    method: 'POST',
                    cache: 'no-cache',
                }).then((resp) => Promise.all([resp.ok, resp.status, resp.json(), resp.headers]))
                    .then(([ok, status, data, headers]) => {
                        if (ok) {
                            return JSON.parse(data.result);
                        } else {
                            throw new Error(JSON.stringify(json.error));
                        }
                    })
                    .then((data) => {
                        let getBrowser = () => {
                            let ua = navigator.userAgent,
                                tem,
                                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
                            if (ua.match("MicroMessenger"))
                                return "Weixin";

                            if (/trident/i.test(M[1])) {
                                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                                return 'IE ' + (tem[1] || '');
                            }
                            if (M[1] === 'Chrome') {
                                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                            }
                            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
                            if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
                            return M.join(' ');
                        };

                        document.getElementById('_koolclash_debug_info').value = `
======================== KoolClash 调试工具 ========================
调试信息生成于 ${new Date().toString()}
当前浏览器：${getBrowser()}
-------------------- Koolshare OpenWrt 基本信息 --------------------
固件版本：${data.koolshare_version}
路由器 LAN IP：${data.lan_ip}
------------------------ KoolClash 基本信息 ------------------------
KoolClash 版本：${window.dbus.koolclash_version}
Clash 核心版本：${data.clash_version}
KoolClash 当前状态：${(window.dbus.koolclash_enable === '1') ? `Clash 进程正在运行` : `Clash 进程未在运行`}
用户指定 Clash 外部控制 Host：${(window.dbus.koolclash_api_host) ? koolclash_api_host : `未改动`}
IP 数据库是否存在：${data.ipdb_exists}
-------------------------- Clash 进程信息 --------------------------
${Base64.decode(data.clash_process)}
------------------------ Clash 配置文件信息 ------------------------
Clash 原始配置文件是否存在：${data.origin_exists}
Clash 运行配置文件是否存在：${data.config_exists}
Clash 透明代理端口：${data.clash_redir}
Clash 是否允许局域网连接：${data.clash_allow_lan}
Clash 外部控制监听地址：${data.clash_ext_controller}
--------------------- Clash 配置文件 DNS 配置 ----------------------
Clash DNS 是否启用：${data.clash_dns_enable}
Clash DNS 解析 IPv6：${(data.clash_dns_ipv6 === 'null') ? `false` : data.clash_dns_ipv6}
Clash DNS 增强模式：${data.clash_dns_mode}
Clash DNS 监听：${data.clash_dns_listen}
KoolClash 当前 DNS 模式：${dbus.koolclash_dnsmode}
-------------------- KoolClash 自定义 DNS 配置 ---------------------
${Base64.decode(data.fallbackdns)}
------------------------- iptables 条目 ---------------------------
 * iptables mangle 中 Clash 相关条目
${Base64.decode(Base64.decode(data.iptables_mangle))}

 * iptables nat 中 Clash 相关条目
${Base64.decode(Base64.decode(data.iptables_nat))}

 * iptables mangle 中 koolclash 链
${Base64.decode(Base64.decode(data.iptables_mangle_clash))}

 * iptables nat 中 koolclash 链
${Base64.decode(Base64.decode(data.iptables_nat_clash))}

* iptables mangle 中 koolclash_dns 链
${Base64.decode(Base64.decode(data.iptables_mangle_clash_dns))}

 * iptables nat 中 koolclash_dns 链
${Base64.decode(Base64.decode(data.iptables_nat_clash_dns))}

 * iptables nat 中 Chromecast 相关条目
${Base64.decode(data.chromecast_nu)}
---------------------- ipset 白名单 IP 列表 ------------------------
${Base64.decode(data.firewall_white_ip)}

===================================================================
`;
                    })
            },
            acl: {
                submitWhiteIP: () => {
                    KoolClash.disableAllButton();
                    let data = Base64.encode(document.getElementById('_koolclash_firewall_white_ipset').value);

                    document.getElementById('koolclash-btn-submit-white-ip').innerHTML = `正在提交`;
                    let id = parseInt(Math.random() * 100000000),
                        postData = JSON.stringify({
                            id,
                            "method": "koolclash_firewall.sh",
                            "params": ['white', `${data}`],
                            "fields": ""
                        });

                    $.ajax({
                        type: "POST",
                        cache: false,
                        url: "/_api/",
                        data: postData,
                        dataType: "json",
                        success: (resp) => {
                            document.getElementById('koolclash-btn-submit-white-ip').innerHTML = `提交成功，下次启动 Clash 时生效！`;
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                document.getElementById('koolclash-btn-submit-white-ip').innerHTML = '提交';
                            }, 2500)
                        },
                        error: () => {
                            document.getElementById('koolclash-btn-submit-white-ip').innerHTML = `提交失败，请重试！`;
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                document.getElementById('koolclash-btn-submit-white-ip').innerHTML = '提交';
                            }, 2500)
                        }
                    });
                },
            },
            submitWatchdog: () => {
                KoolClash.disableAllButton();
                document.getElementById('koolclash-btn-submit-watchdog').innerHTML = `正在提交`;

                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        id,
                        "method": "koolclash_watchdog_config.sh",
                        "params": [`${document.getElementById('_koolclash-select-watchdog').value}`],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        document.getElementById('koolclash-btn-submit-watchdog').innerHTML = `提交成功，下次启动 Clash 时生效！`;
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            document.getElementById('koolclash-btn-submit-watchdog').innerHTML = '提交';
                        }, 2500)
                    },
                    error: () => {
                        document.getElementById('koolclash-btn-submit-watchdog').innerHTML = `提交失败，请重试！`;
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            document.getElementById('koolclash-btn-submit-watchdog').innerHTML = '提交';
                        }, 2500)
                    }
                });
            },
            load: (cb) => {
                window.dbus = {}
                document.title = 'KoolClash - Clash for Koolshare OpenWrt/LEDE';

                fetch(`/_api/koolclash`, { method: 'GET' })
                    .then((resp) => Promise.all([resp.ok, resp.status, resp.json(), resp.headers]))
                    .then(([ok, status, data, headers]) => {
                        if (ok) {
                            window.dbus = data.result[0];
                        } else {
                            throw new Error(JSON.stringify(json.error));
                        }
                    })
                    .then((res) => {
                        if (typeof $('#koolclash-field').forms === 'function') {
                            KoolClash.renderUI();
                        } else {
                            console.clear();
                            setTimeout(() => {
                                console.clear();
                                window.location.reload();
                            }, 1000);
                        }
                    })
                    .then((res) => {
                        KoolClash.getClashStatus();
                        KoolClash.checkUpdate();
                    })
            },
        }

        function verifyFields(r) {
            // 自定义 DNS 配置的显示隐藏
            if ($(r).attr("id") === "_koolclash-dns-config-switch") {
                if (document.getElementById('_koolclash-dns-config-switch').checked) {
                    $('#_koolclash-config-dns').show();
                    $('#koolclash-btn-save-dns-config').show();
                } else {
                    $('#_koolclash-config-dns').hide();
                    if (window.dbus.koolclash_dnsmode === '1') {
                        $('#koolclash-btn-save-dns-config').hide();
                    }
                }
            }/* else if (r.getAttribute('id') === '_koolclash-acl-default-port') {
                if (document.getElementById('_koolclash-acl-default-port').value === '0') {
                    $('#_koolclash-acl-default-port-user').show();
                } else {
                    $('#_koolclash-acl-default-port-user').hide();
                }
            }*/
        }
    </script>
    <script>
        KoolClash.load();
    </script>
    <script>
        if (document.readyState === 'complete') {
            KoolClash.checkIP();
        } else {
            window.addEventListener('load', () => {
                KoolClash.checkIP();
            });
        }
    </script>
    <script src="https://www.taobao.com/help/getip.php"></script>
    <script src="https://ipv4.ip.sb/addrinfo?callback=IP.getIpsbIP"></script>
</content>
