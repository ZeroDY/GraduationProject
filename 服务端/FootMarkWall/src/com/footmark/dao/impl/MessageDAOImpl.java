package com.footmark.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.footmark.dao.MessageDAO;
import com.footmark.model.Message;
import com.footmark.model.User;
import com.footmark.model.Wall;
import com.footmark.tools.HibernateSessionFactory;

public class MessageDAOImpl implements MessageDAO {

	@Override
	public boolean createMessage(long msgid,User user, Wall wall, String msgContent,
			 String msgImage) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			Message msg = new Message(msgid,wall, user, msgContent,  msgImage);
			session.save(msg);
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
	public boolean updateMessage(long msgid, String msgContent,
			Integer msgType, Integer msgStatus, String msgImage) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			Message msg = (Message) session.get(Message.class, msgid);
			msg.setMsgcontent(msgContent);
			msg.setMsgtype(msgType);
			msg.setMsgstatus(msgStatus);
			msg.setMsgimage(msgImage);
			session.update(msg);
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
	public boolean updateMessageStatus(long msgid, Integer msgStatus) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			Message msg = (Message) session.get(Message.class, msgid);
			msg.setMsgstatus(msgStatus);
			session.update(msg);
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
	public boolean updateMessageType(long msgid, Integer msgType) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			Message msg = (Message) session.get(Message.class, msgid);
			msg.setMsgtype(msgType);
			session.update(msg);
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
	public List<Message> findAllMsgByWallid(long wallid) {
		List<Message> list = new ArrayList<Message>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Message as m where m.wall.wallid = "+
							wallid+"  order by m.msgcreattime desc";
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
	public List<Message> findAllUserMsgByUsername(String username) {
		List<Message> list = new ArrayList<Message>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Message as m  where m.user.username = '"+
							username+"'  order by m.msgcreattime desc";
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
	public List<Message> findMsgByUsernameAndStatus(String username,
			Integer msgStatus) {
		List<Message> list = new ArrayList<Message>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Message as m where m.user.username = '"+username+"' and m.msgstatus="+msgStatus+"   order by m.msgcreattime desc";
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
	public List<Message> findMsgByUsernameAndType(String username,
			Integer msgType) {
		List<Message> list = new ArrayList<Message>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Message as m where m.user.username = '"+
							username+"' and m.msgtype="+
							msgType+"   order by m.msgcreattime desc";
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
	public Message findMsgByMsgid(long msgid) {
		Message msg = new Message();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Message as m  where m.msgid="+msgid;
			Query query = session.createQuery(hsql);
			msg = (Message) query.uniqueResult();
			t.commit();
			return msg;
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return null;
	}
	
	public boolean deleteMsgByWallid(Long wallid) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "delete from Message as m where m.wall.wallid = "+wallid ;
			Query query = session.createQuery(hsql);
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
	
	public boolean deleteMsgByWallidAndUser(Long wallid,String username) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "delete from Message as m where m.user.username='"+username+"' and m.wall.wallid = "+wallid ;
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

}
