// default package



/**
 * User entity. @author MyEclipse Persistence Tools
 */

public class User  implements java.io.Serializable {


    // Fields    

     private String username;
     private String truename;
     private String password;
     private Integer age;
     private String sex;
     private String tel;
     private String photourl;
     private Integer status;


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
    public User(String username, String truename, String password, Integer age, String sex, String tel, String photourl, Integer status) {
        this.username = username;
        this.truename = truename;
        this.password = password;
        this.age = age;
        this.sex = sex;
        this.tel = tel;
        this.photourl = photourl;
        this.status = status;
    }

   
    // Property accessors

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

    public Integer getAge() {
        return this.age;
    }
    
    public void setAge(Integer age) {
        this.age = age;
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
   








}