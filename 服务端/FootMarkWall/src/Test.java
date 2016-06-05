import java.util.List;

import com.footmark.dao.MessageDAO;
import com.footmark.dao.ReviewDAO;
import com.footmark.dao.UserDAO;
import com.footmark.dao.WallDAO;
import com.footmark.dao.impl.MessageDAOImpl;
import com.footmark.dao.impl.ReviewDAOImpl;
import com.footmark.dao.impl.UserDAOImpl;
import com.footmark.dao.impl.WallDAOImpl;
import com.footmark.model.Message;
import com.footmark.model.Review;
import com.footmark.model.User;
import com.footmark.model.Wall;


public class Test {

	public static void main(String[] args) {
		/*
		 * 用户
		 * 
		 * UserDAO userDAO = new UserDAOImpl();	
		System.out.println((User)userDAO.Login("test01", "qaz123"));
		//System.out.println(userDAO.register("test06", "qaz123", "测试用户5"));
		System.out.println(userDAO.updateUser("test01", "qaz123", "zhou", "1234555555", "fwsfqwfqwe", 1, 21, "女"));
		 */
		UserDAO userDAO = new UserDAOImpl();	
		
		
		/*墙
		 * WallDAO wallDAO = new WallDAOImpl();
		//System.out.println(wallDAO.createWall("测试墙02", "这是第2面测试墙", "test01", 1, 110.101, 21.435, null));
		System.out.println(wallDAO.updateWall((long) 1, "ceshiqiang", "xiugaihoudeceshiqiang", "tupiandizhi", 0, 2));
		System.out.println(wallDAO.findWallsByUserName("test01").size());
		System.out.println(wallDAO.findWallByWallid((long)2).getMessages().size());
		List<Wall> walls = wallDAO.findWallsByXY(110.101, 21.435);
		for (Wall wall : walls) {
			System.out.println(wall.getWallid());
		}
		 */
		WallDAO wallDAO = new WallDAOImpl();
		
		/*
		 * 消息
		 */
		MessageDAO messageDAO = new MessageDAOImpl();
//		User user = userDAO.findUserByUserName("test01");
//		Wall wall = wallDAO.findWallByWallid((long)2);
//		System.out.println(messageDAO.createMessage(user, wall, "这是我发布的第一条信息", 1, 1, null));
//		
//		System.out.println(messageDAO.updateMessage((long)2, "这是我发布的第一条信息cccccc", 2, 2, "http://"));
//		
//		List<Message> messages = messageDAO.findMsgByUsernameAndType("test01", 2);
//		for (Message message : messages) {
//			System.out.println(message.getMsgcontent());
//		}
//		
//		System.out.println(messageDAO.findMsgByMsgid((long)2).getReviews().size());
		
		/*
		 * 评论
		 */
		ReviewDAO reviewDAO = new ReviewDAOImpl();
		reviewDAO.createReview((long)2, "test01", "test02","这是第er条评论");
		reviewDAO.updateReviewStatus((long)1, 1);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}

}
