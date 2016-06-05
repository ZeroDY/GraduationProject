package com.footmark.service.impl;

import java.util.Date;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.footmark.dao.AtdWallDAO;
import com.footmark.dao.UserDAO;
import com.footmark.dao.impl.AtdWallDAOImpl;
import com.footmark.dao.impl.UserDAOImpl;
import com.footmark.model.AtdWall;
import com.footmark.model.User;
import com.footmark.model.Wall;
import com.footmark.service.AtdWallService;
import com.footmark.tools.ResultObject;

@Path("atdwallservice")
public class AtdWallServiceImpl implements AtdWallService {
	
	UserDAO userDAO = new UserDAOImpl();
	AtdWallDAO wallDAO = new AtdWallDAOImpl();

	public boolean reloadAtdWallStatus( AtdWall wall) {
		Date dt=new Date();
		if (wall.getAtdwallstatus() == 1 && ( dt.getTime() - wall.getAtdwallcreattime().getTime()) > 3600000) {
			if (wallDAO.updateAtdWall(wall.getAtdwallid(), 0)) {
				return true;
			}
		}
		return false;
	}
		
	@Override
	@GET
	@Path("createatdwall/{wallName},{username},{x},{y}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject createAtdWall( @PathParam("wallName")String wallName,
			@PathParam("username")String username, @PathParam("x")double x, @PathParam("y")double y) {
		boolean result = false;
		User user = userDAO.findUserByUserName(username);
		if (user != null) {
			result = wallDAO.createAtdWall(wallName, user,x, y);
			if (result) {
				return new ResultObject(KSUCCESS, "success");
			}
		}
		return new ResultObject(KFAIL, "fial");
	}

	@Override
	@GET
	@Path("updateatdwall/{wallid},{wallStatus}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject updateAtdWall(@PathParam("wallid")Long wallid, @PathParam("wallStatus")int wallStatus) {
		boolean result = wallDAO.updateAtdWall(wallid, wallStatus);
		if (result) {
			return new ResultObject(KSUCCESS,"success");
		}
		return new ResultObject(KFAIL,"fial");
	}

	@Override
	@GET
	@Path("findatdwallsbyusername/{username}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findAtdWallsByUserName(@PathParam("username")String username) {
		List<AtdWall> walls = wallDAO.findAtdWallsByUserName(username);
		for (AtdWall atdWall : walls) {
			if (this.reloadAtdWallStatus(atdWall)) {
				atdWall.setAtdwallstatus(0);
			}
		}
		if (walls.size()!=0) {
			
			return new ResultObject(KSUCCESS,walls);
		}
		return new ResultObject(KFAIL,null);
	}

	@Override
	@GET
	@Path("findatdwallbywallid/{wallid}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findAtdWallByWallid(@PathParam("wallid")Long wallid) {
		AtdWall wall = wallDAO.findAtdWallByAtdWallid(wallid);
		if (wall!=null) {
			return new ResultObject(KSUCCESS,wall);
		}
		return new ResultObject(KFAIL,null);
	}

	@Override
	@GET
	@Path("findatdwallsbyxy/{x},{y}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findAtdWallsByXY(@PathParam("x")double x,@PathParam("y") double y) {
		List<AtdWall> walls = wallDAO.findAtdAtdWallsByXY(x, y);
		for (int i=0;i<walls.size();i++) {
			AtdWall atdWall = walls.get(i);
			if (this.reloadAtdWallStatus(atdWall)) {
				walls.remove(atdWall);
			}
		}
		if (walls.size()!=0) {
			return new ResultObject(KSUCCESS,walls);
		}
		return new ResultObject(KFAIL,null);
	}

	
	/**
	 * 1¡¢É¾³ýÇ½ wallid Ç½id£»creator ´´½¨Õß£»
	 * ÀàÐÍ£»wallStatus Ç½×´Ì¬£» wallImage ±³¾°Í¼Æ¬µØÖ·
	 */
	@Override
	@GET
	@Path("deleteatdwall/{wallid},{username}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject deleteWall(@PathParam("wallid")Long wallid, 
			@PathParam("username")String username) {
		boolean result = false;
		AtdWall wall = wallDAO.findAtdWallByAtdWallid(wallid);
		if (wall != null && wall.getUser().getUsername().equals(username)) {
			result = wallDAO.deleteAtdWall(wallid);
			if (result) {
				return new ResultObject(KSUCCESS,"success");
			}
//			if (wall.getUser().getUsername().equals(username)) {
//				switch (wall.getWalltype()) {
//				case 0:
//					result=wallDAO.deleteWall(wallid);
//					result=msgDao.deleteMsgByWallid(wallid);
//					if (result) {
//						return new ResultObject(KSUCCESS,"success");
//					}
//					break;
//
//				case 1:
//					User user = new User("admin");
//					wall.setUser(user);
//					result=wallDAO.updateWallUser(wallid, user);
//					result=msgDao.deleteMsgByWallid(wallid);
//					if (result) {
//						return new ResultObject(KSUCCESS,"success");
//					}
//					break;
//
//				default:
//					break;
//				}
//			}
			
		}
		return new ResultObject(KFAIL,"fial");
	}
}
