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
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String adminname=request.getParameter("adminname");
		String password=request.getParameter("password");
		//int adminid=0;
		List<Admin> admins=AdminDao.getInstance().getAdminByAdminname(adminname);
		boolean loginFlag=false;
		if(admins!=null) {
			Admin adminTemp=new Admin();
			for(int i=0;i<admins.size();i++) {
				adminTemp=admins.get(i);
				if(adminTemp.getPassword().equals(password)) {
					//adminid=adminTemp.getAdminid();
					loginFlag=true;
					break;
				}
				else continue;
			}
		}
		PrintWriter out = response.getWriter();
		
		if(loginFlag==true) {
			out.print("loginT");
			/*
			HttpSession session=request.getSession();
			session.setAttribute("adminname", adminname);
			session.setAttribute("adminid", adminid);
			request.setAttribute("returnValue", "T");
			request.getRequestDispatcher("admin/adminHomepage.jsp").forward(request, response);
			*/
		}
		else {
			out.print("loginF");
			/*
			request.setAttribute("returnValue", "F");
			request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
			*/
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
