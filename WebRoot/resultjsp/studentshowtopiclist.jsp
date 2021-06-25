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
    ,url:'studenttopiclist.do'//在Logincontroller中从而获取用户名，根据其查询授课列表
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
      ,{field:'coursename', title:'课程名', width:120,   sort: true}
      ,{field:'topicid', title:'主题ID', width:120,   sort: true}
      ,{field:'topic', title:'主题名', width:120,   sort: true}
      ,{field:'keyword', title:'关键词', width:120, sort: true}
      ,{field:'name', title:'出题教师姓名', width:120,  sort: true}
      ,{field:'creationtime', title:'创建时间', width:180, sort: true}
      ,{field:'studentnum', title:'已选人数', width:120, sort: true}
	  ,{field:'maxnum', title:'最大选题人数', width:130, sort: true}
      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:200}
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


  //监听行工具事件
  table.on('tool(test)', function(obj){
    var data = obj.data;
    //console.log(obj)
    if(obj.event === 'stutopic'){
              console.log(data);
						layer.open({
                            type: 1,
                            area: ['40%', '60%'],
                            title: "我要读",
                            fixed: false, //不固定
                            maxmin: true,
                            maxmin: false,
                            shadeClose:false,
                            content: $('#stutopic'),                            
                    	success : function(layero, index) {
                        $("#coursename").val(data.coursename);
                        $("#topicid").val(data.topicid);
                        $("#topic").val(data.topic);
                        $("#keyword").val(data.keyword);
                        $("#name").val(data.name);
                        $("#creationtime").val(data.creationtime);
                        $("#studentnum").val(data.studentnum);

                   			 }
                          });
    } else if(obj.event === 'stutopiclist'){
              console.log(data);
						layer.open({
                            type: 1,
                            area: ['40%', '60%'],
                            title: "选题学生名单",
                            fixed: false, //不固定
                            maxmin: true,
                            maxmin: false,
                            shadeClose:false,
                            content: $('#stutopiclist'),                            
                    	success : function(layero, index) {
                        $("#coursenames").val(data.coursename);
                        $("#topicids").val(data.topicid);
                        $("#topics").val(data.topic);
                        $("#keywords").val(data.keyword);
                        $("#names").val(data.name);
                        $("#creationtimes").val(data.creationtime);
                        $("#studentnums").val(data.studentnum);

                   			 }
                          });
    } 
  });
});
</script>
</head>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="stutopic"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="studentstutopic.do">
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课程名</label>
			<div class="layui-input-inline">
				<input type="text" name="course_name" id='coursename' required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">主题ID</label>
			<div class="layui-input-inline">
				<input type="text" name="topic_id" id='topicid' required 
				lay-verify="required" placeholder="请输入topic_id" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">主题名</label>
			<div class="layui-input-inline">
				<input type="text" name="topic" id='topic'required 
				lay-verify="required" placeholder="topic" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">关键词</label>
			<div class="layui-input-inline">
				<input type="text" name="keyword" id='keyword'required 
				lay-verify="required" placeholder="请输入keyword" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">出题教师教师姓名</label>
			<div class="layui-input-inline">
				<input type="text" name="name" id='name'required 
				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">创建时间</label>
			<div class="layui-input-inline">
				<input type="text" name="creation_time" id='creationtime'required 
				lay-verify="required" placeholder="请输入creationtime" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">选题人数</label>
			<div class="layui-input-inline">
				<input type="text" name="student_num" id='studentnum'required 
				lay-verify="required" placeholder="请输入studentnum" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">我要读</button>
				
			</div>
		</div>
		
	</form>
</div>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="stutopiclist"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="studentjumpshowstudentstutopiclist.do">
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">课程名</label>
			<div class="layui-input-inline">
				<input type="text" name="course_name" id='coursenames' required 
				lay-verify="required" placeholder="请输入course_name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">主题ID</label>
			<div class="layui-input-inline">
				<input type="text" name="topic_id" id='topicids' required 
				lay-verify="required" placeholder="请输入topic_id" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">主题名</label>
			<div class="layui-input-inline">
				<input type="text" name="topic" id='topics'required 
				lay-verify="required" placeholder="topic" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">关键词</label>
			<div class="layui-input-inline">
				<input type="text" name="keyword" id='keywords'required 
				lay-verify="required" placeholder="请输入keyword" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">出题教师教师姓名</label>
			<div class="layui-input-inline">
				<input type="text" name="name" id='names'required 
				lay-verify="required" placeholder="请输入name" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">创建时间</label>
			<div class="layui-input-inline">
				<input type="text" name="creation_time" id='creationtimes'required 
				lay-verify="required" placeholder="请输入creationtime" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">选题人数</label>
			<div class="layui-input-inline">
				<input type="text" name="student_num" id='studentnums'required 
				lay-verify="required" placeholder="请输入studentnum" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">查看选题学生列表</button>
				
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
		研究生<%User username=(User)session.getAttribute("userid");
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
          <a class="" href="javascript:;">选题管理</a>
          <dl class="layui-nav-child">
            <dd><a href="studentjumpsc.do">选课列表</a></dd>
<!--             <dd><a href="javascript:;">编辑学生</a></dd> -->
<!--             <dd><a href="javascript:;">列表三</a></dd> -->
<!--             <dd><a href="">超链接</a></dd> -->
          </dl>
        </li>
        <li class="layui-nav-item">
          <a href="javascript:;">论文管理</a>
          <dl class="layui-nav-child">
            <dd><a href="studentjumpmytopic.do">我的主题</a></dd>
<!--             <dd><a href="javascript:;">上传论文</a></dd> -->
<!--             <dd><a href="">超链接</a></dd> -->
          </dl>
        </li>

      </ul>
    </div>
  </div>
  
  <div class="layui-body">
<blockquote class="layui-elem-quote"><font color="red">课程主题列表（该课程未选主题可选择主题）</font></blockquote>

    <div style="padding: 15px;">				
    <table class="layui-hide" id="test" lay-filter="test"></table>
 
<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">

  </div>
</script>

<script type="text/html" id="barDemo">
	{{# if(d.studentnum<d.maxnum){ }}
  		<a class="layui-btn layui-btn-xs" lay-event="stutopic">我要读</a>
	{{# } }}
	{{# if(d.studentnum>=d.maxnum){ }}
  		<a class="layui-btn layui-btn-disabled layui-btn-xs" >我要读</a>
	{{# } }}
	<a class="layui-btn layui-btn-xs" lay-event="stutopiclist">选题学生名单</a>
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
