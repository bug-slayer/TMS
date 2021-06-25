<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*" import="dao.ManagerDao,pojo.Teacher,pojo.User,
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
layui.use('table', function(){
        var 	$=layui.$,
        table=layui.table,
        layuimini=layui.layuimini,
        layer=layui.layer,
  			 element = layui.element;
  
  table.render({
    elem: '#test'
    ,url:'getallteacher.do'

    ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
    ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
      title: '提示'
      ,layEvent: 'LAYTABLE_TIPS'
      ,icon: 'layui-icon-tips'
    }]
    ,title: '用户数据表'
    ,cols: [[
      {type: 'checkbox', fixed: 'left'}
      ,{field:'teacherid', title:'教师ID', width:150, sort: true}
      ,{field:'teachername', title:'教师姓名', width:150, sort: true}
      ,{field:'teachersex', title:'教师性别', width:150, sort: true}
      ,{field:'teacherprotitle', title:'教师职称', width:150, sort: true}
      ,{field:'teacherphone', title:'教师电话', width:150, sort: true}
      ,{field:'userid', title:'用户名', width:150, width:150, sort: true}

      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:180}
    ]]
    ,page: true
    ,limit:10



  });
  
  //头工具栏事件
  table.on('toolbar(test)', function(obj){
    var checkStatus = table.checkStatus(obj.config.id);
    switch(obj.event){
      case 'add':
		  layer.open({
			  type: 1, 
			  title:"新增教师",
			  area:['50%','80%'],
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
    if(obj.event === 'del'){
      layer.confirm('真的删除行么', function(index){
        obj.del();
        layer.close(index);
      });
    } else if(obj.event === 'edit'){
        console.log(data);
						layer.open({
                            type: 1,
                            area: ['50%', '60%'],
                            title: "更改教师信息",
                            fixed: false, //不固定
                            maxmin: true,
                            maxmin: false,
                            shadeClose:false,
                            content: $('#teacheredit'),                            
                    	success : function(layero, index) {
                        $("#teacherid").val(data.teacherid);
                        $("#teachername").val(data.teachername);
                        $("#teachersex").val(data.teachersex);
                        $("#teacherprotitle").val(data.teacherprotitle);
                        $("#teacherphone").val(data.teacherphone);
                        $("#userid").val(data.userid);
                   			 }
                          });
    }else{
        console.log(data);
						layer.open({
                            type: 1,
                            area: ['50%', '60%'],
                            title: "确认教师信息",
                            fixed: false, //不固定
                            maxmin: true,
                            maxmin: false,
                            shadeClose:false,
                            content: $('#tclist'),                            
                    	success : function(layero, index) {
                        $("#teacherids").val(data.teacherid);
                        $("#teachernames").val(data.teachername);
                        $("#teachersexs").val(data.teachersex);
                        $("#teacherprotitles").val(data.teacherprotitle);
                        $("#teacherphones").val(data.teacherphone);
                        $("#userids").val(data.userid);
                   			 }
                          });
    }
    
  });
});
</script>
</head>
<body class="layui-layout-body">

<div class="site-text" style="position:relative;left:25%;margin: 5%; display: none" id="window"  target="test123" >	
	<form class="layui-form layui-form-pane" method="post" action="Manageraddteacher.do">
	
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
<div class="site-text" style="position:relative;left:25%;margin: 5%; display: none" id="teacheredit"  target="test123" >	
	<form class="layui-form layui-form-pane" method="post" action="updateteacher.do">
		<div class="layui-form-item">
<!-- 		<div class="layui-inline"> -->
			<label class="layui-form-label layui-bg-red">教师ID</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_id" id="teacherid" required lay-verify="required"
					placeholder="请输入teacher_id" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑请添加新教师）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-blue">教师姓名</label>
			<div class="layui-input-inline">
				<input type="text" name="name" id="teachername"required 
				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-blue">教师性别</label>
			<div class="layui-input-inline">
				<input type="text" name="sex" id="teachersex" required 
				lay-verify="required" placeholder="请输入sex" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">（可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-blue">教师职称</label>
			<div class="layui-input-inline">
				<input type="text" name="protitle" id="teacherprotitle" required 
				lay-verify="required" placeholder="请输入protitle" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">（可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-blue">教师电话</label>
			<div class="layui-input-inline">
				<input type="text" name="phone" id="teacherphone" required 
				lay-verify="required" placeholder="请输入phone" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-mid layui-word-aux">（可编辑）</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">用户名</label>
			<div class="layui-input-inline">
				<input type="text" name="user_id" id="userid" required 
				lay-verify="required" placeholder="请输入user_id" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">(不可编辑)</div>
		</div>

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
<div class="site-text" style="position:relative;left:25%;margin: 5%; display: none" id="tclist"  target="test123" >	
	<form class="layui-form layui-form-pane" method="post" action="Managerjumptc.do">
		<div class="layui-form-item">
<!-- 		<div class="layui-inline"> -->
			<label class="layui-form-label layui-bg-red">教师ID</label>
			<div class="layui-input-inline">
				<input type="text" name="teacher_id" id="teacherids" required lay-verify="required"
					placeholder="请输入teacher_id" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">教师姓名</label>
			<div class="layui-input-inline">
				<input type="text" name="name" id="teachernames"required 
				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">教师性别</label>
			<div class="layui-input-inline">
				<input type="text" name="sex" id="teachersexs" required 
				lay-verify="required" placeholder="请输入sex" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">教师职称</label>
			<div class="layui-input-inline">
				<input type="text" name="protitle" id="teacherprotitles" required 
				lay-verify="required" placeholder="请输入protitle" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">教师电话</label>
			<div class="layui-input-inline">
				<input type="text" name="phone" id="teacherphones" required 
				lay-verify="required" placeholder="请输入phone" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">用户名</label>
			<div class="layui-input-inline">
				<input type="text" name="user_id" id="userids" required 
				lay-verify="required" placeholder="请输入user_id" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑)</div>
		</div>

		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">授课列表</button>
				
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
        <li class="layui-nav-item">
          <a class="" href="javascript:;">课程管理</a>
          <dl class="layui-nav-child">
            <dd><a href="Managermanacourse.do?metohd=jump">课程详情</a></dd>
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
<blockquote class="layui-elem-quote"><font color="red">教师详情</font></blockquote>
		
				<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm data-add-btn" lay-event="add">添加教师 </button>
  </div>
</script>
 
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="tclist">授课列表</a>
</script>
              
          

<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 --> 
 


    </div>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © 计算机18-2 张青峰
  </div>
</div>

<script>
//JavaScript代码区域
layui.use('element', function(){
  var element = layui.element;
  
});
</script>
</body>
</html>
