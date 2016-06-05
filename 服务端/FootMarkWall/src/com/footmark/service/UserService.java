package com.footmark.service;

import javax.ws.rs.PathParam;

import com.footmark.tools.ResultObject;


public interface UserService {

	public static final String KSUCCESS = "1";
    public static final String KFAIL = "0";
	/**
	 * 1.用户注册
	 * 参数：userName 用户名;  password 密码 ;  trueName  真实姓名    
	 */
	public ResultObject register(String userName, String password, String trueName);
	
	/**
	 * 2.用户登录 
	 * 参数：userName 用户名; password 密码
	 */
	public ResultObject Login(String userName, String password);
	
	/**
	 * 3.根据用户名查询用户
	 *  参数： username  用户名
	 */
	public ResultObject findUserByUserName(String userName);
	
	/**
	 * 4.修改用户信息
	 * 参数：userName 用户名; password 密码;  trueName 真实姓名;  tel  电话; photoURL 头像地址;  userStatus  用户状态
	 */
	public ResultObject updateUserTrue(String userName,
			String trueName);
	
	public ResultObject updateUserTel(String userName,String tel);
	public ResultObject updateUserAge(String userName,int age);
	public ResultObject updateUserSex(String userName,String sex);
	public ResultObject updateUserPhotoURL(String userName, String photourl);
	
	/**
	 * 5.修改用户密码
	 * 参数：userName 用户名; password 密码  
	 */
	public ResultObject updateUserPwd(String userName, String password);
}
