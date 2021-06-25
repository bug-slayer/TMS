package service;

import java.util.List;

import pojo.Comment;
import pojo.Course;
import pojo.Paper;
import pojo.Student;
import pojo.Topic;

public interface StudentService {

	public List<Course> selectsclist(String user_id, Integer page, Integer limit);
	public List<Topic> selectmytopics(String user_id, Integer page, Integer limit);
	public void addstutopic(String student_id, String topic_id, String select_time, String flag);
	public void uptopicstudentnum(String topic_id,Integer student_num);
	public String ifcoursehaschosentopic(String student_id, String course_id);
	public List<Student> selectstutopicstudentlist(String topic_id, Integer page, Integer limit);
	public List<Paper> selectstutopicstudentpaperlist(String student_id, String topic_id, Integer page,Integer limit);
	public List<Comment> selectcomments(String paper_id, Integer page, Integer limit);
	public void stuaddcomment(String paper_id, String user_id, String comment_content);

}
