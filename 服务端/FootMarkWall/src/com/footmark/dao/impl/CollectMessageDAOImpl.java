package com.footmark.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.footmark.dao.CollectMessageDAO;
import com.footmark.model.CollectMessage;
import com.footmark.model.Message;
import com.footmark.model.User;
import com.footmark.tools.HibernateSessionFactory;

public class CollectMessageDAOImpl implements CollectMessageDAO {

	@Override
	public boolean collectMessage(String username, long msgid) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			CollectMessage collectMessage = new CollectMessage(username, msgid);
			session.save(collectMessage);
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
	public boolean deleteCollectMessage(CollectMessage collectMessage) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			session.delete(collectMessage);
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
	public List<CollectMessage> findAllCollectMessageByUsername(String username) {
		List<CollectMessage> list = new ArrayList<CollectMessage>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from CollectMessage as cm  where cm.username='"+username+"'";
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
	public CollectMessage findCollectMessageByUsername(String username,
			long msgid) {
		CollectMessage collectMessage = new CollectMessage();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from CollectMessage as cm  where cm.username='"+username+"' and cm.msgid="+msgid;
			Query query = session.createQuery(hsql);
			collectMessage = (CollectMessage) query.uniqueResult();
			t.commit();
			return collectMessage;
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return null;
	}

	

}
