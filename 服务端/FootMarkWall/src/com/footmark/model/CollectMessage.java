package com.footmark.model;
// default package



/**
 * CollectMessage entity. @author MyEclipse Persistence Tools
 */

public class CollectMessage  implements java.io.Serializable {


    // Fields    

     /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long collectmsgid;
     private String username;
     private Long msgid;
     
	public CollectMessage() {
		super();
	}
	public CollectMessage(Long collectmsgid) {
		super();
		this.collectmsgid = collectmsgid;
	}
	public CollectMessage(String username, Long msgid) {
		super();
		this.username = username;
		this.msgid = msgid;
	}
	public CollectMessage(Long collectmsgid, String username, Long msgid) {
		super();
		this.collectmsgid = collectmsgid;
		this.username = username;
		this.msgid = msgid;
	}
	public Long getCollectmsgid() {
		return collectmsgid;
	}
	public void setCollectmsgid(Long collectmsgid) {
		this.collectmsgid = collectmsgid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Long getMsgid() {
		return msgid;
	}
	public void setMsgid(Long msgid) {
		this.msgid = msgid;
	}


    // Constructors



}