package pojo;

public class Comment {

	private String paper_id;
	private String user_id;
	private String comment_content;

	public String getPaperid() {
		return paper_id;
	}
	public void setPaperid(String paper_id) {
		this.paper_id=paper_id;
	}
	public String getUserid() {
		return user_id;
	}
	public void setUserid(String user_id) {
		this.user_id=user_id;
	}
	public String getCommentcontent() {
		return comment_content;
	}
	public void setCommentcontent(String comment_content) {
		this.comment_content=comment_content;
	}


}
