package com.footmark.service.impl;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.footmark.dao.ReviewDAO;
import com.footmark.dao.UserDAO;
import com.footmark.dao.impl.ReviewDAOImpl;
import com.footmark.dao.impl.UserDAOImpl;
import com.footmark.model.Review;
import com.footmark.model.User;
import com.footmark.service.ReviewService;
import com.footmark.tools.ResultObject;

@Path("reviewservice")
public class ReviewServiceImpl implements ReviewService {
	
	ReviewDAO reviewDAO = new ReviewDAOImpl();
	UserDAO userDAO = new UserDAOImpl();

	/**
	 * 发布评论
	 * 信息id；发布用户名；接收用户名；评论内容；
	 */
	@Override
	@GET
	@Path("createreview/{msgid},{fromUserName},{toUserName},{revContent}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject createReview(@PathParam("msgid")long msgid,@PathParam("fromUserName") String fromUserName,
			@PathParam("toUserName")String toUserName,@PathParam("revContent") String revContent) {
		boolean result = false;
		User fromuser = userDAO.findUserByUserName(fromUserName);
		User touser = userDAO.findUserByUserName(toUserName);
		if (fromuser != null && touser != null) {
			result = reviewDAO.createReview(msgid, fromUserName, toUserName, revContent);
			if (result) {
				return new ResultObject(KSUCCESS, "success");
			}
		}
		return new ResultObject(KFAIL, "fial");
	}

	/**
	 * 修改评论状态
	 * 评论id；状态；
	 */
	@Override
	@GET
	@Path("changereviewstatus/{revid},{revStatus}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject updateReviewStatus(@PathParam("revid")long revid, @PathParam("revStatus")Integer revStatus) {
		boolean result = reviewDAO.updateReviewStatus(revid, revStatus);
		if (result) {
			return new ResultObject(KSUCCESS,"success");
		}
		return new ResultObject(KFAIL,"fial");
	}

	/**
	 * 通过信息ID查找所属评论
	 * 信息id；
	 */
	@Override
	@GET
	@Path("findreviewbymsgid/{msgid}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findReviewByMsgid(@PathParam("msgid")long msgid) {
		List<Review> reviewsList = reviewDAO.findReviewByMsgid(msgid);
		if (reviewsList.size()!=0) {
			return new ResultObject(KSUCCESS,reviewsList);
		}
		return new ResultObject(KFAIL,null);
	}

	/**
	 * 通过发布用户查找所属评论
	 * 用户名；
	 */
	@Override
	@GET
	@Path("findreviewbyfromuser/{username}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findReviewByFromUser(@PathParam("username")String username) {
		List<Review> reviewsList = reviewDAO.findReviewByFromUser(username);
		if (reviewsList.size()!=0) {
			return new ResultObject(KSUCCESS,reviewsList);
		}
		return new ResultObject(KFAIL,null);
	}

	/**
	 * 通过接收用户查找所属评论
	 * 用户名；
	 */
	@Override
	@GET
	@Path("findreviewbytouser/{username}")
	@Produces(MediaType.APPLICATION_JSON)
	public ResultObject findReviewByToUser(@PathParam("username")String username) {
		List<Review> reviewsList = reviewDAO.findReviewByToUser(username);
		if (reviewsList.size()!=0) {
			return new ResultObject(KSUCCESS,reviewsList);
		}
		return new ResultObject(KFAIL,null);
	}

}
