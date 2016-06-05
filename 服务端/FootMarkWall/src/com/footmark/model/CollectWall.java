package com.footmark.model;
// default package



/**
 * CollectWall entity. @author MyEclipse Persistence Tools
 */

public class CollectWall  implements java.io.Serializable {


    // Fields    

     private Long collectwallid;
     private Long wallid;
     private String username;
     
     
     
     
	public CollectWall(Long wallid, String username) {
		super();
		this.wallid = wallid;
		this.username = username;
	}
	public CollectWall() {
		super();
	}
	public CollectWall(Long collectwallid) {
		super();
		this.collectwallid = collectwallid;
	}
	public CollectWall(Long collectwallid, Long wallid, String username) {
		super();
		this.collectwallid = collectwallid;
		this.wallid = wallid;
		this.username = username;
	}
	public Long getCollectwallid() {
		return collectwallid;
	}
	public void setCollectwallid(Long collectwallid) {
		this.collectwallid = collectwallid;
	}
	public Long getWallid() {
		return wallid;
	}
	public void setWallid(Long wallid) {
		this.wallid = wallid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

     

  



}