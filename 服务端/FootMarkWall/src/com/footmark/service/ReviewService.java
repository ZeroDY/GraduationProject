package com.footmark.service;

import com.footmark.tools.ResultObject;

public interface ReviewService {

	public static final String KSUCCESS = "1";
    public static final String KFAIL = "0";
    
	/**
	 * 发布评论
	 * 信息id；发布用户名；接收用户名；评论内容；
	 */
	public ResultObject createReview(long msgid,String fromUserName,String toUserName,String revContent);
	
	/**
	 * 修改评论状态
	 * 评论id；状态；
	 */
	public ResultObject updateReviewStatus(long revid,Integer revStatus);
	
	/**
	 * 通过信息ID查找所属评论
	 * 信息id；
	 */
	public ResultObject findReviewByMsgid(long msgid);
	
	/**
	 * 通过发布用户查找所属评论
	 * 用户名；
	 */
	public ResultObject findReviewByFromUser(String username);
	
	/**
	 * 通过接收用户查找所属评论
	 * 用户名；
	 */
	public ResultObject findReviewByToUser(String username);
}
