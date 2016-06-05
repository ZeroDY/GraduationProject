package com.footmark.service;

import javax.ws.rs.PathParam;

import com.footmark.tools.ResultObject;

public interface WallService {

	public static final String KSUCCESS = "1";
    public static final String KFAIL = "0";
	/**
	 * 1、创建墙
	 * Long wallid,wallName 墙名；wallSignature 签名；creator 创建者；wallType 类型； x 经度； y 纬度； wallImage 背景图片地址
	 */
	public ResultObject createWall(Long wallid,String wallName,String wallSignature,String username,Integer wallType, double x,double y,String wallImage,String walladress);
	
	/**
	 * 2、修改墙信息
	 * wallid 墙id；wallName 墙名；wallSignature 签名；creator 创建者；wallType 类型；wallStatus 墙状态； wallImage 背景图片地址
	 */
	public ResultObject updateWall(Long wallid, String wallName,String wallSignature,String wallImage,Integer wallType,int wallStatus);
	
	/**
	 * 3、通过用户名查找用户建立的所有墙
	 * username 用户名
	 */
	public ResultObject findWallsByUserName(String username);
	
	/**
	 * 4、通过id获取墙信息
	 * wallid 墙id
	 */
	public ResultObject findWallByWallid(Long wallid);
	
	/**
	 * 5、通过坐标查找附近的墙
	 *  x 经度； y 纬度；
	 */
	public ResultObject findWallsByXY( double x,double y);
	
	public ResultObject deleteWall(Long wallid, String wallName);
	
}
