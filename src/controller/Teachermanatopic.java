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
	
	@RequestMapping("/teacherjumptopic.do")//��ʦ�û������������
	public String tjt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		course_id=request.getParameter("course_id");
		tea_identity=request.getParameter("tea_identity");//���ݽ�ʦ����ж��Ƿ���Բ鿴������������
		name1=request.getParameter("name");//�ڿν�ʦ����
		
		return "teachermanatopic";
	}
	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/topiclist.do",method=RequestMethod.GET)//��ʦ�û���������ܣ��鿴�ÿγ������б�
	public Map<String, Object> teachergettopicPage(@RequestParam("page")Integer page, 
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
	
	@RequestMapping("/teacheraddtopic.do")
	public String doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String topic_id=request.getParameter("topic_id");
 		String topic=request.getParameter("topic");
 		String teacher_id=request.getParameter("teacher_id");
 		String keyword=request.getParameter("keyword");
 		
    	//�����µ����ڶ���ʹ��Date����
        Date currentTime = new Date();
    	//�½����ڸ�ʽ
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    	//�����ڶ����ʽ����ָ����ʽ����String���
        String creation_time = simpleDateFormat.format(currentTime);
        
 		//String sn=request.getParameter("student_num");
 		Integer student_num=0;
 		String maxnum=request.getParameter("maxnum");
 		
 		teacherService.addtopic(topic_id,course_id,topic,teacher_id,keyword,creation_time,student_num,maxnum);
 		
 		return "teachermanatopic";

	}
	@RequestMapping("/teachertopicdetails.do")//��ʦ�û������������
	public String tjd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		topic_id = request.getParameter("topic_id");
		String name2 = request.getParameter("name");//�����ʦ����
		
		String details=teacherService.selectdetails(topic_id);
 		HttpSession session=request.getSession();
 		
			session.setAttribute("topicdetails",details);
		
		
		if(tea_identity.equals("������ʦ")||name1.equals(name2))//�����������ʦ�����ǳ����ʦ���Բ鿴��������
			return "teachershowtopicdetails";
		else							//����������ʦ�Ҳ��ǳ����ʦ�޷��鿴����
			return "teachermanatopic";
	}
	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/topicdetails.do",method=RequestMethod.GET)//��ʦ�û���������ܣ��鿴�ÿγ������б�
	public Map<String, Object> gettopicdetails(@RequestParam("page")Integer page, 
			@RequestParam("limit")Integer limit){//page��limit��������layui��table���Ĭ���Զ����ݵģ�����ֻ����ռ���
		Map<String, Object> map = new HashMap<String, Object>();
 		
		List<Student> list = teacherService.topicdetails(topic_id,page, limit);//ִ�з�ҳ��ѯ�ķ���
		PageInfo<Student> userPageInfo = new PageInfo<Student>(list);
		//System.out.println("list������Ϊ��" + list.get(12));
		//System.out.println("pageInfo������Ϊ��" + userPageInfo.getTotal());
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", userPageInfo.getTotal());
		map.put("data", userPageInfo.getList());//������ؼ��Ĵ��룬layui��table���Զ���ȡ����ʾ�����ݼ�
		return map;
	}
	
	@RequestMapping("/teacherjumppaperlist.do")//��ʦ�û������������
	public String tjpl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		student_id = request.getParameter("student_id");
		
		return "teachershowpaperlist2";
	}
	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/teacherpaperlist2.do",method=RequestMethod.GET)//��ʦ�û�ѧ�������ܣ��鿴��ʦ�ÿγ�����ѧ���б�
	public Map<String, Object> getpaperlist2(@RequestParam("page")Integer page, 
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
	
	@RequestMapping("/teacherjumpcomment.do")//��ʦ�û������������
	public String tjc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		paper_id=request.getParameter("paper_id");
		return "teachercomment";
	}
	@ResponseBody //�Զ�����json��ʽ������
	@RequestMapping(value="/teachershowcomment.do",method=RequestMethod.GET)//��ʦ�û���������ܣ��鿴�ÿγ������б�
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
	@RequestMapping("/teacheraddcomment.do")//��ʦ�û������������
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
