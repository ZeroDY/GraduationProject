package com.footmark.model;
// default package

import java.sql.Timestamp;


/**
 * Review entity. @author MyEclipse Persistence Tools
 */

public class Review  implements java.io.Serializable {


    // Fields    

     private Long revid;
     private User userByTouser;
     private Message message;
     private User userByFromuser;
     private Timestamp revtime;
     private String revcontent;
     private int revstatus;


    // Constructors

    /** default constructor */
    public Review() {
    }

    
    /** full constructor */
    public Review(User userByTouser, Message message, User userByFromuser, Timestamp revtime, String revcontent,int revstatus) {
        this.userByTouser = userByTouser;
        this.message = message;
        this.userByFromuser = userByFromuser;
        this.revtime = revtime;
        this.revcontent = revcontent;
        this.revstatus = revstatus;
    }

    
   
    public Review(User userByTouser, Message message, User userByFromuser,
			String revcontent) {
		super();
		this.userByTouser = userByTouser;
		this.message = message;
		this.userByFromuser = userByFromuser;
		this.revcontent = revcontent;
	}


	public Review(Long revid) {
		super();
		this.revid = revid;
	}


	// Property accessors

    public Long getRevid() {
        return this.revid;
    }
    
    public void setRevid(Long revid) {
        this.revid = revid;
    }

    public User getUserByTouser() {
        return this.userByTouser;
    }
    
    public void setUserByTouser(User userByTouser) {
        this.userByTouser = userByTouser;
    }

    public Message getMessage() {
        return this.message;
    }
    
    public void setMessage(Message message) {
        this.message = message;
    }

    public User getUserByFromuser() {
        return this.userByFromuser;
    }
    
    public void setUserByFromuser(User userByFromuser) {
        this.userByFromuser = userByFromuser;
    }

    public Timestamp getRevtime() {
        return this.revtime;
    }
    
    public void setRevtime(Timestamp revtime) {
        this.revtime = revtime;
    }

    public String getRevcontent() {
        return this.revcontent;
    }
    
    public void setRevcontent(String revcontent) {
        this.revcontent = revcontent;
    }


	public int getRevstatus() {
		return revstatus;
	}


	public void setRevstatus(int revstatus) {
		this.revstatus = revstatus;
	}
   








}