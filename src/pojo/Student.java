package pojo;

public class Student {
	private String student_id;
	private String name;
	private String sex;
	private String major;
	private String classes;
	private String user_id;
	private String course_name;
	public String getStuid() {
		return student_id;
	}
	public void setStuid(String student_id) {
		this.student_id=student_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name=name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex=sex;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major=major;
	}
	public String getClasses() {
		return classes;
	}
	public void setClasses(String classes) {
		this.classes=classes;
	}
	public String getUserid() {
		return user_id;
	}
	public void setUserid(String user_id) {
		this.user_id=user_id;
	}
	public String getCoursename() {
		return course_name;
	}
	public void setCoursename(String course_name) {
		this.course_name=course_name;
	}

}
