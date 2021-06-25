package dao;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import pojo.Course;
import pojo.Paper;
import pojo.Sc;
import pojo.Student;
import pojo.Stutopic;
import pojo.Tc;
import pojo.Topic;

@Repository("teacherDao")
@Mapper
/*使用Spring自动扫描MyBatis的接口并装配
（Spring将指定包中所有被@Mapper注解标注的接口自动装配为MyBatis的映射接*/
public interface TeacherDao {
	/**
	 * 接口方法对应SQL映射文件UserMapper.xml中的id
	 */

	public List<Course> selectallcourse(String user_id);
	public List<Stutopic> selectallshoukestudent(String course_id);
	public List<Topic> selecttopics(String course_id);
	public int addtopic(Topic tp);
	public List<Tc> selectteachers(String course_id);
	public List<Paper> selectpaperlist(Paper p);
	public void upscore(Sc stu);
	public void deletesc(Sc stu);
	public void addsc(Sc stu);
	public List<Student> topicdetails(String topic_id);
	public String selectdetails(String topic_id);
	public int addtc(Tc add);
	public int uptc(Tc et);
	public int deletetc(Tc dtc);
	public String selectcn(String course_id);

}
