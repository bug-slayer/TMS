package serviceimpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;

import dao.TeacherDao;
import pojo.Course;
import pojo.Paper;
import pojo.Sc;
import pojo.Student;
import pojo.Stutopic;
import pojo.Tc;
import pojo.Topic;
import service.TeacherService;

@Service("teacherService")
public class TeacherServiceImpl implements TeacherService{
	@Resource
	private TeacherDao teacherDao; 
	
	public List<Course> selectallcourses(String user_id, Integer page, Integer limit) {
		PageHelper.startPage(page,limit);//设置分页
		List<Course> list=teacherDao.selectallcourse(user_id);
		return list;
	}

	public List<Stutopic> selectallshoukestudent(String course_id, Integer page, Integer limit) {
		PageHelper.startPage(page,limit);//设置分页		
		List<Stutopic> list=teacherDao.selectallshoukestudent(course_id);
		return list;
	}

	public List<Topic> selecttopic(String course_id, Integer page, Integer limit) {
		PageHelper.startPage(page,limit);//设置分页		
		List<Topic> list=teacherDao.selecttopics(course_id);
		return list;
	}

	public void addtopic(String topic_id, String course_id,String topic,String teacher_id, String keyword,String creation_time, Integer student_num,String maxnum) {
		Topic tp=new Topic();
		tp.setTopicid(topic_id);
		tp.setCourseid(course_id);
		tp.setTopic(topic);
		tp.setTeacherid(teacher_id);
		tp.setKeyword(keyword);
		tp.setCreationtime(creation_time);
		tp.setStudentnum(student_num);
		tp.setMaxnum(maxnum);
		int add=teacherDao.addtopic(tp);
	}

	public List<Tc> selectteacher(String course_id, Integer page, Integer limit) {
		PageHelper.startPage(page,limit);//设置分页		
		List<Tc> list=teacherDao.selectteachers(course_id);
		return list;
	}

	public List<Paper> selectpaperlist(String course_id, String student_id, Integer page, Integer limit) {
		Paper p=new Paper();
		p.setCourseid(course_id);
		p.setStudentid(student_id);
		List<Paper>list=teacherDao.selectpaperlist(p);
		return list;
	}

	public void updatescore(String student_id,String course_id, Integer score) {
		Sc stu=new Sc();
		stu.setStudentid(student_id);
		stu.setCourseid(course_id);
		stu.setScore(score);
		teacherDao.upscore(stu);
		
	}

	public void deletesc(String student_id, String course_id) {
		Sc stu=new Sc();
		stu.setStudentid(student_id);
		stu.setCourseid(course_id);
		teacherDao.deletesc(stu);
		
	}

	public void addsc(String student_id, String course_id, Integer score) {
		Sc stu=new Sc();
		stu.setStudentid(student_id);
		stu.setCourseid(course_id);
		stu.setScore(score);
		teacherDao.addsc(stu);
		
	}

	public List<Student> topicdetails(String topic_id, Integer page, Integer limit) {
		PageHelper.startPage(page,limit);//设置分页		
		List<Student> list=teacherDao.topicdetails(topic_id);
		return list;
	}

	public String selectdetails(String topic_id) {
		String de=teacherDao.selectdetails(topic_id);
		return de;
	}

	public void addtc(String course_id, String teacher_id, String tea_identity, Integer teacher_hour) {
		Tc add=new Tc();
		add.setCourseid(course_id);
		add.setTeacherid(teacher_id);
		add.setTeaidentity(tea_identity);
		add.setCoursehour(teacher_hour);
		int tc=teacherDao.addtc(add);
		
	}

	public void edittc(String course_id, String teacher_id, String tea_identity, Integer teacher_hour) {
		Tc et=new Tc();
		et.setCourseid(course_id);
		et.setTeacherid(teacher_id);
		et.setTeaidentity(tea_identity);
		et.setCoursehour(teacher_hour);
		int uptc=teacherDao.uptc(et);
		
	}

	public void deletetc(String course_id, String teacher_id) {
		Tc dtc=new Tc();
		dtc.setCourseid(course_id);
		dtc.setTeacherid(teacher_id);
		int delete=teacherDao.deletetc(dtc);
		
	}

	public String selectcourse_name(String course_id) {
		String course_name=teacherDao.selectcn(course_id);
		return course_name;
	}

}
