package com.footmark.dao;

import java.util.List;

import com.footmark.model.AtdWall;
import com.footmark.model.User;

public interface AtdWallDAO {

	/**
	 * 1、创建墙
	 */
	public boolean createAtdWall(String atdwallname,User user, double x,double y);
	
	/**
	 * 2、修改墙信息
	 */
	public boolean updateAtdWall(Long wallid, int wallStatus);
	
	/**
	 * 3、通过用户名查找用户建立的所有墙
	 * username 用户名
	 */
	public List<AtdWall> findAtdWallsByUserName(String username);
	
	/**
	 * 4、通过id获取墙信息
	 * wallid 墙id
	 */
	public AtdWall findAtdWallByAtdWallid(Long wallid);
	
	/**
	 * 5、通过坐标查找附近的墙
	 *  x 经度； y 纬度；
	 */
	public List<AtdWall> findAtdAtdWallsByXY( double x,double y);
	
	public boolean deleteAtdWall(Long wallid);
}
