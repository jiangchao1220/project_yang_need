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
                $("#user_phone").append(loginUser);
            } else {
                $("#alogin").append("<a href='login.jsp'>登录</a>");
                $("#user_phone").append("您还没有登录");
            }
        })

        var pwdverify = /^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){5,17}$/;

        function sub_username() {
            var loginCheck = <%=session.getAttribute("loginUser") %>;
            if (loginCheck == null) {
                alert("请先登录!");
                return;
            }
            $("#comfirm").empty();
            $("#checkpwd").empty();
            var newpassword = $("#new_password").val();
            var comfirmpwd = $("#comfirm_password1").val();
            if (validate(newpassword) && comfirmValidate(newpassword, comfirmpwd)) {
                // 两次密码一致校验通过
                updatePwd(newpassword);
            } else {
                return;
            }
        }

        function comfirmValidate(newpassword, comfirmpwd) {
            if (newpassword != comfirmpwd) {
                $("#comfirm").append("密码不一致");
                return false;
            } else {
                return true;
            }
        }

        function validate(pwd) {
            //校验不够严格,全字母可以通过校验
            if (pwdverify.test(pwd)) {
                return true;
            }
            else {
                $("#checkpwd").append("请以字母开头，长度在6~18之间，只能包含字母、数字和下划线");
                return false;
            }
        }

        function updatePwd(newpwd) {
            var newPasswoed = {
                "password": newpwd,
            };
            $.ajax({
                type: "GET",
                url: "updatePwssword.do",
                contentType: "application/json;charset=UTF-8",
                data: newPasswoed,
                dataType: "JSON",
                success: function (data) {
                    if (data == 1) {
                        //修改成功
                        alert("密码修改成功,请重新登录");
                        window.location = "login.jsp";
                    } else {
                        alert("密码修改失败,请稍后重试");
                    }
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
                            window.location = "user_pwd.jsp";
                        } else {
                            alert("您还未登录!");
                        }
                    }, error: function () {
                        alert("ajax error!");
                    }
                });
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
        <div class="vip-left">
            <div class="vipNav">
                <h3 class="vipTitle">会员中心</h3>
                <dl>
                    <dt class="vipIcon3">账户设置</dt>
                    <dd>
                        <a href="user.jsp">我的资料</a>
                        <a href="user_pwd.jsp" class="vipNavCur">账户密码设置</a>
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
            <h3 class="vipright-title">修改资料</h3>
            <table class="grinfo">
                <tbody>
                <tr>
                    <th>原手机号：</th>
                    <td><strong id="user_phone"></strong></td>
                </tr>
                <%--<tr>
                    <th>账号：</th>
                    <td><input class="inp inw" type="text" id="new_username" maxlength="15" placeholder="不少于3位中英文即可"
                               value="" onkeyup="return only_py_num(this)">

                    </td>
                </tr>--%>
                <tr>
                    <th>新密码：</th>
                    <td>
                        <input class="inp inw" type="password" id="new_password" placeholder="不少于6位">
                        <a id="checkpwd"></a>
                    </td>
                </tr>
                <tr>
                    <th>重复新密码：</th>
                    <td>
                        <input class="inp inw" type="password" id="comfirm_password1" placeholder="不少于6位">
                        <a id="comfirm"></a>
                    </td>
                </tr>
                <tr>
                    <th>&nbsp;</th>
                    <td colspan="2">
                        <label class="butt" id="butt">
                            <div class="member_mod_buttom" onclick="sub_username()">完成修改</div>
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
