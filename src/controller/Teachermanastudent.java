package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;

import pojo.Paper;
import pojo.Stutopic;
import service.TeacherService;

@Controller
@RequestMapping
public class Teachermanastudent{
	@Resource
	private TeacherService teacherService;
	
	String course_id=null;
	String keyword=null;
	String student_id=null;
	
	@RequestMapping("/teacherjumpstudent.do")//教师用户的学生管理功能
	public String tjs(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		course_id=request.getParameter("course_id");
		String tea_identity = request.getParameter("tea_identity");
		if(tea_identity.equals("主讲教师"))
			return "teachermanastudent";
		return "teachermanastudentnm";
	}
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/shoukestudentlist.do",method=RequestMethod.GET)//教师用户学生管理功能，查看教师该课程所授学生列表
	public Map<String, Object> getstudentPage(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page、limit参数都是layui的table组件默认自动传递的，我们只需接收即可
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Stutopic> list = teacherService.selectallshoukestudent(course_id,page, limit);//执行分页查询的方法
		PageInfo<Stutopic> userPageInfo = new PageInfo<Stutopic>(list);
		//System.out.println("list的内容为：" + list.get(12));
		//System.out.println("pageInfo的内容为：" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//最最最关键的代码，layui的table会自动获取并显示该数据集
		return map;
	}
	
	@RequestMapping("/teacheraddstudent.do")
	public String  tas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		student_id=request.getParameter("student_id");
		String s = request.getParameter("score");
		Integer score=Integer.parseInt(s);
		teacherService.addsc(student_id,course_id,score);
		return "teachermanastudent";
	}
	
	@RequestMapping("/teachereditstudent.do")
	public String  tes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		student_id=request.getParameter("student_id");
		String s = request.getParameter("score");
		Integer score=Integer.parseInt(s);
		teacherService.updatescore(student_id,course_id,score);
		return "teachermanastudent";
	}
	
	@RequestMapping("/teacherdeletestudent.do")
	public String  tds(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		student_id=request.getParameter("student_id");

		teacherService.deletesc(student_id,course_id);
		return "teachermanastudent";
	}
	
	@RequestMapping("/teacherpaperlist.do")
	public String  jumppaperlist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		keyword=request.getParameter("keyword");
		student_id=request.getParameter("student_id");
		
		return "teachershowpaperlist";
	}
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/teacherpaperlist.do",method=RequestMethod.GET)//教师用户学生管理功能，查看教师该课程所授学生列表
	public Map<String, Object> getpaperlist(@RequestParam("page")Integer page, 
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
}

