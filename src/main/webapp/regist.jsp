<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <title>注册界面</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
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

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
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

        .input-item::placeholder {
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

        #code {
            margin-top: 6%;
            border-style: solid;
            border-width: 1px;
            background-color: #fff;
            line-height: 1.3
        }

        span {
            color: #fff;
        }
    </style>
</head>


<div class="container">
    <div class="login-wrapper">
        <div class="header">Register</div>
        <form method="post" action="${pageContext.request.contextPath}/register">

            <span style="color: red;">${msg}</span>
            <div class="row">
                <label>账号: </label><input id="userId" class="layui-input" name="userId">
            </div>
            <div class="row">
                <label>密码:</label><input id="password" class="layui-input" name="password">
            </div>
            <div class="row">
                <label>手机号:</label><input id="mobile" class="layui-input" name="mobile">
            </div>
            <div class="row">
                <label>验证码:</label>
                <%--                <input class="layui-form" name="verifyCode">--%>
                <span> <input id="code" style="color:#999;padding:7px;margin-right:19px;width:210px;"
                              name="code"
                              type="text" value="请输入验证码"
                              onfocus="if(this.value='请输入验证码'){this.value=''}"
                              onblur="if(this.value==''){this.value='请输入验证码'}"></span>
                <span> <input type="button" class="sendVerifyCode" value="获取验证码" onclick="add($(this))"/></span>
            </div>

            <button onclick="insert()" id="reg_btn" class="sui-btn btn-block btn-xlarge btn-danger reg-btn" href="javascript:;">完成注册</button>
<%--            <div>--%>
<%--                <button type="button" class="sub-btn">提交</button>--%>
<%--            </div>--%>

            <%--            <input type="text" name="username" placeholder="username" class="input-item">--%>
            <%--            <input type="password" name="password" placeholder="password" class="input-item">--%>
            <%--            <input type="text" id="number" name="number" placeholder="number" class="input-item">--%>
            <%--            <input type="hidden" id="imgCodeKey" value="" name="imgCodeKey" placeholder="imgCodeKey" class="input-item">--%>


            <table cellpadding="0" cellspacing="0" border="0"
                   class="form_table">


            </table>
            <%--                    <div class="btn" onclick="login()">Login</div>--%>


            <%--                <button type="submit" class="btn btn-primary btn-block mb-1 mt-1">登录</button>--%>


<%--            <div class="msg">--%>
<%--                Don't have account?--%>
<%--                <a href="#">Sign up</a>--%>
<%--            </div>--%>

        </form>

    </div>
</div>

<script>


    //短信验证码发送
    function add(onself) {
        //手机号
        var mobile = $("#mobile").val();

        console.log(mobile);
        if (mobile == '' || mobile.length != 11) {
            alert('手机号码参数错误');
            $("#mobile").next().text('手机号码参数错误');
            return false;
        } else {
            $("#mobile").next().text('');
        }

        var code=$("#code").val();


        $.ajax({
            url: "${pageContext.request.contextPath}/sendSms",
            dataType: "json",
            type: "post",
            contentType: "application/json",
            data: {
                mobile:mobile,
                type:0,
                template_id:"ST_2022051100000001",
                sign:"健身房管理系统",
            },
            success: function (res) {
                console.log(res);
            }
        })
        //计时器
        var count = 60;
        var countdown = setInterval(Countdown, 1000);

        function Countdown() {
            onself.attr("disabled", true);
            onself.text(count + "s后重试!");
            if (count == 0) {
                onself.text("发送验证码").removeAttr("disabled");
                clearInterval(countdown);
            }
            count--;
        }
    }

    //注册
    function insert() {
//找对象并验证
        //手机号码
        var mobile = $("#mobile").val();
        var userId = $("#userId").val();
        if (mobile == '') {
            $("#mobile").next().text('手机号为空');
            return false;
        } else {
            $("#mobile").next().text('');
        }
        //验证码
        var code = $("#code").val();
        if (code == '') {
            $(".error").eq(1).text('验证码为空');
            return false;
        } else {
            $(".error").eq(1).text('');
        }
        //登录密码
        var password = $("#password").val();
        if (password == '') {
            $("#password").next().text('登录密码为空');
            return false;
        } else {
            $("#password").next().text('');
        }
        //确认密码
        var repassword = $("#repassword").val();
        if (repassword == '') {
            $("#repassword").next().text('确认密码为空');
            return false;
        } else if (repassword != password) {
            $("#repassword").next().text('与登录密码不符');
            return false;
        } else {
            $("#repassword").next().text('');
        }

        //ajax提交
        $.ajax({
            url: "${pageContext.request.contextPath}/register",
            dataType: "json",
            type: 'post',
            contentType: "application/json",
            data: {
                userId:userId,
                mobile: mobile,
                code: code,
                password: password,
                // repassword: repassword,
            },
            success: function (res) {
                if (res.code == 200) {
                    alert('注册成功!');
                    return true;
                } else {
                    alert('注册失败!');
                    return false;
                }
            }
        })
    }
    /*
 * 短信验证码
 * */
//     if(!function_exists("code")){
//         function code(mobile,$code){
//             $statusStr = array(
//                 "0" => "短信发送成功",
//             "10001" => "开发者数据错误",
//             "10002" => "参数格式错误或缺少参数",
//             "10003" => "短信类型错误",
//             "10004" => "短信签名错误或缺少签名",
//             "10005" => "模板错误或模板类型错误",
//             "10006" => "短信条数不足"
//         );
//             $smsapi = "http://api.shansuma.com/gateway.do/";
//             $user = "******"; //短信平台帐号
//             $pass = '*********'; //短信平台密码
//             $content="【未来科技】您的验证码为 {$code}，5分钟内有效。若非本人操作，请忽略此消息。";//要发送的短信内容
//             moible = moible;//要发送短信的手机号码
//             $sendurl = $smsapi."sms?u=".$user."&p=".$pass."&m=".moible."&c=".urlencode($content);
//             // #使用curl 返回
// //        $result =file_get_contents($sendurl) ;
//             $resutl=curl($sendurl);
//             return $statusStr[$resutl];
//         }
//     }




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
