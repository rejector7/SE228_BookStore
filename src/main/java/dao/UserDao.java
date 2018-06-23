package dao;

import java.util.*;

import org.hibernate.Query;
import org.hibernate.Session;


import entity.User;
import entity.Book;
import entity.Order;
import entity.Orderitem;


public class UserDao {
	private static UserDao userDao=null;
	
	public static UserDao getInstance() {
		if(userDao==null) {
			userDao=new UserDao();
		}
		return userDao;
	}
	
	public boolean saveUser(User user) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.save(user);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return false;
		
	}
	
	public boolean updateUser(User user) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.update(user);
			session.getTransaction().commit();
			//System.out.println("here we are");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return false;
	}
	
	public boolean destroyUser(int userid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			User user = (User) session.load(User.class, userid);
			session.delete(user);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
			return false;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<User> getUsers() {//int offset , int limits
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from User";
			session.beginTransaction();
			List<User> users = session.createQuery(hql).list();
			session.getTransaction().commit();
			return users;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings({ "unchecked", "deprecation", "rawtypes" })
	public List<User> getUsers(int pageSize,int currentPage) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			//String hql = "from User limit ? , ?"; I don't know why this way does not work.
			String hql="from User";
			session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setFirstResult((currentPage-1)*pageSize);
			query.setMaxResults(pageSize);
			List<User> users = query.list();
			session.getTransaction().commit();
			return users;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
		
		
	}
	//Username like is Ok, not totally the same.
	public List<User> getUserByUsername(String username){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		String hql = "";
		try {
			hql = "from User a where a.username like ?0";
			session.beginTransaction();
			List<User> users = session.createQuery(hql).setParameter(0, "%"+username+"%").list();
			session.getTransaction().commit();
//			System.out.println(Users);
			if(users.size()>0)
				return users;
			else
				return null;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return null;
	}
	
	public List<User> getUserEqualUsername(String username){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		String hql = "";
		try {
			hql = "from User a where a.username = ?0";
			session.beginTransaction();
			List<User> users = session.createQuery(hql).setParameter(0, username).list();
			session.getTransaction().commit();
//			System.out.println(Users);
			if(users.size()>0)
				return users;
			else
				return null;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return null;
	}
	
	public User getUserById(Integer userid){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			
			String hql = "from User where userid = ?0";
			session.beginTransaction();
			List<User> list = session.createQuery(hql).setParameter(0, userid).list();
			session.getTransaction().commit();
			if(list.size() == 1)
				return (User)list.get(0);
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return null;
	}
	

	public int getUserTotalNum(){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from User";
			session.beginTransaction();
			List<User> list= session.createQuery(hql).list();
			session.getTransaction().commit();
			int totalNum=list.size();
			return totalNum;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return 0;
	}
	
	public int getMaxId() {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from User order by userid desc";
			session.beginTransaction();
			List<User> list= session.createQuery(hql).list();
			session.getTransaction().commit();
			int maxid=0;
			if(list!=null) {
				maxid=list.get(0).getUserid();
			}
			return maxid;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return 0;
	}
}
