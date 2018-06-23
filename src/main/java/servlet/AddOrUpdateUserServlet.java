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
 * Servlet implementation class AddOrUpdateUserServlet
 */
@WebServlet("/AddOrUpdateUserServlet")
public class AddOrUpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddOrUpdateUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String phone=request.getParameter("phone");
		String userid=null;
		
		User user= new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setPhone(phone);
		
		if(request.getParameter("userid")!=null) {
			userid=request.getParameter("userid");
			user.setUserid(Integer.parseInt(userid));
			boolean flag= UserDao.getInstance().updateUser(user);
			PrintWriter out = response.getWriter();
			if(flag==true) {
				out.print("updateUserT");
			}
			else {
				out.print("updateUserF");
			}
			return;
		}
		boolean flag= UserDao.getInstance().saveUser(user);
		PrintWriter out = response.getWriter();
		if(flag==true) {
			out.print("saveUserT");
		}
		else {
			out.print("saveUserF");
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
