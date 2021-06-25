<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>注册页面</title>
<link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>

	<!-- 你的HTML代码 -->
<fieldset class="layui-elem-field layui-field-title" style="margin-top:20px">
	<legend>请注册用户</legend>
</fieldset>
	<br>
	<br>
	<br>
	<div style="width:650px;position:relative;left:30%">
	<form class="layui-form layui-form-pane" method="post" action="Registercontroller">
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-orange">注册用户名</label>
			<div class="layui-input-inline">
				<input type="text" name="user_id" required lay-verify="required"
					placeholder="注册用户名" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">注册的用户名</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-blue">注册密码</label>
			<div class="layui-input-inline">
				<input type="password" name="password" required
					lay-verify="required" placeholder="注册密码" autocomplete="off"
					class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">区分大小写</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">用户类型</label>
			<div class="layui-input-block">
				<input type="radio" name="registertype" value="1" title="管理员" checked> 
				<input type="radio" name="registertype" value="2" title="教师"> 
				<input type="radio" name="registertype" value="3" title="学生">
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">注册</button>
				<button type="reset" class="layui-btn layui-btn-radius layui-btn-danger">重置</button>
			</div>
		</div>
	</form>
	</div>
<script src="layui/layui.all.js"></script>
	<script>
//Demo
;!function(){
  var layer = layui.layer
  ,form = layui.form;

}();
</script>
</body>
</html>
