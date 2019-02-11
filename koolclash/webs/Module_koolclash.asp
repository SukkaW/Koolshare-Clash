<title>V2Ray</title>
<content>
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="/js/tomato.js"></script>
    <script type="text/javascript" src="/js/advancedtomato.js"></script>
    <style type="text/css">
        .box,
        #clash_tabs {
            min-width: 720px;
        }
    </style>
    <script>

    </script>
    <div class="box">
        <div class="heading">
            <span id="_v2ray_version"></span>
            <a href="#/soft-center.asp" class="btn"
                style="float:right; border-radius:3px; margin-right:5px; margin-top:0px;">返回</a>
            <!--<a href="https://github.com/koolshare/ledesoft/blob/master/v2ray/Changelog.txt" target="_blank"
                class="btn btn-primary" style="float:right;border-radius:3px;margin-right:5px;margin-top:0px;">更新日志</a>-->
            <!--<button type="button" id="updateBtn" onclick="check_update()" class="btn btn-primary" style="float:right;border-radius:3px;margin-right:5px;margin-top:0px;">检查更新 <i class="icon-upgrade"></i></button>-->
        </div>
        <div class="content">
            <div class="col" style="line-height:30px; width:700px">
                <p>Clash 是一个基于规则的代理程序，兼容 Shadowsocks、V2Ray 等协议，拥有像 Surge 一样强大的代理规则。</p>
                <p><a href="https://github.com/Dreamacro/clash">Clash on GitHub</a></p>

                <p style="color: red; margin-top: 40px">！！请注意！！</p>
                <p style="color: red">为了降低插件开发难度（实际上是我偷懒），插件将会修改 Clash Config 文件中的部分设置（如代理端口、透明代理端口、外部控制端口等）。</p>
                <p style="color: red">如果你正在购买并使用商业性质的公共代理服务，请务必先仔细阅读相关服务商的 服务条款与条件（ToS）。部分公共代理服务商（如 rixCloud）的服务条款与条件规定，如果用户更改了服务商提供的托管配置将会被视为自动放弃 SLA 和技术支持服务。</p>
                <p style="color: red">如果你使用的公共代理服务有诸如此类的限制性条款（如 rixCloud），我会耸耸肩，然后表示很遗憾。你应该向你的服务商提交技术支持请求，并在支持请求中附上 <a href="https://graph.org/%E5%85%B3%E4%BA%8E-KoolClash-%E6%8F%92%E4%BB%B6-02-11" target="_blank">这篇文章</a> 的链接，询问使用本插件是否违背了他们的条款和条件。然后由您自行做出选择是否继续使用本插件。</p>
            </div>
        </div>
    </div>
    <div class="box" style="margin-top: 0px;">
        <div class="heading">
        </div>
        <div class="content">
            <div id="v2ray_switch_pannel" class="section" style="margin-top: -20px;"></div>
            <hr />
            <div>
                <p>查看代理运行状态请访问 <a href="https://ip.skk.moe/?from=koolclash_plugin" target="_blank">IP.SKK.MOE</a> 查看自己的 IP</p>
            </div>
        </div>
    </div>

    <div id="msg_warring" class="alert alert-warning icon" style="display:none;"></div>
    <div id="msg_success" class="alert alert-success icon" style="display:none;"></div>
    <div id="msg_error" class="alert alert-error icon" style="display:none;"></div>
    <button type="button" value="Save" id="save-button" onclick="save()" class="btn btn-primary">提交 <i
            class="icon-check"></i></button>
</content>