package com.footmark.dao.impl;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.footmark.dao.UserDAO;
import com.footmark.model.User;
import com.footmark.tools.HibernateSessionFactory;

public class UserDAOImpl implements UserDAO {

	@Override
	public boolean register(String userName, String password, String trueName) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			User user = new User(userName, trueName, password);
			session.save(user);
			t.commit();
			flag = true;
		} catch (Exception e) {
			System.out.println(e);
			flag = false;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}

	@Override
	public User Login(String userName, String password) {
		User user = new User();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from User u where u.username = '"+userName+"'";
			Query query = session.createQuery(hsql);
			user = (User) query.uniqueResult();
			System.out.println(user.getAge());
			if ((user == null) | !(user.getPassword().equals(password))) {
				return null;
			}
			t.commit();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return user;
	}

	@Override
	public User findUserByUserName(String userName) {
		User user = new User();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from User u where u.username = '"+userName+"'";
			Query query = session.createQuery(hsql);
			user = (User) query.uniqueResult();
			t.commit();
			return user;
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			HibernateSessionFactory.closeSession();
		} 
		return null;
	}

	@Override
	public boolean updateUser(String userName, String password,
			String trueName, String tel, String photoURL, int userStatus,
			int age, String sex) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			User user = (User) session.get(User.class, userName);
			if (user.getPassword().equals(password)) {
				user.setTel(tel);
				user.setTruename(trueName);
				user.setPhotourl(photoURL);
				user.setStatus(userStatus);
				user.setAge(age);
				user.setSex(sex);
				session.update(user);
				t.commit();
				flag = true;
			}
		} catch (Exception e) {
			System.out.println(e);
			flag = false;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}
	
	public boolean updateUser(User user) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			session.update(user);
			t.commit();
			flag = true;
		} catch (Exception e) {
			System.out.println(e);
			flag = false;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}

	@Override
	public boolean updateUserPwd(String userName, String password) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			User user = (User) session.get(User.class, userName);
			user.setPassword(password);
			session.update(user);
			t.commit();
			flag = true;
		} catch (Exception e) {
			System.out.println(e);
			flag = false;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}

}
