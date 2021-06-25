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
<script src="layui/excel.js"></script>
<script src="layui/excel.min.js"></script>
<script>
layui.use(['table','element', 'excel'], function(){
        var 	$=layui.$,
        table=layui.table,
        layuimini=layui.layuimini,
        layer=layui.layer,
  			 element = layui.element,
  			 excel = layui.excel;
  			 
    /**
   * 上传excel的处理函数，传入文件对象数组
   * @param  {FileList} files [description]
   * @return {[type]}       [description]
   */
  function uploadExcel(files) {
    try {
      excel.importExcel(files, {
        // 可以在读取数据的同时梳理数据
        /*fields: {
          'id': 'A'
          , 'username': 'B'
          , 'experience': 'C'
          , 'sex': 'D'
          , 'score': 'E'
          , 'city': 'F'
          , 'classify': 'G'
          , 'wealth': 'H'
          , 'sign': 'I'
        }*/
      }, function (data, book) {
        // data: {1: {sheet1: [{id: 1, name: 2}, {...}]}}// 工作表的数据对象
        // book: {1: {Sheets: {}, Props: {}, ....}} // 工作表的整个原生对象，https://github.com/SheetJS/js-xlsx#workbook-object
        // 也可以全部读取出来再进行数据梳理
/*        data = excel.filterImportData(data, {
          'id': 'A'
          , 'username': 'B'
          , 'experience': 'C'
          , 'sex': 'D'
          , 'score': 'E'
          , 'city': 'F'
          , 'classify': 'G'
          , 'wealth': 'H'
          , 'sign': 'I'
        })*/
        // 如果不需要展示直接上传，可以再次 $.ajax() 将JSON数据通过 JSON.stringify() 处理后传递到后端即可
        /**
         * 2019-06-21 JeffreyWang 应群友需求，加一个单元格合并还原转换
         * 思路：
         * 1. 渲染时为每个cell加上唯一的ID，demo里边采用 table-export-文件索引-sheet名称-行索引-列索引
         * 2. 根据 book[文件索引].Sheets[sheet名称]['!merge'] 参数，取左上角元素设置 colspan 以及 rowspan，并删除其他元素
         */
        layer.open({
          title: '文件转换结果'
          , area: ['799px', '399px']
          , tipsMore: true
          , content: laytpl($('#LAY-excel-export-ans').html()).render({data: data, files: files})
          , success: function () {
            element.render('tab')
            layui.code({})
            // 处理合并
            for (var file_index in book) {
              if (!book.hasOwnProperty(file_index)) {
                continue
              }
              // 遍历每个Sheet
              for (var sheet_name in book[file_index].Sheets) {
                if (!book[file_index].Sheets.hasOwnProperty(sheet_name)) {
                  continue
                }
                var sheetObj = book[file_index].Sheets[sheet_name]
                // 仅在有合并参数时进行操作
                if (!sheetObj['!merges']) {
                  continue
                }
                // 遍历每个Sheet中每个 !merges
                for (var merge_index = 0; merge_index < sheetObj['!merges'].length; merge_index++) {
                  var mergeObj = sheetObj['!merges'][merge_index]
                  // 每个合并参数的 s.c 表示左上角单元格的列，s.r 表示左上角单元格的行，e.c 表示右下角单元格的列，e.r 表示右下角单元格的行，计算时注意 + 1
                  $('#table-export-' + file_index + '-' + sheet_name + '-' + mergeObj.s.r + '-' + mergeObj.s.c)
                    .prop('rowspan', mergeObj.e.r - mergeObj.s.r + 1)
                    .prop('colspan', mergeObj.e.c - mergeObj.s.c + 1)
                  for (var r = mergeObj.s.r; r <= mergeObj.e.r; r++) {
                    for (var c = mergeObj.s.c; c <= mergeObj.e.c; c++) {
                      // 排除左上角
                      if (r === mergeObj.s.r && c === mergeObj.s.c) {
                        continue
                      }
                      $('#table-export-' + file_index + '-' + sheet_name + '-' + r + '-' + c).remove()
                    }
                  }
                }
              }
            }
          }
        })
      })
    } catch (e) {
      layer.alert(e.message)
    }
  }
  table.render({
    elem: '#test'
    ,url:'studentmytopiclist.do'//在Logincontroller中从而获取用户名，根据其查询授课列表
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
      ,{field:'studentnum', title:'选题人数', width:120, sort: true}

     // ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:100}
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
//   table.on('tool(test)', function(obj){
//     var data = obj.data;
//     //console.log(obj)
//     if(obj.event === 'uploadpaper'){
//     $('#LAY-excel-import-excel').change(function(e) {
//         var files = e.target.files;
//         try {
//             // 方式一：先读取数据，后梳理数据
// //             excel.importExcel(files, {}, function(data) {
// //                 console.log(data);
// //                 data = excel.filterImportData(data, {
// //                     'id': 'A'
// //                     ,'username': 'B'
// //                     ,'experience': 'C'
// //                     ,'sex': 'D'
// //                     ,'score': 'E'
// //                     ,'city': 'F'
// //                     ,'classify': 'G'
// //                     ,'wealth': 'H'
// //                     ,'sign': 'I'
// //                 })
// //                 console.log(data);
// //             });
//             // 方式二：可以在读取过程中梳理数据
//             excel.importExcel(files, {
//                 fields: {
//                     'coursename': 'A'
//                     ,'topicid': 'B'
//                     ,'topic': 'C'
//                     ,'keyword': 'D'
//                     ,'name': 'E'
//                     ,'creationtime': 'F'
//                     ,'studentnum': 'G'
// //                     ,'wealth': 'H'
// //                     ,'sign': 'I'
//                 }
//             }, function(data) {
//                 console.log(data);
//             });
//         } catch (e) {
//             layer.alert(e.message);
//         }
//     });
//     } 
//   });
$(function () {
    // 监听上传文件的事件
    $('#LAY-excel-import-excel').change(function (e) {
      // 注意：这里直接引用 e.target.files 会导致 FileList 对象在读取之前变化，导致无法弹出文件
      var files = Object.values(e.target.files)
      uploadExcel(files)
      // 变更完清空，否则选择同一个文件不触发此事件
      e.target.value = ''
    })
    // 文件拖拽
    document.body.ondragover = function (e) {
      e.preventDefault()
    }
    document.body.ondrop = function (e) {
      e.preventDefault()
      var files = e.dataTransfer.files
      uploadExcel(files)
    }
    // 2019-08-17 页面直接展示所有demo
    renderDemoList()

  })


});

</script>

</head>
<div class="site-text" style="position:relative;left:20%;margin: 5%; display: none" id="uploadpaper"  target="test123">	
	<form class="layui-form layui-form-pane" method="post" action="teachertopicdetails.do">
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
				<input type="text" name="creationtime" id='creationtime'required 
				lay-verify="required" placeholder="请输入creationtime" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label layui-bg-red">选题人数</label>
			<div class="layui-input-inline">
				<input type="text" name="studentnum" id='studentnum'required 
				lay-verify="required" placeholder="请输入studentnum" autocomplete="off" class="layui-input" readonly>
			</div>
			<div class="layui-form-mid layui-word-aux">（不可编辑）</div>
		</div>
		<br>
		<br>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">进入上传论文页面</button>
				
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
        <li class="layui-nav-item ">
          <a class="" href="javascript:;">选题管理</a>
          <dl class="layui-nav-child">
            <dd><a href="studentjumpsc.do">选课列表</a></dd>
<!--             <dd><a href="javascript:;">编辑学生</a></dd> -->
<!--             <dd><a href="javascript:;">列表三</a></dd> -->
<!--             <dd><a href="">超链接</a></dd> -->
          </dl>
        </li>
        <li class="layui-nav-item layui-nav-itemed">
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
<blockquote class="layui-elem-quote"><font color="red">我的主题列表</font></blockquote>

    <div style="padding: 15px;">				
    <table class="layui-hide" id="test" lay-filter="test"></table>
    
		<div class="layui-form-item">
					<div class="layui-form-label">导入Excel</div>
					<div class="layui-form-block">
						<input type="file" class="layui-btn layui-btn-primary" id="LAY-excel-import-excel" multiple="multiple">
					</div>
		</div>
				
<script type="text/html" id="LAY-excel-export-ans">
	{{# layui.each(d.data, function(file_index, item){ }}
		<blockquote class="layui-elem-quote">{{d.files[file_index].name}}</blockquote>
		<div class="layui-tab">
		  <ul class="layui-tab-title">
		  	{{# layui.each(item, function(sheet_name, content) { }}
			    <li>{{sheet_name}}</li>
		  	{{# }); }}
		  </ul>
		  <div class="layui-tab-content">
		  	{{# layui.each(item, function(sheet_name, content) { }}
			    <div class="layui-tab-item">
						<table class="layui-table">
							{{# layui.each(content, function(row_index, value) { }}
                {{# var col_index = 0 }}
								<tr>
									{{# layui.each(value, function(col_key, val) { }}
									<td id="table-export-{{file_index}}-{{sheet_name}}-{{row_index}}-{{col_index++}}">{{val}}</td>
									{{# });}}
								</tr>
							{{# });}}
						</table>
						<pre class="layui-code">{{JSON.stringify(content, null, 2)}}</pre>
					</div>
		  	{{# }); }}
		  </div>
		</div>
	{{# }) }}
</script>			
<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">

  </div>
</script>
 
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="uploadpaper">上传论文</a>

</script></div>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © 计算机18-2 张青峰
  </div>
</div>

</body>
</html>
