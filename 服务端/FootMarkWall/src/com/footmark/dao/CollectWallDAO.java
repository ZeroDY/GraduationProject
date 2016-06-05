package com.footmark.dao;

import java.util.List;

import com.footmark.model.CollectWall;
import com.footmark.model.User;
import com.footmark.model.Wall;

public interface CollectWallDAO {
	
	/**
	 * 收藏
	 * 用户名；墙ID
	 */
	public boolean collectWall(String username,Long wallid);
	
	/**
	 * 取消收藏
	 * 用户名；墙ID
	 */
	public boolean deleteCollectWall(CollectWall collectWall);
	
	/**
	 * 根据用户名查找全部收藏
	 * 用户名
	 */
	public List<CollectWall> findAllCollectWallByUsername(String username);
	
	/**
	 * 根据用户名墙id查看是否收藏
	 * 用户名
	 */
	public CollectWall findCollectWallByUsername(String username,long wallid);

}
