<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="Author" contect="http://www.webqin.net">
    <title>邻居大妈</title>
    <link rel="shortcut icon" href="images/favicon.ico"/>
    <link type="text/css" href="css/css.css" rel="stylesheet"/>
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/js.js"></script>
    <script type="text/javascript">
        $(function () {
            //导航定位
            $(".nav li:eq(6)").addClass("navCur");
            var loginUser = <%=session.getAttribute("loginUser") %>;
            if (loginUser != null) {
                $("#alogin").append("<a href='user.jsp'>" + loginUser + "</a>");
                $("#phone").empty();
                $("#phone").text(loginUser);
                //加载个人信息
                loadUserInfo(loginUser);
            } else {
                $("#alogin").append("<a href='login.jsp'>登录</a>");
            }
        })

        function loadUserInfo(username) {
            var userInfo = {
                "username": username,
            };
            $.ajax({
                type: "GET",
                url: "loadUserInfo.do",
                contentType: "application/json;charset=UTF-8",
                data: userInfo,
                dataType: "JSON",
                success: function (data) {
                    if (data == null) {
                        return;
                    }
                    switch (data.sex) {
                        case "女":
                            console.log("m")
                            $("#rbSex1").prop("checked", true);
                            break;
                        case "男":
                            console.log("f")
                            $("#rbSex2").prop("checked", true);
                            break;
                        case "保密":
                            console.log("s")
                            $("#rbSex3").prop("checked", true);
                            break;
                    }
                    $("#title").val(data.name);
                    $("#age").val(data.age);
                    $("#qq").val(data.qq);
                    $("#sign").val(data.signtext);
                }, error: function () {
                    alert("ajax error!");
                }
            });
        }

        function loginout() {
            var msg = "退出登录!"
            var result = confirm(msg);
            if (result) {
                $.ajax({
                    type: "GET",
                    url: "..//loginOut/signOut.do",
                    contentType: "application/json;charset=UTF-8",
                    data: "",
                    dataType: "JSON",
                    success: function (data) {
                        if (data == "signoutsuccess") {
                            //退出成功
                            alert("安全退出登录成功.");
                            $("#alogin").empty();
                            $("#alogin").append("<a href='login.jsp'>登录</a>");
                            window.location = "user.jsp";
                        } else {
                            alert("您还未登录!");
                        }
                    }, error: function () {
                        alert("ajax error!");
                    }
                });
            }
        }

        function mod_member() {
            var username = <%=session.getAttribute("loginUser") %>;
            if (username == null) {
                alert("请登陆后操作!");
                return;
            }
            var phone = username;
            var sex = $('input[name="sex"]:checked').val();
            var name = $("#title").val();
            var age = $("#age").val();
            var qq = $("#qq").val();
            var signtext = $("#sign").val();

            var userInfo = {
                "username": username,
                "phone": phone,
                "sex": encodeURI(sex),
                "name": encodeURI(name),
                "age": age,
                "qq": qq,
                "signtext": encodeURI(signtext),
            };
            $.ajax({
                type: "GET",
                url: "userinfo.do",
                contentType: "application/json;charset=UTF-8",
                data: userInfo,
                dataType: "JSON",
                success: function (data) {
                    alert(data);
                }, error: function () {
                    alert("ajax error!");
                }
            });
        }
    </script>
</head>

<body>
<div class="header">
    <div class="width1190">
        <div class="fl">您好，欢迎来到邻居大妈！</div>
        <div class="fr">
            <a id="alogin"></a>
            <%--<a href="login.jsp">登录</a>--%> |
            <a href="reg.jsp">注册</a> |
            <a href="javascript:;" onclick="AddFavorite(window.location,document.title)">加入收藏</a> |
            <a href="javascript:;" onclick="SetHome(this,window.location)">设为首页</a>
        </div>
        <div class="clears"></div>
    </div><!--width1190/-->
</div><!--header/-->
<div class="logo-phone">
    <div class="width1190">
        <h1 class="logo"><a href="index.jsp"><img src="images/logo.png" width="163" height="59"/></a></h1>
        <div class="phones"><strong>021-63179891</strong></div>
        <div class="clears"></div>
    </div><!--width1190/-->
</div><!--logo-phone/-->

<div class="content">
    <div class="width1190">
        <div class="vip-left">
            <div class="vipNav">
                <h3 class="vipTitle">会员中心</h3>
                <dl>
                    <dt class="vipIcon3">账户设置</dt>
                    <dd>
                        <a href="user.jsp" class="vipNavCur">我的资料</a>
                        <a href="user_pwd.jsp">账户密码设置</a>
                    </dd>
                    <dt class="vipIcon1">我的邻居大妈</dt>
                    <dd>
                        <a href="user_guanzhu.jsp">关注房源</a>
                        <a href="javascript:;" onclick="loginout()">退出登录</a>
                    </dd>
                </dl>
            </div><!--vipNav/-->
        </div><!--vip-left/-->
        <div class="vip-right">
            <%--<h3 class="vipright-title">修改头像</h3>
            <form action="#" method="get">
                <dl class="vip-touxiang">
                    <dt><img src="images/tx.jpg" width="100" height="100"/></dt>
                    <dd>
                        <h3><strong>点击选择文件上传头像</strong></h3>
                        <div class="sctx"><input type="file"/><a href="javascript:;">上传</a></div>
                        <p>图片格式：GIF、JPG、JPEG、PNG ，最适合尺寸100*100像素</p>
                    </dd>
                    <div class="clearfix"></div>
                </dl><!--vip-touxiang/-->
            </form>--%>
            <h3 class="vipright-title">修改资料</h3>
            <table class="grinfo">
                <tbody>
                <tr>
                    <th>手机号：</th>
                    <td><strong id="phone">未登录</strong>
                        &nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;"><span
                                style="color:#888;cursor:pointer">(修改手机号)</span></a>
                    </td>
                </tr>
                <tr>
                    <th><span class="red">*</span> 昵称：</th>
                    <td>
                        <input class="inp inw" type="text" id="title" value="" maxlength="14">
                    </td>
                </tr>
                <tr>
                    <th><span class="red">*</span> 性 &nbsp; &nbsp;别：</th>
                    <td>
                        <input type="radio" value="女" id="rbSex1" name="sex">
                        <label for="rbSex1">女</label>
                        <input type="radio" value="男" id="rbSex2" name="sex">
                        <label for="rbSex2">男</label>
                        <input type="radio" value="保密" id="rbSex3" name="sex">
                        <label for="rbSex2">保密</label>
                        <span id="Sex_Tip"></span>
                    </td>
                </tr>
                <tr>
                    <th><span class="red"></span> 年 &nbsp; &nbsp;龄：</th>
                    <td>
                        <input class="inp inw" type="text" id="age" value="0"
                               onkeyup="this.value=this.value.replace(/[^\d]/g,'')">
                    </td>
                </tr>


                <tr>
                    <th>&nbsp;Q &nbsp; &nbsp;Q：</th>
                    <td>
                        <input class="inp inw" type="text" maxlength="15" value="" id="qq"
                               onkeyup="this.value=this.value.replace(/[^\d]/g,'')">
                    </td>
                </tr>

                <tr>
                    <th valign="top">个性签名：</th>
                    <td>
                        <textarea id="sign" class="grtextarea"></textarea>
                        <br>
                        <span class="fgrey">(128字符以内)</span>
                    </td>
                </tr>
                <tr>
                    <th>&nbsp;</th>
                    <td colspan="2">
                        <label class="butt" id="butt">
                            <input type="submit" class="member_mod_buttom" onclick="mod_member()" value="完成修改"/>
                        </label>
                    </td>
                </tr>
                </tbody>
            </table>
        </div><!--vip-right/-->
        <div class="clearfix"></div>
    </div><!--width1190/-->
</div><!--content/-->

<div class="footer">
    <div class="width1190">
        <div class="fl"><a href="index.html"><strong>邻居大妈</strong></a><a href="about.html">关于我们</a><a
                href="contact.html">联系我们</a><a href="user.html">个人中心</a></div>
        <div class="fr">
            <dl>
                <dt><img src="images/erweima.png" width="76" height="76"/></dt>
                <dd>微信扫一扫<br/>房价点评，精彩发布</dd>
            </dl>
            <dl>
                <dt><img src="images/erweima.png" width="76" height="76"/></dt>
                <dd>微信扫一扫<br/>房价点评，精彩发布</dd>
            </dl>
            <div class="clears"></div>
        </div>
        <div class="clears"></div>
    </div><!--width1190/-->
</div><!--footer/-->
<div class="copy">Copyright@ 2015 邻居大妈 版权所有 沪ICP备1234567号-0&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div class="bg100"></div>
<div class="zhidinggoufang">
    <h2>指定购房 <span class="close">X</span></h2>
    <form action="#" method="get">
        <div class="zhiding-list">
            <label>选择区域：</label>
            <select>
                <option>智慧园</option>
                <option>立民村</option>
                <option>塘口村</option>
                <option>勤劳村</option>
                <option>芦胜村</option>
                <option>知新村</option>
            </select>
        </div>
        <div class="zhiding-list">
            <label>方式：</label>
            <select>
                <option>租房</option>
                <option>新房</option>
                <option>二手房</option>
            </select>
        </div>
        <div class="zhiding-list">
            <label>联系方式：</label>
            <input type="text"/>
        </div>
        <div class="zhidingsub"><input type="submit" value="提交"/></div>
    </form>
    <div class="zhidingtext">
        <h3>指定购房注意事宜：</h3>
        <p>1、请详细输入您所需要购买的房源信息(精确到小区)</p>
        <p>2、制定购房申请提交后，客服中心会在24小时之内与您取得联系</p>
        <p>3、如有任何疑问，请随时拨打我们的电话：400-000-0000</p>
    </div><!--zhidingtext/-->
</div><!--zhidinggoufang/-->
</body>
</html>
