package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;

import pojo.Comment;
import pojo.Course;
import pojo.Paper;
import pojo.Student;
import pojo.Stutopic;
import pojo.Topic;
import pojo.User;
import service.StudentService;
import service.TeacherService;

@Controller
@RequestMapping
public class Studentmanacourse {
	@Resource
	private StudentService studentService;
	@Resource
	private TeacherService teacherService;
	
	String student_id=null;
	String course_id=null;
	String topic_ids=null;
	String student_ids=null;
	String paper_id=null;
	
	@RequestMapping("/studentjumpsc.do")//教师用户的主题管理功能
	public String sjsc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		return "loginsuccessstudent";
	}
	@RequestMapping("/studentjumpmytopic.do")//教师用户的主题管理功能
	public String sjmt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		return "studentmanamytopic";
	}
	
	@RequestMapping("/studentshowtopiclist.do")//教师用户的主题管理功能
	public String tjd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		student_id=request.getParameter("student_id");
		course_id = request.getParameter("course_id");
		
 		String ifhas=studentService.ifcoursehaschosentopic(student_id,course_id);
 		if(ifhas!=null)
 			return "studentshowtopiclistseeonly";
		return "studentshowtopiclist";
	}
	
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/studenttopiclist.do",method=RequestMethod.GET)//教师用户主题管理功能，查看该课程主题列表
	public Map<String, Object> studentgettopicPage(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page、limit参数都是layui的table组件默认自动传递的，我们只需接收即可
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Topic> list = teacherService.selecttopic(course_id,page, limit);//执行分页查询的方法
		PageInfo<Topic> userPageInfo = new PageInfo<Topic>(list);
		//System.out.println("list的内容为：" + list.get(12));
		//System.out.println("pageInfo的内容为：" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//最最最关键的代码，layui的table会自动获取并显示该数据集
		return map;
	}

	@RequestMapping("/studentstutopic.do")
	public String doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String topic_id=request.getParameter("topic_id");
    	//产生新的日期对象（使用Date生成
        Date currentTime = new Date();
    	//新建日期格式
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    	//将日期对象格式化成指定格式并以String输出
        String select_time = simpleDateFormat.format(currentTime);
        String flag="0";
 		String sn=request.getParameter("student_num");
 		Integer student_num=Integer.parseInt(sn)+1;

 		studentService.addstutopic(student_id,topic_id,select_time,flag);
 		studentService.uptopicstudentnum(topic_id,student_num);
 		
 		return "loginsuccessstudent";

	}
	
	@RequestMapping("/studentjumpshowstudentstutopiclist.do")//教师用户的主题管理功能
	public String sjssstl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		topic_ids=request.getParameter("topic_id");
		return "studentshowstustudentlist";
	}
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/studentshowstutopiclist.do",method=RequestMethod.GET)//教师用户主题管理功能，查看该课程主题列表
	public Map<String, Object> studentshowstutopiclist(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page、limit参数都是layui的table组件默认自动传递的，我们只需接收即可
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Student> list = studentService.selectstutopicstudentlist(topic_ids,page, limit);//执行分页查询的方法
		PageInfo<Student> userPageInfo = new PageInfo<Student>(list);
		//System.out.println("list的内容为：" + list.get(12));
		//System.out.println("pageInfo的内容为：" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//最最最关键的代码，layui的table会自动获取并显示该数据集
		return map;
	}
	
	@RequestMapping("/studentjumpshowstudentstutopicpaperlist.do")//教师用户的主题管理功能
	public String sjssstpl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		student_ids=request.getParameter("student_id");
		//topic_ids=request.getParameter("topic_id");
		
		return "studentshowstustudentpaperlist";
	}
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/studentshowstutopicpaperlist.do",method=RequestMethod.GET)//教师用户主题管理功能，查看该课程主题列表
	public Map<String, Object> studentshowstutopicpaperlist(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page、limit参数都是layui的table组件默认自动传递的，我们只需接收即可
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Paper> list = studentService.selectstutopicstudentpaperlist(student_ids,topic_ids,page, limit);//执行分页查询的方法
		PageInfo<Paper> userPageInfo = new PageInfo<Paper>(list);
		//System.out.println("list的内容为：" + list.get(12));
		//System.out.println("pageInfo的内容为：" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//最最最关键的代码，layui的table会自动获取并显示该数据集
		return map;
	}
	
	@RequestMapping("/studentjumpcomment.do")//教师用户的主题管理功能
	public String sjc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		paper_id=request.getParameter("paper_id");
		return "studentcomment";
	}
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/studentshowcomment.do",method=RequestMethod.GET)//教师用户主题管理功能，查看该课程主题列表
	public Map<String, Object> studentshowcomment(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page、limit参数都是layui的table组件默认自动传递的，我们只需接收即可
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Comment> list = studentService.selectcomments(paper_id,page, limit);//执行分页查询的方法
		PageInfo<Comment> userPageInfo = new PageInfo<Comment>(list);
		//System.out.println("list的内容为：" + list.get(12));
		//System.out.println("pageInfo的内容为：" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//最最最关键的代码，layui的table会自动获取并显示该数据集
		return map;
	}
	@RequestMapping("/studentaddcomment.do")//教师用户的主题管理功能
	public String sac(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session=request.getSession();
		User username=(User)session.getAttribute("userid");
		String user_id=username.getUserid();
		String comment_content=request.getParameter("comment_content");
		
		studentService.stuaddcomment(paper_id,user_id,comment_content);
		return "studentcomment";
	}
}
