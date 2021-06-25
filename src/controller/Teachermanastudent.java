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
	
	@RequestMapping("/teacherjumpstudent.do")//��ʦ�û���ѧ��������
	public String tjs(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		course_id=request.getParameter("course_id");
		String tea_identity = request.getParameter("tea_identity");
		if(tea_identity.equals("������ʦ"))
			return "teachermanastudent";
		return "teachermanastudentnm";
	}
	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/shoukestudentlist.do",method=RequestMethod.GET)//��ʦ�û�ѧ�������ܣ��鿴��ʦ�ÿγ�����ѧ���б�
	public Map<String, Object> getstudentPage(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page��limit��������layui��table���Ĭ���Զ����ݵģ�����ֻ����ռ���
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Stutopic> list = teacherService.selectallshoukestudent(course_id,page, limit);//ִ�з�ҳ��ѯ�ķ���
		PageInfo<Stutopic> userPageInfo = new PageInfo<Stutopic>(list);
		//System.out.println("list������Ϊ��" + list.get(12));
		//System.out.println("pageInfo������Ϊ��" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//������ؼ��Ĵ��룬layui��table���Զ���ȡ����ʾ�����ݼ�
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
	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/teacherpaperlist.do",method=RequestMethod.GET)//��ʦ�û�ѧ�������ܣ��鿴��ʦ�ÿγ�����ѧ���б�
	public Map<String, Object> getpaperlist(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page��limit��������layui��table���Ĭ���Զ����ݵģ�����ֻ����ռ���
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Paper> list = teacherService.selectpaperlist(course_id,student_id,page, limit);//ִ�з�ҳ��ѯ�ķ���
		PageInfo<Paper> userPageInfo = new PageInfo<Paper>(list);
		//System.out.println("list������Ϊ��" + list.get(12));
		//System.out.println("pageInfo������Ϊ��" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//������ؼ��Ĵ��룬layui��table���Զ���ȡ����ʾ�����ݼ�
		return map;
	}
}

