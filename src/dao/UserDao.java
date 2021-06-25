package dao;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import pojo.User;
@Repository("userDao")
@Mapper
/*ʹ��Spring�Զ�ɨ��MyBatis�Ľӿڲ�װ��
��Spring��ָ���������б�@Mapperע���ע�Ľӿ��Զ�װ��ΪMyBatis��ӳ��ӿ�*/
public interface UserDao {
	/**
	 * �ӿڷ�����ӦSQLӳ���ļ�UserMapper.xml�е�id
	 */
	public int addUser(User user);
	public String selectpwd(String user_id);
	public String selectrole(String user_id);
}
