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
            var loginUser = "${loginUser}";
            if (loginUser != "") {
                $("#alogin").append("<a href='user.jsp'>" + loginUser + "</a>");
            } else {
                $("#alogin").append("<a href='login.jsp'>登录</a>");
            }
        })

        var phoneverify = /^(13[0-9]|14[0-9]|15[0-9]|166|17[0-9]|18[0-9]|19[8|9])\d{8}$/;
        var pwdverify = /^[a-zA-Z]\w{5,17}$/;
        var realnameverify = /^[\u4e00-\u9fa5]{2,8}$/;

        function validate(date) {
            $("#apwd").empty();
            $("#aname").empty();
            $("#confirm_tips").empty();
            $("#null_tips").empty();
            $("#name_tips").empty();
            $("#phone_tips").empty();
            if (verifyusername(date) && verifypwd(date)) {
                if (valify(date) && existValify(date)) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                return false;
            }
        }
        function existValify(date) {
            var user_name = {
                "accout": date.username.value,
            };
            var success_flag = false;
            $.ajax({
                type: "POST",
                url: "checkBrokerAccout.do",
                async: false,
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                data: user_name,
                dataType: "JSON",
                success: function (data) {
                    if (data == "does not exist") {
                        success_flag = true;
                    }
                    else if (data == "exist") {
                        $("#aname").append("账号已存在");
                    }
                }, error: function () {
                    alert("ajax error!");
                }
            });
            return success_flag;
        }

        function valify(date) {
            if (date.username.value == ""
                || date.password.value == ""
                || date.confirm_password.value == "") {
                $("#null_tips").append("账号或密码为空!");
                return false;
            }
            else if (date.password.value != date.confirm_password.value) {
                $("#confirm_tips").append("密码不一致");
                return false;
            } else if (date.context_phone.value == "") {
                $("#phone_tips").append("手机号码不能为空");
                return false;
            }
            else if (!phoneverify.test(date.context_phone.value)) {
                $("#phone_tips").append("手机号码格式不正确");
                return false;
            } else if (date.real_name.value == "") {
                $("#name_tips").append("您需要输入姓名");
                return false;
            }
            else if (!realnameverify.test(date.real_name.value)) {
                $("#name_tips").append("姓名格式不正确");
                return false;
            }
            else {
                $("#apwd").empty();
                $("#aname").empty();
                $("#confirm_tips").empty();
                $("#null_tips").empty();
                $("#phone_tips").empty();
                $("#name_tips").empty();
                return true;
            }
        }
        function verifyusername(date) {
            if (date.username.value.length > 6) {
                return true;
            }
            else {
                $("#aname").append("用户名长度需大于6");
                return false;
            }
        }
        function verifypwd(date) {
            if (pwdverify.test(date.password.value)) {
//              密码符合规则!
                return true;
            }
            else {
//              密码不符合规则!
                $("#apwd").append("请以字母开头，长度在6~18之间，只能包含字母、数字和下划线");
                return false;
            }
        }

        function submitreg(data) {
            var fromNode = data.parentNode.parentNode;
            if (!validate(fromNode)) {
                return;
            }
            var context_phone = $("#context_phone").val();
            var sex = $('input[name="sex"]:checked').val();
            var real_name = $("#real_name").val();
            var accout = $("#agent").val();
            var password = $("#password").val();

            var userInfo = {
                "accout": accout,
                "context_phone": context_phone,
                "sex": encodeURI(sex),
                "real_name": encodeURI(real_name),
                "password": password,
            };
            $.ajax({
                type: "POST",
                url: "brokerRegister.do",
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                data: userInfo,
                dataType: "JSON",
                success: function (data) {
                    if (data == "success") {
                        var msg = "注册成功,现在登录?";
                        var isTurnPage = confirm(msg);
                        if (isTurnPage) {
                            window.location = "login.jsp";
                        }
                    } else {
                        alert("注册失败, 请稍后再试!")
                    }
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
        <div class="reg-logo">
            <%--<form id="signupForm" method="get" action="brokerRegister.do" onsubmit="return validate(this)" class="zcform">--%>
            <form id="signupForm" method="get" action="brokerRegister.do" class="zcform">
                <h3>经纪人注册:</h3>
                <a id="null_tips"></a>
                <p id="name" class="clearfix">
                    <label class="one" for="agent">用户名：</label>
                    <input id="agent" name="username" type="text" class="required" value placeholder="请输入您的用户名"/>
                </p>
                <a id="aname"></a>
                <p id="pwd" class="clearfix">
                    <label class="one" for="password">登录密码：</label>
                    <input id="password" name="password" type="password" class="{required:true,rangelength:[8,20],}"
                           value placeholder="请输入密码"/>
                </p>
                <a id="apwd"></a>
                <p class="clearfix">
                    <label class="one" for="confirm_password">确认密码：</label>
                    <input id="confirm_password" name="confirm_password" type="password"
                           class="{required:true,equalTo:'#password'}" value placeholder="请再次输入密码"/>
                </p>
                <a id="confirm_tips"></a>

                <p class="clearfix" align="center">
                    <label class="one" for="rbSex2">性 &nbsp; &nbsp;别：</label>
                    <input type="radio" value="男" id="rbSex2" name="sex" checked="checked">
                    <label for="rbSex2">男</label>
                    <input type="radio" value="女" id="rbSex1" name="sex">
                    <label for="rbSex1">女</label>
                    <span id="Sex_Tip"></span>
                </p>
                <a id="name_tips"></a>
                <p class="clearfix">
                    <label class="one" for="real_name"><span class="red">*</span>姓 &nbsp; &nbsp;名：</label>
                    <input class="inp inw" type="text" name="real_name" id="real_name" value="" maxlength="14">
                </p>
                <a id="phone_tips"></a>
                <p class="clearfix">
                    <label class="one" for="real_name"><span class="red">*</span>联系电话：</label>
                    <input class="inp inw" type="text" name="context_phone" id="context_phone" value=""
                           onkeyup="this.value=this.value.replace(/[^\d]/g,'')">
                </p>

                <p class="clearfix"><input class="submit" type="button" onclick="submitreg(this)" value="立即注册"/></p>
            </form>
            <div class="reg-logo-right">
                <h3>如果您已有账号，请</h3>
                <a href="login.jsp" class="logo-a">立即登录</a>
            </div><!--reg-logo-right/-->
            <div class="clears"></div>
        </div><!--reg-logo/-->
    </div><!--width1190/-->
</div><!--content/-->

<div class="footer">
    <div class="width1190">
        <div class="fl"><a href="index.jsp"><strong>邻居大妈</strong></a><a href="about.html">关于我们</a><a
                href="contact.html">联系我们</a><a href="user.jsp">个人中心</a></div>
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
<div class="copy">Copyright@ 2015 邻居大妈 版权所有 沪ICP备1234567号-0&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<div class="bg100"></div>
</body>
</html>
