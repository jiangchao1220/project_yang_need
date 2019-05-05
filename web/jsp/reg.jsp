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
                $("#alogin").append("<a href='user.jsp'>" + loginUser +"</a>");
            } else{
                $("#alogin").append("<a href='login.jsp'>登录</a>");
            }
        })

        var usernameverify = /^(13[0-9]|14[0-9]|15[0-9]|166|17[0-9]|18[0-9]|19[8|9])\d{8}$/;
        var pwdverify = /^[a-zA-Z]\w{5,17}$/;

        function validate(date) {
            $("#apwd").empty();
            $("#aname").empty();
            $("#confirm_tips").empty();
            $("#null_tips").empty();
            if(verifyusername(date) && verifypwd(date)){
//                return valify(date);
                if (valify(date) && existValify(date))
                {
                    return true;
                }
                else{
                    return false;
                }
            }
            else {
                return false;
            }
        }
        function existValify(date) {
            var user_name = {
                "username": date.username.value,
            };
            var success_flag = false;
            $.ajax({
                type: "GET",
                url: "checkUserName.do",
                async:false,
                contentType: "application/json;charset=UTF-8",
                data: user_name,
                dataType: "JSON",
                success: function (data) {
                    if (data == 0){
                        success_flag = true;
                    }
                    else if(data == 1){
                        $("#aname").append("账号已存在");
                    }
                }, error: function () {
                    alert("ajax error!");
                }
            });
            return success_flag;

        }

        function valify(date) {
            if (date.username.value == "" || date.password.value == "" || date.confirm_password.value == ""){
//                alert("账号密码不能为空,请重新输入!")
                $("#null_tips").append("账号或密码为空!");
                return false;
            }
            else if (date.password.value != date.confirm_password.value){
//                alert("密码不一致!"
                $("#confirm_tips").append("密码不一致");
                return false;
            }
//            else if(!verifyusername(date) || !verifypwd(date)){
//                return false;
//            }
            else{
//                alert("通过校验");
                $("#apwd").empty();
                $("#aname").empty();
                $("#confirm_tips").empty();
                $("#null_tips").empty();
                return true;
            }
        }
        function verifyusername(date) {
            if (usernameverify.test(date.username.value)){
//                alert("账号符合规则!");
                return true;
            }
            else {
//                alert("账号不符合规则!");
                $("#aname").append("请输入正确的手机号码");
                return false;
            }
        }
        function verifypwd(date) {
            if (pwdverify.test(date.password.value)){
//                alert("密码符合规则!");
                return true;
            }
            else {
//                alert("密码不符合规则!");
                $("#apwd").append("请以字母开头，长度在6~18之间，只能包含字母、数字和下划线");
                return false;
            }
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
            <form id="signupForm" method="post" action="register.do" onsubmit="return validate(this)" class="zcform">
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
                <!--<p class="clearfix agreement">
                    <input type="checkbox" />
                    <b class="left">已阅读并同意<a href="#">《用户协议》</a></b>
                </p>-->
                <p class="clearfix"><input class="submit" type="submit" value="立即注册"/></p>
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
