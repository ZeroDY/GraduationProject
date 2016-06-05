package com.footmark.model;

// default package

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

import org.codehaus.jackson.annotate.JsonProperty;

/**
 * Wall entity. @author MyEclipse Persistence Tools
 */

public class Wall implements java.io.Serializable {

	// Fields

	private Long wallid;
	private User user;
	private String wallname;
	private String wallsignature;
	private Timestamp wallcreattime;
	private Integer walltype;
	private Integer wallstatus;
	private double xcoordinate;
	private double ycoordinate;
	private String wallimage;
	private String walladress;

	// Constructors

	/** default constructor */
	public Wall() {
	}

	/** minimal constructor */
	public Wall(String wallname, Timestamp wallcreattime, Integer walltype,
			Integer wallstatus, double xcoordinate, double ycoordinate,String walladress) {
		this.wallname = wallname;
		this.wallcreattime = wallcreattime;
		this.walltype = walltype;
		this.wallstatus = wallstatus;
		this.xcoordinate = xcoordinate;
		this.ycoordinate = ycoordinate;
		this.walladress = walladress;
	}

	/** full constructor */
	public Wall(User user, String wallname, String wallsignature,
			Timestamp wallcreattime, Integer walltype, Integer wallstatus,
			double xcoordinate, double ycoordinate, String wallimage, String walladress) {
		this.user = user;
		this.wallname = wallname;
		this.wallsignature = wallsignature;
		this.wallcreattime = wallcreattime;
		this.walltype = walltype;
		this.wallstatus = wallstatus;
		this.xcoordinate = xcoordinate;
		this.ycoordinate = ycoordinate;
		this.wallimage = wallimage;
		this.walladress = walladress;
	}
	
	

	public Wall(User user, String wallname, String wallsignature,
			Integer walltype, double xcoordinate, double ycoordinate,
			String wallimage ,String walladress) {
		super();
		this.user = user;
		this.wallname = wallname;
		this.wallsignature = wallsignature;
		this.walltype = walltype;
		this.xcoordinate = xcoordinate;
		this.ycoordinate = ycoordinate;
		this.wallimage = wallimage;
		this.walladress = walladress;
	}
	
	

	public Wall(Long wallid, User user, String wallname, String wallsignature,
			Integer walltype, double xcoordinate, double ycoordinate,
			String wallimage ,String walladress) {
		super();
		this.wallid = wallid;
		this.user = user;
		this.wallname = wallname;
		this.wallsignature = wallsignature;
		this.walltype = walltype;
		this.xcoordinate = xcoordinate;
		this.ycoordinate = ycoordinate;
		this.wallimage = wallimage;
		this.walladress = walladress;
	}

	public Wall(Long wallid) {
		super();
		this.wallid = wallid;
	}

	// Property accessors
	public Long getWallid() {
		return this.wallid;
	}

	public void setWallid(Long wallid) {
		this.wallid = wallid;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getWallname() {
		return this.wallname;
	}

	public void setWallname(String wallname) {
		this.wallname = wallname;
	}

	public String getWallsignature() {
		return this.wallsignature;
	}

	public void setWallsignature(String wallsignature) {
		this.wallsignature = wallsignature;
	}

	public Timestamp getWallcreattime() {
		return this.wallcreattime;
	}

	public void setWallcreattime(Timestamp wallcreattime) {
		this.wallcreattime = wallcreattime;
	}

	public Integer getWalltype() {
		return this.walltype;
	}

	public void setWalltype(Integer walltype) {
		this.walltype = walltype;
	}

	public Integer getWallstatus() {
		return this.wallstatus;
	}

	public void setWallstatus(Integer wallstatus) {
		this.wallstatus = wallstatus;
	}

	public double getXcoordinate() {
		return this.xcoordinate;
	}

	public void setXcoordinate(double xcoordinate) {
		this.xcoordinate = xcoordinate;
	}

	public double getYcoordinate() {
		return this.ycoordinate;
	}

	public void setYcoordinate(double ycoordinate) {
		this.ycoordinate = ycoordinate;
	}


	public String getWallimage() {
		return wallimage;
	}

	public void setWallimage(String wallimage) {
		this.wallimage = wallimage;
	}

	public String getWalladress() {
		return walladress;
	}

	public void setWalladress(String walladress) {
		this.walladress = walladress;
	}

}