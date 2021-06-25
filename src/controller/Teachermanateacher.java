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

import com.github.pagehelper.PageInfo;

import pojo.Tc;
import pojo.Teacher;
import pojo.Topic;
import service.ManagerService;
import service.TeacherService;

@Controller
@RequestMapping
public class Teachermanateacher {
	@Resource
	private TeacherService teacherService;
	@Resource
	private ManagerService managerService;
	
	String course_id=null;
	String tea_identity=null;
	Integer course_hour=null;
	
	@RequestMapping("/teacherjumpteacher.do")//教师用户的主题管理功能
	public String tjt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		course_id=request.getParameter("course_id");
		tea_identity=request.getParameter("tea_identity");
		
		if(tea_identity.equals("主讲教师"))
			return "teachermanateacher";
		else
			return "teachermanateachernm";
	}
	@ResponseBody //自动返回json格式的数据
	@RequestMapping(value="/teacherlist.do",method=RequestMethod.GET)//教师用户主题管理功能，查看该课程主题列表
	public Map<String, Object> getteacherPage(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page、limit参数都是layui的table组件默认自动传递的，我们只需接收即可
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Tc> list = teacherService.selectteacher(course_id,page, limit);//执行分页查询的方法
		PageInfo<Tc> userPageInfo = new PageInfo<Tc>(list);
		//System.out.println("list的内容为：" + list.get(12));
		//System.out.println("pageInfo的内容为：" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//最最最关键的代码，layui的table会自动获取并显示该数据集
		return map;
	}
	
	@RequestMapping("/teaaddtea.do")
	public String doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

 		String teacher_id=request.getParameter("teacher_id");
 		String tea_identity=request.getParameter("tea_identity");
 		String th=request.getParameter("teacher_hour");
 		Integer teacher_hour=Integer.parseInt(th);
 		String course_name=teacherService.selectcourse_name(course_id);
 		
 		Integer total=0;
		String isexist=managerService.selectidentity(course_name);//是否已经有主讲教师
		List<Tc> list=managerService.selecttchours(course_name);
		for(Tc t:list) {		
			total+=t.getCoursehour();//现有的总授课时数	
		}

		Integer course_hour=managerService.selectcoursehour(course_name);//课程课时
		if(tea_identity.equals("主讲教师")) {
			if((isexist!=null)||((total+teacher_hour)>course_hour))
				return "managermanatckeshi404";
		}
 		if((total+teacher_hour)>course_hour)
 				return "managermanatckeshi404";	
 		
 		teacherService.addtc(course_id,teacher_id,tea_identity,teacher_hour);
 		return "teachermanateacher";
	}
	@RequestMapping("/teaedittea.do")
	public String tet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

 		String teacher_id=request.getParameter("teacher_id");
 		String tea_identity=request.getParameter("tea_identity");
 		String th=request.getParameter("teacher_hour");
 		Integer teacher_hour=Integer.parseInt(th);
 		String course_name=request.getParameter("course_name");
 		String teacher_name=request.getParameter("name");
 		
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
 		
 		teacherService.edittc(course_id,teacher_id,tea_identity,teacher_hour);
 		return "teachermanateacher";
 		

	}
	@RequestMapping("/teadeletetea.do")
	public String tdt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

 		String teacher_id=request.getParameter("teacher_id");

 		teacherService.deletetc(course_id,teacher_id);
 		
 		return "teachermanateacher";
	}
}
