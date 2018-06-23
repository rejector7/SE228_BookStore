package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.sf.json.JSONArray;

import entity.*;
import dao.*;
/**
 * Servlet implementation class WXCartManagerServlet
 */
@WebServlet("/WXCartManagerServlet")
public class WXCartManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WXCartManagerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			PrintWriter out=response.getWriter();
			response.setContentType("text/html;charset=utf-8");
			
			System.out.println("This is a cart manager");
			int userid=0;
			if(request.getParameter("userid")!=null) {
				userid=Integer.parseInt(request.getParameter("userid"));
			}
			List<Cartitem> result=CartitemDao.getInstance().getCartitemsByUserid(userid);
			Iterator<Cartitem> it=result.iterator();
			
			ArrayList<JSONArray> cartsJson = new ArrayList<JSONArray>();
			
			Book book=new Book();
            while (it.hasNext()) {
                Cartitem item = (Cartitem) it.next();
                ArrayList<String> arrayList = new ArrayList<String>();
                
                book = BookDao.getInstance().getBookById(item.getBookid());
                arrayList.add(book.getBookname());
                arrayList.add(Double.toString(book.getPrice()));
                arrayList.add(Integer.toString(item.getBooknum()));                          
                cartsJson.add(JSONArray.fromObject(arrayList));
            }
            JSONArray carts = JSONArray.fromObject(cartsJson.toArray());

            System.out.println(carts);
            out.println(carts);
            out.flush();
            out.close();
            HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().commit();
		}
		catch (Exception ex) {
            HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().rollback();
            if ( ServletException.class.isInstance( ex ) ) {
                throw ( ServletException ) ex;
            }
            else {
                throw new ServletException( ex );
            }
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
