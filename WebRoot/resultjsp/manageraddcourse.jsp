<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="dao.User" %>
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

</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">研究生论文管理系统</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->

    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <img src="layui/images/animal.jpg" class="layui-nav-img">
         	管理员<%User username=(User)session.getAttribute("userid");
         	out.print(username.getUserid());
         	 %>
        </a>
        <dl class="layui-nav-child">
          <dd><a href="">基本资料</a></dd>
          <dd><a href="">安全设置</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="login.jsp">退出</a></li>
    </ul>
  </div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
        <li class="layui-nav-item layui-nav-itemed">
          <a class="" href="javascript:;">课程管理</a>
          <dl class="layui-nav-child">
            <dd><a href="Managermanacourse.do">课程详情</a></dd>
            <dd><a href="Managerjumpaddcourse.do">新增课程</a></dd>
<!--             <dd><a href="javascript:;">列表三</a></dd> -->
<!--             <dd><a href="">超链接</a></dd> -->
          </dl>
        </li>
        <li class="layui-nav-item">
          <a href="javascript:;">教师管理</a>
          <dl class="layui-nav-child">
            <dd><a href="Managermanateacher.do">教师详情</a></dd>
            <dd><a href="Managerjumpaddteacher.do">新增教师</a></dd>
<!--             <dd><a href="">超链接</a></dd> -->
          </dl>
        </li>
<!--         <li class="layui-nav-item"><a href="">云市场</a></li> -->
<!--         <li class="layui-nav-item"><a href="">发布商品</a></li> -->
      </ul>
    </div>
  </div>
  
  <div class="layui-body">
    <!-- 内容主体区域 -->
    <div style="padding: 15px;">
    
    <fieldset class="layui-elem-field layui-field-title" style="margin-top:20px">
	<legend><font color="green">请输入新增课程信息</font></legend>
</fieldset>
	<br>
	<br>
	<br>
	<div style="width:650px;position:relative;left:30%">

	<form class="layui-form layui-form-pane" method="post" action="Manageraddcourse.do">
		<div class="layui-form-item">
<!-- 		<div class="layui-inline"> -->
			<label class="layui-form-label layui-bg-orange">course_id</label>
			<div class="layui-input-inline">
				<input type="text" name="course_id" required lay-verify="required"
					placeholder="请输入course_id" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">课程号</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-blue">course_name</label>
			<div class="layui-input-inline">
				<input type="password" name="course_name" required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">课程名</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">term</label>
			<div class="layui-input-inline">
				<input type="password" name="term" required 
				lay-verify="required" placeholder="请输入term" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">学期</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-black">course_hour</label>
			<div class="layui-input-inline">
				<input type="password" name="course_hour" required 
				lay-verify="required" placeholder="请输入course_hour" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">课时数</div>
		</div>
		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">添加</button>
				<button type="reset" class="layui-btn layui-btn-radius layui-btn-danger">重置</button>
			</div>
		</div>
		
	</form>
	</div>
    
    </div>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © 计算机18-2 张青峰
  </div>
</div>
<script src="layui/layui.js"></script>
<script>
//JavaScript代码区域
layui.use(['element','layer','form'], function(){
  var element = layui.element,
    layer = layui.layer
  ,form = layui.form;
});
</script>
</body>
</html>
