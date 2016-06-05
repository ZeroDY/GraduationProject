package com.footmark.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.footmark.dao.WallDAO;
import com.footmark.model.User;
import com.footmark.model.Wall;
import com.footmark.tools.HibernateSessionFactory;

public class WallDAOImpl implements WallDAO {

	@Override
	public boolean createWall(Long wallid,String wallName, String wallSignature,
			User user, Integer wallType, double x, double y,
			String wallImage,String walladress) {
		boolean flag = false;
		try {
			if (user != null) {
				Session session = HibernateSessionFactory.getSession();
				Transaction t = session.beginTransaction();
				Wall wall = new Wall(wallid,user, wallName, wallSignature, wallType,
						x, y, wallImage,walladress);
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
	public boolean deleteWall(Long wallid) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "delete from Wall as w where w.wallid = "+wallid ;
			Query query = session.createQuery(hsql);
			int ret = query.executeUpdate();
			t.commit();
			return true;
		} catch (Exception e) {
			System.out.println(e);
			flag = false;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}

	@Override
	public boolean updateWall(Long wallid, String wallName,
			String wallSignature, String wallImage, Integer wallType,
			int wallStatus) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			Wall wall = (Wall) session.get(Wall.class, wallid);
			wall.setWallname(wallName);
			wall.setWallsignature(wallSignature);
			wall.setWallimage(wallImage);
			wall.setWalltype(wallType);
			wall.setWallstatus(wallStatus);
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
	public boolean updateWallUser(Long wallid, User user) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			Wall wall = (Wall) session.get(Wall.class, wallid);
			wall.setUser(user);
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
	public List<Wall> findWallsByUserName(String username) {
		List<Wall> list = new ArrayList<Wall>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Wall as w left join fetch w.user where w.user.username = '"+username+"' order by w.wallcreattime desc" ;
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
	public Wall findWallByWallid(Long wallid) {
		Wall wall = new Wall();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Wall w left join fetch w.user where w.wallid ="+wallid;
			Query query = session.createQuery(hsql);
			wall = (Wall) query.uniqueResult();
			System.out.println(wall.getWallcreattime());
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
	public List<Wall> findWallsByXY(double x, double y) {
		List<Wall> list = new ArrayList<Wall>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Wall w left join fetch w.user where w.xcoordinate between "+
						(x-0.01)+" and "+(x+0.01)+" and w.ycoordinate between "+
						(y-0.01)+" and "+(y+0.01) +"and w.walltype = 1  order by w.wallcreattime desc";
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
