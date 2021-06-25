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
	
	@RequestMapping("/studentjumpsc.do")//��ʦ�û������������
	public String sjsc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		return "loginsuccessstudent";
	}
	@RequestMapping("/studentjumpmytopic.do")//��ʦ�û������������
	public String sjmt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		return "studentmanamytopic";
	}
	
	@RequestMapping("/studentshowtopiclist.do")//��ʦ�û������������
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
	
	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/studenttopiclist.do",method=RequestMethod.GET)//��ʦ�û���������ܣ��鿴�ÿγ������б�
	public Map<String, Object> studentgettopicPage(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page��limit��������layui��table���Ĭ���Զ����ݵģ�����ֻ����ռ���
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Topic> list = teacherService.selecttopic(course_id,page, limit);//ִ�з�ҳ��ѯ�ķ���
		PageInfo<Topic> userPageInfo = new PageInfo<Topic>(list);
		//System.out.println("list������Ϊ��" + list.get(12));
		//System.out.println("pageInfo������Ϊ��" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//������ؼ��Ĵ��룬layui��table���Զ���ȡ����ʾ�����ݼ�
		return map;
	}

	@RequestMapping("/studentstutopic.do")
	public String doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String topic_id=request.getParameter("topic_id");
    	//�����µ����ڶ���ʹ��Date����
        Date currentTime = new Date();
    	//�½����ڸ�ʽ
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    	//�����ڶ����ʽ����ָ����ʽ����String���
        String select_time = simpleDateFormat.format(currentTime);
        String flag="0";
 		String sn=request.getParameter("student_num");
 		Integer student_num=Integer.parseInt(sn)+1;

 		studentService.addstutopic(student_id,topic_id,select_time,flag);
 		studentService.uptopicstudentnum(topic_id,student_num);
 		
 		return "loginsuccessstudent";

	}
	
	@RequestMapping("/studentjumpshowstudentstutopiclist.do")//��ʦ�û������������
	public String sjssstl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		topic_ids=request.getParameter("topic_id");
		return "studentshowstustudentlist";
	}
	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/studentshowstutopiclist.do",method=RequestMethod.GET)//��ʦ�û���������ܣ��鿴�ÿγ������б�
	public Map<String, Object> studentshowstutopiclist(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page��limit��������layui��table���Ĭ���Զ����ݵģ�����ֻ����ռ���
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Student> list = studentService.selectstutopicstudentlist(topic_ids,page, limit);//ִ�з�ҳ��ѯ�ķ���
		PageInfo<Student> userPageInfo = new PageInfo<Student>(list);
		//System.out.println("list������Ϊ��" + list.get(12));
		//System.out.println("pageInfo������Ϊ��" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//������ؼ��Ĵ��룬layui��table���Զ���ȡ����ʾ�����ݼ�
		return map;
	}
	
	@RequestMapping("/studentjumpshowstudentstutopicpaperlist.do")//��ʦ�û������������
	public String sjssstpl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		student_ids=request.getParameter("student_id");
		//topic_ids=request.getParameter("topic_id");
		
		return "studentshowstustudentpaperlist";
	}
	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/studentshowstutopicpaperlist.do",method=RequestMethod.GET)//��ʦ�û���������ܣ��鿴�ÿγ������б�
	public Map<String, Object> studentshowstutopicpaperlist(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page��limit��������layui��table���Ĭ���Զ����ݵģ�����ֻ����ռ���
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Paper> list = studentService.selectstutopicstudentpaperlist(student_ids,topic_ids,page, limit);//ִ�з�ҳ��ѯ�ķ���
		PageInfo<Paper> userPageInfo = new PageInfo<Paper>(list);
		//System.out.println("list������Ϊ��" + list.get(12));
		//System.out.println("pageInfo������Ϊ��" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//������ؼ��Ĵ��룬layui��table���Զ���ȡ����ʾ�����ݼ�
		return map;
	}
	
	@RequestMapping("/studentjumpcomment.do")//��ʦ�û������������
	public String sjc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		paper_id=request.getParameter("paper_id");
		return "studentcomment";
	}
	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/studentshowcomment.do",method=RequestMethod.GET)//��ʦ�û���������ܣ��鿴�ÿγ������б�
	public Map<String, Object> studentshowcomment(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page��limit��������layui��table���Ĭ���Զ����ݵģ�����ֻ����ռ���
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Comment> list = studentService.selectcomments(paper_id,page, limit);//ִ�з�ҳ��ѯ�ķ���
		PageInfo<Comment> userPageInfo = new PageInfo<Comment>(list);
		//System.out.println("list������Ϊ��" + list.get(12));
		//System.out.println("pageInfo������Ϊ��" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//������ؼ��Ĵ��룬layui��table���Զ���ȡ����ʾ�����ݼ�
		return map;
	}
	@RequestMapping("/studentaddcomment.do")//��ʦ�û������������
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
