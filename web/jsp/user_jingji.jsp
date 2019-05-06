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
            $(".nav li:eq(5)").addClass("navCur");
        })
    </script>
</head>

<body>
<div class="header">
    <div class="width1190">
        <div class="fl">您好，欢迎来到邻居大妈！</div>
        <div class="fr">
            <a href="login.jsp">登录</a> |
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
                        <a href="user_pwd.jsp">账户密码设置</a>
                    </dd>
                    <dt class="vipIcon1">我的邻居大妈</dt>
                    <dd>
                        <a href="user_guanzhu.jsp">关注房源</a>
                        <a href="user_shenqing.jsp">申请社区自由经纪人</a>
                        <a href="user_jingji.jsp" class="vipNavCur">社区自由经纪人</a>
                    </dd>
                </dl>
            </div><!--vipNav/-->
        </div><!--vip-left/-->
        <div class="vip-right">
            <h3 class="vipright-title">社区自由经纪人</h3>
            <div class="jingjiren">
                <dl>
                    <dt><img src="images/tx.jpg"/></dt>
                    <dd>
                        <h3>个体 秋枫 <img src="images/phone2.jpg"/> 185221032511</h3>
                        <div class="wuxing"><img src="images/wuxing.jpg" width="104" height="16"/></div>
                        <div class="dizhi">上海市 - 智慧园 - 二手房</div>
                    </dd>
                    <div class="xunzhang"><img src="images/xunzhang.jpg" width="51" height="50"/></div>
                    <div class="clearfix"></div>
                </dl>
                <dl>
                    <dt><img src="images/tx.jpg"/></dt>
                    <dd>
                        <h3>个体 秋枫 <img src="images/phone2.jpg"/> 185221032511</h3>
                        <div class="wuxing"><img src="images/wuxing.jpg" width="104" height="16"/></div>
                        <div class="dizhi">上海市 - 智慧园 - 二手房</div>
                    </dd>
                    <div class="xunzhang"><img src="images/xunzhang.jpg" width="51" height="50"/></div>
                    <div class="clearfix"></div>
                </dl>
                <dl>
                    <dt><img src="images/tx.jpg"/></dt>
                    <dd>
                        <h3>个体 秋枫 <img src="images/phone2.jpg"/> 185221032511</h3>
                        <div class="wuxing"><img src="images/wuxing.jpg" width="104" height="16"/></div>
                        <div class="dizhi">上海市 - 智慧园 - 二手房</div>
                    </dd>
                    <div class="xunzhang"><img src="images/xunzhang.jpg" width="51" height="50"/></div>
                    <div class="clearfix"></div>
                </dl>
                <dl>
                    <dt><img src="images/tx.jpg"/></dt>
                    <dd>
                        <h3>个体 秋枫 <img src="images/phone2.jpg"/> 185221032511</h3>
                        <div class="wuxing"><img src="images/wuxing.jpg" width="104" height="16"/></div>
                        <div class="dizhi">上海市 - 智慧园 - 二手房</div>
                    </dd>
                    <div class="xunzhang"><img src="images/xunzhang.jpg" width="51" height="50"/></div>
                    <div class="clearfix"></div>
                </dl>
                <dl>
                    <dt><img src="images/tx.jpg"/></dt>
                    <dd>
                        <h3>个体 秋枫 <img src="images/phone2.jpg"/> 185221032511</h3>
                        <div class="wuxing"><img src="images/wuxing.jpg" width="104" height="16"/></div>
                        <div class="dizhi">上海市 - 智慧园 - 二手房</div>
                    </dd>
                    <div class="xunzhang"><img src="images/xunzhang.jpg" width="51" height="50"/></div>
                    <div class="clearfix"></div>
                </dl>
                <dl>
                    <dt><img src="images/tx.jpg"/></dt>
                    <dd>
                        <h3>个体 秋枫 <img src="images/phone2.jpg"/> 185221032511</h3>
                        <div class="wuxing"><img src="images/wuxing.jpg" width="104" height="16"/></div>
                        <div class="dizhi">上海市 - 智慧园 - 二手房</div>
                    </dd>
                    <div class="xunzhang"><img src="images/xunzhang.jpg" width="51" height="50"/></div>
                    <div class="clearfix"></div>
                </dl>
                <dl>
                    <dt><img src="images/tx.jpg"/></dt>
                    <dd>
                        <h3>个体 秋枫 <img src="images/phone2.jpg"/> 185221032511</h3>
                        <div class="wuxing"><img src="images/wuxing.jpg" width="104" height="16"/></div>
                        <div class="dizhi">上海市 - 智慧园 - 二手房</div>
                    </dd>
                    <div class="xunzhang"><img src="images/xunzhang.jpg" width="51" height="50"/></div>
                    <div class="clearfix"></div>
                </dl>
            </div><!--jingjiren/-->
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
<div class="copy">Copyright@ 2015 邻居大妈 版权所有 沪ICP备1234567号-0&nbsp;&nbsp;&nbsp;&nbsp;技术支持：<a target="_blank"
                                                                                           href="http://www.webqin.net/">秦王网络</a>
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