package service;

import java.util.List;

import pojo.Course;
import pojo.Paper;
import pojo.Student;
import pojo.Stutopic;
import pojo.Tc;
import pojo.Topic;

public interface TeacherService {
	public List<Course> selectallcourses(String user_id,Integer page,Integer limit);
	public List<Stutopic> selectallshoukestudent(String course_id, Integer page, Integer limit);
	public List<Topic> selecttopic(String course_id, Integer page, Integer limit);
	public void addtopic(String topic_id, String course_id,String topic,String teacher_id, String keyword,String creation_time, Integer student_num, String maxnum);
	public List<Tc> selectteacher(String course_id, Integer page, Integer limit);
	public List<Paper> selectpaperlist(String course_id, String student_id, Integer page, Integer limit);
	public void updatescore(String student_id, String course_id, Integer score);
	public void deletesc(String student_id, String course_id);
	public void addsc(String student_id, String course_id, Integer score);
	public List<Student> topicdetails(String topic_id, Integer page, Integer limit);
	public String selectdetails(String topic_id);
	public void addtc(String course_id, String teacher_id, String tea_identity, Integer teacher_hour);
	public void edittc(String course_id, String teacher_id, String tea_identity, Integer teacher_hour);
	public void deletetc(String course_id, String teacher_id);
	public String selectcourse_name(String course_id);
	
}
