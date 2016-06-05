package com.footmark.dao;

import java.util.List;

import com.footmark.model.Message;
import com.footmark.model.User;
import com.footmark.model.Wall;

public interface MessageDAO {
	/**
	 * 创建
	 * 创建者；所属墙；内容；类型；状态；图片
	 */
	public boolean createMessage(long msgid,User user, Wall wall,String msgContent,String msgImage);
	
	/**
	 * 修改
	 * ID；内容；类型；状态；图片
	 */
	public boolean updateMessage(long msgid,String msgContent,Integer msgType,Integer msgStatus,String msgImage);
	
	/**
	 * 修改状态
	 * ID；状态
	 */
	public boolean updateMessageStatus(long msgid,Integer msgStatus);
	
	/**
	 * 修改类型
	 * ID；类型；
	 */
	public boolean updateMessageType(long msgid,Integer msgType);
	
	/**
	 * 通过墙查询
	 * 墙ID；
	 */
	public List<Message> findAllMsgByWallid(long wallid);
	
	/**
	 * 通过用户名查询所有
	 * 用户名；
	 */
	public List<Message> findAllUserMsgByUsername(String username);
	
	/**
	 * 通过用户名和状态查询
	 * 用户名；状态
	 */
	public List<Message> findMsgByUsernameAndStatus(String username,Integer msgStatus);
	
	/**
	 * 通过用户名和类型查询
	 * 用户名；类型
	 */
	public List<Message> findMsgByUsernameAndType(String username,Integer msgType);
	
	/**
	 * 通过信息ID查询信息详细内容
	 * id
	 */
	public Message findMsgByMsgid(long msgid);
	
	
	
	public boolean deleteMsgByWallid(Long wallid) ;
	
	public boolean deleteMsgByWallidAndUser(Long wallid,String username);
	
	
	
	
	
	
	
	
	
	
	
}
