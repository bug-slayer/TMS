<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*" import="pojo.User"%>
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
    ,url:'teacherlist.do'
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
      ,{field:'coursename', title:'课程', width:120,  sort: true}
      ,{field:'teacherid', title:'教师ID', width:120,   sort: true}
      ,{field:'name', title:'教师姓名', width:120,   sort: true}
      ,{field:'teaidentity', title:'授课身份', width:150, sort: true}
      ,{field:'coursehour', title:'授课学时', width:120,  sort: true}

      //,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:140}
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
			  area:['50%','70%'],
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
    if(obj.event === 'student'){
              console.log(data);
						layer.open({
                            type: 1,
                            area: ['60%', '70%'],
                            title: "学生管理",
                            fixed: false, //不固定
                            maxmin: true,
                            maxmin: false,
                            shadeClose:false,
                            content: $('#student'),                            
                    	success : function(layero, index) {
                        $("#courseid").val(data.courseid);
                        $("#coursename").val(data.coursename);
                        $("#courseterm").val(data.courseterm);
                        $("#coursehour").val(data.coursehour);
                        $("#name").val(data.name);
                        $("#teaidentity").val(data.teaidentity);
                        $("#teacherhour").val(data.teacherhour);
                   			 }
                          });
    } else if(obj.event === 'class'){
        console.log(data);
						layer.open({
                            type: 1,
                            area: ['60%', '70%'],
                            title: "选题管理",
                            fixed: false, //不固定
                            maxmin: true,
                            maxmin: false,
                            shadeClose:false,
                            content: $('#class'),                            
                    	success : function(layero, index) {
                        $("#courseids").val(data.courseid);
                        $("#coursenames").val(data.coursename);
                        $("#courseterms").val(data.courseterm);
                        $("#coursehours").val(data.coursehour);
                        $("#names").val(data.name);
                        $("#teaidentitys").val(data.teaidentity);
                        $("#teacherhours").val(data.teacherhour);
                   			 }
                          });

    }
    else{
        console.log(data);
						layer.open({
                            type: 1,
                            area: ['60%', '70%'],
                            title: "教师管理",
                            fixed: false, //不固定
                            maxmin: true,
                            maxmin: false,
                            shadeClose:false,
                            content: $('#student'),                            
                    	success : function(layero, index) {
                        $("#courseidss").val(data.courseid);
                        $("#coursenamess").val(data.coursename);
                        $("#coursetermss").val(data.courseterm);
                        $("#coursehourss").val(data.coursehour);
                        $("#namess").val(data.name);
                        $("#teaidentityss").val(data.teaidentity);
                        $("#teacherhourss").val(data.teacherhour);
                   			 }
                          });    	
    }
  });
});
</script>
</head>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="window"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="teacheraddtopic.do">
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-green">主题ID</label>
			<div class="layui-input-inline">
				<input type="text" name="topic_id" id='topicid' required 
				lay-verify="required" placeholder="请输入topic_id" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux"></div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-green">课程ID</label>
			<div class="layui-input-inline">
				<input type="text" name="course_id" id='courseid' required 
				lay-verify="required" placeholder="请输入course_id" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux"></div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-green">主题名</label>
			<div class="layui-input-inline">
				<input type="text" name="topic" id='topic' required 
				lay-verify="required" placeholder="请输入topic" autocomplete="off" class="layui-input" >
			</div>
			<div class="layui-form-mid layui-word-aux"></div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-green">关键词</label>
			<div class="layui-input-inline">
				<input type="text" name="keyword" id='keyword'required 
				lay-verify="required" placeholder="请输入keyword" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux"></div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-green">出题教师id</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_id" id='teacher_id'required 
				lay-verify="required" placeholder="请输入teacher_id" autocomplete="off" class="layui-input" >
			</div>
			<div class="layui-form-mid layui-word-aux"></div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-green">创建时间</label>
			<div class="layui-input-inline">
				<input type="text" name="creation_time" id='creationtime'required 
				lay-verify="required" placeholder="请输入creation_time" autocomplete="off" class="layui-input" >
			</div>
			<div class="layui-form-mid layui-word-aux"></div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-green">选题人数</label>
			<div class="layui-input-inline">
				<input type="text" name="student_num" id='student_num'required 
				lay-verify="required" placeholder="请输入student_num" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux"></div>
		</div>

		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">进入学生管理页面</button>
				
			</div>
		</div>
		
	</form>
</div>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="student"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="teacherjumpstudent">
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课程ID</label>
			<div class="layui-input-inline">
				<input type="text" name="course_id" id='courseid' required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑，课程信息请在课程详情页面修改）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课程名</label>
			<div class="layui-input-inline">
				<input type="text" name="course_name" id='coursename' required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑，课程信息请在课程详情页面修改）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">学期</label>
			<div class="layui-input-inline">
				<input type="text" name="term" id='courseterm'required 
				lay-verify="required" placeholder="请输入term" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑，课程信息请在课程详情页面修改）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课时数</label>
			<div class="layui-input-inline">
				<input type="text" name="course_hour" id='coursehour'required 
				lay-verify="required" placeholder="请输入course_hour" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑，课程信息请在课程详情页面修改）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">教师姓名</label>
			<div class="layui-input-inline">
				<input type="text" name="name" id='name'required 
				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">教师身份</label>
			<div class="layui-input-inline">
				<input type="text" name="tea_identity" id='teaidentity'required 
				lay-verify="required" placeholder="请输入教师身份" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（注意身份冲突，一门课只能有一个主讲教师）</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">授课学时</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_hour" id='teacherhour'required 
				lay-verify="required" placeholder="请输入授课学时" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（注意课时冲突）</div>
		</div>
		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">进入学生管理页面</button>
				
			</div>
		</div>
		
	</form>
</div>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="class"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="updatetc.do">
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课程ID</label>
			<div class="layui-input-inline">
				<input type="text" name="course_id" id='courseids' required 
				lay-verify="required" placeholder="请输入course_id" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑，课程信息请在课程详情页面修改）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课程名</label>
			<div class="layui-input-inline">
				<input type="text" name="course_name" id='coursenames' required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑，课程信息请在课程详情页面修改）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">学期</label>
			<div class="layui-input-inline">
				<input type="text" name="term" id='courseterms'required 
				lay-verify="required" placeholder="请输入term" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑，课程信息请在课程详情页面修改）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课时数</label>
			<div class="layui-input-inline">
				<input type="text" name="course_hour" id='coursehours'required 
				lay-verify="required" placeholder="请输入course_hour" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑，课程信息请在课程详情页面修改）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">教师姓名</label>
			<div class="layui-input-inline">
				<input type="text" name="name" id='names'required 
				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">教师身份</label>
			<div class="layui-input-inline">
				<input type="text" name="tea_identity" id='teaidentitys'required 
				lay-verify="required" placeholder="请输入教师身份" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（注意身份冲突，一门课只能有一个主讲教师）</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">授课学时</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_hour" id='teacherhours'required 
				lay-verify="required" placeholder="请输入授课学时" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（注意课时冲突）</div>
		</div>
		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">进入选题管理页面</button>
				
			</div>
		</div>
		
	</form>
</div>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="teacher"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="updatetc.do">
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课程ID</label>
			<div class="layui-input-inline">
				<input type="text" name="course_id" id='courseidss' required 
				lay-verify="required" placeholder="请输入course_id" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑，课程信息请在课程详情页面修改）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课程名</label>
			<div class="layui-input-inline">
				<input type="text" name="course_name" id='coursenamess' required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑，课程信息请在课程详情页面修改）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">学期</label>
			<div class="layui-input-inline">
				<input type="text" name="term" id='coursetermss'required 
				lay-verify="required" placeholder="请输入term" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑，课程信息请在课程详情页面修改）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课时数</label>
			<div class="layui-input-inline">
				<input type="text" name="course_hour" id='coursehourss'required 
				lay-verify="required" placeholder="请输入course_hour" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑，课程信息请在课程详情页面修改）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">教师姓名</label>
			<div class="layui-input-inline">
				<input type="text" name="name" id='namess'required 
				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">教师身份</label>
			<div class="layui-input-inline">
				<input type="text" name="tea_identity" id='teaidentityss'required 
				lay-verify="required" placeholder="请输入教师身份" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（注意身份冲突，一门课只能有一个主讲教师）</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">授课学时</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_hour" id='teacherhourss'required 
				lay-verify="required" placeholder="请输入授课学时" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（注意课时冲突）</div>
		</div>
		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">进入教师管理页面</button>
				
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
<blockquote class="layui-elem-quote"><font color="red">授课教师列表（您是该课程非主讲教师只能查看授课教师列表无法进行编辑）</font></blockquote>
    
    <div style="padding: 15px;">				
    <table class="layui-hide" id="test" lay-filter="test"></table>
 
<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">

  </div>
</script>
 
<script type="text/html" id="barDemo">

</script></div>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © 计算机18-2 张青峰
  </div>
</div>

</body>
</html>
