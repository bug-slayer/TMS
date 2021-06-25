package serviceimpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;

import dao.StudentDao;
import pojo.Comment;
import pojo.Course;
import pojo.Paper;
import pojo.Sc;
import pojo.Student;
import pojo.Stutopic;
import pojo.Topic;
import service.StudentService;

@Service("studentService")
public class StudentServiceImpl implements StudentService{
	@Resource
	private StudentDao studentDao;

	public List<Course> selectsclist(String user_id, Integer page, Integer limit) {
		PageHelper.startPage(page,limit);//设置分页
		List<Course> list=studentDao.selectsclist(user_id);
		return list;
	}

	public List<Topic> selectmytopics(String user_id, Integer page, Integer limit) {
		PageHelper.startPage(page,limit);//设置分页
		List<Topic> list=studentDao.selectmytopics(user_id);
		return list;
	}

	public void addstutopic(String student_id, String topic_id, String select_time, String flag) {
		Stutopic st=new Stutopic();
		st.setStuid(student_id);
		st.setTopicid(topic_id);
		st.setSelecttime(select_time);
		st.setFlag(flag);
		int add=studentDao.addstutopic(st);
		
	}

	public void uptopicstudentnum(String topic_id,Integer student_num) {
		Topic t=new Topic();
		t.setTopicid(topic_id);
		t.setStudentnum(student_num);
		int up=studentDao.updatestudentnum(t);
		
	}

	public String ifcoursehaschosentopic(String student_id, String course_id) {
		Sc ifhas=new Sc();
		ifhas.setStudentid(student_id);
		ifhas.setCourseid(course_id);
		String ifhasti=studentDao.ifcoursehaschosentopic(ifhas);
		return ifhasti;
	}

	public List<Student> selectstutopicstudentlist(String topic_id, Integer page, Integer limit) {
		PageHelper.startPage(page,limit);//设置分页
		List<Student> list=studentDao.selectstutopicstudentlist(topic_id);
		return list;
	}

	public List<Paper> selectstutopicstudentpaperlist(String student_id, String topic_id, Integer page,
			Integer limit) {
		PageHelper.startPage(page,limit);//设置分页
		Paper p=new Paper();
		p.setStudentid(student_id);
		p.setTopicid(topic_id);
		List<Paper> list=studentDao.selectstutopicstudentpaperlist(p);
		return list;
	}

	public List<Comment> selectcomments(String paper_id, Integer page, Integer limit) {
		PageHelper.startPage(page,limit);//设置分页
		List<Comment> list=studentDao.selectcomments(paper_id);
		return list;
	}

	public void stuaddcomment(String paper_id, String user_id, String comment_content) {
		Comment com=new Comment();
		com.setPaperid(paper_id);
		com.setUserid(user_id);
		com.setCommentcontent(comment_content);
		int add=studentDao.stuaddcomment(com);
		
	}
	
}
