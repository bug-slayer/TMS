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
	  
      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:140}
    ]]

    ,limit:10


  });
  
  //头工具栏事件
  table.on('toolbar(test)', function(obj){
   var data = obj.data;
    var checkStatus = table.checkStatus(obj.config.id);
    switch(obj.event){
      case 'add':
       console.log(data);
		  layer.open({
			  type: 1, 
			  title:"新增授课教师",
			  area:['50%','50%'],
			 // btn: ['确定', '取消'], 
			  //zIndex: 100,
			  content: $("#window"),
			  yes:function(layero, index){
			  $("#coursenamess").val(data.coursename);
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
    if(obj.event === 'edit'){
              console.log(data);
						layer.open({
                            type: 1,
                            area: ['50%', '60%'],
                            title: "编辑授课教师信息",
                            fixed: false, //不固定
                            maxmin: true,
                            maxmin: false,
                            shadeClose:false,
                            content: $('#teaedittea'),                            
                    	success : function(layero, index) {
                        $("#coursename").val(data.coursename);
                        $("#teacherid").val(data.teacherid);
                        $("#name").val(data.name);
                        $("#teaidentity").val(data.teaidentity);
                        $("#teacherhour").val(data.coursehour);
                   			 }
                          });
    } else if(obj.event === 'delete'){
        console.log(data);
						layer.open({
                            type: 1,
                            area: ['40%', '50%'],
                            title: "删除授课教师",
                            fixed: false, //不固定
                            maxmin: true,
                            maxmin: false,
                            shadeClose:false,
                            content: $('#teadeletetea'),                            
                    	success : function(layero, index) {
                        $("#coursenames").val(data.coursename);
                        $("#teacherids").val(data.teacherid);
                        $("#names").val(data.name);
                        $("#teaidentitys").val(data.teaidentity);
                        $("#teacherhours").val(data.coursehour);
                   			 }
                          });

    }

  });
});
</script>
</head>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="window"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="teaaddtea.do">
	
<!-- 	  	<div class="layui-form-item"> -->
<!-- 			<label class="layui-form-label layui-bg-red">课程名</label> -->
<!-- 			<div class="layui-input-inline"> -->
<!-- 				<input type="text" name="course_name" id='coursenamess' required  -->
<!-- 				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input" > -->
<!-- 			</div> -->
<!-- 			<div class="layui-form-mid layui-word-aux">（不可编辑）</div> -->
<!-- 		</div> -->
      <label class="layui-form-label layui-bg-green">教师ID及姓名</label>
      <div class="layui-input-inline">
        <select name="teacher_id" lay-verify="required" lay-search="">
          <option value="">直接选择或搜索选择</option>
          <option value="1">1-王新阳</option>
          <option value="2">2-王新阳助</option>
          <option value="3">3-杨波</option>
          <option value="4">4-杨波助</option>
          <option value="5">5-崔晓辉</option>
          <option value="6">6-崔晓辉助</option>
          <option value="7">7-齐建东</option>
          <option value="8">8-齐建东助</option>
          <option value="9">9-于辉辉</option>
          <option value="10">10-于辉辉助</option>
          <option value="11">11-韩慧</option>
          <option value="12">12-韩慧助</option>
          <option value="13">13-王春玲</option>
          <option value="14">14-王春玲助</option>
          <option value="15">15-杜景芬</option>
		  <option value="16">16-杜景芬助</option>
		  <option value="17">17-姚明</option>
		  <option value="18">18-姚明助</option>
		  <option value="19">19-王建新</option>
		  <option value="20">20-王建新助</option>
		  <option value="21">21-马龙</option>
		  <option value="22">22-马龙助</option>
		  <option value="23">23-李冬梅</option>
		  <option value="24">24-李冬梅助</option>
		  <option value="25">25-刘翔</option>
		  <option value="26">26-刘翔助</option>
		  <option value="27">27-刘翔助助</option>
        </select>
      </div>
	<br>
	<br>
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-green">教师身份</label>
			<div class="layui-input-inline">
				<input type="text" name="tea_identity" required 
				lay-verify="required" placeholder="请输入教师身份" autocomplete="off" class="layui-input" >
			</div>
			<div class="layui-form-mid layui-word-aux">（注意身份冲突，一门课只能有一个主讲教师）</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-green">授课学时</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_hour" required 
				lay-verify="required" placeholder="请输入授课学时" autocomplete="off" class="layui-input" >
			</div>
			<div class="layui-form-mid layui-word-aux">（注意课时冲突，总授课学时不能超过课时）</div>
		</div>
		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">添加</button>
				
			</div>
		</div>
		
	</form>
</div>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="teaedittea"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="teaedittea.do">
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课程名</label>
			<div class="layui-input-inline">
				<input type="text" name="course_name" id='coursename' required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">教师ID</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_id" id='teacherid'required 
				lay-verify="required" placeholder="请输入teacherid" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
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
			<label class="layui-form-label layui-bg-green">教师身份</label>
			<div class="layui-input-inline">
				<input type="text" name="tea_identity" id='teaidentity'required 
				lay-verify="required" placeholder="请输入教师身份" autocomplete="off" class="layui-input" >
			</div>
			<div class="layui-form-mid layui-word-aux">（注意身份冲突，一门课只能有一个主讲教师）</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-green">授课学时</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_hour" id='teacherhour'required 
				lay-verify="required" placeholder="请输入授课学时" autocomplete="off" class="layui-input" >
			</div>
			<div class="layui-form-mid layui-word-aux">（注意课时冲突，总授课学时不能超过课时）</div>
		</div>
		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">确认更改</button>
				
			</div>
		</div>
		
	</form>
</div>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="teadeletetea"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="teadeletetea.do">
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课程名</label>
			<div class="layui-input-inline">
				<input type="text" name="course_name" id='coursenames' required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">教师ID</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_id" id='teacherids'required 
				lay-verify="required" placeholder="请输入teacherid" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
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
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">授课学时</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_hour" id='teacherhours'required 
				lay-verify="required" placeholder="请输入授课学时" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius layui-btn-danger" lay-submit lay-filter="formDemo">确认删除</button>
				
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
<blockquote class="layui-elem-quote"><font color="red">授课教师列表（您是该课程主讲教师可以增删改授课教师信息）</font></blockquote>
    
    <div style="padding: 15px;">				
    <table class="layui-hide" id="test" lay-filter="test"></table>
 
<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm data-add-btn"lay-event="add">新增授课教师 </button>
  </div>
</script>
 
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
</script></div>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © 计算机18-2 张青峰
  </div>
</div>

</body>
</html>
