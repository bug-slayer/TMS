<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*" import="dao.ManagerDao,pojo.Course,pojo.User,
org.springframework.context.ApplicationContext,org.springframework.context.support.ClassPathXmlApplicationContext" %>	
	
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
    ,url:'getcoursess.do'
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
      ,{field:'courseid', title:'课程ID', width:120,   sort: true}
      ,{field:'coursename', title:'课程名', width:150, sort: true}
      ,{field:'courseterm', title:'学期', width:120, sort: true}
      ,{field:'coursehour', title:'总课时数', width:120, sort: true}
      ,{field:'name', title:'主讲教师', width:120, sort: true}
//       ,{field:'teacherid', title:'教师ID', width:120, sort: true}
//       ,{field:'teacherhour', title:'授课学时', width:120, sort: true}

      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:120}
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
			  title:"新增课程",
			  area:['50%','50%'],
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

	  $("#add").click(function(){
		  layer.open({
			  type: 1, 
			  title:"新增课程",
			  area:['50%','50%'],
			 // btn: ['确定', '取消'], 
			  //zIndex: 100,
			  content: $("#window"),
			  yes:function(index,layero){
               }
			}); 
	  })



  //监听行工具事件
  table.on('tool(test)', function(obj){
    var data = obj.data;
    //console.log(obj)
    if(obj.event === 'del'){
      layer.confirm('真的删除行么', function(index){
        obj.del();
        layer.close(index);
      });
    } else if(obj.event === 'detail'){
        console.log(data);
						layer.open({
                            type: 1,
                            area: ['50%', '70%'],
                            title: "课程详细信息",
                            fixed: false, //不固定
                            maxmin: true,
                            maxmin: false,
                            shadeClose:false,
                            content: $('#coursedetail'),                            
                    	success : function(layero, index) {
                        $("#courseid").val(data.courseid);
                        $("#coursename").val(data.coursename);
                        $("#courseterm").val(data.courseterm);
                        $("#coursehour").val(data.coursehour);
                        $("#name").val(data.name);

                   			 }
                          });

    }else {
        console.log(data);
						layer.open({
                            type: 1,
                            area: ['50%', '70%'],
                            title: "更改课程信息",
                            fixed: false, //不固定
                            maxmin: true,
                            maxmin: false,
                            shadeClose:false,
                            content: $('#courseedit'),                            
                    	success : function(layero, index) {
                        $("#courseids").val(data.courseid);
                        $("#coursenames").val(data.coursename);
                        $("#courseterms").val(data.courseterm);
                        $("#coursehours").val(data.coursehour);
                        $("#names").val(data.name);

                   			 }
                          });

    }
  });
});
</script>

</head>
<body class="layui-layout-body">

<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="window"  target="test123">	
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
				<input type="text" name="course_name" required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">课程名</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">term</label>
			<div class="layui-input-inline">
				<input type="text" name="term" required 
				lay-verify="required" placeholder="请输入term" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">学期</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-black">course_hour</label>
			<div class="layui-input-inline">
				<input type="text" name="course_hour" required 
				lay-verify="required" placeholder="请输入course_hour" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">课时数</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">添加</button>
				<button type="reset" class="layui-btn layui-btn-radius layui-btn-danger">重置</button>
			</div>
		</div>
		
	</form>
</div>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="coursedetail"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="managercoursedetail.do">
		<div class="layui-form-item">
<!-- 		<div class="layui-inline"> -->
			<label class="layui-form-label layui-bg-red">课程ID</label>
			<div class="layui-input-inline">
				<input type="text" name="course_id" id='courseid'required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑请添加新课程）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课程名</label>
			<div class="layui-input-inline">
				<input type="text" name="course_name" id='coursename' required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">学期</label>
			<div class="layui-input-inline">
				<input type="text" name="term" id='courseterm'required 
				lay-verify="required" placeholder="请输入term" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课时数</label>
			<div class="layui-input-inline">
				<input type="text" name="course_hour" id='coursehour'required 
				lay-verify="required" placeholder="请输入course_hour" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">主讲教师</label>
			<div class="layui-input-inline">
				<input type="text" name="name" id='name'required 
				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
<!-- 		<div class="layui-form-item"> -->
<!-- 			<label class="layui-form-label layui-bg-red">教师ID</label> -->
<!-- 			<div class="layui-input-inline"> -->
<!-- 				<input type="text" name="name" id='teacherid'required  -->
<!-- 				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly> -->
<!-- 			</div> -->
<!-- 			<div class="layui-form-mid layui-word-aux">（不可编辑）</div> -->
<!-- 		</div> -->

<!-- 		<div class="layui-form-item"> -->
<!-- 			<label class="layui-form-label layui-bg-red">授课学时</label> -->
<!-- 			<div class="layui-input-inline"> -->
<!-- 				<input type="text" name="name" id='teacherhour'required  -->
<!-- 				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly> -->
<!-- 			</div> -->
<!-- 			<div class="layui-form-mid layui-word-aux">（不可编辑）</div> -->
<!-- 		</div> -->
		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">查看课程详情</button>
			</div>
		</div>
		
	</form>
</div>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="courseedit"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="updatecourse.do">
		<div class="layui-form-item">
<!-- 		<div class="layui-inline"> -->
			<label class="layui-form-label layui-bg-red">课程ID</label>
			<div class="layui-input-inline">
				<input type="text" name="course_id" id='courseids'required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑请添加新课程）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-blue">课程名</label>
			<div class="layui-input-inline">
				<input type="text" name="course_name" id='coursenames' required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">（可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-blue">学期</label>
			<div class="layui-input-inline">
				<input type="text" name="term" id='courseterms'required 
				lay-verify="required" placeholder="请输入term" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">（可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-blue">课时数</label>
			<div class="layui-input-inline">
				<input type="text" name="course_hour" id='coursehours'required 
				lay-verify="required" placeholder="请输入course_hour" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">（可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">主讲教师</label>
			<div class="layui-input-inline">
				<input type="text" name="name" id='names'required 
				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
<!-- 		<div class="layui-form-item"> -->
<!-- 			<label class="layui-form-label layui-bg-red">教师ID</label> -->
<!-- 			<div class="layui-input-inline"> -->
<!-- 				<input type="text" name="name" id='teacherid'required  -->
<!-- 				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly> -->
<!-- 			</div> -->
<!-- 			<div class="layui-form-mid layui-word-aux">（不可编辑）</div> -->
<!-- 		</div> -->

<!-- 		<div class="layui-form-item"> -->
<!-- 			<label class="layui-form-label layui-bg-red">授课学时</label> -->
<!-- 			<div class="layui-input-inline"> -->
<!-- 				<input type="text" name="name" id='teacherhour'required  -->
<!-- 				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly> -->
<!-- 			</div> -->
<!-- 			<div class="layui-form-mid layui-word-aux">（不可编辑）</div> -->
<!-- 		</div> -->
		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">更改</button>
				<button type="reset" class="layui-btn layui-btn-radius layui-btn-danger">重置</button>
			</div>
		</div>
		
	</form>
</div>
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
            <dd><a href="Managermanateacher.do">授课详情</a></dd>
            <dd><a href="Managerjumpaddteacher.do">修改授课信息</a></dd>
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
<blockquote class="layui-elem-quote"><font color="red">所有课程列表</font></blockquote>
	    

		
				<table class="layui-hide" id="test" lay-filter="test"></table>
 
<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm data-add-btn"lay-event="add">添加课程 </button>
  </div>
</script>
 
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="detail">详情</a>
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</script>
             
    </div>
  </div>

  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © 计算机18-2 张青峰
  </div>
</div>



</body>
</html>
