<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/jsp";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="Author" contect="http://www.webqin.net">
    <title>邻居大妈</title>
    <link rel="shortcut icon" href="<%=basePath%>/images/favicon.ico"/>
    <link type="text/css" href="<%=basePath%>/css/css.css" rel="stylesheet"/>
    <script type="text/javascript" src="<%=basePath%>/js/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/js.js"></script>
    <script type="text/javascript">
        var houseData = {
            "type": 2,
        };
        // 刷新房源信息左右节点
        function a() {
//            var houseData = {
//                "type": 1,
//            };
            $.ajax({
                type: "GET",
                url: "..//house/getAllHouse.do",
                contentType: "application/json;charset=UTF-8",
                data: houseData,
                dataType: "JSON",
                success: function (data) {
                    // 加载所有租房房源信息
                    var str = "";
                    for (var i = 0; i < data.length; i++) {
                        str = str + "<dl>"
                            + "<dt><a href='../house/proinfo.do?houseNumber=" + data[i].house.houseNumber + "'>"
                            + "<img src='" + data[i].houseImages[0] + "' width='286' height='188'/></a></dt>"
                            + "<dd>"
                            + "<h3><a href='../house/proinfo.do?houseNumber=" + data[i].house.houseNumber + "'>" + data[i].house.houseInfo + "</a></h3>"
                            + "<div class='pro-wei'>"
                            + "<img src='images/weizhi.png' width='12' height='16'/> <strong class='red'>" + data[i].house.houseLocation + "</strong>"
                            + "</div>"
                            + "<div class='pro-fang'>" + data[i].house.houseType + "&nbsp;&nbsp;" + data[i].house.houseArea + "平米" + "&nbsp;&nbsp;" + data[i].house.houseFloor + "层" + "</div>"
                            + "<div class='pra-fa'>发布人：" + data[i].house.publisher + " 发布时间：" + data[i].house.publishDate + "</div>"
                            + "</dd>"
                            + "<div class='price'>¥ <strong>" + data[i].house.housePrice + "</strong><span class='font12'>万元</span></div>"
                            + "<div class='clears'></div>"
                            + "</dl>";
                    }
                    console.log(str);
                    $("#pro-left111111").append(str);
                }, error: function () {
                    alert("ajax error!");
                }
            });

            // 加载最近上新
            $.ajax({
                type: "GET",
                url: "..//house/getNewAddHouse.do",
                contentType: "application/json;charset=UTF-8",
                data: houseData,
                dataType: "JSON",
                success: function (data) {
                    // 加载所有租房房源信息
                    var str = "";
                    for (var i = 0; i < data.length; i++) {
                        str = str + "<dl>"
                            + "<dt><a href='../house/proinfo.do?houseNumber=" + data[i].house.houseNumber + "'><img src='" + data[i].houseImages[0] + "'/></a></dt>"
                            + "<dd>"
                            + "<h3><a href='../house/proinfo.do?houseNumber=" + data[i].house.houseNumber + "'>" + data[i].house.houseInfo + "</a></h3>"
                            + "<div class='pro-fang'>" + data[i].house.houseType + "&nbsp;&nbsp;" + data[i].house.houseArea + "平米" + "&nbsp;&nbsp;" + data[i].house.houseFloor + "层" + "</div>"
                            + "<div class='right-price'>" + data[i].house.housePrice + "万元</div>"
                            + "</dd>"
                            + "</dl>";
                    }
                    console.log(str);
                    $("#right-pro").append(str);
                }, error: function () {
                    alert("ajax error!");
                }
            });
        }

        $(function () {
            //导航定位
            $(".nav li:eq(1)").addClass("navCur");
            var loginUser = <%=session.getAttribute("loginUser") %>;
            if (loginUser != null) {
                $("#alogin").append("<a href='user.jsp'>" + loginUser +"</a>");
            } else{
                $("#alogin").append("<a href='login.jsp'>登录</a>");
            }
            // 加载事件
            a();
        })

        function aclick() {

        }

        function click_defort_sort() {
            // 清除节点
            $("#pro-left111111").empty();
            $("#right-pro").empty();
            // 获取筛选信息
//            var area = $.trim($("#houseArea").text());
            //重新加载
            a();
        }

        function click_price() {
            // 清除节点
            $("#pro-left111111").empty();
//         $("#right-pro").empty();
            // 重新加载
            $.ajax({
                type: "GET",
                url: "..//house/houseSortByPrice.do",
                contentType: "application/json;charset=UTF-8",
                data: houseData,
                dataType: "JSON",
                success: function (data) {
                    // 加载所有租房房源信息
                    var str = "";
                    for (var i = 0; i < data.length; i++) {
                        str = str + "<dl>"
                            + "<dt><a href='../house/proinfo.do?houseNumber=" + data[i].house.houseNumber + "'>"
                            + "<img src='" + data[i].houseImages[0] + "' width='286' height='188'/></a></dt>"
                            + "<dd>"
                            + "<h3><a href='../house/proinfo.do?houseNumber=" + data[i].house.houseNumber + "'>" + data[i].house.houseInfo + "</a></h3>"
                            + "<div class='pro-wei'>"
                            + "<img src='images/weizhi.png' width='12' height='16'/> <strong class='red'>" + data[i].house.houseLocation + "</strong>"
                            + "</div>"
                            + "<div class='pro-fang'>" + data[i].house.houseType + "&nbsp;&nbsp;" + data[i].house.houseArea + "平米" + "&nbsp;&nbsp;" + data[i].house.houseFloor + "层" + "</div>"
                            + "<div class='pra-fa'>发布人：" + data[i].house.publisher + " 发布时间：" + data[i].house.publishDate + "</div>"
                            + "</dd>"
                            + "<div class='price'>¥ <strong>" + data[i].house.housePrice + "</strong><span class='font12'>万元</span></div>"
                            + "<div class='clears'></div>"
                            + "</dl>";
                    }
                    console.log(str);
                    $("#pro-left111111").append(str);
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
            <%--<a href="javascript:;" onclick="AddFavorite(window.location,document.title)">加入收藏</a> |
            <a href="javascript:;" onclick="SetHome(this,window.location)">设为首页</a>--%>
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
        <form action="#" method="get" class="pro-search">
            <table>
                <tr>
                    <th>房源区域：</th>
                    <td id="houseLocation">
                        <a onclick="aclick()" class="pro-cur">不限</a>
                        <a onclick="aclick()">武侯区</a>
                        <a onclick="aclick()">金牛区</a>
                        <a onclick="aclick()">青羊区</a>
                        <a onclick="aclick()">郫都区</a>
                        <a onclick="aclick()">其它</a>
                    </td>
                </tr>
                <tr>
                    <th>租金：</th>
                    <td id="housePrice">
                        <a onclick="aclick_price()" class="pro-cur">不限</a>
                        <a onclick="aclick_price()">1000以下</a>
                        <a onclick="aclick_price()">1001-2000</a>
                        <a onclick="aclick_price()">2001-3000</a>
                        <a onclick="aclick_price()">3001-4000</a>
                        <a onclick="aclick_price()">4000以上</a>
                        <%--<input type="text" class="protext"/> - <input type="text" class="protext"/> 元--%>
                        <%--<input type="submit" class="proSub" value="确定"/>--%>
                    </td>
                </tr>
                <tr>
                    <th>面积：</th>
                    <td id="houseArea">
                        <a onclick="aclick_area()" class="pro-cur">不限</a>
                        <a onclick="aclick_area()">20平方以下</a>
                        <a onclick="aclick_area()">20-40平方</a>
                        <a onclick="aclick_area()">41-60平方</a>
                        <a onclick="aclick_area()">61-80平方</a>
                        <a onclick="aclick_area()">100平方以上</a>
                    </td>
                </tr>
            </table>
            <div class="paixu">
                <strong>排序：</strong>
                <a onclick="click_defort_sort()" class="pai-cur">默认</a><!--时间顺序排序-->
                <a onclick="click_price()">价格 &or;</a>
                <%--<a href="javascript:;">最新 &or;</a>--%>
            </div>
        </form><!--pro-search/-->
    </div><!--width1190/-->
    <div class="width1190">
        <div id="pro-left111111" class="pro-left">

        </div><!--pro-left/-->
        <div class="pro-right">
            <h2 class="right-title">最近一周新上房源</h2>
            <div id="right-pro" class="right-pro">

            </div><!--right-pro/-->
        </div><!--pro-right/-->
        <div class="clears"></div>
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
