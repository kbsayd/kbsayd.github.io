<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <title>用户登录界面</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=1.0,target-densitydpi=low-dpi"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/style.css"/>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/HTmoban/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/HTmoban/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/HTmoban/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/HTmoban/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/HTmoban/js/xadmin.js"></script>
    <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.slim.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <style>
        * {
            margin: 0;
            padding: 0;
        }

        html {
            height: 100%;
        }

        body {
            height: 100%;
        }

        .container {
            height: 100%;
            background-image: linear-gradient(to right, #fbc2eb, #a6c1ee);
        }

        .login-wrapper {
            background-color: #fff;
            width: 358px;
            height: 588px;
            border-radius: 15px;
            padding: 0 50px;
            position: relative;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
        }

        .header {
            font-size: 38px;
            font-weight: bold;
            text-align: center;
            line-height: 200px;
        }

        .input-item {
            display: block;
            width: 100%;
            margin-bottom: 20px;
            border: 0;
            padding: 10px;
            border-bottom: 1px solid rgb(128, 125, 125);
            font-size: 15px;
            outline: none;
        }

        .input-item:placeholder {
            text-transform: uppercase;
        }

        .btn {
            text-align: center;
            padding: 10px;
            width: 100%;
            margin-top: 40px;
            background-image: linear-gradient(to right, #a6c1ee, #fbc2eb);
            color: #fff;
        }

        .msg {
            text-align: center;
            line-height: 88px;
        }

        a {
            text-decoration-line: none;
            color: #abc1ee;
        }
    </style>
</head>

    <div class="container">
        <div class="login-wrapper">
            <div class="header">Login</div>
            <form method="post"  action="${pageContext.request.contextPath}/dl/yz">

                    <span style="color: red;">${msg}</span>
                    <input type="text" name="username" placeholder="username" class="input-item">
                    <input type="password" name="password" placeholder="password" class="input-item">
                    <input type="text" id="imgCode" name="imgCode" placeholder="Verification Code" class="input-item">
                    <input type="hidden" id="imgCodeKey" value="" name="imgCodeKey" placeholder="imgCodeKey" class="input-item">

                    <table cellpadding="0" cellspacing="0" border="0"
                           class="form_table">

                        <img id="randomImage" title="点击更换" οnclick="refreshimg();" src=""/>
                        <a href="javascript:;" onclick="refreshimg()">换一张</a>

                    </table>
<%--                    <div class="btn" onclick="login()">Login</div>--%>
                <div class="checkbox">
                    <label><input type="checkbox"> 记住我</label>
                </div>
                <p>
                    <input type="submit" class="btn btn-primary btn-block mb-1 mt-1" value="登录"/>
                </p>
<%--                <button type="submit" class="btn btn-primary btn-block mb-1 mt-1">登录</button>--%>
                <p class="text-muted text-center" align="center"> <a href="login.html#">
                      <a href="/regist.jsp">注册一个新账号</a>
                </p>

                <div class="msg">
                    Don't have account?
                    <a href="/regist.jsp">Sign up</a>
                </div>

            </form>

        </div>
    </div>
<%--<small>忘记密码了？</small></a>--%>
    <script>
        // window.onload = function(){
        //     $("#catchImg").click(function(){
        //         $("#catchImg").attr("src","/login/captchImg?_"+new Date().getTime());
        //     });
        // }
        <%--function login() {--%>
        <%--    $.ajax({--%>
        <%--        type: "post",--%>
        <%--        dataType: "json",--%>
        <%--        url: "${pageContext.request.contextPath}/dl/yz",--%>
        <%--        data: {},--%>
        <%--        success: function (data) {--%>
        <%--            alert(data.msg);--%>
        <%--        },--%>
        <%--        error: function () {--%>
        <%--            alert("登录失败");--%>
        <%--        }--%>
        <%--    });--%>
        <%--}--%>

        var imgCodeKey = document.getElementById("uuid");
        var imgCode = document.getElementById("code");

        <%--$('#code').blur(function () {--%>
        <%--    $.ajax({--%>
        <%--        type: "get",--%>
        <%--        dataType: "json",--%>
        <%--        url: "${pageContext.request.contextPath}/api/checkImgCode?imgCodeKey=" + imgCodeKey.value + "&imgCode=" + imgCode.value,--%>
        <%--        data: {},--%>
        <%--        // responseType: 'blob',--%>
        <%--        success: function (data) {--%>
        <%--            alert(data.msg);--%>
        <%--            console.log(imgCodeKey.value);--%>
        <%--            console.log(imgCode.value);--%>
        <%--        },--%>
        <%--        error: function () {--%>
        <%--            alert("没有获取返回数据");--%>
        <%--        }--%>
        <%--    });--%>
        <%--})--%>


    </script>


<%--<body class="login-bg">--%>

<%--<div class="login layui-anim layui-anim-up">--%>
<%--    <div class="message">健身房管理系统</div>--%>
<%--    <div id="darkbannerwrap"></div>--%>

<%--    <form method="post" class="layui-form" action="${pageContext.request.contextPath}/dl/yz">--%>
<%--        <span style="color: red;">${msg}</span>--%>
<%--        <input name="username" placeholder="用户名" type="text" lay-verify="required" class="layui-input">--%>
<%--        <hr class="hr15">--%>
<%--        <input name="password" lay-verify="required" placeholder="密码" type="password" class="layui-input">--%>
<%--        <hr class="hr15">--%>


<%--        <div id="wrap">--%>
<%--            <div id="top_content">--%>
<%--                <div id="content">--%>
<%--                    <p>--%>
<%--                        <input type="submit" class="button" value="Submit &raquo;"/>--%>
<%--                    </p>--%>

<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>


<%--        --%>
<%--        &lt;%&ndash; <input class="layui-input" type="checkbox" name="ckbox">记住我&ndash;%&gt;--%>
<%--    </form>--%>


<%--</div>--%>
<!--vue导入-->
<script src="${pageContext.request.contextPath}/static/vue.js"></script>
<!--异步请求导入-->
<script src="${pageContext.request.contextPath}/static/axios.min.js"></script>

<script>
    if (window.top !== window.self) {
        window.top.location = window.location
    }

</script>
<script type="text/javascript">
    $(function () {
        refreshimg();
    })

    function refreshimg() {
        $.ajax({
            type: "get",
            dataType: "json",
            url: "${pageContext.request.contextPath}/api/getImgCode",
            data: {},
            success: function (data) {
                $('#randomImage').attr('src', data.data.data);
                $('#imgCodeKey').attr('value', data.data.imgCodeKey);
            },
            error: function () {
                alert("没有获取返回数据111");
            }
        });
        //页面创建之前进行处理
        //用来在页面创建前，请求获取验证码
        // $(function () {
        //     //获取验证码
        //     this.getSrc();
        // })

    }
</script>



<%--</body>--%>
</html>
