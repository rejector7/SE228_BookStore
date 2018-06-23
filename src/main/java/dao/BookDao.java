package dao;

import java.util.*;


import org.hibernate.Query;
import org.hibernate.Session;


import entity.User;
import entity.Book;
import entity.Order;
import entity.Orderitem;


public class BookDao {
	private static BookDao bookDao=null;
	
	public static BookDao getInstance() {
		if(bookDao==null) {
			bookDao=new BookDao();
		}
		return bookDao;
	}
	public boolean saveBook(Book book) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.save(book);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return false;
		
	}
	
	public boolean updateBook(Book book) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.update(book);
			session.getTransaction().commit();
			//System.out.println("here we are");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return false;
	}
	
	public boolean destroyBook(int bookid) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Book book = (Book) session.load(Book.class, bookid);
			session.delete(book);
			session.getTransaction().commit();
			return true;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
			return false;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<Book> getBooks() {//int offset , int limits
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from Book";
			session.beginTransaction();
			List<Book> books = session.createQuery(hql).list();
			session.getTransaction().commit();
			return books;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings({ "unchecked", "deprecation", "rawtypes" })
	public List<Book> getBooks(int pageSize,int currentPage) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			//String hql = "from Book limit ? , ?"; I don't know why this way does not work.
			String hql="from Book";
			session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setFirstResult((currentPage-1)*pageSize);
			query.setMaxResults(pageSize);
			List<Book> books = query.list();
			session.getTransaction().commit();
			return books;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return null;
	}
	//bookname like is Ok, not totally the same.
	public List<Book> getBookByBookname(String bookname){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		String hql = "";
		try {
			hql = "from Book a where a.bookname like ?0";
			session.beginTransaction();
			List<Book> books = session.createQuery(hql).setParameter(0, "%"+bookname+"%").list();
			session.getTransaction().commit();
//			System.out.println(books);
			if(books.size()>0)
				return books;
			else
				return null;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return null;
	}
	
	public Book getBookById(Integer bookid){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			
			String hql = "from Book where bookid = ?0";
			session.beginTransaction();
			List<Book> list = session.createQuery(hql).setParameter(0, bookid).list();
			session.getTransaction().commit();
			if(list.size() == 1)
				return (Book)list.get(0);
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return null;
	}
	

	public int getBookTotalNum(){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			String hql = "from Book";
			session.beginTransaction();
			List<Book> list= session.createQuery(hql).list();
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
			String hql = "from Book order by bookid desc";
			session.beginTransaction();
			List<Book> list= session.createQuery(hql).list();
			session.getTransaction().commit();
			int maxid=0;
			if(list!=null) {
				maxid=list.get(0).getBookid();
			}
			return maxid;
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} 
		return 0;
	}
}
