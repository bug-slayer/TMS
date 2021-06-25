package pojo;

public class Course {
	private String student_id;
	private String course_id;
	private String course_name;
	private String term;
	private Integer course_hour;
	private String name;
	private String teacher_id;
	private Integer teacher_hour;
	private String tea_identity;
	
	public String getStudentid() {
		return student_id;
	}
	public void setStudentid(String student_id) {
		this.student_id=student_id;
	}
	public String getCourseid() {
		return course_id;
	}
	public void setCourseid(String course_id) {
		this.course_id=course_id;
	}
	public String getCoursename() {
		return course_name;
	}
	public void setCoursename(String course_name) {
		this.course_name=course_name;
	}
	public String getCourseterm() {
		return term;
	}
	public void setCourseterm(String term) {
		this.term=term;
	}
	public Integer getCoursehour() {
		return course_hour;
	}
	public void setCoursehour(Integer course_hour) {
		this.course_hour=course_hour;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name=name;
	}
	public String getTeacherid() {
		return teacher_id;
	}
	public void setTeacherid(String teacher_id) {
		this.teacher_id=teacher_id;
	}
	public Integer getTeacherhour() {
		return teacher_hour;
	}
	public void setTeacherhour(Integer teacher_hour) {
		this.teacher_hour=teacher_hour;
	}
	public String getTeaidentity() {
		return tea_identity;
	}
	public void setTeaidentity(String tea_identity) {
		this.tea_identity=tea_identity;
	}
}
