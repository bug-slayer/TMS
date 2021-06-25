package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;

import pojo.Course;
import pojo.Teacher;
import service.ManagerService;

@Controller
@RequestMapping//("/Managermanacourse.do")
//@ResponseBody //自动返回json格式的数据
public class Managermanacoursecontroller{
	
	@Resource  
    private ManagerService managerService;
	
	private String course_id=null;
	
	@RequestMapping("/Managermanacourse.do")
	public String  jump(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		return "managermanagecourse";
	}

	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/getcoursess",method=RequestMethod.GET)
	public Map<String, Object> getPage(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page、limit参数都是layui的table组件默认自动传递的，我们只需接收即可
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Course> list = managerService.selectallcourses(page, limit);//执行分页查询的方法
		PageInfo<Course> userPageInfo = new PageInfo<Course>(list);
		//System.out.println("list的内容为：" + list.get(12));
		//System.out.println("pageInfo的内容为：" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//最最最关键的代码，layui的table会自动获取并显示该数据集
		return map;
	}

	@RequestMapping("/Managerjumpaddcourse.do")
	public String  jumpaddcourse() throws Exception {
		
		return "manageraddcourse";
	}
	@RequestMapping("/Manageraddcourse.do")
	public String doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String course_id=request.getParameter("course_id");
 		String course_name=request.getParameter("course_name");
 		String term=request.getParameter("term");
 		String hour=request.getParameter("course_hour");
 		Integer course_hour=Integer.parseInt(hour);

		managerService.addcourse(course_id,course_name,term,course_hour);
 		
 		return "managermanagecourse";

	}
	@RequestMapping("/updatecourse.do")
	public String updatecourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String course_id=request.getParameter("course_id");
 		String course_name=request.getParameter("course_name");
 		String term=request.getParameter("term");
 		String hour=request.getParameter("course_hour");
 		Integer course_hour=Integer.parseInt(hour);

 		managerService.updatecourse(course_id,course_name,term,course_hour);
 		
 		return "managermanagecourse";

	}
	
	@RequestMapping("/managercoursedetail.do")
	public String  jumpaddcoursedetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		course_id=request.getParameter("course_id");
		return "managermanagecoursedetail";
	}
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/getcoursedetail.do",method=RequestMethod.GET)
	public Map<String, Object> getcdPage(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page、limit参数都是layui的table组件默认自动传递的，我们只需接收即可
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Course> list = managerService.selectallcoursesdetail(course_id,page, limit);//执行分页查询的方法
		PageInfo<Course> userPageInfo = new PageInfo<Course>(list);
		//System.out.println("list的内容为：" + list.get(12));
		//System.out.println("pageInfo的内容为：" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//最最最关键的代码，layui的table会自动获取并显示该数据集
		return map;
	}
}

