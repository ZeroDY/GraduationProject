package com.footmark.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.footmark.dao.AtdDAO;
import com.footmark.model.Atd;
import com.footmark.model.AtdWall;
import com.footmark.model.Message;
import com.footmark.model.User;
import com.footmark.tools.HibernateSessionFactory;

public class AtdDAOImpl implements AtdDAO {

	@Override
	public boolean atd( User user, AtdWall wall, String atdinfo,
			String atdidentifier) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			Atd atd = new Atd( user, wall, atdinfo, atdidentifier);
			session.save(atd);
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
	public boolean isAtded(Long atdwallid, String atdidentifier) {
		List<Atd> list = new ArrayList<Atd>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Atd as a  where a.atdwall.atdwallid = "+atdwallid+" and a.atdidentifier = '"+
						atdidentifier+"'  order by a.atdtime desc" ;
			Query query = session.createQuery(hsql);
			list = query.list();
			t.commit();
			if (list.size() == 0) {
				return false;
			}			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return true;
	}
	
	public List<Atd> findAllAtdBuyAtdWallid(Long atdwallid){
		List<Atd> list = new ArrayList<Atd>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Atd as a where a.atdwall.atdwallid = "+ atdwallid +"  order by a.atdtime desc";
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
