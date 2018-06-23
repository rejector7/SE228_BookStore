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

import dao.*;
import entity.*;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class WXOrderManagerServlet
 */
@WebServlet("/WXOrderManagerServlet")
public class WXOrderManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WXOrderManagerServlet() {
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
			
			System.out.println("This is a order manager");
			int userid=0;
			if(request.getParameter("userid")!=null) {
				userid=Integer.parseInt(request.getParameter("userid"));
			}
			List<Order> result=OrderDao.getInstance().getOrdersByUserid(userid);
			Iterator<Order> it=result.iterator();
			
			ArrayList<JSONArray> ordersJson = new ArrayList<JSONArray>();
			
			
            while (it.hasNext()) {
                Order order = (Order) it.next();
                ArrayList<String> arrayList = new ArrayList<String>();
                
                if(order.getDate()==null) {
                	arrayList.add("Not Set");
                }else {
                    arrayList.add(order.getDate().toString());
                }
                if(order.getPhone()==null) {
                	arrayList.add("Not Set");
                }else {
                	arrayList.add(order.getPhone());
                }
                
                if(order.getAddress()==null) {
                	arrayList.add("Not Set");
                }else {
                	arrayList.add(order.getAddress()); 
                }                  
                arrayList.add(Integer.toString(order.getStatus()));
                
                ordersJson.add(JSONArray.fromObject(arrayList));
            }
            JSONArray orders = JSONArray.fromObject(ordersJson.toArray());

            System.out.println(orders);
            out.println(orders);
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
