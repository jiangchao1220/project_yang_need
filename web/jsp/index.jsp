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
            $(".nav li:eq(0)").addClass("navCur");
            <%--var loginUser = <%=session.getAttribute("loginUser") %>;--%>
            var loginUser = "${loginUser}";
            if (loginUser != "") {
                $("#from1").empty();
                $("#from1").append("<h1 align='cnter'>您已经登陆</h1>" +
                    "<div class='zhidingsub'> " +
                    "<input type='button' onclick='loginout()' value='退出登录'/> " +
                    "</div>");
                $("#alogin").append("<a href='user.jsp'>" + loginUser + "</a>");
            } else {
                $("#alogin").append("<a href='login.jsp'>登录</a>");
            }

            //加载租房房源信息
            $.ajax({
                type: "GET",
                url: "..//house/findHouse.do",
                contentType: "application/json;charset=UTF-8",
                data: {"type": "1"},
                dataType: "JSON",
                success: function (data) {
                    //首页只显示最多8条数据
                    var maxLength = data.length;
                    if (maxLength > 8) {
                        maxLength = 8;
                    }

                    for (var i = 0; maxLength > i; i++) {
                        $("#rent_house").append(
                            "<dl>"
                            + "<dt><a href='../house/proinfo.do?houseNumber=" + data[i].houseNumber + "'><img src='" + data[i].images[0] + "' width='286' height='188'/></a></dt>"
                            + "<dd>"
                            + "<h3><a href='../house/proinfo.do?houseNumber=" + data[i].houseNumber + "'></a>" + data[i].houseInfo + "</h3>"
                            + "<div class='hui'>" + data[i].houseType + " " + data[i].decorationType + "</div>"
                            + "</dd>"
                            + "</dl>"
                        );
                    }
                    $("#rent_house").append("<div class='clears'></div>");
                }, error: function () {
                    alert("ajax error!");
                }
            });

            //加载新房房源信息
            $.ajax({
                type: "GET",
                url: "..//house/findHouse.do",
                contentType: "application/json;charset=UTF-8",
                data: {"type": "2"},
                dataType: "JSON",
                success: function (data) {
                    //首页只显示最多8条数据
                    var maxLength = data.length;
                    if (maxLength > 8) {
                        maxLength = 8;
                    }

                    for (var i = 0; maxLength > i; i++) {
                        $("#new_house").append(
                            "<dl>"
                            + "<dt><a href='../house/proinfo.do?houseNumber=" + data[i].houseNumber + "'><img src='" + data[i].images[0] + "' width='286' height='188'/></a></dt>"
                            + "<dd>"
                            + "<h3><a href='../house/proinfo.do?houseNumber=" + data[i].houseNumber + "'></a>" + data[i].houseInfo + "</h3>"
                            + "<div class='hui'>" + data[i].houseType + " " + data[i].decorationType + "</div>"
                            + "</dd>"
                            + "</dl>"
                        );
                    }
                    $("#new_house").append("<div class='clears'></div>");
                }, error: function () {
                    alert("ajax error!");
                }
            });

            //加载二手房源信息
            $.ajax({
                type: "GET",
                url: "..//house/findHouse.do",
                contentType: "application/json;charset=UTF-8",
                data: {"type": "3"},
                dataType: "JSON",
                success: function (data) {
                    //首页只显示最多8条数据
                    var maxLength = data.length;
                    if (maxLength > 8) {
                        maxLength = 8;
                    }

                    for (var i = 0; maxLength > i; i++) {
                        if (i == 0) {
                            $("#secondhand_house_list1").append(
                                "<a href='../house/proinfo.do?houseNumber=" + data[i].houseNumber + "'>"
                                + "<img src='" + data[i].images[0] + "' width='380' height='285'/>"
                                + "</a>"
                                + "<div class='in-er-left-text'><strong class='fl'>" + data[i].houseInfo
                                + "</strong><strong class='fr alignRight'>¥" + data[i].housePrice + "万元</strong></div>"
                            );
                        }
                        else {
                            $("#secondhand_house_list2").append(
                                "<dl>"
                                + "<dt><a href='../house/proinfo.do?houseNumber=" + data[i].houseNumber + "'><img src='" + data[i].images[0] + "' width='150' height='115'/></a></dt>"
                                + "<dd>"
                                + "<h3><a href='../house/proinfo.do?houseNumber=" + data[i].houseNumber + "'>" + data[i].houseInfo + "</a></h3>"
                                + "<div class='in-er-right-text'>" + data[i].houseDetails + "</div>"
                                + "<div class='price'>¥<strong>" + data[i].housePrice + "万元</strong></div>"
                                + "</dd>"
                                + "<div class='clears'></div>"
                                + "</dl>"
                            );
                        }
                    }
                    $("#secondhand_house_list2").append("<div class='clears'></div>");
                }, error: function () {
                    alert("ajax error!");
                }
            });
        })

        function broker_submit() {
            var username = $("#broker_accout").val();
            var password = $("#broker_passwprd").val();
            var loginMsg = {
                "username": username,
                "password": password,
            };
            $.ajax({
                type: "POST",
                url: "brokerLogin.do",
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                data: loginMsg,
                dataType: "JSON",
                success: function (data) {
                    switch (data) {
                        case "failed":
                            $("#msg").empty();
                            $("#msg").append("<span class='red'>账号或密码错误</span>");
                            break;
                        case "successed":
                            window.location = "index.jsp";//经纪人查询自己添加的房屋界面
                            break;
                    }
                }, error: function () {
                    alert("请求失败!");
                }
            });
        }

        function borker_reg() {
            window.location = "broker_reg.jsp";
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
                            window.location = "index.jsp";
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
<div class="list-nav">
    <div class="width1190">
        <div class="list">
            <h3>房源分类</h3>
            <div class="list-list">
                <dl>
                    <dt><a href="javascript:;">房源区域</a></dt>
                    <dd>
                        <a href="javascript:;">武侯区</a>
                        <a href="javascript:;">金牛区</a>
                        <a href="javascript:;">青羊区</a>
                        <a href="javascript:;">郫都区</a>
                        <a href="javascript:;">其它</a>
                    </dd>
                </dl>
                <dl>
                    <dt><a href="pro_zu.jsp">租房</a></dt>
                    <dd>
                        <a href="pro_zu.jsp">最新房源</a>
                        <%--<a href="pro_zu.html">出租方式</a>
                        <a href="pro_zu.html">面积</a>
                        <a href="pro_zu.html">房型</a>--%>
                    </dd>
                </dl>
                <dl>
                    <dt><a href="pro_xin.jsp">新房</a></dt>
                    <dd>
                        <a href="pro_xin.jsp">最新房源</a>
                        <%--<a href="pro_xin.jsp">面积</a>
                        <a href="pro_xin.jsp">房型</a>--%>
                    </dd>
                </dl>
                <dl>
                    <dt><a href="pro_er.jsp">二手房</a></dt>
                    <dd>
                        <a href="pro_er.jsp">最新房源</a>
                        <%--<a href="pro_er.jsp">面积</a>
                        <a href="pro_er.jsp">房型</a>--%>
                    </dd>
                </dl>
            </div>
        </div><!--list/-->

        <ul class="nav">
            <li><a href="index.jsp">首页</a></li>
            <li><a href="pro_zu.jsp">租房</a></li>
            <li><a href="pro_xin.jsp">新房</a></li>
            <li><a href="pro_er.jsp">二手房</a></li>
            <li class="zhiding"><a href="javascript:;">经纪人</a></li>
            <div class="clears"></div>
        </ul><!--nav/-->
        <div class="clears"></div>
    </div><!--width1190/-->
</div><!--list-nav/-->
<div class="banner" style="background:url(images/ban.jpg) center center no-repeat;"></div>
<div class="content">
    <div class="width1190">
        <h2 class="title">租房 <a href="pro_zu.jsp">更多&gt;&gt;</a></h2>
        <div id="rent_house" class="index-fang-list">
            <!-- 刷新页面时ajax加载数据 -->
        </div><!--index-fang-list/-->

        <h2 class="title">新房 <a href="pro_xin.jsp">更多&gt;&gt;</a></h2>
        <div id="new_house" class="index-fang-list">
            <!-- 刷新页面时ajax加载数据 -->
        </div><!--index-fang-list/-->

        <h2 class="title">二手房 <a href="pro_er.jsp">更多&gt;&gt;</a></h2>
        <div id="secondhand_house" class="index-ershou">
            <div id="secondhand_house_list1" class="in-er-left">

            </div><!--in-er-left/-->
            <div id="secondhand_house_list2" class="in-er-right">

            </div><!--in-er-right/-->
            <div class="clears"></div>
            <!-- secondhand_house 结束div -->
        </div><!--index-ershou/-->
    </div><!--width1190/-->
</div><!--content/-->
<div class="xinren">
    <div class="width1190">
        <dl style="background:url(images/icon1.jpg) left center no-repeat;">
            <dt>承诺</dt>
            <dd>真实可信100%真房源<br/>链家承诺，假一赔百</dd>
        </dl>
        <dl style="background:url(images/icon2.jpg) left center no-repeat;">
            <dt>权威</dt>
            <dd>独家房源 覆盖全城<br/>房源信息最权威覆盖最广</dd>
        </dl>
        <dl style="background:url(images/icon3.jpg) left center no-repeat;">
            <dt>信赖</dt>
            <dd>万名置业顾问 专业服务<br/>百万家庭的信赖之选</dd>
        </dl>
        <dl style="background:url(images/icon4.jpg) left center no-repeat;">
            <dt>安全</dt>
            <dd>安心承诺 保驾护航<br/>多重风险防范机制 无后顾之忧</dd>
        </dl>
        <div class="clears"></div>
    </div><!--width1190/-->
</div><!--xinren/-->
<div class="footer">
    <div class="width1190">
        <div class="fl"><a href="index.html"><strong>邻居大妈</strong></a><a href="about.html">关于我们</a><a
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
<div class="copy">Copyright@ 2019 杨超 版权所有 川ICP备1234567号-0
</div>
<div class="bg100"></div>
<div class="zhidinggoufang">
    <h2>经纪人登录 <span class="close">X</span></h2>
    <form action="#" method="get" id="from1">
        <%--<div class="zhiding-list">
            <label>选择区域：</label>
            <select>
                <option>武侯区</option>
                <option>金牛区</option>
                <option>青羊区</option>
                <option>郫都区</option>
                <option>其  它</option>
            </select>
        </div>
        <div class="zhiding-list">
            <label>方式：</label>
            <select>
                <option>租房</option>
                <option>新房</option>
                <option>二手房</option>
            </select>
        </div>--%>
        <div class="zhiding-list">
            <label>账号：</label>
            <input type="text" id="broker_accout"/>
        </div>
        <div class="zhiding-list">
            <label>密码：</label>
            <input type="password" id="broker_passwprd"/>
        </div>
        <p id="msg" align="center"></p>
        <div class="zhidingsub">
            <input type="button" onclick="broker_submit()" value="提交"/>
            <input type="button" onclick="borker_reg()" value="注册"/>
        </div>
    </form>
    <div class="zhidingtext">
        <h3>经纪人登录注意事宜：</h3>
        <p>1、普通用户无权登录</p>
        <p>2、经纪人不得发布任何虚假房源信息</p>
        <p>3、如有任何疑问，请随时拨打我们的电话：400-000-0000</p>
    </div><!--zhidingtext/-->
</div><!--zhidinggoufang/-->
</body>
</html>
