package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;

import pojo.Course;
import pojo.Tc;
import pojo.Teacher;
import service.ManagerService;
import service.TeacherService;



@Controller
@RequestMapping//("/Managermanateacher.do")
public class Managermanateachercontroller {
	@Resource  
    private ManagerService managerService;
	@Resource
	private TeacherService teacherService;
	
	private static final long serialVersionUID = 1L;   
	String userid=null;
	@RequestMapping("/Managermanateacher.do")
	protected String jump() throws Exception {
 		return "managermanageteacher";
	
	}
	@RequestMapping("/Managerjumpaddteacher.do")
	protected String jumpad() throws Exception {
 		return "manageraddteacher";
	
	}
	
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/getallteacher.do",method=RequestMethod.GET)
	public Map<String, Object> getallteacher(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page、limit参数都是layui的table组件默认自动传递的，我们只需接收即可
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Teacher> list = managerService.selectallteachers(page, limit);//执行分页查询的方法
		PageInfo<Teacher> userPageInfo = new PageInfo<Teacher>(list);
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//最最最关键的代码，layui的table会自动获取并显示该数据集
		return map;
	}
	@RequestMapping("/Managerjumptc.do")
	public String  jumpaddcourse(HttpServletRequest request, HttpServletResponse response) throws Exception {
		userid=request.getParameter("user_id");
		return "managershowtc";
	}
	@RequestMapping("/Manageraddteacher.do")
	public String doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String teacher_id=request.getParameter("teacher_id");
 		String name=request.getParameter("name");
 		String sex=request.getParameter("sex");
 		String protitle=request.getParameter("protitle");
 		String phone=request.getParameter("phone");
 		String user_id=request.getParameter("user_id");

 		String course_id=request.getParameter("course_id");
 		String tea_identity=request.getParameter("tea_identity");
 		String th=request.getParameter("teacher_hour");
 		Integer teacher_hour=Integer.parseInt(th);
 		
		Integer total=0;
		String course_name=managerService.selectcoursename(course_id);
		
		String isexist=managerService.selectidentity(course_name);//是否已经有主讲教师
		List<Tc> list=managerService.selecttchours(course_name);
		for(Tc t:list) {
			
			total+=t.getCoursehour();//现有的总授课时数
			
		}
		Integer beforehour=managerService.selecttchour(name,course_name);//更改前该教师的所授课时
		Integer course_hour=managerService.selectcoursehour(course_name);//课程课时
		if(tea_identity.equals("主讲教师")) {
			if((isexist!=null)||((total+teacher_hour)>course_hour))
				return "managermanatckeshi404";
		}
 		if((total+teacher_hour)>course_hour)
 				return "managermanatckeshi404";
 		
 		managerService.addteacher(teacher_id,name,sex,protitle,phone,user_id);
 		managerService.addtc(course_id,teacher_id,tea_identity,teacher_hour);
 		return "managermanageteacher";
 		


	}
	@RequestMapping("/updateteacher.do")
	public String updateteacher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String teacher_id=request.getParameter("teacher_id");
 		String name=request.getParameter("name");
 		String sex=request.getParameter("sex");
 		String protitle=request.getParameter("protitle");
 		String phone=request.getParameter("phone");
 		String user_id=request.getParameter("user_id");

 		managerService.updateteacher(teacher_id,name,sex,protitle,phone,user_id);
 		
 		return "managermanageteacher";

	}
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/managershowtc.do",method=RequestMethod.GET)
	public Map<String, Object> getteachershoukelist(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page、limit参数都是layui的table组件默认自动传递的，我们只需接收即可
		Map<String, Object> map = new HashMap<String, Object>();

		List<Course> list = teacherService.selectallcourses(userid,page, limit);//执行分页查询的方法
		PageInfo<Course> userPageInfo = new PageInfo<Course>(list);
		//System.out.println("list的内容为：" + list.get(12));
		//System.out.println("pageInfo的内容为：" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//最最最关键的代码，layui的table会自动获取并显示该数据集
		return map;
	}
	@RequestMapping("/updatetc.do")
	public String updatc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String course_name=request.getParameter("course_name");
		String thour=request.getParameter("teacher_hour");
		String teacher_name=request.getParameter("name");
		String tea_identity=request.getParameter("tea_identity");
		Integer teacher_hour=Integer.parseInt(thour);
		Integer total=0;

		
		String isexist=managerService.selectidentity(course_name);//是否已经有主讲教师
		List<Tc> list=managerService.selecttchours(course_name);
		for(Tc t:list) {
			
			total+=t.getCoursehour();//现有的总授课时数
			
		}
		Integer beforehour=managerService.selecttchour(teacher_name,course_name);//更改前该教师的所授课时
		Integer course_hour=managerService.selectcoursehour(course_name);//课程课时
		if(tea_identity.equals("主讲教师")) {
			if((isexist!=null)||((total-beforehour+teacher_hour)>course_hour))
				return "managermanatckeshi404";
		}
 		if((total-beforehour+teacher_hour)>course_hour)
 				return "managermanatckeshi404";	
 		return "managermanageteacher";

	}
}
