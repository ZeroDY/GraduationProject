package com.footmark.dao;

import java.util.List;

import com.footmark.model.User;
import com.footmark.model.Wall;

public interface WallDAO {
	/**
	 * 1、创建墙
	 *wallid 墙id; wallName 墙名；wallSignature 签名；creator 创建者；wallType 类型； x 经度； y 纬度； wallImage 背景图片地址
	 */
	public boolean createWall(Long wallid,String wallName,String wallSignature,User user,Integer wallType, double x,double y,String wallImage,String walladress);
	
	/**
	 * 2、修改墙信息
	 * wallid 墙id；wallName 墙名；wallSignature 签名；creator 创建者；wallType 类型；wallStatus 墙状态； wallImage 背景图片地址
	 */
	public boolean updateWall(Long wallid, String wallName,String wallSignature,String wallImage,Integer wallType,int wallStatus);
	
	/**
	 * 3、通过用户名查找用户建立的所有墙
	 * username 用户名
	 */
	public List<Wall> findWallsByUserName(String username);
	
	/**
	 * 4、通过id获取墙信息
	 * wallid 墙id
	 */
	public Wall findWallByWallid(Long wallid);
	
	/**
	 * 5、通过坐标查找附近的墙
	 *  x 经度； y 纬度；
	 */
	public List<Wall> findWallsByXY( double x,double y);
	
	public boolean deleteWall(Long wallid);
	
	public boolean updateWallUser(Long wallid, User user);


}
