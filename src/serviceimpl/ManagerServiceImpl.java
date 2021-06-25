package serviceimpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;

import dao.ManagerDao;
import pojo.Course;
import pojo.Tc;
import pojo.Teacher;
import service.ManagerService;

@Service("managerService")
public class ManagerServiceImpl implements ManagerService{
	@Resource  
    private ManagerDao managerDao; 
	
	public List<Course> selectallcourses(Integer page, Integer limit) {
		PageHelper.startPage(page,limit);//设置分页
		List<Course> list=managerDao.selectallcourse();
		return list;
	}

	public List<Teacher> selectallteachers(Integer page, Integer limit) {
		PageHelper.startPage(page,limit);//设置分页
		
		List<Teacher> list=managerDao.selectallteacher();
		return list;
	}

	public void addcourse(String course_id, String course_name, String term, Integer course_hour) {
		Course course=new Course();
		course.setCourseid(course_id);
		course.setCoursename(course_name);
		course.setCourseterm(term);
		course.setCoursehour(course_hour);
		int addc=managerDao.addcourse(course);
	}

	public void addteacher(String teacher_id, String name, String sex, String protitle, String phone, String user_id) {
		Teacher teacher=new Teacher();
		teacher.setTeacherid(teacher_id);
		teacher.setTeachername(name);
		teacher.setTeachersex(sex);
		teacher.setTeacherprotitle(protitle);
		teacher.setTeacherphone(phone);
		teacher.setTeacherphone(phone);
		teacher.setUserid(user_id);
		int addt=managerDao.addteacher(teacher);		
	}

	public void updatecourse(String course_id, String course_name, String term, Integer course_hour) {
		Course course=new Course();
		course.setCourseid(course_id);
		course.setCoursename(course_name);
		course.setCourseterm(term);
		course.setCoursehour(course_hour);
		int upc=managerDao.updatecourse(course);		
	}

	public void updateteacher(String teacher_id, String name, String sex, String protitle, String phone,
			String user_id) {
		Teacher teacher=new Teacher();
		teacher.setTeacherid(teacher_id);;
		teacher.setTeachername(name);
		teacher.setTeachersex(sex);;
		teacher.setTeacherprotitle(protitle);
		teacher.setTeacherphone(phone);
		teacher.setUserid(user_id);
		int upc=managerDao.updateteacher(teacher);
		
	}

	public String selectidentity(String course_name) {
		String sliden=managerDao.selectidentity(course_name);
		return sliden;
	}

	public List<Tc> selecttchours(String course_name) {
		List<Tc> list=managerDao.selecttchours(course_name);
		return list;
	}

	public Integer selectcoursehour(String course_name) {
		Integer coursehour=managerDao.selectcoursehour(course_name);
		return coursehour;
	}

	public Integer selecttchour(String teacher_name,String course_name) {
		Tc tc=new Tc();
		tc.setName(teacher_name);
		tc.setCoursename(course_name);
		Integer tchour=managerDao.selecttchour(tc);
		return tchour;
	}

	public List<Course> selectallcoursesdetail(String course_id, Integer page, Integer limit) {
		PageHelper.startPage(page,limit);//设置分页
		List<Course> list=managerDao.selectcoursedetail(course_id);
		return list;
	}

	public void addtc(String course_id, String teacher_id, String tea_identity, Integer teacher_hour) {
		Tc tc=new Tc();
		tc.setCourseid(course_id);
		tc.setTeacherid(teacher_id);
		tc.setTeaidentity(tea_identity);
		tc.setCoursehour(teacher_hour);
		int add=managerDao.addtc(tc);
		
	}

	public String selectcoursename(String course_id) {
		String course_name=managerDao.selectcoursename(course_id);
		return course_name;
	}

}
