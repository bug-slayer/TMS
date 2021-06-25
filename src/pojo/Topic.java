package pojo;

public class Topic {
	private String topic_id;
	private String course_id;
	private String topic;
	private String keyword;
	private String name;
	private String teacher_id;
	private String creation_time;
	private Integer student_num;
	private String course_name;
	private String details;
	private String maxnum;
	public String getTopicid() {
		return topic_id;
	}
	public void setTopicid(String topic_id) {
		this.topic_id=topic_id;
	}
	public String getCourseid() {
		return course_id;
	}
	public void setCourseid(String course_id) {
		this.course_id=course_id;
	}
	public String getTopic() {
		return topic;
	}
	public void setTopic(String topic) {
		this.topic=topic;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword=keyword;
	}
	public String getTeacherid() {
		return teacher_id;
	}
	public void setTeacherid(String teacher_id) {
		this.teacher_id=teacher_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name=name;
	}
	public String getCreationtime() {
		return creation_time;
	}
	public void setCreationtime(String creation_time) {
		this.creation_time=creation_time;
	}
	public Integer getStudentnum() {
		return student_num;
	}
	public void setStudentnum(Integer student_num) {
		this.student_num=student_num;
	}
	public String getCoursename() {
		return course_name;
	}
	public void setCoursename(String course_name) {
		this.course_name=course_name;
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details=details;
	}
	public String getMaxnum() {
		return maxnum;
	}
	public void setMaxnum(String maxnum) {
		this.maxnum=maxnum;
	}

}
