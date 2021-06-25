package dao;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import pojo.Course;
import pojo.Tc;
import pojo.Teacher;
@Repository("managerDao")
@Mapper
/*ʹ��Spring�Զ�ɨ��MyBatis�Ľӿڲ�װ��
��Spring��ָ���������б�@Mapperע���ע�Ľӿ��Զ�װ��ΪMyBatis��ӳ��ӿ�*/
public interface ManagerDao {
	/**
	 * �ӿڷ�����ӦSQLӳ���ļ�UserMapper.xml�е�id
	 */

	public List<Course> selectallcourse();
	//public List<Course> selectallcourse();
	public List<Teacher> selectallteacher();
	public int addcourse(Course course);
	public int addteacher(Teacher teacher);
	public int updatecourse(Course course);
	public int updateteacher(Teacher teacher);
	public String selectidentity(String course_name);
	public List<Tc> selecttchours(String course_name);
	public Integer selectcoursehour(String course_name);
	public Integer selecttchour(Tc tc);
	public List<Course> selectcoursedetail(String course_id);
	public int addtc(Tc tc);
	public String selectcoursename(String course_id);
}
