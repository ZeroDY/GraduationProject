package com.footmark.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.footmark.dao.AtdWallDAO;
import com.footmark.model.AtdWall;
import com.footmark.model.User;
import com.footmark.model.Wall;
import com.footmark.tools.HibernateSessionFactory;
import com.footmark.tools.ResultObject;

public class AtdWallDAOImpl implements AtdWallDAO {

	@Override
	public boolean createAtdWall( String atdwallname, User user,
			double x, double y) {
		boolean flag = false;
		try {
			if (user != null) {
				Session session = HibernateSessionFactory.getSession();
				Transaction t = session.beginTransaction();
				AtdWall wall = new AtdWall(atdwallname, x, y, user );
				session.save(wall);
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

	@Override
	public boolean updateAtdWall(Long wallid, int wallStatus) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			AtdWall wall = (AtdWall) session.get(AtdWall.class, wallid);
			wall.setAtdwallstatus(wallStatus);
			session.update(wall);
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
	public boolean deleteAtdWall(Long wallid) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			AtdWall wall = (AtdWall) session.get(AtdWall.class, wallid);
			session.delete(wall);
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
	public List<AtdWall> findAtdWallsByUserName(String username) {
		List<AtdWall> list = new ArrayList<AtdWall>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from AtdWall as w left join fetch w.user where w.user.username = '"+username+"'  order by w.atdwallcreattime desc";
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
	public AtdWall findAtdWallByAtdWallid(Long wallid) {
		AtdWall wall = new AtdWall();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from AtdWall w  where w.atdwallid ="+wallid;
			Query query = session.createQuery(hsql);
			wall = (AtdWall) query.uniqueResult();
			t.commit();
			return wall;
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return null;
	}

	@Override
	public List<AtdWall> findAtdAtdWallsByXY(double x, double y) {
		List<AtdWall> list = new ArrayList<AtdWall>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from AtdWall w left join fetch w.user where w.atdxcoordinate between "+
					(x-0.01)+" and "+(x+0.01)+" and w.atdycoordinate between "+
					(y-0.01)+" and "+(y+0.01)+" and w.atdwallstatus=1  order by w.atdwallcreattime desc";
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

}
