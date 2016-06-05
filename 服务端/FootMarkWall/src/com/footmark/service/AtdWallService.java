package com.footmark.service;

import javax.ws.rs.PathParam;

import com.footmark.tools.ResultObject;

public interface AtdWallService {

	public static final String KSUCCESS = "1";
    public static final String KFAIL = "0";
	/**
	 * 1、创建墙
	 * Long wallid,wallName 墙名；wallSignature 签名；creator 创建者；wallType 类型； x 经度； y 纬度； wallImage 背景图片地址
	 */
	public ResultObject createAtdWall(String wallName,String username, double x,double y);
	
	/**
	 * 2、修改墙信息
	 * wallid 墙id；wallName 墙名；wallSignature 签名；creator 创建者；wallType 类型；wallStatus 墙状态； wallImage 背景图片地址
	 */
	public ResultObject updateAtdWall(Long wallid, int wallStatus);
	
	/**
	 * 3、通过用户名查找用户建立的所有墙
	 * username 用户名
	 */
	public ResultObject findAtdWallsByUserName(String username);
	
	/**
	 * 4、通过id获取墙信息
	 * wallid 墙id
	 */
	public ResultObject findAtdWallByWallid(Long wallid);
	
	/**
	 * 5、通过坐标查找附近的墙
	 *  x 经度； y 纬度；
	 */
	public ResultObject findAtdWallsByXY( double x,double y);
	
	public ResultObject deleteWall(Long wallid, String username) ;
}
