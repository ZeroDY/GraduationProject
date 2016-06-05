package com.footmark.dao;

import java.util.List;

import com.footmark.model.Review;

public interface ReviewDAO {
	
	/**
	 * 发布评论
	 * 信息id；发布用户名；接收用户名；评论内容；
	 */
	public boolean createReview(long msgid,String fromUserName,String toUserName,String revContent);
	
	/**
	 * 修改评论状态
	 * 评论id；状态；
	 */
	public boolean updateReviewStatus(long revid,Integer revStatus);
	
	/**
	 * 通过信息ID查找所属评论
	 * 信息id；
	 */
	public List<Review> findReviewByMsgid(long msgid);
	
	/**
	 * 通过发布用户查找所属评论
	 * 用户名；
	 */
	public List<Review> findReviewByFromUser(String username);
	
	/**
	 * 通过接收用户查找所属评论
	 * 用户名；
	 */
	public List<Review> findReviewByToUser(String username);
	
	
	
	
	
	
	
	
	
	
	
	
	

}
