package com.footmark.service;

import com.footmark.tools.ResultObject;

public interface MessageService {

	public static final String KSUCCESS = "1";
    public static final String KFAIL = "0";
    
    /**
	 * 创建
	 * 创建者；所属墙；内容；类型；状态；图片
	 */
	public ResultObject createMessage(long msgid,String username, Long wallid,String msgContent,String msgImage);
	
	/**
	 * 修改
	 * ID；内容；类型；状态；图片
	 */
	public ResultObject updateMessage(long msgid,String msgContent,Integer msgType,Integer msgStatus,String msgImage);
	
	/**
	 * 修改状态
	 * ID；状态
	 */
	public ResultObject updateMessageStatus(long msgid,Integer msgStatus);
	
	/**
	 * 修改类型
	 * ID；类型；
	 */
	public ResultObject updateMessageType(long msgid,Integer msgType);
	
	/**
	 * 通过墙查询
	 * 墙ID；
	 */
	public ResultObject findAllMsgByWallid(long wallid);
	
	/**
	 * 通过用户名查询所有
	 * 用户名；
	 */
	public ResultObject findAllUserMsgByUsername(String username);
	
	/**
	 * 通过用户名和状态查询
	 * 用户名；状态
	 */
	public ResultObject findMsgByUsernameAndStatus(String username,Integer msgStatus);
	
	/**
	 * 通过用户名和类型查询
	 * 用户名；类型
	 */
	public ResultObject findMsgByUsernameAndType(String username,Integer msgType);
	
	/**
	 * 通过信息ID查询信息详细内容
	 * id
	 */
	public ResultObject findMsgByMsgid(long msgid);
}
