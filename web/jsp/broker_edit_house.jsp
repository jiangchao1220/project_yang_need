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
        var loginUser = "${loginUser}";
        var isBorker = "${isBorker}";
        $(function () {
            if (loginUser == "") {
                alert("请登录!");
                window.location = "<%=basePath%>/login.jsp";
                return;
            }
            if (isBorker != "borker") {
                alert("您无权修改房屋!");
                window.location = "<%=basePath%>/index.jsp";
                return;
            }
            $("#alogin").append("<a href='<%=basePath%>/user.jsp'>" + loginUser + "</a>");
            $("#my_account").append(loginUser);
            loadPageInfo();
        })

        function loadPageInfo() {
            var hoouseNumber = "${brokerDetailHouseNumber}";
            if (hoouseNumber == "") {
                alert("未获取到房屋信息!")
                window.location = "<%=basePath%>/broker_user.jsp";
                return;
            }
            var houseData = {
                "houseNumber": hoouseNumber,
            };
            // 通过房屋编号查询房屋详情
            $.ajax({
                type: "GET",
                url: "..//house/detail.do",
                contentType: "application/json;charset=UTF-8",
                data: houseData,
                dataType: "JSON",
                success: function (data) {
                    loadImages(data);
                    loadHouseInfo(data);
                }, error: function () {
                    alert("ajax error!");
                }
            });
        }

        function loadHouseInfo(data) {
            var type = data.house.type;
            $('#type').val(type);
            if (type == "2" || type == "3") {
                $('#price_type').text("万元");
            }
            $('#house_number').append(data.house.houseNumber);
            $('#house_info').val(data.house.houseInfo);
            $("#house_price").val(data.house.housePrice);
            $("#house_area").val(data.house.houseArea);
            $("#house_towards").val(data.house.houseTowards);
            $("#house_floor").val(data.house.houseFloor);
            $("#house_type").val(data.house.houseType);
            $("#house_decorationtype").val(data.house.houseDecorationtype);
            $("#house_address").val(data.house.houseAddress);
            $("#house_details").val(data.house.houseDetails);
            $("#introduced").val(data.house.introduced);
            $("#location").val(data.house.houseLocation);
        }

        function loadImages(data) {
            var images = "";
            for (var i = 0; i < data.houseImages.length; i++) {
                images = images + "<div>"
                    + "<img name='existsImg' src='<%=basePath%>/" + data.houseImages[i] + "' width='100' height='100'/>"
                    + "<div class='sctx'>"
                    + "<input type='button'/> <a href='javascript:;' " +
                    "onclick='delete_img(this)' name='"+ data.houseImages[i] +"'>删除图片</a>"
                    +"</div>"
                    + "</div>"
            }
            $("#houseImages").append(images);
        }

        function delete_img(obj) {
            var houseNumber = "${brokerDetailHouseNumber}";
            var imageName = {
                "imageName": obj.name,
                "houseNumber":houseNumber,
            };
            var msg = "是否删除图片?"
            var result = confirm(msg);
            if (result) {
                $.ajax({
                    type: "GET",
                    url: "..//house/deleteImage.do",
                    contentType: "application/json;charset=UTF-8",
                    data: imageName,
                    dataType: "JSON",
                    success: function (data) {
                        if (data == "success") {
                            var father = obj.parentNode.parentNode;
                            father.remove();
                        } else {
                            alert("删除失败,请刷新页面重试.");
                        }
                    }, error: function () {
                        alert("ajax error!");
                    }
                });
            }
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

        function select_house_type(type) {
            switch (type) {
                case "1":
                    $('#price_type').text("元/月");
                    break;
                case "2":
                case "3":
                    $('#price_type').text("万元");
                    break;
            }
        }

        function checkInput(house) {
            for (var item in house) {
                //校验是否有没有输入的参数以及是否有全部为空的输入
                if (item != null && Trim(house[item], "g") == "") {
                    return true;
                }
            }
            return false;
        }

        /*去除空格*/
        function Trim(str, is_global) {
            var result;
            result = str.replace(/(^\s+)|(\s+$)/g, "");
            if (is_global.toLowerCase() == "g") {
                result = result.replace(/\s/g, "");
            }
            return result;
        }

        function add_house() {
            var type = $('#type').val();
            var house_info = $('#house_info').val();
            var house_price = $("#house_price").val();
            var house_area = $("#house_area").val();
            var house_towards = $("#house_towards").val();
            var house_floor = $("#house_floor").val();
            var house_type = $("#house_type").val();
            var house_decorationtype = $("#house_decorationtype").val();
            var house_address = $("#house_address").val();
            var house_details = $("#house_details").val();
            var introduced = $("#introduced").val();
            var location = $("#location").val();

            var house = {
                "type": type,
                "houseNumber": "${brokerDetailHouseNumber}",
                "houseInfo": house_info,
                "housePrice": house_price,
                "houseArea": house_area,
                "houseTowards": house_towards,
                "houseFloor": house_floor,
                "houseType": house_type,
                "houseDecorationtype": house_decorationtype,
                "houseAddress": house_address,
                "houseDetails": house_details,
                "introduced": introduced,
                "houseLocation": location,
            };
            if (checkInput(house)) {
                //不输入完整信息,后台接受不到,会报400错误
                alert("请输入完整房屋信息");
                return;
            }
            var formdata = getFile();
            if (!checkFile(formdata)) {
                alert("请上传房屋图片");
                return;
            }

            if (formdata.get("images") == null) {
                //只上传房屋信息
                updateHouse(house);
            } else {
                //先上传图片再上传房屋信息
                uploadImgAndInfo(formdata, house);
            }


        }

        function uploadImgAndInfo(formdata, house) {
            $.ajax({
                type: "POST",
                url: "..//house/updateHouseByFromData.do",
                cache: false,
                data: formdata,
                dataType:"JSON",
                processData: false,
                contentType: false,
                success: function (data) {
                    if (data == "fail") {
                        alert("添加失败,请稍后重试!");
                    } else if (data == "success") {
                        //添加house信息
                        updateHouse(house);
                    }
                }, error: function () {
                    alert("ajax error!");
                }
            });
        }

        function updateHouse(house) {
            $.ajax({
                type: "POST",
                url: "..//house/updateHouse.do",
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                data: house,
                dataType: "JSON",
                success: function (data) {
                    if (data == "success") {
                        alert("更新成功!");
                        window.location = "..//house/brokerProinfo.do?houseNumber=" + house.houseNumber;
                    } else {
                        //TODO 删除已上传的图片
//                        deleteUploadImg(datastate);
                        alert("未知错误, 请稍后重试!");
                    }
                }, error: function () {
                    alert("ajax error!");
                }
            });
        }

        function getFile() {
            var formData = new FormData();
            var fileInput = document.getElementsByName("file_input");
            for (var i = 0; i < fileInput.length; i++) {
                var inputId = fileInput[i].id;
                var img_input = document.getElementById(inputId);
                var img_file = img_input.files[0];
                console.log(img_file);
                formData.append("images", img_file);
            }
            return formData;
        }

        function checkFile(formdata) {
            //检查是否已经存在图片
            var existscount = document.getElementsByName("existsImg").length;
            if (existscount != 0) {
                return true;
            }

            //校验是否有图片上传
            if (formdata.get("images") == "undefined") {
                return false;
            } else {
                return true;
            }
        }

        function add_img_div() {
            var existscount = document.getElementsByName("existsImg").length;
            var count = document.getElementsByName("file_input").length + existscount;
            var newcount = count + 1;
            if (count == 5) {
                $("#msg").empty();
                $("#msg").append("最多上传5张图片");
                return;
            }
            console.log("个数:" + count);
            $(".vip-touxiang").append(
                "<dt><img src='images/tx.jpg' id='img" + newcount + "' width='100' height='100'/></dt>"
                + "<dd>"
                + "<h3><strong>点击选择文件上传房屋图片</strong></h3>"
                + "<div class='sctx'><input type='file' id='file" + newcount + "' name='file_input' onclick='show(this)'/><a href='javascript:;'>上传</a></div>"
                + "  <p>图片格式：GIF、JPG、JPEG、PNG</p>"
                + "</dd>"
                + "<div class='clearfix'></div>");
        }

        function show(obj) {
            var num = obj.id.replace(/[a-zA-Z]/g, "");
            console.log("这是第" + num + "个图片div")
            var fileTag = document.getElementById('file' + num);
            fileTag.onchange = function () {
                var file = fileTag.files[0];
                var fileReader = new FileReader();
                fileReader.onloadend = function () {
                    if (fileReader.readyState == fileReader.DONE) {
                        document.getElementById('img' + num).setAttribute('src', fileReader.result);
                    }
                };
                fileReader.readAsDataURL(file);
            };
        };
    </script>
</head>
<body>
<div class="header">
    <div class="width1190">
        <div class="fl">您好，欢迎来到邻居大妈！</div>
        <div class="fr">
            <a id="alogin"></a> |
            <a href="<%=basePath%>/reg.jsp">注册</a> |
            <a href="javascript:;" onclick="AddFavorite(window.location,document.title)">加入收藏</a> |
            <a href="javascript:;" onclick="SetHome(this,window.location)">设为首页</a>
        </div>
        <div class="clears"></div>
    </div>
</div>
<div class="logo-phone">
    <div class="width1190">
        <h1 class="logo"><a href="<%=basePath%>/index.jsp">
            <img src="<%=basePath%>/images/logo.png" width="163" height="59"/></a>
        </h1>
        <div class="phones"><strong>021-63179891</strong></div>
        <div class="clears"></div>
    </div>
</div>
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
                        <a href="broker_user_guanzhu.jsp">关注房源</a>
                        <a href="broker_fabu.jsp">我的发布</a>
                        <a href="broker_add_house.jsp" class="vipNavCur">修改房源</a>
                        <a href="javascript:;" onclick="loginout()">退出登录</a>
                    </dd>
                </dl>
            </div>
        </div>
        <div class="vip-right">
            <h2 class="vipright-title">房屋信息修改</h2>
            <!-- 展示房屋图片 -->
            <div id="houseImages" class="houseImages">

            </div>
            <hr style="height:1px;border:none;border-top:1px dashed #0066CC;" />
            <form action="#" id="form11" method="get" enctype="multipart/form-data">
                <dl class="vip-touxiang">
                </dl><!--vip-touxiang/-->
                <span class="red" id="msg"></span>
                <div class="sctx" name="add_images">
                    <input type="button"/>
                    <a href="javascript:;" onclick="add_img_div()">添加图片</a>
                </div>
            </form>
            <table class="grinfo">
                <tbody>
                <tr>
                    <th>我的账号：</th>
                    <td><strong id="my_account"></strong>
                    </td>
                </tr>
                <tr>
                    <th>房屋编号：</th>
                    <td><strong id="house_number"></strong>
                    </td>
                </tr>
                <tr>
                    <th><span class="red">*</span> 选择房源类型：</th>
                    <td>
                        <div id="type1">
                            <select id="type" onchange="select_house_type($('#type').val());">
                                <option value="1">租房</option>
                                <option value="2">新房</option>
                                <option value="3">二手房</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><span class="red">*</span> 简略描述：</th>
                    <td>
                        <input class="inp inw" type="text" id="house_info" value="" maxlength="32">
                    </td>
                </tr>
                <tr>
                    <th><span class="red">*</span> 房屋价格：</th>
                    <td>
                        <input class="inp inw" type="text" id="house_price" value="" maxlength="9"
                               onkeyup="this.value=this.value.replace(/[^\d]/g,'')">
                        <span class="red" id="price_type">元/月</span>
                    </td>
                </tr>
                <tr>
                    <th><span class="red">*</span> 房屋面积：</th>
                    <td>
                        <input class="inp inw" type="text" id="house_area" value="" maxlength="4"
                               onkeyup="this.value=this.value.replace(/[^\d]/g,'')">
                        <span class="block">平方米</span>
                    </td>
                </tr>
                <tr>
                    <th><span class="red">*</span>房屋朝向：</th>
                    <td>
                        <input class="inp inw" type="text" id="house_towards" value placeholder="南北" maxlength="9">
                    </td>
                </tr>
                <tr>
                    <th><span class="red">*</span> 房屋楼层：</th>
                    <td>
                        <input class="inp inw" type="text" id="house_floor" value="" maxlength="3"
                               onkeyup="this.value=this.value.replace(/[^\d]/g,'')">
                        <span class="block">层</span>
                    </td>
                </tr>
                <tr>
                    <th><span class="red">*</span> 房屋类型：</th>
                    <td>
                        <input class="inp inw" type="text" id="house_type" value="">
                        <br>
                        <span class="fgrey">(类型:标准,2室 1厅 1卫)</span>
                    </td>
                </tr>
                <tr>
                    <th><span class="red">*</span> 装修类型：</th>
                    <td>
                        <div>
                            <select id="house_decorationtype">
                                <option value="简单装修">简单装修</option>
                                <option value="精装修">精装修</option>
                                <option value="无">无</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><span class="red">*</span>房屋所在区域：</th>
                    <td>
                        <div>
                            <select id="location">
                                <option value="武侯区">武侯区</option>
                                <option value="金牛区">金牛区</option>
                                <option value="青羊区">青羊区</option>
                                <option value="成华区">成华区</option>
                                <option value="高新区">高新区</option>
                                <option value="锦江区">锦江区</option>
                                <option value="郫都区">郫都区</option>
                                <option value="双流区">双流区</option>
                                <option value="高新西区">高新西区</option>
                                <option value="简阳市">简阳市</option>
                                <option value="龙泉驿区">龙泉驿区</option>
                                <option value="新都区">新都区</option>
                                <option value="温江区">温江区</option>
                                <option value="都江堰市">都江堰市</option>
                                <option value="彭州市">彭州市</option>
                                <option value="青白江区">青白江区</option>
                                <option value="崇州市">崇州市</option>
                                <option value="金堂县">金堂县</option>
                                <option value="新津县">新津县</option>
                                <option value="其他地区">其他地区</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th valign="top"><span class="red">*</span>房屋地址：</th>
                    <td>
                        <textarea id="house_address" class="grtextarea"></textarea>
                        <br>
                        <span class="fgrey">(请输入准备地址)</span>
                    </td>
                </tr>
                <tr>
                    <th valign="top"><span class="red">*</span>详情描述：</th>
                    <td>
                        <textarea id="house_details" class="grtextarea"></textarea>
                        <br>
                        <span class="fgrey">(请输入房屋介绍信息)</span>
                    </td>
                </tr>
                <tr>
                    <th valign="top"><span class="red">*</span>小区介绍：</th>
                    <td>
                        <textarea id="introduced" class="grtextarea"></textarea>
                        <br>
                        <span class="fgrey">(请输入房屋介绍信息)</span>
                    </td>
                </tr>
                <tr>
                    <th>&nbsp;</th>
                    <td colspan="2">
                        <label class="butt" id="butt">
                            <div class="member_mod_buttom" onclick="add_house()">确认添加</div>
                        </label>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="clearfix"></div>
    </div>
</div>
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
    </div><!--width1190/-->
</div><!--footer/-->
<div class="copy">Copyright@ 2015 邻居大妈 版权所有 沪ICP备1234567号-0&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div class="bg100"></div>
</body>
</html>
