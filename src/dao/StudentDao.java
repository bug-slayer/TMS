package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import pojo.Comment;
import pojo.Course;
import pojo.Paper;
import pojo.Sc;
import pojo.Student;
import pojo.Stutopic;
import pojo.Topic;

@Repository("studentDao")
@Mapper
public interface StudentDao {

	public List<Course> selectsclist(String user_id);
	public List<Topic> selectmytopics(String user_id);
	public int addstutopic(Stutopic st);
	public int updatestudentnum(Topic t);
	public String ifcoursehaschosentopic(Sc ifhas);
	public List<Student> selectstutopicstudentlist(String topic_id);
	public List<Paper> selectstutopicstudentpaperlist(Paper p);
	public List<Comment> selectcomments(String paper_id);
	public int stuaddcomment(Comment com);

}
