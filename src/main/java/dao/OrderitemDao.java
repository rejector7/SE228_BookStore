package dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;


import entity.User;
import entity.Book;
import entity.Order;
import entity.Orderitem;

public class OrderitemDao {
	private static OrderitemDao orderitemDao=null;
	
	public static OrderitemDao getInstance() {
		if(orderitemDao==null) {
			orderitemDao=new OrderitemDao();
		}
		return orderitemDao;
	}
	
	public boolean saveOrderitem(Orderitem item) {
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.save(item);
			session.getTransaction().commit();;
			session.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
			return false;
		}
	}
	
	public boolean destroyOrderitem(int itemid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Orderitem item = (Orderitem) session.load(Orderitem.class, itemid);
			session.delete(item);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean updateOrderitem(Orderitem item) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.update(item);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return false;
	}
	
	public List<Orderitem> getOrderitems() {//int offset , int limits
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from Orderitem";
			session.beginTransaction();
			List<Orderitem> items = session.createQuery(hql).list();
			session.getTransaction().commit();
			//System.out.println(users);
			return items;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	public int getItemNumByOrderid(int orderid) {//int offset , int limits
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from Orderitem items where orderid=:orderid order by items.itemid asc";
			session.beginTransaction();
			List<Orderitem> items = session.createQuery(hql).setParameter("orderid", orderid).list();
			session.getTransaction().commit();
			//System.out.println(users);
			if(items!=null) {
				return items.size();
			}
			else {
				return 0;
			}
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return 0;
	}
	public List<Orderitem> getOrderitems(int pageSize,int currentPage,int orderid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			//String hql = "from User limit ? , ?"; I don't know why this way does not work.
			String hql="from Orderitem items where orderid=:orderid order by items.itemid asc";
			session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setParameter("orderid", orderid);
			query.setFirstResult((currentPage-1)*pageSize);
			query.setMaxResults(pageSize);
			List<Orderitem> orderitems = query.list();
			session.getTransaction().commit();
			return orderitems;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	public List<Orderitem> getOrderitemByBookid(int bookid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			//String hql = "from User limit ? , ?"; I don't know why this way does not work.
			String hql="from Orderitem items where bookid=:bookid";
			session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setParameter("bookid", bookid);
			
			List<Orderitem> orderitems = query.list();
			session.getTransaction().commit();
			return orderitems;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	
	
}
