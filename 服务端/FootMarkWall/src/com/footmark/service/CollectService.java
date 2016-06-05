package com.footmark.service;

import javax.ws.rs.PathParam;

import com.footmark.tools.ResultObject;

public interface CollectService {
	public static final String KSUCCESS = "1";
    public static final String KFAIL = "0";

    /**
	 * 收藏
	 * 用户名；墙ID
	 */
	public ResultObject collectWall(String username,long wallid);
	
	
	/**
	 * 根据用户名查找全部收藏
	 * 用户名
	 */
	public ResultObject findAllCollectByUsername(String username);
	
	
/////////////////////////////////////////////////////////////////////////////
	/**
	 * 收藏
	 * 用户名；信息ID
	 */
	public ResultObject collectMessage(String username,long msgid);
	
	
	/**
	 * 根据用户名查找全部收藏
	 * 用户名
	 */
	public ResultObject findAllCollectMessageByUsername(String username);
	
	
	public ResultObject findAllCollectWallByUsername(String username);
	
    
}
