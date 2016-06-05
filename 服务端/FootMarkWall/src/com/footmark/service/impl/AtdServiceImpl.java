package com.footmark.service.impl;

import java.util.Date;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.footmark.dao.AtdDAO;
import com.footmark.dao.AtdWallDAO;
import com.footmark.dao.UserDAO;
import com.footmark.dao.impl.AtdDAOImpl;
import com.footmark.dao.impl.AtdWallDAOImpl;
import com.footmark.dao.impl.UserDAOImpl;
import com.footmark.model.Atd;
import com.footmark.model.AtdWall;
import com.footmark.model.Message;
import com.footmark.model.User;
import com.footmark.service.AtdService;
import com.footmark.tools.ResultObject;

@Path("atdservice")
public class AtdServiceImpl implements AtdService {

	UserDAO userDAO = new UserDAOImpl();
	AtdWallDAO wallDAO = new AtdWallDAOImpl();
	AtdDAO atdDAO = new AtdDAOImpl();
	@Override
	@GET
	@Path("atd/{username},{atdwallid},{atdinfo},{atdidentifier}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject atd(@PathParam("username")String username,@PathParam("atdwallid") Long atdwallid,@PathParam("atdinfo")String atdinfo,@PathParam("atdidentifier")String atdidentifier) {
		boolean result = false;
		User user = userDAO.findUserByUserName(username);
		AtdWall wall = wallDAO.findAtdWallByAtdWallid(atdwallid);
		if (wall.getAtdwallstatus() == 0) {
			return new ResultObject(KFAIL, "the wall did close");
		}else {
			Date dt=new Date();
			if (( dt.getTime() - wall.getAtdwallcreattime().getTime()) > 3600000) {
				if (wallDAO.updateAtdWall(atdwallid, 0)) {
					System.out.println("sssssssssssssssss");
				}
				return new ResultObject(KFAIL, "the wall did close");
			}else {
				boolean isAtded = atdDAO.isAtded(atdwallid, atdidentifier);
				if (user != null && wall != null && !isAtded) {
					result = atdDAO.atd(user, wall, atdinfo, atdidentifier);
					if (result) {
						return new ResultObject(KSUCCESS, "success");
					}
				}
				return new ResultObject(KFAIL, "fial");
			}

		}
		
	}
	
	/**
	 * Í¨¹ýÇ½²éÑ¯
	 * Ç½ID£»
	 */
	@Override
	@GET
	@Path("findallatdbyatdwallid/{wallid}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findAllAtdByAtdWallid(@PathParam("wallid")Long wallid) {
		List<Atd> msgList = atdDAO.findAllAtdBuyAtdWallid(wallid);
		if (msgList.size()!=0) {
			return new ResultObject(KSUCCESS,msgList);
		}
		return new ResultObject(KFAIL,null);
	}

}
