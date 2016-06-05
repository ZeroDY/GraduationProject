package com.footmark.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.footmark.dao.ReviewDAO;
import com.footmark.model.Message;
import com.footmark.model.Review;
import com.footmark.model.User;
import com.footmark.tools.HibernateSessionFactory;

public class ReviewDAOImpl implements ReviewDAO {

	@Override
	public boolean createReview(long msgid, String fromUserName,
			String toUserName, String revContent) {
		boolean flag = false;
		try {
			User fromUser = new User(fromUserName);
			User toUser = new User(toUserName);
			Message message = new Message(msgid);
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			Review review = new Review(toUser, message, fromUser, revContent);
			session.save(review);
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
	public boolean updateReviewStatus(long revid, Integer revStatus) {
		boolean flag = false;
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			Review review = (Review) session.get(Review.class, revid);
			review.setRevstatus(revStatus);
			session.update(review);
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
	public List<Review> findReviewByMsgid(long msgid) {
		List<Review> list = new ArrayList<Review>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Review as r where r.message.msgid = "+msgid+ " order by r.revtime desc";
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
	public List<Review> findReviewByFromUser(String username) {
		List<Review> list = new ArrayList<Review>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Review as r where r.userByFromuser.username = '"+username+"'  order by r.revtime desc";
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
	public List<Review> findReviewByToUser(String username) {
		List<Review> list = new ArrayList<Review>();
		try {
			Session session = HibernateSessionFactory.getSession();
			Transaction t = session.beginTransaction();
			String hsql = "from Review as r where r.userByTouser.username = '"+username+"'  order by r.revtime desc";
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
