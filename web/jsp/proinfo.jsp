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
        $(function () {
            var loginUser = <%=session.getAttribute("loginUser") %>;
            if (loginUser != null) {
                $("#alogin").append("<a href='<%=basePath%>/user.jsp'>" + loginUser +"</a>");
            } else{
                $("#alogin").append("<a href='<%=basePath%>/login.jsp'>登录</a>");
            }

            // 从session中获取房屋编号houseNumber
            var houseNum = <%=session.getAttribute("houseNumber") %>;
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
                    if(data.house.type == 1){
                        $("#f1_image").append("<img src='<%=basePath%>/" + data.houseImages[0] + "'/>");
                        $("#proTitle").append("出租房信息: "+data.house.houseInfo);

                        var text = "编号：" + data.house.houseNumber
                            + "<br/> 租金：" + data.house.housePrice
                            + "元/月<br/> 户型：" + data.house.houseType
                            + "<br/> 面积：" + data.house.houseArea
                            + "㎡<br/> 朝向：" + data.house.houseTowards
                            + "<br/> 楼层：" + data.house.houseFloor
                            + "<br/> 装修：" + data.house.houseDecorationtype
                            + "<br/> 地址：" + data.house.houseAddress;
                        $("#proText1").append(text);

                        var proList = data.house.houseDetails+"<br/>";
                        for(var i=0;i<data.houseImages.length;i++){
                            proList = proList + "<img src='<%=basePath%>/"+ data.houseImages[i] +"'/>"
                        }
                        $("#proList").append(proList);

                        var proList_img = "";
                        for(var i=0;i<data.houseImages.length;i++){
                            proList_img = proList_img + "<img src='<%=basePath%>/"+ data.houseImages[i] +"'/>"
                        }
                        $("#proList_img").append(proList_img);

                        $("#proList_introduced").append(data.house.introduced);
                    }

                    // 新房信息
                    if(data.house.type == 2){
                        $("#f1_image").append("<img src='<%=basePath%>/" + data.houseImages[0] + "'/>");
                        $("#proTitle").append("新房信息: "+data.house.houseInfo);

                        var text = "编号：" + data.house.houseNumber
                            + "<br/> 售价：" + data.house.housePrice
                            + "万<br/> 户型：" + data.house.houseType
                            + "<br/> 面积：" + data.house.houseArea
                            + "㎡<br/> 朝向：" + data.house.houseTowards
                            + "<br/> 楼层：" + data.house.houseFloor
                            + "<br/> 装修：" + data.house.houseDecorationtype
                            + "<br/> 地址：" + data.house.houseAddress;
                        $("#proText1").append(text);

                        var proList = data.house.houseDetails+"<br/>";
                        for(var i=0;i<data.houseImages.length;i++){
                            proList = proList + "<img src='<%=basePath%>/"+ data.houseImages[i] +"'/>"
                        }
                        $("#proList").append(proList);

                        var proList_img = "";
                        for(var i=0;i<data.houseImages.length;i++){
                            proList_img = proList_img + "<img src='<%=basePath%>/"+ data.houseImages[i] +"'/>"
                        }
                        $("#proList_img").append(proList_img);

                        $("#proList_introduced").append(data.house.introduced);
                    }

                    // 二手房信息
                    if(data.house.type == 3){
                        $("#f1_image").append("<img src='<%=basePath%>/" + data.houseImages[0] + "'/>");
                        $("#proTitle").append("二手房信息: "+data.house.houseInfo);

                        var text = "编号：" + data.house.houseNumber
                            + "<br/> 售价：" + data.house.housePrice
                            + "万<br/> 户型：" + data.house.houseType
                            + "<br/> 面积：" + data.house.houseArea
                            + "㎡<br/> 朝向：" + data.house.houseTowards
                            + "<br/> 楼层：" + data.house.houseFloor
                            + "<br/> 装修：" + data.house.houseDecorationtype
                            + "<br/> 地址：" + data.house.houseAddress;
                        $("#proText1").append(text);

                        var proList = data.house.houseDetails+"<br/>";
                        for(var i=0;i<data.houseImages.length;i++){
                            proList = proList + "<img src='<%=basePath%>/"+ data.houseImages[i] +"'/>"
                        }
                        $("#proList").append(proList);

                        var proList_img = "";
                        for(var i=0;i<data.houseImages.length;i++){
                            proList_img = proList_img + "<img src='<%=basePath%>/"+ data.houseImages[i] +"'/>"
                        }
                        $("#proList_img").append(proList_img);

                        $("#proList_introduced").append(data.house.introduced);
                    }

                }, error: function () {
                    alert("ajax error!");
                }
            });

        })
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
        <h1 class="logo"><a href="<%=basePath%>/index.jsp"><img src="<%=basePath%>/images/logo.png" width="163" height="59"/></a>
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
                <%--编号：312737<br/>
                售价：225万<br/>
                户型：2室 1厅 1卫<br/>
                面积：70.0㎡<br/>
                朝向：南<br/>
                楼层：2层/18层<br/>
                装修：简单装修<br/>
                小区：甘露园南里一区（朝阳 甘露园）1995年--%>
            </div>
            <div class="xun-car">
                <%--<a href="javascript:;" class="xwjg">¥<strong>3600</strong>元</a>--%>
                <a href="javascript:;" class="projrgwc">关注房源</a>
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

            <%--枝江，是王松华仕途的重要一站。担任枝江市委书记期间，王松华起早贪黑，展现出过人的能力。调查人员告诉记者，枝江市能位居湖北省“十强县”之列，王松华立下汗马功劳。以江汉大道的修建为例，当年修建的时候，规划比较保守，唯有王松华力排众议，决定拓宽车道，引来非议一片。然而，几年过去，枝江经济社会快速发展，再回看这条路，人们都认为王松华有眼光，更有甚者，认为该路应该再修宽一些。<br/>
            枝江成就了王松华，正是凭着在枝江任职时期的政绩，王松华被提拔为副厅级干部。但某种程度上说，又是枝江“毁了”王松华，也正是在枝江时期，王松华性格中的负面因素被不断放大，长时间的唯我独尊，让他养成了独断专行、骄傲跋扈、自以为是的作风，这为他日后的严重违纪埋下了伏笔。<br/>
            2006年，王松华迎来了人生中的十字路口。当时，正值市县换届，踌躇满志的他满心以为能“更进一步”，不料却与宜昌市委常委的职务失之交臂。<br/>
            这样的挫折，本是一个契机。如果泰然处之，反躬自省，人生未尝不能有所精进。然而，王松华无法接受这样的结果，他认为组织不公，怨天尤人。即便是2007年初，组织提拔其为宜昌市经济技术开发区管委会主任（副厅级），他依然精神萎靡，公开宣称“不想来这里”。<br/>
            而在这之后，尽管王松华多方“运作”，但又与两次“进步”机会擦肩而过。连续三次受挫，对他打击严重，让他心理彻底失衡，从此一蹶不振。<br/>
            “我当时像疯了一样。”王松华这样形容自己当时的状态。有一次，宜昌市某市领导到开发区视察工作，本应出面接待的他坚决不去，并愤愤不平地说：“我去陪他干嘛？！他的位子本来应该是我的！！”<br/>
            <br/>

            <img src="<%=basePath%>/images/fang1.jpg"/><img src="<%=basePath%>/images/fang2.jpg"/><img
                src="<%=basePath%>/images/fang3.jpg"/><img
                src="<%=basePath%>/images/fang4.jpg"/><img src="<%=basePath%>/images/fang5.jpg"/><img
                src="<%=basePath%>/images/fang6.jpg"/><img
                src="<%=basePath%>/images/fang7.jpg"/><img src="<%=basePath%>/images/fang8.jpg"/>--%>
        </div><!--proList/-->
        <div id="proList_img" class="proList">
            <%--<img src="<%=basePath%>/images/fang1.jpg"/><img src="<%=basePath%>/images/fang2.jpg"/><img
                src="<%=basePath%>/images/fang3.jpg"/><img
                src="<%=basePath%>/images/fang4.jpg"/><img src="<%=basePath%>/images/fang5.jpg"/><img
                src="<%=basePath%>/images/fang6.jpg"/><img
                src="<%=basePath%>/images/fang7.jpg"/>--%>
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
