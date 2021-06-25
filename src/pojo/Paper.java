package pojo;

public class Paper {
	private String paper_id;
	private String title;
	private String author;
	private String source;
	private String keyword;
	private String abstracts;
	private String doc_location;
	private String student_id;
	private String uploading_time;
	private String course_id;
	private String topic_id;
	
	public String getPaperid() {
		return paper_id;
	}
	public void setPaperid(String paper_id) {
		this.paper_id=paper_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title=title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author=author;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source=source;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword=keyword;
	}
	public String getAbstracts() {
		return abstracts;
	}
	public void setAbstracts(String abstracts) {
		this.abstracts=abstracts;
	}
	public String getDocl() {
		return doc_location;
	}
	public void setDocl(String doc_location) {
		this.doc_location=doc_location;
	}
	public String getStudentid() {
		return student_id;
	}
	public void setStudentid(String student_id) {
		this.student_id=student_id;
	}
	public String getUptime() {
		return uploading_time;
	}
	public void setUptime(String uploading_time) {
		this.uploading_time=uploading_time;
	}
	public String getcourseid() {
		return course_id;
	}
	public void setCourseid(String course_id) {
		this.course_id=course_id;
	}
	public String getTopicid() {
		return topic_id;
	}
	public void setTopicid(String topic_id) {
		this.topic_id=topic_id;
	}
}
