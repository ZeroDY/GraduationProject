package com.footmark.service.impl;

import java.util.Collections;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import com.footmark.dao.MessageDAO;
import com.footmark.dao.UserDAO;
import com.footmark.dao.WallDAO;
import com.footmark.dao.impl.MessageDAOImpl;
import com.footmark.dao.impl.UserDAOImpl;
import com.footmark.dao.impl.WallDAOImpl;
import com.footmark.model.Message;
import com.footmark.model.User;
import com.footmark.model.Wall;
import com.footmark.service.WallService;
import com.footmark.tools.ResultObject;

@Path("wallservice")
public class WallServiceImpl implements WallService {

	UserDAO userDAO = new UserDAOImpl();
	WallDAO wallDAO = new WallDAOImpl();
	MessageDAO msgDao = new MessageDAOImpl();

	/**
	 * 1、删除墙 wallid 墙id；creator 创建者；
	 * 类型；wallStatus 墙状态； wallImage 背景图片地址
	 */
	@Override
	@GET
	@Path("deletewall/{wallid},{username}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject deleteWall(@PathParam("wallid")Long wallid, 
			@PathParam("username")String username) {
		boolean result = false;
		Wall wall = wallDAO.findWallByWallid(wallid);
		if (wall != null) {
			if (wall.getUser().getUsername().equals(username)) {
				switch (wall.getWalltype()) {
				case 0:
					result=wallDAO.deleteWall(wallid);
					result=msgDao.deleteMsgByWallid(wallid);
					if (result) {
						return new ResultObject(KSUCCESS,"success");
					}
					break;

				case 1:
					User user = new User("admin");
					wall.setUser(user);
					result=wallDAO.updateWallUser(wallid, user);
					result=msgDao.deleteMsgByWallidAndUser(wallid, username);
					if (result) {
						return new ResultObject(KSUCCESS,"success");
					}
					break;

				default:
					break;
				}
			}
			
		}
		return new ResultObject(KFAIL,"fial");
	}
	
	/**
	 * 2、修改墙信息 wallid 墙id；wallName 墙名；wallSignature 签名；creator 创建者；wallType
	 * 类型；wallStatus 墙状态； wallImage 背景图片地址
	 */
	@Override
	@GET
	@Path("updatewall/{wallid},{wallName},{wallSignature},{wallImage},{wallType},{wallStatus}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject updateWall(@PathParam("wallid")Long wallid, 
			@PathParam("wallName")String wallName,
			@PathParam("wallSignature")String wallSignature, 
			@PathParam("wallImage")String wallImage, 
			@PathParam("wallType")Integer wallType,
			@PathParam("wallStatus")int wallStatus) {
		boolean result = wallDAO.updateWall(wallid, wallName, wallSignature, wallImage, wallType, wallStatus);
		if (result) {
			return new ResultObject(KSUCCESS,"success");
		}
		return new ResultObject(KFAIL,"fial");
	}

	/**
	 * 3、通过用户名查找用户建立的所有墙 username 用户名
	 */
	@Override
	@GET
	@Path("findwallsbyusername/{username}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findWallsByUserName(@PathParam("username")String username) {
		List<Wall> walls = wallDAO.findWallsByUserName(username);
		if (walls.size()!=0) {
			return new ResultObject(KSUCCESS,walls);
		}
		return new ResultObject(KFAIL,null);
	}

	/**
	 * 4、通过id获取墙信息 wallid 墙id
	 */
	@Override
	@GET
	@Path("findwallbywallid/{wallid}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findWallByWallid(@PathParam("wallid")Long wallid) {
		Wall wall = wallDAO.findWallByWallid(wallid);
		System.out.println(wall.getWallcreattime());
		if (wall!=null) {
			return new ResultObject(KSUCCESS,wall);
		}
		return new ResultObject(KFAIL,null);
	}

	/**
	 * 5、通过坐标查找附近的墙 x 经度； y 纬度；
	 */
	@Override
	@GET
	@Path("findwallsbyxy/{x},{y}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findWallsByXY(@PathParam("x")double x, @PathParam("y")double y) {
		List<Wall> walls = wallDAO.findWallsByXY(x, y);
		if (walls.size()!=0) {
			return new ResultObject(KSUCCESS,walls);
		}
		return new ResultObject(KFAIL,null);
	}

	/**
	 * {wallid},1、创建墙 wallName 墙名；wallSignature 签名；creator 创建者；wallType 类型； x 经度； y 纬度；
	 * wallImage 背景图片地址
	 */
	@Override
	@GET
	@Path("/createwall")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject createWall(@QueryParam("wallid")Long wallid,
			@QueryParam("wallname") String wallName,
			@QueryParam("wallsignature") String wallSignature,
			@QueryParam("username") String username,
			@QueryParam("walltype") Integer wallType,
			@QueryParam("x") double x, @QueryParam("y") double y,
			@QueryParam("wallimage") String wallImage,
			@QueryParam("walladress") String walladress) {
		boolean result = false;
		User user = userDAO.findUserByUserName(username);
		if (user != null) {
			result = wallDAO.createWall(wallid,wallName, wallSignature, user,
					wallType, x, y, wallImage ,walladress);
			if (result) {
				return new ResultObject(KSUCCESS, "success");
			}
		}
		return new ResultObject(KFAIL, "fial");
	}

}
