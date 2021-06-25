package service;

public interface UserService {
	public void insuser(String user_id,String password,int role);
	public boolean loginsuccess(String user_id, String password);
	public String selectusertype(String user_id);
}
