package dao;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import pojo.Course;
import pojo.Tc;
import pojo.Teacher;
@Repository("managerDao")
@Mapper
/*使用Spring自动扫描MyBatis的接口并装配
（Spring将指定包中所有被@Mapper注解标注的接口自动装配为MyBatis的映射接口*/
public interface ManagerDao {
	/**
	 * 接口方法对应SQL映射文件UserMapper.xml中的id
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
