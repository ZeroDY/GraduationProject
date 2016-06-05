package com.footmark.model;

import java.sql.Timestamp;

/**
 * AtdwallTable entity. @author MyEclipse Persistence Tools
 */

public class AtdWall implements java.io.Serializable {

	// Fields

	private Long atdwallid;
	private String atdwallname;
	private Timestamp atdwallcreattime;
	private Double atdxcoordinate;
	private Double atdycoordinate;
	private Integer atdwallstatus;
	private User user;

	// Constructors

	/** default constructor */
	public AtdWall() {
	}

	/** minimal constructor */
	public AtdWall(Long atdwallid) {
		this.atdwallid = atdwallid;
	}

	/** full constructor */
	public AtdWall(Long atdwallid, String atdwallname,
			Timestamp atdwallcreattime, Double atdxcoordinate,
			Double atdycoordinate, Integer atdwallstatus,
			User user, String atdwalladress) {
		this.atdwallid = atdwallid;
		this.atdwallname = atdwallname;
		this.atdwallcreattime = atdwallcreattime;
		this.atdxcoordinate = atdxcoordinate;
		this.atdycoordinate = atdycoordinate;
		this.atdwallstatus = atdwallstatus;
		this.user = user;
	}

	// Property accessors
	
	public AtdWall( String atdwallname, Double atdxcoordinate,
			Double atdycoordinate, User user) {
		super();
		this.atdwallname = atdwallname;
		this.atdxcoordinate = atdxcoordinate;
		this.atdycoordinate = atdycoordinate;
		this.user = user;
	}

	public Long getAtdwallid() {
		return this.atdwallid;
	}

	public void setAtdwallid(Long atdwallid) {
		this.atdwallid = atdwallid;
	}

	public String getAtdwallname() {
		return this.atdwallname;
	}

	public void setAtdwallname(String atdwallname) {
		this.atdwallname = atdwallname;
	}

	public Timestamp getAtdwallcreattime() {
		return this.atdwallcreattime;
	}

	public void setAtdwallcreattime(Timestamp atdwallcreattime) {
		this.atdwallcreattime = atdwallcreattime;
	}

	public Double getAtdxcoordinate() {
		return this.atdxcoordinate;
	}

	public void setAtdxcoordinate(Double atdxcoordinate) {
		this.atdxcoordinate = atdxcoordinate;
	}

	public Double getAtdycoordinate() {
		return this.atdycoordinate;
	}

	public void setAtdycoordinate(Double atdycoordinate) {
		this.atdycoordinate = atdycoordinate;
	}

	public Integer getAtdwallstatus() {
		return this.atdwallstatus;
	}

	public void setAtdwallstatus(Integer atdwallstatus) {
		this.atdwallstatus = atdwallstatus;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}



}