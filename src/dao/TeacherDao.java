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
/*ʹ��Spring�Զ�ɨ��MyBatis�Ľӿڲ�װ��
��Spring��ָ���������б�@Mapperע���ע�Ľӿ��Զ�װ��ΪMyBatis��ӳ���*/
public interface TeacherDao {
	/**
	 * �ӿڷ�����ӦSQLӳ���ļ�UserMapper.xml�е�id
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
