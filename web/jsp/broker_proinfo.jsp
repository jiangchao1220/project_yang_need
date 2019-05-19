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
        <%--var loginUser = "${loginUser}";--%>
        var loginUser = "${loginUser}";
        // 从session中获取房屋编号houseNumber
        var houseNum = <%=session.getAttribute("brokerDetailHouseNumber") %>;
        $(function () {
            if (loginUser != "") {
                $("#alogin").append("<a href='<%=basePath%>/user.jsp'>" + loginUser + "</a>");
            } else {
                $("#alogin").append("<a href='<%=basePath%>/login.jsp'>登录</a>");
            }

            if (houseNum == "") {
                alert("未获取到房屋信息!")
                window.location = "<%=basePath%>/index.jsp";
                return;
            }
            var houseData = {
                "houseNumber": houseNum,
            };
            // 通过房屋编号查询房屋详情
            $.ajax({
                type: "GET",
                url: "..//house/detail.do",
                contentType: "application/json;charset=UTF-8",
                data: houseData,
                dataType: "JSON",
                success: function (data) {
                    // 租房信息
                    if (data.house.type == 1) {
                        $("#f1_image").append("<img src='<%=basePath%>/" + data.houseImages[0] + "' width='286' height='188'/>");
                        $("#proTitle").append("出租房信息: " + data.house.houseInfo);

                        var text = "编号：" + data.house.houseNumber
                            + "<br/> 租金：" + data.house.housePrice
                            + "元/月<br/> 户型：" + data.house.houseType
                            + "<br/> 面积：" + data.house.houseArea
                            + "㎡<br/> 朝向：" + data.house.houseTowards
                            + "<br/> 楼层：" + data.house.houseFloor
                            + "<br/> 装修：" + data.house.houseDecorationtype
                            + "<br/> 地址：" + data.house.houseAddress
                            + "<br/> <span style='color:red'>发布人信息：" + data.house.publisher +" 电话:" + data.house.publisherPhone + "</span>";
                        $("#proText1").append(text);

                        var proList = data.house.houseDetails + "<br/>";
                        for (var i = 0; i < data.houseImages.length; i++) {
                            proList = proList + "<img src='<%=basePath%>/" + data.houseImages[i] + "' width='286' height='188'/>"
                        }
                        $("#proList").append(proList);

                        var proList_img = "";
                        for (var i = 0; i < data.houseImages.length; i++) {
                            proList_img = proList_img + "<img src='<%=basePath%>/" + data.houseImages[i] + "' width='286' height='188'/>"
                        }
                        $("#proList_img").append(proList_img);

                        $("#proList_introduced").append(data.house.introduced);
                    }

                    // 新房信息
                    if (data.house.type == 2) {
                        $("#f1_image").append("<img src='<%=basePath%>/" + data.houseImages[0] + "' width='286' height='188'/>");
                        $("#proTitle").append("新房信息: " + data.house.houseInfo);

                        var text = "编号：" + data.house.houseNumber
                            + "<br/> 售价：" + data.house.housePrice
                            + "万<br/> 户型：" + data.house.houseType
                            + "<br/> 面积：" + data.house.houseArea
                            + "㎡<br/> 朝向：" + data.house.houseTowards
                            + "<br/> 楼层：" + data.house.houseFloor
                            + "<br/> 装修：" + data.house.houseDecorationtype
                            + "<br/> 地址：" + data.house.houseAddress
                            + "<br/> <span style='color:red'>发布人信息：" + data.house.publisher +" 电话:" + data.house.publisherPhone +"</span>";
                        $("#proText1").append(text);

                        var proList = data.house.houseDetails + "<br/>";
                        for (var i = 0; i < data.houseImages.length; i++) {
                            proList = proList + "<img src='<%=basePath%>/" + data.houseImages[i] + "' width='286' height='188'/>"
                        }
                        $("#proList").append(proList);

                        var proList_img = "";
                        for (var i = 0; i < data.houseImages.length; i++) {
                            proList_img = proList_img + "<img src='<%=basePath%>/" + data.houseImages[i] + "' width='286' height='188'/>"
                        }
                        $("#proList_img").append(proList_img);

                        $("#proList_introduced").append(data.house.introduced);
                    }

                    // 二手房信息
                    if (data.house.type == 3) {
                        $("#f1_image").append("<img src='<%=basePath%>/" + data.houseImages[0] + "' width='286' height='188'/>");
                        $("#proTitle").append("二手房信息: " + data.house.houseInfo);

                        var text = "编号：" + data.house.houseNumber
                            + "<br/> 售价：" + data.house.housePrice
                            + "万<br/> 户型：" + data.house.houseType
                            + "<br/> 面积：" + data.house.houseArea
                            + "㎡<br/> 朝向：" + data.house.houseTowards
                            + "<br/> 楼层：" + data.house.houseFloor
                            + "<br/> 装修：" + data.house.houseDecorationtype
                            + "<br/> 地址：" + data.house.houseAddress
                            + "<br/> <span style='color:red'>发布人信息：" + data.house.publisher +" 电话:" + data.house.publisherPhone + "</span> ";
                        $("#proText1").append(text);

                        var proList = data.house.houseDetails + "<br/>";
                        for (var i = 0; i < data.houseImages.length; i++) {
                            proList = proList + "<img src='<%=basePath%>/" + data.houseImages[i] + "' width='286' height='188'/>"
                        }
                        $("#proList").append(proList);

                        var proList_img = "";
                        for (var i = 0; i < data.houseImages.length; i++) {
                            proList_img = proList_img + "<img src='<%=basePath%>/" + data.houseImages[i] + "' width='286' height='188'/>"
                        }
                        $("#proList_img").append(proList_img);

                        $("#proList_introduced").append(data.house.introduced);
                    }

                }, error: function () {
                    alert("ajax error!");
                }
            });
        })

        function edit() {
            alert("TODO修改房屋:" + houseNum);
        }

        function deleteHouse() {
            alert("TODO删除房屋:" + houseNum);
        }
    </script>
</head>

<body>
<div class="header">
    <div class="width1190">
        <div class="fl">您好，欢迎来到邻居大妈！</div>
        <div class="fr">
            <a id="alogin"></a>
            <%--<a href="<%=basePath%>/login.jsp">登录</a>--%> |
            <a href="<%=basePath%>/reg.jsp">注册</a> |
            <a href="javascript:;" onclick="AddFavorite(window.location,document.title)">加入收藏</a> |
            <a href="javascript:;" onclick="SetHome(this,window.location)">设为首页</a>
        </div>
        <div class="clears"></div>
    </div><!--width1190/-->
</div><!--header/-->
<div class="logo-phone">
    <div class="width1190">
        <h1 class="logo"><a href="<%=basePath%>/index.jsp"><img src="<%=basePath%>/images/logo.png" width="163"
                                                                height="59"/></a>
        </h1>
        <div class="phones"><strong>021-63179891</strong></div>
        <div class="clears"></div>
    </div><!--width1190/-->
</div><!--logo-phone/-->
<div class="content">
    <div class="width1190" style="width:1000px;">
        <div id="f1_image" class="proImg fl">
            <%--<img src="<%=basePath%>/images/fangt1.jpg"/>--%>
        </div><!--proImg/-->
        <div class="proText fr">
            <h3 id="proTitle" class="proTitle"></h3>
            <div id="proText1" class="proText1">
            </div>
            <div class="xun-car">
                <a href="javascript:;" class="projrgwc" id="edit" onclick="edit()">修改房源</a>
                <a href="javascript:;" class="projrgwc" id="delete" onclick="deleteHouse()">删除房源</a>
            </div><!--xun-car/-->
        </div><!--proText/-->
        <div class="clears"></div>
    </div><!--width1190/-->
    <div id="proBox" class="proBox" style="width:1000px;margin:10px auto;">
        <div class="proEq">
            <ul class="fl">
                <li class="proEqCur">房源详情</li>
                <li>房源图片</li>
                <li>小区介绍</li>
            </ul>
            <div class="lxkf fr"><a href="http://wpa.qq.com/msgrd?v=3&uin=1072631488&site=qq&menu=yes"
                                    target="_blank"></a></div>
            <div class="clears"></div>
        </div><!--proEq/-->
        <div id="proList" class="proList">

        </div><!--proList/-->
        <div id="proList_img" class="proList">

        </div><!--proList/-->
        <div id="proList_introduced" class="proList">
            <%--暂无信息...--%>
        </div><!--proList/-->
    </div><!--proBox/-->
</div><!--content/-->

<div class="footer">
    <div class="width1190">
        <div class="fl"><a href="<%=basePath%>/index.jsp"><strong>邻居大妈</strong></a><a href="<%=basePath%>/about.html">关于我们</a><a
                href="<%=basePath%>/contact.html">联系我们</a><a href="<%=basePath%>/user.jsp">个人中心</a></div>
        <div class="fr">
            <dl>
                <dt><img src="<%=basePath%>/images/erweima.png" width="76" height="76"/></dt>
                <dd>微信扫一扫<br/>房价点评，精彩发布</dd>
            </dl>
            <dl>
                <dt><img src="<%=basePath%>/images/erweima.png" width="76" height="76"/></dt>
                <dd>微信扫一扫<br/>房价点评，精彩发布</dd>
            </dl>
            <div class="clears"></div>
        </div>
        <div class="clears"></div>
        i
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
