package service;

import java.util.List;

import pojo.Course;
import pojo.Tc;
import pojo.Teacher;

public interface ManagerService {
	public List<Course> selectallcourses(Integer page,Integer limit);
	public List<Teacher> selectallteachers(Integer page,Integer limit);
	public void addcourse(String course_id, String course_name, String term, Integer course_hour);
	public void addteacher(String teacher_id, String name, String sex, String protitle, String phone, String user_id);
	public void updatecourse(String course_id, String course_name, String term, Integer course_hour);
	public void updateteacher(String teacher_id, String name, String sex, String protitle, String phone,String user_id);
	public String selectidentity(String course_name);
	public List<Tc> selecttchours(String course_name);
	public Integer selectcoursehour(String course_name);
	public Integer selecttchour(String teacher_name, String course_name);
	public List<Course> selectallcoursesdetail(String course_id, Integer page, Integer limit);
	public void addtc(String course_id, String teacher_id, String tea_identity, Integer teacher_hour);
	public String selectcoursename(String course_id);
	
}
