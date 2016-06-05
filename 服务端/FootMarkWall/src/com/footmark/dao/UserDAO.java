package com.footmark.dao;

import com.footmark.model.User;

public interface UserDAO {

	/**
	 * 1.用户注册
	 * 参数：userName 用户名;  password 密码 ;  trueName  真实姓名    
	 */
	public boolean register(String userName, String password, String trueName);
	
	/**
	 * 2.用户登录 
	 * 参数：userName 用户名; password 密码
	 */
	public User Login(String userName, String password);
	
	/**
	 * 3.根据用户名查询用户
	 *  参数： username  用户名
	 */
	public User findUserByUserName(String userName);
	
	/**
	 * 4.修改用户信息
	 * 参数：userName 用户名; password 密码;  trueName 真实姓名;  tel  电话; photoURL 头像地址;  userStatus  用户状态
	 */
	public boolean updateUser(String userName, String password,
			String trueName, String tel,String photoURL,int userStatus,int age,String sex);
	
	public boolean updateUser(User user);
	
	/**
	 * 5.修改用户密码
	 * 参数：userName 用户名; password 密码  
	 */
	public boolean updateUserPwd(String userName, String password);
	

}
