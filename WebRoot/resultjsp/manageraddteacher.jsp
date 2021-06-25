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
        <li class="layui-nav-item ">
          <a class="" href="javascript:;">课程管理</a>
          <dl class="layui-nav-child">
            <dd><a href="Managermanacourse.do">课程详情</a></dd>
            <dd><a href="Managerjumpaddcourse.do">新增课程</a></dd>
<!--             <dd><a href="javascript:;">列表三</a></dd> -->
<!--             <dd><a href="">超链接</a></dd> -->
          </dl>
        </li>
        <li class="layui-nav-item layui-nav-itemed">
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
	<legend><font color="green">请输入新增教师信息</font></legend>
</fieldset>
	<br>
	<br>
	<br>
	<div style="width:650px;position:relative;left:30%">

	<form class="layui-form layui-form-pane" method="post" action="Manageraddteacher.do">
		<div class="layui-form-item">
		<div class="layui-form-item">
<!-- 		<div class="layui-inline"> -->
			<label class="layui-form-label layui-bg-orange">teacher_id</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_id" required lay-verify="required"
					placeholder="请输入teacher_id" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">教师id</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-orange">name</label>
			<div class="layui-input-inline">
				<input type="text" name="name" required 
				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">教师姓名</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-orange">sex</label>
			<div class="layui-input-inline">
				<input type="text" name="sex" required 
				lay-verify="required" placeholder="请输入sex" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">教师性别</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-orange">protitle</label>
			<div class="layui-input-inline">
				<input type="text" name="protitle" required 
				lay-verify="required" placeholder="请输入protitle" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">教师职称</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-orange">phone</label>
			<div class="layui-input-inline">
				<input type="text" name="phone" required 
				lay-verify="required" placeholder="请输入phone" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">教师电话</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-orange">user_id</label>
			<div class="layui-input-inline">
				<input type="text" name="user_id" required 
				lay-verify="required" placeholder="请输入user_id" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">教师用户名</div>
		</div>
		
		<label class="layui-form-label layui-bg-black">所授课程</label>
      <div class="layui-input-inline">
        <select name="course_id" lay-verify="required" lay-search="">
          <option value="">直接选择或搜索选择</option>
          <option value="1">javaweb</option>
          <option value="2">软件工程</option>
          <option value="3">数据库</option>
          <option value="4">计算机网络</option>
          <option value="5">汇编语言程序设计</option>
          <option value="6">java程序设计</option>
          <option value="7">c++程序设计</option>
          
          <option value="9">景区英语</option>
          <option value="10">篮球课</option>
          <option value="11">软件设计模式</option>
          <option value="12">乒乓球</option>
          <option value="13">数据结构</option>
          <option value="14">跑步</option>
          <option value="15">跨栏</option>

        </select>
      </div>
      <br>
      <br>
      <br>
 		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-black">授课身份</label>
			<div class="layui-input-inline">
				<input type="text" name="tea_identity" required 
				lay-verify="required" placeholder="请输入tea_identity" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">注意身份冲突，一门课程只能有一个主讲教师</div>
		</div>
				<div class="layui-form-item">
			<label class="layui-form-label layui-bg-black">授课学时</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_hour" required 
				lay-verify="required" placeholder="请输入teacher_hour" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">注意课时冲突，总授课时数不能超过总课时数</div>
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
