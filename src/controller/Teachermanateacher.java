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
	
	@RequestMapping("/teacherjumpteacher.do")//��ʦ�û������������
	public String tjt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		course_id=request.getParameter("course_id");
		tea_identity=request.getParameter("tea_identity");
		
		if(tea_identity.equals("������ʦ"))
			return "teachermanateacher";
		else
			return "teachermanateachernm";
	}
	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/teacherlist.do",method=RequestMethod.GET)//��ʦ�û���������ܣ��鿴�ÿγ������б�
	public Map<String, Object> getteacherPage(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page��limit��������layui��table���Ĭ���Զ����ݵģ�����ֻ����ռ���
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Tc> list = teacherService.selectteacher(course_id,page, limit);//ִ�з�ҳ��ѯ�ķ���
		PageInfo<Tc> userPageInfo = new PageInfo<Tc>(list);
		//System.out.println("list������Ϊ��" + list.get(12));
		//System.out.println("pageInfo������Ϊ��" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//������ؼ��Ĵ��룬layui��table���Զ���ȡ����ʾ�����ݼ�
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
		String isexist=managerService.selectidentity(course_name);//�Ƿ��Ѿ���������ʦ
		List<Tc> list=managerService.selecttchours(course_name);
		for(Tc t:list) {		
			total+=t.getCoursehour();//���е����ڿ�ʱ��	
		}

		Integer course_hour=managerService.selectcoursehour(course_name);//�γ̿�ʱ
		if(tea_identity.equals("������ʦ")) {
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
		String isexist=managerService.selectidentity(course_name);//�Ƿ��Ѿ���������ʦ
		List<Tc> list=managerService.selecttchours(course_name);
		for(Tc t:list) {		
			total+=t.getCoursehour();//���е����ڿ�ʱ��	
		}
		Integer beforehour=managerService.selecttchour(teacher_name,course_name);//����ǰ�ý�ʦ�����ڿ�ʱ
		Integer course_hour=managerService.selectcoursehour(course_name);//�γ̿�ʱ
		if(tea_identity.equals("������ʦ")) {
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
