package servlet;

import java.io.IOException;


import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.*;
import entity.*;
import dao.*;

/**
 * Servlet implementation class AddOrUpdateOrderServlet
 */
@WebServlet("/AddOrUpdateOrderServlet")
public class AddOrUpdateOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddOrUpdateOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String status=request.getParameter("status");
		
		String orderid=null;
		
		Order order= new Order();
		order.setStatus(Integer.parseInt(status));
		
		
		if(request.getParameter("orderid")!=null) {
			orderid=request.getParameter("orderid");
			order.setOrderid(Integer.parseInt(orderid));
			boolean flag= OrderDao.getInstance().updateOrder(order);
			PrintWriter out = response.getWriter();
			if(flag==true) {
				out.print("updateOrderT");
			}
			else {
				out.print("updateOrderF");
			}
			return;
		}
		boolean flag= OrderDao.getInstance().saveOrder(order);
		PrintWriter out = response.getWriter();
		if(flag==true) {
			out.print("saveOrderT");
		}
		else {
			out.print("saveOrderF");
		}
		return;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
