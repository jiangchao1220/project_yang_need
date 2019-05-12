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
            loadHouse(loginUser);
        })

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
                            window.location = "user_guanzhu.jsp";
                        } else {
                            alert("您还未登录!");
                        }
                    }, error: function () {
                        alert("ajax error!");
                    }
                });
            }
        }

        function loadHouse(loginUser) {
            if (loginUser == null) {
                alert("您还未登录,无法查看已关注房屋信息!");
                return;
            }
            var username = {
                "username": loginUser,
            };
            $.ajax({
                type: "GET",
                url: "..//house/findConcernHouse.do",
                contentType: "application/json;charset=UTF-8",
                data: username,
                dataType: "JSON",
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].house.type == 1){
                            //租房
                            zufang(data[i]);
                        } else if (data[i].house.type == 2){
                            //新房
                            xinfang(data[i],"xinfang")
                        } else if (data[i].house.type == 3){
                            //二手房
                            xinfang(data[i],"ershoufang")
                        }
                    }

                }, error: function () {
                    alert("ajax error!");
                }
            });
        }

        function deleteConcern(houseNumber) {
            var loginUser = "${loginUser}";
            var concernInfo = {
                "houseNumber": houseNumber,
                "username": loginUser,
            };
            var msg = "取消关注?"
            var result = confirm(msg);
            if (result) {
                $.ajax({
                    type: "GET",
                    url: "..//house/cancelConcern.do",
                    contentType: "application/json;charset=UTF-8",
                    data: concernInfo,
                    dataType: "JSON",
                    success: function (data) {
                        if (data == "deletesuccessed") {
                            window.location = "user_guanzhu.jsp";
                        } else {
                            alert(data);
                        }
                    }, error: function () {
                        alert("ajax error!");
                    }
                });
            }
        }

        function zufang(houseVO) {
            $("#zufanginfo").remove();
            $("#zufang").append(
            "<dl>"
            +"<dt><a href='../house/proinfo.do?houseNumber="+ houseVO.house.houseNumber +"'><img src='" + houseVO.houseImages[0] + "' width='190' height='128'/></a></dt>"
             +"   <dd>"
              +"  <h3><a href='../house/proinfo.do?houseNumber="+ houseVO.house.houseNumber +"'>"+ houseVO.house.houseInfo +"</a></h3>"
              +"  <div class='guantext'>"+ houseVO.house.houseLocation +"</div>"
              +"  <div class='guantext'>"+ houseVO.house.houseType +" | "+  houseVO.house.houseArea +"平米 | "+ houseVO.house.houseTowards +"</div>"
            +"<div class='guantext2'>发布时间："+ houseVO.house.publishDate +" <a href='javascript:;' class='qxgz' onclick='deleteConcern("+ houseVO.house.houseNumber +")'>取消关注</a>"
             +"   </div>"
              +"  </dd>"
              +"  <div class='price'>¥ <strong>"+ houseVO.house.housePrice +"</strong><span class='font12'>元/月</span></div>"
               +" <div class='clearfix'></div>"
              +"  </dl>"
            );
        }

        function xinfang(houseVO,divType) {
            var id = "#" + divType;
            $(id + "info").remove();
            $(id).append(
                "<dl>"
                +"<dt><a href='../house/proinfo.do?houseNumber="+ houseVO.house.houseNumber +"'><img src='" + houseVO.houseImages[0] + "' width='190' height='128'/></a></dt>"
                +"   <dd>"
                +"  <h3><a href='../house/proinfo.do?houseNumber="+ houseVO.house.houseNumber +"'>"+ houseVO.house.houseInfo +"</a></h3>"
                +"  <div class='guantext'>"+ houseVO.house.houseLocation +"</div>"
                +"  <div class='guantext'>"+ houseVO.house.houseType +" | "+  houseVO.house.houseArea +"平米 | "+ houseVO.house.houseTowards +"</div>"
                +"<div class='guantext2'>发布时间："+ houseVO.house.publishDate +" <a href='javascript:;' class='qxgz' onclick='deleteConcern("+ houseVO.house.houseNumber +")'>取消关注</a>"
                +"   </div>"
                +"  </dd>"
                +"  <div class='price'>¥ <strong>"+ houseVO.house.housePrice +"</strong><span class='font12'>万元</span></div>"
                +" <div class='clearfix'></div>"
                +"  </dl>"
            );
        }

        function ershoufang() {

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
                <h3 class="vipTitle">经纪人中心</h3>
                <dl>
                    <dt class="vipIcon3">账户设置</dt>
                    <dd>
                        <a href="broker_user.jsp">我的资料</a>
                        <a href="broker_user_pwd.jsp">账户密码设置</a>
                    </dd>
                    <dt class="vipIcon1">我的邻居大妈</dt>
                    <dd>
                        <a href="broker_user_guanzhu.jsp" class="vipNavCur">关注房源</a>
                        <a href="#">我的发布</a>
                        <a href="#">添加房源</a>
                        <a href="javascript:;" onclick="loginout()">退出登录</a>
                    </dd>
                </dl>
            </div><!--vipNav/-->
        </div><!--vip-left/-->
        <div class="vip-right">
            <h3 class="vipright-title">关注房源</h3>
            <ul class="guanzhueq">
                <li class="guanzhueqcur"><a href="javascript:;">租房</a></li>
                <li><a href="javascript:;">新房</a></li>
                <li><a href="javascript:;">二手房</a></li>
                <div class="clearfix"></div>
            </ul><!--guanzhueq/-->
            <div id="zufang" class="guanzhulist">
                <p id="zufanginfo">您还没有关注的出租房屋......</p>
            </div><!--guanzhulist/-->
            <div id="xinfang" class="guanzhulist">
                <p id="xinfanginfo">您还没有关注的房屋......</p>
            </div><!--guanzhulist/-->
            <div id="ershoufang" class="guanzhulist">
                <p id="ershoufanginfo">您还没有关注的二手房屋......</p>
            </div><!--guanzhulist/-->
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
</body>
</html>
