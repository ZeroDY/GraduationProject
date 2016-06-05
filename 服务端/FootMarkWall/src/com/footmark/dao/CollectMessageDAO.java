package com.footmark.dao;

import java.util.List;

import com.footmark.model.CollectMessage;

public interface CollectMessageDAO {
	
	/**
	 * 收藏
	 * 用户名；信息ID
	 */
	public boolean collectMessage(String username,long msgid);
	
	/**
	 * 取消收藏
	 * 用户名；信息ID
	 */
	public boolean deleteCollectMessage(CollectMessage collectMessage);
	
	/**
	 * 根据用户名查找全部收藏
	 * 用户名
	 */
	public List<CollectMessage> findAllCollectMessageByUsername(String username);
	
	/**
	 * 根据用户名和id查找收藏
	 * 用户名
	 */
	public CollectMessage findCollectMessageByUsername(String username,long msgid);

}
