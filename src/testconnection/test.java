package testconnection;

import java.sql.*;
public class test {
	public static void main(String [] args)
	{
		String driverName="com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String dbURL="jdbc:sqlserver://localhost:1433;DatabaseName=paper";  //Ҫ���ӵ����ݿ���
		String userName="123456";  //���ݿ��û���
		String userPwd="123456";  //���ݿ�����
		try
		{
			Class.forName(driverName);
			Connection dbConn=DriverManager.getConnection(dbURL,userName,userPwd);
			System.out.println("�������ݿ�ɹ�");
			}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.print("����ʧ��");
			}
		}
	}
