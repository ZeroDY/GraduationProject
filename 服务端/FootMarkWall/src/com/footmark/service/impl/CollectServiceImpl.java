package com.footmark.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.footmark.dao.CollectMessageDAO;
import com.footmark.dao.CollectWallDAO;
import com.footmark.dao.MessageDAO;
import com.footmark.dao.UserDAO;
import com.footmark.dao.WallDAO;
import com.footmark.dao.impl.CollectMessageDAOImpl;
import com.footmark.dao.impl.CollectWallDAOImpl;
import com.footmark.dao.impl.MessageDAOImpl;
import com.footmark.dao.impl.UserDAOImpl;
import com.footmark.dao.impl.WallDAOImpl;
import com.footmark.model.CollectMessage;
import com.footmark.model.CollectWall;
import com.footmark.model.Message;
import com.footmark.model.User;
import com.footmark.model.Wall;
import com.footmark.service.CollectService;
import com.footmark.tools.ResultObject;

@Path("collectservice")
public class CollectServiceImpl implements CollectService {
	
	UserDAO userDAO = new UserDAOImpl();
	WallDAO wallDAO = new WallDAOImpl();
	MessageDAO messageDAO = new MessageDAOImpl();
	CollectWallDAO collectWallDAO = new CollectWallDAOImpl();
	CollectMessageDAO collectMessageDAO = new CollectMessageDAOImpl();

	/**
	 * 收藏
	 * 用户名；墙ID
	 */
	@Override
	@GET
	@Path("collectwall/{username},{wallid}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject collectWall(@PathParam("username")String username,@PathParam("wallid") long wallid) {
		User user = userDAO.findUserByUserName(username);
		Wall wall = wallDAO.findWallByWallid(wallid);
		if (user != null && wall != null) {
			CollectWall collectWall = collectWallDAO.findCollectWallByUsername(username, wallid);
			if (collectWall==null) {
				if (collectWallDAO.collectWall(username, wallid)) {
					return new ResultObject(KSUCCESS, "collect");
				}else {
					return new ResultObject(KFAIL, "collect");
				}
			}else {
				if (collectWallDAO.deleteCollectWall(collectWall)) {
					return new ResultObject(KSUCCESS, "uncollect");
				}else {
					return new ResultObject(KFAIL, "uncollect");
				}
			}
		}
		return new ResultObject(KFAIL, "no user or wall");
	}

	/**
	 * 根据用户名查找全部收藏
	 * 用户名
	 */
	@Override
	@GET
	@Path("findcollectbyusername/{username}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findAllCollectByUsername(@PathParam("username")String username) {
		List<CollectWall> collectWalls = collectWallDAO.findAllCollectWallByUsername(username);
		if (collectWalls.size()!=0) {
			return new ResultObject(KSUCCESS,collectWalls);
		}
		return new ResultObject(KFAIL,null);
	}
	
	/**
	 * 根据用户名查找全部收藏
	 * 用户名
	 */
	@Override
	@GET
	@Path("findcollectwallsbyusername/{username}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findAllCollectWallByUsername(@PathParam("username")String username) {
		List<CollectWall> collectWalls = collectWallDAO.findAllCollectWallByUsername(username);
		List<Wall> walls = new ArrayList<Wall>();
		if (collectWalls.size()!=0) {
			for (CollectWall collectWall : collectWalls) {
				Wall wall = wallDAO.findWallByWallid(collectWall.getWallid());
				walls.add(wall);
			}
			return new ResultObject(KSUCCESS,walls);
		}
		return new ResultObject(KFAIL,null);
	}

///////////////////////////////
	
	/**
	 * 收藏
	 * 用户名；信息ID
	 */
	@Override
	@GET
	@Path("collectmsg/{username},{msgid}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject collectMessage(@PathParam("username")String username,@PathParam("msgid") long msgid) {
		User user = userDAO.findUserByUserName(username);
		Message message = messageDAO.findMsgByMsgid(msgid);
		if (user != null && message != null) {
			CollectMessage collectMessage = collectMessageDAO.findCollectMessageByUsername(username, msgid);
			if (collectMessage==null) {
				if (collectMessageDAO.collectMessage(username, msgid)) {
					return new ResultObject(KSUCCESS, "collect");
				}else {
					return new ResultObject(KFAIL, "collect");
				}
			}else {
				if (collectMessageDAO.deleteCollectMessage(collectMessage)) {
					return new ResultObject(KSUCCESS, "uncollect");
				}else {
					return new ResultObject(KFAIL, "uncollect");
				}
			}
		}
		return new ResultObject(KFAIL, "no user or message");
	}

	/**
	 * 根据用户名查找全部收藏
	 * 用户名
	 */
	@Override
	@GET
	@Path("findcollectmsgsbyusername/{username}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findAllCollectMessageByUsername(@PathParam("username")String username) {
		List<CollectMessage> collectMessages = collectMessageDAO.findAllCollectMessageByUsername(username);
		if (collectMessages.size()!=0) {
			return new ResultObject(KSUCCESS,collectMessages);
		}
		return new ResultObject(KFAIL,null);
	}


}
