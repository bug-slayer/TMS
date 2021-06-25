package pojo;

public class User {
	private String user_id;
	private String password;
	private Integer role;
	public String getUserid() {
		return user_id;
	}
	public void setUserid(String user_id) {
		this.user_id=user_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password=password;
	}
	public Integer getRole() {
		return role;
	}
	public void setRole(Integer role) {
		this.role=role;
	}
}
