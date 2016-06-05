package com.footmark.model;
// default package

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;


/**
 * Message entity. @author MyEclipse Persistence Tools
 */

public class Message  implements java.io.Serializable {


    // Fields    

     private Long msgid;
     private Wall wall;
     private User user;
     private String msgcontent;
     private Timestamp msgcreattime;
     private Integer msgstatus;
     private Integer msgtype;
     private String msgimage;


    // Constructors

    /** default constructor */

     

	/** minimal constructor */
    public Message(Wall wall, User user, String msgcontent, Timestamp msgcreattime, Integer msgstatus, Integer msgtype) {
        this.wall = wall;
        this.user = user;
        this.msgcontent = msgcontent;
        this.msgcreattime = msgcreattime;
        this.msgstatus = msgstatus;
        this.msgtype = msgtype;
    }
    
    public Message() {
		super();
	}

	/** full constructor */
    public Message(Wall wall, User user, String msgcontent, Timestamp msgcreattime, Integer msgstatus, Integer msgtype, String magimage) {
        this.wall = wall;
        this.user = user;
        this.msgcontent = msgcontent;
        this.msgcreattime = msgcreattime;
        this.msgstatus = msgstatus;
        this.msgtype = msgtype;
        this.msgimage = magimage;
    }
    
    

   
    public Message(Long msgid, Wall wall, User user, String msgcontent,
			Integer msgstatus, Integer msgtype, String msgimage) {
		super();
		this.msgid = msgid;
		this.wall = wall;
		this.user = user;
		this.msgcontent = msgcontent;
		this.msgstatus = msgstatus;
		this.msgtype = msgtype;
		this.msgimage = msgimage;
	}

	public Message(Long msgid, Wall wall, User user, String msgcontent,
			Integer msgtype, String msgimage) {
		super();
		this.msgid = msgid;
		this.wall = wall;
		this.user = user;
		this.msgcontent = msgcontent;
		this.msgtype = msgtype;
		this.msgimage = msgimage;
	}

	public Message(Wall wall, User user, String msgcontent, Integer msgtype,Integer msgStatus,
			String magimage) {
		super();
		this.wall = wall;
		this.user = user;
		this.msgcontent = msgcontent;
		this.msgtype = msgtype;
		this.msgstatus = msgStatus;
		this.msgimage = magimage;
	}
    
    

	public Message(Long msgid, Wall wall, User user, String msgcontent,
			String msgimage) {
		super();
		this.msgid = msgid;
		this.wall = wall;
		this.user = user;
		this.msgcontent = msgcontent;
		this.msgimage = msgimage;
	}

	public Message(Long msgid, User user, String msgcontent,
			Timestamp msgcreattime, Integer msgstatus, Integer msgtype,
			String msgimage) {
		super();
		this.msgid = msgid;
		this.user = user;
		this.msgcontent = msgcontent;
		this.msgcreattime = msgcreattime;
		this.msgstatus = msgstatus;
		this.msgtype = msgtype;
		this.msgimage = msgimage;
	}

	public Message(Long msgid) {
		super();
		this.msgid = msgid;
	}

	// Property accessors

    public Long getMsgid() {
        return this.msgid;
    }
    
    public void setMsgid(Long msgid) {
        this.msgid = msgid;
    }

    public Wall getWall() {
        return this.wall;
    }
    
    public void setWall(Wall wall) {
        this.wall = wall;
    }

    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }

    public String getMsgcontent() {
        return this.msgcontent;
    }
    
    public void setMsgcontent(String msgcontent) {
        this.msgcontent = msgcontent;
    }

    public Timestamp getMsgcreattime() {
        return this.msgcreattime;
    }
    
    public void setMsgcreattime(Timestamp msgcreattime) {
        this.msgcreattime = msgcreattime;
    }

    public Integer getMsgstatus() {
        return this.msgstatus;
    }
    
    public void setMsgstatus(Integer msgstatus) {
        this.msgstatus = msgstatus;
    }

    public Integer getMsgtype() {
        return this.msgtype;
    }
    
    public void setMsgtype(Integer msgtype) {
        this.msgtype = msgtype;
    }

    public String getMsgimage() {
        return this.msgimage;
    }
    
    public void setMsgimage(String msgimage) {
        this.msgimage = msgimage;
    }

    
   








}