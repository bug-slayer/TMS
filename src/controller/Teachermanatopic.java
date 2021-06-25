package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;

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
import pojo.Paper;
import pojo.Student;
import pojo.Topic;
import pojo.User;
import service.StudentService;
import service.TeacherService;

@Controller
@RequestMapping
public class Teachermanatopic {
	@Resource
	private TeacherService teacherService;
	@Resource
	private StudentService studentService;
	
	String course_id=null;
	String topic_id=null;
	String student_id=null;
	String tea_identity=null;
	String name1=null;
	String paper_id=null;
	
	@RequestMapping("/teacherjumptopic.do")//教师用户的主题管理功能
	public String tjt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		course_id=request.getParameter("course_id");
		tea_identity=request.getParameter("tea_identity");//根据教师身份判断是否可以查看所有主题详情
		name1=request.getParameter("name");//授课教师姓名
		
		return "teachermanatopic";
	}
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/topiclist.do",method=RequestMethod.GET)//教师用户主题管理功能，查看该课程主题列表
	public Map<String, Object> teachergettopicPage(@RequestParam("page")Integer page, 
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
	
	@RequestMapping("/teacheraddtopic.do")
	public String doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String topic_id=request.getParameter("topic_id");
 		String topic=request.getParameter("topic");
 		String teacher_id=request.getParameter("teacher_id");
 		String keyword=request.getParameter("keyword");
 		
    	//产生新的日期对象（使用Date生成
        Date currentTime = new Date();
    	//新建日期格式
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    	//将日期对象格式化成指定格式并以String输出
        String creation_time = simpleDateFormat.format(currentTime);
        
 		//String sn=request.getParameter("student_num");
 		Integer student_num=0;
 		String maxnum=request.getParameter("maxnum");
 		
 		teacherService.addtopic(topic_id,course_id,topic,teacher_id,keyword,creation_time,student_num,maxnum);
 		
 		return "teachermanatopic";

	}
	@RequestMapping("/teachertopicdetails.do")//教师用户的主题管理功能
	public String tjd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		topic_id = request.getParameter("topic_id");
		String name2 = request.getParameter("name");//出题教师姓名
		
		String details=teacherService.selectdetails(topic_id);
 		HttpSession session=request.getSession();
 		
			session.setAttribute("topicdetails",details);
		
		
		if(tea_identity.equals("主讲教师")||name1.equals(name2))//如果是主讲教师或者是出题教师可以查看主题详情
			return "teachershowtopicdetails";
		else							//不是主讲教师且不是出题教师无法查看详情
			return "teachermanatopic";
	}
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/topicdetails.do",method=RequestMethod.GET)//教师用户主题管理功能，查看该课程主题列表
	public Map<String, Object> gettopicdetails(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page、limit参数都是layui的table组件默认自动传递的，我们只需接收即可
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Student> list = teacherService.topicdetails(topic_id,page, limit);//执行分页查询的方法
		PageInfo<Student> userPageInfo = new PageInfo<Student>(list);
		//System.out.println("list的内容为：" + list.get(12));
		//System.out.println("pageInfo的内容为：" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//最最最关键的代码，layui的table会自动获取并显示该数据集
		return map;
	}
	
	@RequestMapping("/teacherjumppaperlist.do")//教师用户的主题管理功能
	public String tjpl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		student_id = request.getParameter("student_id");
		
		return "teachershowpaperlist2";
	}
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/teacherpaperlist2.do",method=RequestMethod.GET)//教师用户学生管理功能，查看教师该课程所授学生列表
	public Map<String, Object> getpaperlist2(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page、limit参数都是layui的table组件默认自动传递的，我们只需接收即可
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Paper> list = teacherService.selectpaperlist(course_id,student_id,page, limit);//执行分页查询的方法
		PageInfo<Paper> userPageInfo = new PageInfo<Paper>(list);
		//System.out.println("list的内容为：" + list.get(12));
		//System.out.println("pageInfo的内容为：" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//最最最关键的代码，layui的table会自动获取并显示该数据集
		return map;
	}
	
	@RequestMapping("/teacherjumpcomment.do")//教师用户的主题管理功能
	public String tjc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		paper_id=request.getParameter("paper_id");
		return "teachercomment";
	}
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/teachershowcomment.do",method=RequestMethod.GET)//教师用户主题管理功能，查看该课程主题列表
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
	@RequestMapping("/teacheraddcomment.do")//教师用户的主题管理功能
	public String sac(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session=request.getSession();
		User username=(User)session.getAttribute("userid");
		String user_id=username.getUserid();
		String comment_content=request.getParameter("comment_content");
		
		studentService.stuaddcomment(paper_id,user_id,comment_content);
		return "teachercomment";
	}
}
