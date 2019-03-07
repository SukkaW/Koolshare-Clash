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

        #koolclash-nav-overview:checked~.nav-tabs .koolclash-nav-overview>a,
        #koolclash-nav-config:checked~.nav-tabs .koolclash-nav-config>a,
        #koolclash-nav-firewall:checked~.nav-tabs .koolclash-nav-firewall>a,
        #koolclash-nav-log:checked~.nav-tabs .koolclash-nav-log>a {
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
        #koolclash-nav-log:checked~.tab-content>#koolclash-content-log {
            display: block;
        }

    </style>

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
    <input class="koolclash-nav-radio" id="koolclash-nav-log" type="radio" name="nav-tab">

    <ul class="nav nav-tabs">
        <li>
            <label class="koolclash-nav-overview koolclash-nav-label" for="koolclash-nav-overview">
                <a>
                    <i class="icon-info"></i>
                    运行状态
                </a>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-config koolclash-nav-label" for="koolclash-nav-config">
                <a>
                    <i class="icon-system"></i>
                    配置文件
                </a>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-firewall koolclash-nav-label" for="koolclash-nav-firewall">
                <a>
                    <i class="icon-lock"></i>
                    访问控制
                </a>
            </label>
        </li>
        <li>
            <label class="koolclash-nav-log koolclash-nav-label" for="koolclash-nav-log">
                <a>
                    <i class="icon-hourglass"></i>
                    操作日志
                </a>
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
                        <button type="button" id="koolclash-btn-update-ipdb" onclick="KoolClash.updateIPDB()" class="btn" style="float: right">更新 IP 解析库</button>
                    </div>
                </div>
            </div>

            <div id="msg_success" class="alert alert-success icon" style="display:none;"></div>
            <div id="msg_error" class="alert alert-error icon" style="display:none;"></div>
            <div id="msg_warning" class="alert alert-warning icon" style="display:none;"></div>

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
                            <p><span class="ip-title">ipify&nbsp;&nbsp;海外</span>:&nbsp;<span id="ip-ipify"></span>&nbsp;<span id="ip-ipify-ipip"></span></p>
                        </div>
                        <div style="width: 38.2%">
                            <p><span class="ip-title">百度搜索</span>&nbsp;:&nbsp;<span id="http-baidu"></span></p>
                            <p><span class="ip-title">网易 163</span>&nbsp;:&nbsp;<span id="http-163"></span></p>
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
                    <a href="/koolclash/index.html" class="btn btn-primary" target="_blank" style="float: right; margin-right: 5px; border-radius: 3px; margin-top: 0px;">访问 Clash 面板</a>
                </div>
            </div>

        </div>
        <div id="koolclash-content-config">
            <div class="box">
                <div class="heading">KoolClash 配置</div>

                <div class="content">
                    <!-- ### KoolClash 运行配置设置 ### -->
                    <div id="koolclash-config"></div>
                    <div class="koolclash-btn-container">
                        <button type="button" id="koolclash-btn-update-sub" onclick="KoolClash.updateRemoteConfig();" class="btn">更新 Clash 托管配置</button>
                        <button type="button" id="koolclash-btn-del-suburl" onclick="KoolClash.deleteSuburl();" class="btn btn-danger">删除托管 URL（保留 Clash 配置）</button>
                    </div>

                    <div id="koolclash-config-dns"></div>
                    <div class="koolclash-btn-container">
                        <button type="button" id="koolclash-btn-save-dns-config" onclick="KoolClash.submitDNSConfig();" class="btn btn-primary">提交 Clash 后备 DNS 设置</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="koolclash-content-firewall">
            <div class="box">
                <div class="heading">功能开发中</div>
                <div class="content">
                    访问控制 还在开发中。将会提供对局域网内设备的连接控制、端口控制，和劫持局域网内 DNS 的选项。
                </div>
            </div>
        </div>
        <div id="koolclash-content-log">
            <div class="box">
                <div class="heading">功能开发中</div>
                <div class="content">
                    操作日志 还在开发中。
                </div>
            </div>
        </div>
    </div>

    <script>
        if (typeof IP !== 'undefined' || typeof HTTP !== 'undefined' || typeof noop !== 'undefined' || typeof KoolClash !== 'undefined') {
            console.clear();
            window.location.reload();
        }
    </script>
    <script>
        if (typeof softcenter === undefined) {
            let softcenter = 0;
        } else {
            softcenter = 0;
        }

        // IP 检查
        let IP = {
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
                        x += (resp.data[0] !== '') ? `${resp.data[0]} ` : '';
                        x += (resp.data[1] !== '') ? `${resp.data[1]} ` : '';
                        x += (resp.data[2] !== '') ? `${resp.data[2]} ` : '';
                        x += (resp.data[3] !== '') ? `${resp.data[3]} ` : '';
                        x += (resp.data[4] !== '') ? `${resp.data[4]} ` : '';
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
                document.getElementById('ip-ipsb-geo').innerHTML = `${data.country} ${data.province} ${data.city} ${data.operator}`
            },
            getIpifyIP: () => {
                IP.get(`https://api.ipify.org/?format=json&id=${+(new Date)}`, 'json')
                    .then(resp => {
                        document.getElementById('ip-ipify').innerHTML = resp.data.ip;
                        return resp.data.ip;
                    })
                    .then(ip => {
                        IP.parseIPIpip(ip, 'ip-ipify-ipip');
                    })
            },
        };
        // 将淘宝的 jsonp 回调给 IP 函数
        window.ipCallback = (data) => IP.getTaobaoIP(data);
        // 网站访问检查
        let HTTP = {
            checker: (domain, cbElID) => {
                let img = new Image;
                let timeout = setTimeout(() => {
                    img.onerror = img.onload = null;
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
                HTTP.checker('www.163.com', 'http-163');
                HTTP.checker('github.com', 'http-github');
                HTTP.checker('www.youtube.com', 'http-youtube');
            }
        };

        let KoolClash = {
            // KoolClash.renderUI()
            // 创建 KoolClash 界面
            renderUI: () => {
                let inputWidth = `min-width: 220px; max-width: 220px`;
                $('#koolclash-field').forms([
                    {
                        title: '<b>Clash 运行状态</b>',
                        text: '<span id="koolclash_status" name="koolclash_status" color="#1bbf35">正在获取 Clash 进程状态...</span>'
                    },
                ]);
                $('#koolclash-dashboard-info').forms([
                    {
                        title: '<b>Host</b>',
                        text: '<span id="koolclash-lan-ip">路由器 LAN IP</span>'
                    },
                    {
                        title: '<b>端口</b>',
                        text: '6170'
                    },
                    {
                        title: '<b>密钥</b>',
                        text: '<span id="koolclash-dashboard-info-secret">Clash 配置文件中设置的 secret（没有可不填）</span>'
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
                        value: '',
                    },
                ]);
                $('#koolclash-config-dns').forms([
                    {
                        title: '<b>后备 Clash DNS 配置 (YAML)</b>',
                        suffix: '<p id="koolclash-dns-msg" style="margin-top: 10px; margin-bottom: 6px"></p>',
                        name: 'koolclash-config-dns',
                        type: 'textarea',
                        value: '正在加载存储的 Clash DNS Config 配置...',
                        style: 'width: 100%; height: 200px;'
                    },
                ]);

                document.getElementById('_koolclash_config_suburl').setAttribute('placeholder', 'https://api.example.com/clash');
            },
            // 选择 Tab
            // 注意选择的方式是使用 input 的 ID
            selectTab: (inputId) => {
                for (let i of document.getElementsByClassName('koolclash-nav-radio')) {
                    i.removeAttribute('checked');
                    document.getElementById(inputId).setAttribute('checked', '');
                }
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
            // getClashStatus
            // 获取 Clash 进程 PID
            getClashStatus: () => {
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        "id": id,
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

                        let data = resp.result.split('@');
                        document.getElementById('koolclash_status').innerHTML = data[0];
                        document.getElementById('koolclash-lan-ip').innerHTML = data[1];
                        document.getElementById('koolclash-dashboard-info-secret').innerHTML = (data[2] === 'null') ? `` : data[2];
                    },
                    error: () => {
                        if (softcenter === 1) {
                            return false;
                        }
                        document.getElementById('koolclash_status').innerHTML = `<span style="color: red">获取 Clash 进程运行状态失败！请刷新页面重试`;
                    }
                });
            },
            checkIP: () => {
                IP.getIpipnetIP();
                IP.getIpifyIP();
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
                                    "id": id,
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
                                        document.getElementById('koolclash-btn-upload').innerHTML = '在配置文件中没有找到 DNS 设置，请添加 DNS 后备配置！';
                                        // KoolClash.selectTab('koolclash-nav-config')
                                        document.getElementById('koolclash-btn-upload').classList.remove('btn-primary');
                                        document.getElementById('koolclash-btn-upload').classList.add('btn-danger');
                                        document.getElementById('koolclash-btn-save-dns-config').removeAttribute('disabled');
                                    } else {
                                        document.getElementById("koolclash-btn-upload").innerHTML = '配置文件上传完毕！重启 Clash 后生效新的配置';
                                        setTimeout(() => {
                                            KoolClash.enableAllButton();
                                            document.getElementById('koolclash-btn-upload').innerHTML = '上传配置文件';
                                        }, 3000)
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
            defaultDNSConfig: `# 没有找到保存的 Clash DNS 后备配置，推荐使用以下的配置
dns:
  enable: true
  ipv6: false
  listen: 0.0.0.0:53
  enhanced-mode: redir-host
  nameserver:
    - 119.28.28.28
    - 119.29.29.29
    - 223.5.5.5
    - tls://dns.rubyfish.cn:853
  fallback:
    - tls://1.0.0.1:853
    - tls://8.8.4.4:853
`,
            getDNSConfig: () => {
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        "id": id,
                        "method": "koolclash_get_dns_config.sh",
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

                        if (resp.result === '') {
                            document.getElementById('koolclash-dns-msg').innerHTML = `（没有找到已保存的 DNS 配置）`;
                            document.getElementById('_koolclash-config-dns').innerHTML = KoolClash.defaultDNSConfig;
                        } else {
                            document.getElementById('koolclash-dns-msg').innerHTML = `（之前提交的 DNS 配置）`;
                            document.getElementById('_koolclash-config-dns').innerHTML = Base64.decode(resp.result);
                        }
                    },
                    error: () => {
                        if (softcenter === 1) {
                            return false;
                        }
                        document.getElementById('_koolclash-config-dns').innerHTML = KoolClash.defaultDNSConfig;
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
                    postData = JSON.stringify({
                        "id": id,
                        "method": "koolclash_save_dns_config.sh",
                        "params": [`${Base64.encode(document.getElementById('_koolclash-config-dns').value.replace('# 没有找到保存的 Clash DNS 后备配置，推荐使用以下的配置\n', ''))}`],
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
                            document.getElementById('koolclash-btn-save-dns-config').innerHTML = '不能提交 空的 DNS 后备配置！';
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                document.getElementById('koolclash-btn-save-dns-config').innerHTML = '提交 Clash 后备 DNS 设置';
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
                            document.getElementById('koolclash-btn-save-dns-config').innerHTML = '提交 Clash 后备 DNS 设置';
                        }, 4000)
                    }
                });
            },
            restart: () => {
                KoolClash.disableAllButton();
                document.getElementById('msg_warning').innerHTML = `正在启动 Clash，请不要刷新或关闭页面！`;
                $('#msg_warning').show();

                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        "id": id,
                        "method": "koolclash_control.sh",
                        "params": ['start'],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'noconfig') {
                            $('#msg_warning').hide();
                            document.getElementById('msg_error').innerHTML = `没有找到 Clash 配置文件！请在页面自动刷新之后(重新)上传 Clash 配置文件！<span id="koolclash-wait-time"></span>`;
                            document.getElementById('msg_warning').innerHTML = `请不要刷新或关闭页面，务必等待页面自动刷新！`;
                            $('#msg_error').show();
                            $('#msg_warning').show();
                            KoolClash.tminus(15);
                            setTimeout(() => {
                                window.location.reload();
                            }, 15000)
                        } else if (resp.result === 'nodns') {
                            $('#msg_warning').hide();
                            document.getElementById('msg_error').innerHTML = `在 Clash 配置文件中没有找到 DNS 设置！请在页面自动刷新之后(重新)上传 Clash 配置文件！<span id="koolclash-wait-time"></span>`;
                            document.getElementById('msg_warning').innerHTML = `请不要刷新或关闭页面，务必等待页面自动刷新！`;
                            $('#msg_error').show();
                            $('#msg_warning').show();
                            KoolClash.tminus(15);
                            setTimeout(() => {
                                window.location.reload();
                            }, 15000)
                        } else {
                            $('#msg_warning').hide();
                            document.getElementById('msg_success').innerHTML = `Clash 即将启动成功！<span id="koolclash-wait-time"></span>`;
                            document.getElementById('msg_warning').innerHTML = `请不要刷新或关闭页面，务必等待页面自动刷新！`;
                            $('#msg_success').show();
                            $('#msg_warning').show();
                            KoolClash.tminus(20);
                            setTimeout(() => {
                                window.location.reload();
                            }, 20000)
                        }
                    },
                    error: () => {
                        document.getElementById('msg_error').innerHTML = `Clash (可能)启动失败！请在页面自动刷新之后检查 Clash 运行状态！<span id="koolclash-wait-time"></span>`;
                        document.getElementById('msg_warning').innerHTML = `请不要刷新或关闭页面，务必等待页面自动刷新！`;
                        $('#msg_error').show();
                        $('#msg_warning').show();
                        KoolClash.tminus(15);
                        setTimeout(() => {
                            window.location.reload();
                        }, 15000)
                    }
                });
            },
            stop: () => {
                KoolClash.disableAllButton();
                document.getElementById('msg_warning').innerHTML = `正在关闭 Clash，请不要刷新或关闭页面！`;
                $('#msg_warning').show();
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        "id": id,
                        "method": "koolclash_control.sh",
                        "params": ['stop'],
                        "fields": ""
                    });

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        $('#msg_warning').hide();
                        document.getElementById('msg_success').innerHTML = `Clash 即将关闭！<span id="koolclash-wait-time"></span>`;
                        document.getElementById('msg_warning').innerHTML = `请不要刷新或关闭页面，务必等待页面自动刷新！`;
                        $('#msg_success').show();
                        $('#msg_warning').show();
                        KoolClash.tminus(15);
                        setTimeout(() => {
                            window.location.reload();
                        }, 15000)
                    },
                    error: () => {
                        $('#msg_warning').hide();
                        document.getElementById('msg_error').innerHTML = `Clash (可能)关闭失败！请在页面自动刷新之后检查 Clash 运行状态！<span id="koolclash-wait-time"></span>`;
                        document.getElementById('msg_warning').innerHTML = `请不要刷新或关闭页面，务必等待页面自动刷新！`;
                        $('#msg_error').show();
                        $('#msg_warning').show();
                        KoolClash.tminus(15);
                        setTimeout(() => {
                            window.location.reload();
                        }, 15000)
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

                $.ajax({
                    type: "POST",
                    cache: false,
                    url: "/_api/",
                    data: postData,
                    dataType: "json",
                    success: (resp) => {
                        if (resp.result === 'nodl') {
                            document.getElementById('koolclash-btn-update-ipdb').innerHTML = `你的路由器中既没有 curl 也没有 wget，不能下载更新！`;
                        } else if (resp.result === 'fail') {
                            document.getElementById('koolclash-btn-update-ipdb').innerHTML = `IP 解析库更新失败！`;
                        } else {
                            document.getElementById('koolclash-btn-update-ipdb').innerHTML = `IP 解析库更新成功，重新启动 Clash 即可生效！`;
                        }

                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            document.getElementById('koolclash-btn-update-ipdb').innerHTML = '更新 IP 解析库';
                        }, 5500)
                    },
                    error: () => {
                        document.getElementById('koolclash-btn-update-ipdb').innerHTML = `IP 解析库更新失败！`;
                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            document.getElementById('koolclash-btn-update-ipdb').innerHTML = '更新 IP 解析库';
                        }, 3000)
                    }
                });
            },
            deleteSuburl: () => {
                KoolClash.disableAllButton();
                document.getElementById('koolclash-btn-del-suburl').innerHTML = `正在删除 Clash 托管配置 URL`;
                let id = parseInt(Math.random() * 100000000),
                    postData = JSON.stringify({
                        "id": id,
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
                        "id": id,
                        "method": "koolclash_sub.sh",
                        "params": ['update', `${document.getElementById('_koolclash_config_suburl').value}`],
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
                        } else if (resp.result === 'nofallbackdns') {
                            document.getElementById('koolclash-btn-update-sub').innerHTML = '在托管配置中没有找到 DNS 设置，请在下面添加 DNS 配置！';
                            document.getElementById('koolclash-btn-save-dns-config').removeAttribute('disabled');
                        } else {
                            document.getElementById('koolclash-btn-update-sub').innerHTML = 'Clash 配置更新成功，重启 Clash 生效！';
                            setTimeout(() => {
                                KoolClash.enableAllButton();
                                document.getElementById('koolclash-btn-update-sub').innerHTML = '更新 Clash 托管配置';
                            }, 2500)
                        }
                    },
                    error: () => {
                        document.getElementById('koolclash-btn-update-sub').innerHTML = `Clash 配置更新失败！`;

                        setTimeout(() => {
                            KoolClash.enableAllButton();
                            document.getElementById('koolclash-btn-update-sub').innerHTML = '更新 Clash 托管配置';
                        }, 2500)
                    }
                });
            },
        };
    </script>

    <script>
        window.dbus = {}

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
                if (window.dbus.koolclash_suburl) {
                    document.getElementById('_koolclash_config_suburl').value = window.dbus.koolclash_suburl;
                }
            })
            .catch(error => {
                throw error;
            });

        KoolClash.renderUI();
        KoolClash.getClashStatus();
        KoolClash.checkUpdate();
        KoolClash.getDNSConfig();
        KoolClash.checkIP();
    </script>
    <script src="https://www.taobao.com/help/getip.php"></script>
    <script src="https://ipv4.ip.sb/addrinfo.php?callback=IP.getIpsbIP"></script>
</content>
