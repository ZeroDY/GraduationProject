package com.footmark.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.footmark.dao.CollectWallDAO;
import com.footmark.model.CollectWall;
import com.footmark.model.User;
import com.footmark.model.Wall;
import com.footmark.tools.HibernateSessionFactory;

public class CollectWallDAOImpl implements CollectWallDAO {

	@Override
	public boolean collectWall(String username, Long wallid) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			CollectWall collectWall = new CollectWall(wallid, username);
			session.save(collectWall);
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
	public boolean deleteCollectWall(CollectWall collectWall) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			session.delete(collectWall);
			flag = true;
			t.commit();
		} catch (Exception e) {
			System.out.println(e);
			flag = false;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}

	@Override
	public List<CollectWall> findAllCollectWallByUsername(String username) {
		List<CollectWall> list = new ArrayList<CollectWall>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from CollectWall as cw  where cw.username='"+username+"'";
			Query query = session.createQuery(hsql);
			list = query.list();
			t.commit();
			return list;
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return null;
	}
	
	@Override
	public CollectWall findCollectWallByUsername(String username,long wallid){
		CollectWall collectWall = new CollectWall();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from CollectWall as cw  where cw.username='"+username+"' and cw.wallid="+wallid;
			Query query = session.createQuery(hsql);
			collectWall = (CollectWall) query.uniqueResult();
			t.commit();
			return collectWall;
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return null;
	}

}
