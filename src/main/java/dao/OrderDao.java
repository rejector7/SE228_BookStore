package dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;


import entity.User;
import entity.Book;
import entity.Order;
import entity.Orderitem;

public class OrderDao {
	private static OrderDao orderDao=null;
	
	public static OrderDao getInstance() {
		if(orderDao==null) {
			orderDao=new OrderDao();
		}
		return orderDao;
	}
	public boolean saveOrder(Order order) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.save(order);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
			return false;
		}
	}
	
	public List<Order> getOrders() {//int offset , int limits
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from Order";
			session.beginTransaction();
			List<Order> orders = session.createQuery(hql).list();
			//System.out.println(orders);
			session.getTransaction().commit();
			return orders;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Order> getOrders(int pageSize,int currentPage) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			//String hql = "from User limit ? , ?"; I don't know why this way does not work.
			String hql="from Order";
			session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setFirstResult((currentPage-1)*pageSize);
			query.setMaxResults(pageSize);
			List<Order> orders = query.list();
			session.getTransaction().commit();
			return orders;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Order> getOrdersByUserid(int userid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		String hql = "";
		try {
			session.beginTransaction();
			hql = "from Order od where userid=:userid order by od.orderid desc";
			//hql = "from Order as order where userID=:userID order by order.orderTime";
			Query query = session.createQuery(hql);
			query.setParameter("userid", userid);
			List<Order> orders = query.list();
			//
			session.getTransaction().commit();
			//System.out.println(orders);
			return orders;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
			return null;
		}
	}
	
	public List<Order> getOrdersByUserid(int pageSize, int currentPage, int userid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		String hql = "";
		try {
			session.beginTransaction();
			hql = "from Order od where userid=:userid order by od.date desc";
			//hql = "from Order as order where userID=:userID order by order.orderTime";
			Query query = session.createQuery(hql);
			query.setFirstResult((currentPage-1)*pageSize);
			query.setMaxResults(pageSize);
			query.setParameter("userid", userid);
			List<Order> orders = query.list();
			//
			session.getTransaction().commit();
			//System.out.println(orders);
			return orders;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
			return null;
		}
	}
	
	public boolean destroyOrder(int orderid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Order order = (Order) session.load(Order.class, orderid);
			session.delete(order);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
			return false;
		}
	}
	
	public boolean updateOrder(Order order) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.update(order);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return false;
	}
	
	public int getOrderTotalNum(){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from Order";
			session.beginTransaction();
			List<Order> list= session.createQuery(hql).list();
			session.getTransaction().commit();
			int totalNum=list.size();
			return totalNum;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return 0;
	}
	
	public int getOrderTotalNumByUserid(int userid){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from Order  where userid=:userid";
			session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setParameter("userid", userid);
			List<Order> list= query.list();
			session.getTransaction().commit();
			int totalNum=list.size();
			return totalNum;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return 0;
	}
	//
	public Order getOrderById(Integer orderid){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			
			String hql = "from Order where orderid = ?0";
			session.beginTransaction();
			List<Order> list = session.createQuery(hql).setParameter(0, orderid).list();
			session.getTransaction().commit();
			if(list.size() == 1)
				return (Order)list.get(0);
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return null;
	}
	//for search order by username
	public List<Order> getOrderByUsername(String username){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		String hql = "";
		try {
			hql = "select a.userid from User a where a.username like ?0";
			session.beginTransaction();
			List<Integer> userids = session.createQuery(hql).setParameter(0, "%"+username+"%").list();
			int tempUserid=0;
			List<Order> orders=null;
			if(userids!=null) {
				for(int i=0;i<userids.size();i++) {
					tempUserid=userids.get(i);
					hql= "from Order od where userid=:userid order by od.date desc";
					List<Order> tempOrders=null;
					tempOrders=session.createQuery(hql).setParameter("userid", tempUserid).list();
					if(orders==null) {
						orders=tempOrders;
					}else {
						orders.addAll(tempOrders);
					}
				}
			}
			session.getTransaction().commit();
//			System.out.println(Users);
			if(orders.size()>0)
				return orders;
			else
				return null;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return null;
	}
	
	public int getMaxId() {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from Order order by orderid desc";
			session.beginTransaction();
			List<Order> list= session.createQuery(hql).list();
			session.getTransaction().commit();
			int maxid=0;
			if(list!=null) {
				maxid=list.get(0).getOrderid();
			}
			return maxid;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return 0;
	}
}
