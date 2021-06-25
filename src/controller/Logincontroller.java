package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;

import pojo.Course;
import pojo.Topic;
import pojo.User;
import service.StudentService;
import service.TeacherService;
import service.UserService;


@Controller
@RequestMapping
public class Logincontroller {

	String user_id=null;
	
	@Resource  
    private UserService userService;
	@Resource
	private TeacherService teacherService;
	@Resource
	private StudentService studentService;
	
	@RequestMapping("/Logincontroller.do")
	public String login(Model medel,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		user_id=request.getParameter("user_id");
 		String password=request.getParameter("password");
 		String loginertype=null;
 		
 		User user=new User();
 		user.setUserid(user_id);
 		
 		HttpSession session=request.getSession();
 		
 			session.setAttribute("userid", user);
 		
 		loginertype=userService.selectusertype(user_id);
 		
 		if(userService.loginsuccess(user_id,password)) {
 	 		if(loginertype.equals("1"))
 	 			//forwardUrl="loginsuccessmanager.jsp"; 
 	 			return "loginsuccessmanager";
 	 		else if(loginertype.equals("2"))
 	 			//forwardUrl="loginsuccessteacher.jsp"; 
 	 			return "loginsuccessteacher";
 	 		else 
 	 			//forwardUrl="loginsuccessstudent.jsp"; 
 	 			return "loginsuccessstudent";
 		}
 		else
 			//forwardUrl="loginfail.jsp";
 			return "loginfail";

	}	
	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/getshoukes.do",method=RequestMethod.GET)
	public Map<String, Object> getteachershoukelist(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page��limit��������layui��table���Ĭ���Զ����ݵģ�����ֻ����ռ���
		Map<String, Object> map = new HashMap<String, Object>();

		List<Course> list = teacherService.selectallcourses(user_id,page, limit);//ִ�з�ҳ��ѯ�ķ���
		PageInfo<Course> userPageInfo = new PageInfo<Course>(list);
		//System.out.println("list������Ϊ��" + list.get(12));
		//System.out.println("pageInfo������Ϊ��" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//������ؼ��Ĵ��룬layui��table���Զ���ȡ����ʾ�����ݼ�
		return map;
	}

	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/getsclist.do",method=RequestMethod.GET)//��ʦ�û�ѧ�������ܣ��鿴��ʦ�ÿγ�����ѧ���б�
	public Map<String, Object> getsclistPage(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page��limit��������layui��table���Ĭ���Զ����ݵģ�����ֻ����ռ���
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Course> list = studentService.selectsclist(user_id,page, limit);//ִ�з�ҳ��ѯ�ķ���
		PageInfo<Course> userPageInfo = new PageInfo<Course>(list);
		//System.out.println("list������Ϊ��" + list.get(12));
		//System.out.println("pageInfo������Ϊ��" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//������ؼ��Ĵ��룬layui��table���Զ���ȡ����ʾ�����ݼ�
		return map;
	}

	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/studentmytopiclist.do",method=RequestMethod.GET)//��ʦ�û���������ܣ��鿴�ÿγ������б�
	public Map<String, Object> studentgetmytopicPage(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page��limit��������layui��table���Ĭ���Զ����ݵģ�����ֻ����ռ���
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Topic> list = studentService.selectmytopics(user_id,page, limit);//ִ�з�ҳ��ѯ�ķ���
		PageInfo<Topic> userPageInfo = new PageInfo<Topic>(list);
		//System.out.println("list������Ϊ��" + list.get(12));
		//System.out.println("pageInfo������Ϊ��" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//������ؼ��Ĵ��룬layui��table���Զ���ȡ����ʾ�����ݼ�
		return map;
	}
	
	@RequestMapping("/teacherjumpteachermana.do")
	public String teacherjumpteachermana() throws ServletException, IOException {

 		return "loginsuccessteacher";

	}	
	

}
