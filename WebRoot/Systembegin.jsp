<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Title</title>

<link rel="stylesheet" href="layui/css/layui.css">
<script src="layui/layui.js"></script>
</head>
<body>
<div class="stars"></div>
<!-- 	<div class="layui-inline"></div> -->
	<ul class="layui-nav layui-bg-green" lay-filter="">
<!-- 		<li class="layui-nav-item"><a href="">最新活动</a></li> -->
<!-- 		<li class="layui-nav-item"><a href="">大数据</a></li> -->
		<li class="layui-nav-item "><a href="login.jsp">登录</a>
<!-- 			<dl class="layui-nav-child"> -->
<!-- 				二级菜单 -->
<!-- 				<dd> -->
<!-- 					<a href="loginmanager.jsp">管理员登录</a> -->
<!-- 				</dd> -->
<!-- 				<dd> -->
<!-- 					<a href="loginteacher.jsp">教师登录</a> -->
<!-- 				</dd> -->
<!-- 				<dd> -->
<!-- 					<a href="loginstudent.jsp">研究生登录</a> -->
<!-- 				</dd> -->
<!-- 			</dl> -->
			</li>
		<li class="layui-nav-item"><a href="register.jsp">注册</a>
<!-- 			<dl class="layui-nav-child"> -->
<!-- 				二级菜单 -->
<!-- 				<dd> -->
<!-- 					<a href="registermanager.jsp">管理员注册</a> -->
<!-- 				</dd> -->
<!-- 				<dd> -->
<!-- 					<a href="registerteacher.jsp">教师注册</a> -->
<!-- 				</dd> -->
<!-- 				<dd> -->
<!-- 					<a href="registerstudent.jsp">研究生注册</a> -->
<!-- 				</dd> -->
<!-- 			</dl> -->
			</li>
<!-- 		<li class="layui-nav-item"><a href="">社区</a></li> -->
	</ul>

	<script>
		//注意：导航 依赖 element 模块，否则无法进行功能性操作
		layui.use('element', function() {
			var element = layui.element;
	
		//…
		});
	</script>
	<script>
		layui.use('element', function() {
			var element = layui.element;
		});
	</script>
</body>
</html>
