<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*" import="pojo.User,pojo.Topic"%>
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
<script>
layui.use(['table','element'], function(){
        var 	$=layui.$,
        table=layui.table,
        layuimini=layui.layuimini,
        layer=layui.layer,
  			 element = layui.element;
  table.render({
    elem: '#test'
    ,url:'topicdetails.do'
    ,type:'GET'
    ,page: true
    ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
    ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
      title: '提示'
      ,layEvent: 'LAYTABLE_TIPS'
      ,icon: 'layui-icon-tips'
    }]
    ,title: '用户数据表'
    ,cols: [[
      {type: 'checkbox', fixed: 'left'}
      ,{field:'stuid', title:'学号', width:120,   sort: true}
      ,{field:'name', title:'姓名', width:120,   sort: true}
      ,{field:'sex', title:'性别', width:120,   sort: true}
      ,{field:'major', title:'专业', width:150, sort: true}
      ,{field:'classes', title:'班级', width:120,  sort: true}

      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:140}
    ]]

    ,limit:10


  });
  
  //头工具栏事件
  table.on('toolbar(test)', function(obj){
    var checkStatus = table.checkStatus(obj.config.id);
    switch(obj.event){
      case 'add':
		  layer.open({
			  type: 1, 
			  title:"新增主题",
			  area:['40%','70%'],
			 // btn: ['确定', '取消'], 
			  //zIndex: 100,
			  content: $("#window"),
			  yes:function(index,layero){
               }
			});
      break;
      case 'getCheckLength':
        var data = checkStatus.data;
        layer.msg('选中了：'+ data.length + ' 个');
      break;
      case 'isAll':
        layer.msg(checkStatus.isAll ? '全选': '未全选');
      break;
      
      //自定义头工具栏右侧图标 - 提示
      case 'LAYTABLE_TIPS':
        layer.alert('这是工具栏右侧自定义的一个图标按钮');
      break;
    };
  });



  //监听行工具事件
  table.on('tool(test)', function(obj){
    var data = obj.data;
    //console.log(obj)
    if(obj.event === 'paperlist'){
              console.log(data);
						layer.open({
                            type: 1,
                            area: ['40%', '50%'],
                            title: "论文列表",
                            fixed: false, //不固定
                            maxmin: true,
                            maxmin: false,
                            shadeClose:false,
                            content: $('#paperlist'),                            
                    	success : function(layero, index) {
                        $("#stuid").val(data.stuid);
                        $("#name").val(data.name);
                        $("#sex").val(data.sex);
                        $("#major").val(data.major);
                        $("#classes").val(data.classes);
                   			 }
                          });
    } 

  });
});
</script>
</head>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="paperlist"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="teacherjumppaperlist.do">
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">学号</label>
			<div class="layui-input-inline">
				<input type="text" name="student_id" id="stuid" required 
				lay-verify="required" placeholder="请输入student_id" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">学生姓名</label>
			<div class="layui-input-inline">
				<input type="text" name="name" id="name" required 
				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">性别</label>
			<div class="layui-input-inline">
				<input type="text" name="sex" id="sex" required 
				lay-verify="required" placeholder="请输入sex" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">专业</label>
			<div class="layui-input-inline">
				<input type="text" name="major" id="major" required 
				lay-verify="required" placeholder="请输入major" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">班级</label>
			<div class="layui-input-inline">
				<input type="text" name="classes" id="classes" required 
				lay-verify="required" placeholder="请输入classes" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>


		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">查看本主题该学生论文列表</button>
				
			</div>
		</div>
		
	</form>
</div>

<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">研究生论文管理系统</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->

    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <img src="layui/images/animal.jpg" class="layui-nav-img">
		教师<%User username=(User)session.getAttribute("userid");
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
          <a class="" href="javascript:;">教师首页</a>
          <dl class="layui-nav-child">
            <dd><a href="teacherjumpteachermana.do">授课列表</a></dd>

          </dl>
        </li>
      </ul>
    </div>
  </div>
  
  <div class="layui-body">
<blockquote class="layui-elem-quote"><font color="red">选题学生信息</font></blockquote>
<blockquote class="layui-elem-quote">
主题内容:
<%String details=(String)session.getAttribute("topicdetails");
         	out.print(details);
         	 %>
         	 
         	 
         	 
</blockquote>
    
    <div style="padding: 15px;">				
    <table class="layui-hide" id="test" lay-filter="test"></table>
 
<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">

  </div>
</script>
 
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="paperlist">论文列表</a>
</script></div>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © 计算机18-2 张青峰
  </div>
</div>

</body>
</html>