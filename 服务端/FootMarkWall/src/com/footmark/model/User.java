package com.footmark.model;
// default package



/**
 * User entity. @author MyEclipse Persistence Tools
 */

public class User  implements java.io.Serializable {


    // Fields    

     private String username;
     private String truename;
     private String password;
     private String sex;
     private String tel;
     private String photourl;
     private Integer status;
     private Integer age;


    // Constructors

    /** default constructor */
    public User() {
    }

	/** minimal constructor */
    public User(String username, String truename, String password, Integer status) {
        this.username = username;
        this.truename = truename;
        this.password = password;
        this.status = status;
    }
    
    /** full constructor */
    


    
   
    public User(String username, String truename, String password) {
		super();
		this.username = username;
		this.truename = truename;
		this.password = password;
	}

	public User(String username) {
		super();
		this.username = username;
	}

	
	// Property accessors

    public User(String username, String truename, String password, String sex,
			String tel, String photourl, Integer status, Integer age) {
		super();
		this.username = username;
		this.truename = truename;
		this.password = password;
		this.sex = sex;
		this.tel = tel;
		this.photourl = photourl;
		this.status = status;
		this.age = age;
	}

	public String getUsername() {
        return this.username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }

    public String getTruename() {
        return this.truename;
    }
    
    public void setTruename(String truename) {
        this.truename = truename;
    }

    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }

    public String getSex() {
        return this.sex;
    }
    
    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getTel() {
        return this.tel;
    }
    
    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getPhotourl() {
        return this.photourl;
    }
    
    public void setPhotourl(String photourl) {
        this.photourl = photourl;
    }

    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }


	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}
   








}