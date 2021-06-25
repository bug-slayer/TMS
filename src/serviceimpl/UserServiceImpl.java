package serviceimpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import dao.UserDao;
import pojo.User;
import service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService{
    @Resource  
    private UserDao userDao; 

	public void insuser(String user_id, String password, int role) {
		User add=new User();
		add.setUserid(user_id);
		add.setPassword(password);
		add.setRole(role);
		int addmanager=userDao.addUser(add);
		
	}


	public boolean loginsuccess(String user_id, String password) {
		String p=userDao.selectpwd(user_id);
		if(password.equals(p))
			return true;
		return false;
	}


	public String selectusertype(String user_id) {
		String role=userDao.selectrole(user_id);
		return role;
	}

}
