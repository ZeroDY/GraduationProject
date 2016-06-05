package com.footmark.model;

import java.sql.Timestamp;

/**
 * AtdTable entity. @author MyEclipse Persistence Tools
 */

public class Atd implements java.io.Serializable {

	// Fields

	private Long atdid;
	private User atduser;
	private AtdWall atdwall;
	private Timestamp atdtime;
	private String atdinfo;
	private String atdidentifier;
	
	public Atd() {
		super();
	}
	public Atd(Long atdid, User atduser, Timestamp atdtime, String atdinfo,
			AtdWall atdwall, String atdidentifier) {
		super();
		this.atdid = atdid;
		this.atduser = atduser;
		this.atdtime = atdtime;
		this.atdinfo = atdinfo;
		this.atdwall = atdwall;
		this.atdidentifier = atdidentifier;
	}
	public Atd( User atduser, AtdWall atdwall, String atdinfo,
			String atdidentifier) {
		super();
		this.atduser = atduser;
		this.atdwall = atdwall;
		this.atdinfo = atdinfo;
		this.atdidentifier = atdidentifier;
	}
	public Long getAtdid() {
		return atdid;
	}
	public void setAtdid(Long atdid) {
		this.atdid = atdid;
	}
	public User getAtduser() {
		return atduser;
	}
	public void setAtduser(User atduser) {
		this.atduser = atduser;
	}
	public Timestamp getAtdtime() {
		return atdtime;
	}
	public void setAtdtime(Timestamp atdtime) {
		this.atdtime = atdtime;
	}
	public String getAtdinfo() {
		return atdinfo;
	}
	public void setAtdinfo(String atdinfo) {
		this.atdinfo = atdinfo;
	}
	public AtdWall getAtdwall() {
		return atdwall;
	}
	public void setAtdwall(AtdWall atdwall) {
		this.atdwall = atdwall;
	}
	public String getAtdidentifier() {
		return atdidentifier;
	}
	public void setAtdidentifier(String atdidentifier) {
		this.atdidentifier = atdidentifier;
	}
	
	


}