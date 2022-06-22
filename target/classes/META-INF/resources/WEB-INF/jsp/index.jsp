<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>健身房管理系统</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="shortcut icon" href="/favicon.ico"/>
    <link rel="bookmark" href="/favicon.ico" type="image/x-icon"/>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/HTmoban/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/HTmoban/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/HTmoban/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/HTmoban/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/HTmoban/js/xadmin.js"></script>

</head>
<script type="text/css">
    /*.show{ hidden:hidden;}*/
</script>
<script>

//判断角色
        $(document).ready(function () {
            // debugger
            judgeAuthority();
        });

        function judgeAuthority() {
            $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/session",
                    contentType: 'application/json;charset=utf-8',
                    success: function (data) {
                        for (var i = 0; i < data.length; i++) {
                            if (data[i] != "admin") {
                                $(".show").css("display","none");}

                        }
                    }
                })
        }


</script>
<body>
<%--<shiro:hasPermission name="admin"></shiro:hasPermission>--%>
<!-- 顶部开始 -->
<div class="container">
    <div class="logo"><a>健身房管理系统</a></div>
    <div class="left_open">
        <i title="展开左侧栏" class="iconfont">&#xe699;</i>
    </div>
    <ul class="layui-nav left fast-add" lay-filter="">

    </ul>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item">
            <a href="javascript:;">欢迎您,${user.adminName}</a>
            <dl class="layui-nav-child"> <!-- 二级菜单 -->
                <dd>
                    <a onclick="x_admin_show('修改密码','${pageContext.request.contextPath}/updPassword','800','600')">修改密码</a>
                </dd>
                <dd><a href="${pageContext.request.contextPath}/logout">退出</a></dd>
            </dl>
        </li>
    </ul>

</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
    <div id="side-nav">
        <ul id="nav">
            <li class="show">
                <a href="javascript:;">
                    <i class="iconfont">&#xe6b8;</i>
                    <cite>员工管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="${pageContext.request.contextPath}/staff/jin3">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>员工列表</cite>

                        </a>
                    </li>

                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe6b8;</i>
                    <cite>会员管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="${pageContext.request.contextPath}/menber/jin">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>会员列表</cite>

                        </a>
                    </li>
                    <li>
                        <a _href="${pageContext.request.contextPath}/menber/jin2">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>到期会员</cite>

                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="iconfont">&#xe70b;</i>
                            <cite>会员卡管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i>
                        </a>
                        <ul class="sub-menu">
                            <li>
                                <a _href="${pageContext.request.contextPath}/menber/jin3">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>会员续卡</cite>

                                </a>
                            </li>
                            <li>
                                <a _href="${pageContext.request.contextPath}/menber/jin11">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>会员充值</cite>
                                </a>
                            </li>
                            <li>

                                <a _href="${pageContext.request.contextPath}/cz/jin">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>充值续卡记录</cite>

                                </a>
                            </li>
                            <li>

                                <a _href="${pageContext.request.contextPath}/ktype/jin5">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>会员卡列表</cite>

                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </li>
            <li class="show">
                <a href="javascript:;">
                    <i class="iconfont">&#xe723;</i>
                    <cite>教练管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="${pageContext.request.contextPath}/coach/jin3">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>教练列表</cite>
                        </a>
                    </li>
                    <li>
                        <a _href="${pageContext.request.contextPath}/privateinfo/jin3">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>会员私教课程列表</cite>
                        </a>
                    </li>
                    <li>
                        <a _href="${pageContext.request.contextPath}/menber/jin4">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>会员私教详情</cite>

                        </a>
                    </li>
                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe723;</i>
                    <cite>课程管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="${pageContext.request.contextPath}/subject/jin7">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>课程列表</cite>
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe723;</i>
                    <cite>器材管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="${pageContext.request.contextPath}/qc/yemian">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>器材信息</cite>
                        </a>
                    </li>

                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe723;</i>
                    <cite>物品遗失</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="${pageContext.request.contextPath}/loos/jin9">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>物品列表</cite>
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe6ce;</i>
                    <cite>商品管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="${pageContext.request.contextPath}/goods/sp">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>商品列表</cite>
                        </a>
                    </li>
                    <li>
                        <a _href="${pageContext.request.contextPath}/goodinfo/spinfo">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>商品售卖信息</cite>
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont">&#xe6b4;</i>
                    <cite>信息统计</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a _href="${pageContext.request.contextPath}/cz/jin2">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>收入统计</cite>
                        </a>
                    </li>
                </ul>
            </li>

        </ul>
    </div>
</div>
<!-- <div class="x-slide_left"></div> -->
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
    <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
        <ul class="layui-tab-title">
            <li class="home"><i class="layui-icon">&#xe68e;</i>我的桌面</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='${pageContext.request.contextPath}/static/welcome.html' frameborder="0" scrolling="yes"
                        class="x-iframe"></iframe>
            </div>
        </div>
    </div>
</div>
<div class="page-content-bg"></div>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->
<!-- 底部开始 -->

<!-- 底部结束 -->

</body>

</html>
