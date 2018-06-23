package dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import entity.Admin;

public class AdminDao {
private static AdminDao adminDao=null;
	
	public static AdminDao getInstance() {
		if(adminDao==null) {
			adminDao=new AdminDao();
		}
		return adminDao;
	}
	public boolean saveAdmin(Admin admin) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.save(admin);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return false;
		
	}
	
	public boolean updateAdmin(Admin admin) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.update(admin);
			session.getTransaction().commit();
			//System.out.println("here we are");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return false;
	}
	
	public boolean destroyAdmin(int adminid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Admin admin = (Admin) session.load(Admin.class, adminid);
			session.delete(admin);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
			return false;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<Admin> getAdmins() {//int offset , int limits
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from Admin";
			session.beginTransaction();
			List<Admin> admins = session.createQuery(hql).list();
			session.getTransaction().commit();
			return admins;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings({ "unchecked", "deprecation", "rawtypes" })
	public List<Admin> getAdmins(int pageSize,int currentPage) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			//String hql = "from Admin limit ? , ?"; I don't know why this way does not work.
			String hql="from Admin";
			session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setFirstResult((currentPage-1)*pageSize);
			query.setMaxResults(pageSize);
			List<Admin> admins = query.list();
			session.getTransaction().commit();
			return admins;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	//Adminname like is Ok, not totally the same.
	public List<Admin> getAdminByAdminname(String adminname){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		String hql = "";
		try {
			hql = "from Admin where adminname = ?0";
			session.beginTransaction();
			List<Admin> admins = session.createQuery(hql).setParameter(0, adminname).list();
			session.getTransaction().commit();
//			System.out.println(Admins);
			if(admins.size()>0)
				return admins;
			else
				return null;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return null;
	}
	
	public Admin getAdminById(Integer adminid){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			
			String hql = "from Admin where adminid = ?0";
			session.beginTransaction();
			List<Admin> list = session.createQuery(hql).setParameter(0, adminid).list();
			session.getTransaction().commit();
			if(list.size() == 1)
				return (Admin)list.get(0);
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return null;
	}
	

	public int getAdminTotalNum(){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from Admin";
			session.beginTransaction();
			List<Admin> list= session.createQuery(hql).list();
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
			String hql = "from Admin order by adminid desc";
			session.beginTransaction();
			List<Admin> list= session.createQuery(hql).list();
			session.getTransaction().commit();
			int maxid=0;
			if(list!=null) {
				maxid=list.get(0).getAdminid();
			}
			return maxid;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return 0;
	}
}
