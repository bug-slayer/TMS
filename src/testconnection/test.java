package testconnection;

import java.sql.*;
public class test {
	public static void main(String [] args)
	{
		String driverName="com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String dbURL="jdbc:sqlserver://localhost:1433;DatabaseName=paper";  //要连接的数据库名
		String userName="123456";  //数据库用户名
		String userPwd="123456";  //数据库密码
		try
		{
			Class.forName(driverName);
			Connection dbConn=DriverManager.getConnection(dbURL,userName,userPwd);
			System.out.println("连接数据库成功");
			}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.print("连接失败");
			}
		}
	}
