package dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;


import entity.*;


public class CartitemDao {
	private static CartitemDao cartitemDao=null;
	public static CartitemDao getInstance() {
		if(cartitemDao==null) {
			cartitemDao=new CartitemDao();
		}
		return cartitemDao;
	}
	
	public boolean saveCartitem(Cartitem cartitem) {
		Session session=HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.save(cartitem);
			session.getTransaction();
			session.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
			session.close();
			return false;
		}
	}
	
	public boolean destroyCartitem(int cartitemid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Cartitem cartitem = (Cartitem) session.load(Cartitem.class, cartitemid);
			session.delete(cartitem);
			session.getTransaction().commit();
			session.close();
			return true;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean updateCartitem(Cartitem cartitem) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.update(cartitem);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return false;
	}
	
	public List<Cartitem> getCartitems() {//int offset , int limits
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from Cartitem";
			session.beginTransaction();
			List<Cartitem> cartitems = session.createQuery(hql).list();
			session.getTransaction().commit();
			//System.out.println(users);
			return cartitems;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	public int getItemNumByUserid(int userid) {//int offset , int limits
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from Cartitem items where userid=:userid order by items.cartitemid asc";
			session.beginTransaction();
			List<Cartitem> items = session.createQuery(hql).setParameter("userid", userid).list();
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
	
	public List<Cartitem> getCartitemsByUserid(int userid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			//String hql = "from User limit ? , ?"; I don't know why this way does not work.
			String hql="from Cartitem items where userid=:userid order by items.cartitemid asc";
			session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setParameter("userid", userid);
			List<Cartitem> cartitems = query.list();
			session.getTransaction().commit();
			return cartitems;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Cartitem> getCartitems(int pageSize,int currentPage,int userid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			//String hql = "from User limit ? , ?"; I don't know why this way does not work.
			String hql="from Cartitem items where userid=:userid order by items.cartitemid asc";
			session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setParameter("userid", userid);
			query.setFirstResult((currentPage-1)*pageSize);
			query.setMaxResults(pageSize);
			List<Cartitem> cartitems = query.list();
			session.getTransaction().commit();
			return cartitems;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	
	public Cartitem getCartitemById(int cartitemid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			//String hql = "from User limit ? , ?"; I don't know why this way does not work.
			String hql="from Cartitem items where cartitemid=:cartitemid";
			session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setParameter("cartitemid", cartitemid);
			List<Cartitem> cartitems = query.list();
			session.getTransaction().commit();
			if(cartitems.size()==1) {
				return cartitems.get(0);
			}
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
}
