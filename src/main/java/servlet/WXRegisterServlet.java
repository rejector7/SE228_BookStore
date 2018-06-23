package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import entity.*;
import dao.*;

/**
 * Servlet implementation class WXRegisterServlet
 */
@WebServlet("/WXRegisterServlet")
public class WXRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WXRegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				try {
					PrintWriter out = response.getWriter();

					String username = "";
					if(request.getParameter("name")!=null) {
						username=request.getParameter("name");
					}
					String password = "";
					if(request.getParameter("pwd")!=null) {
						password=request.getParameter("pwd");
					}
					String passwordConfirm = "";
					if(request.getParameter("pwdConfirm")!=null) {
						passwordConfirm=request.getParameter("pwdConfirm");
					}
					Boolean isValid = register(username, password, passwordConfirm);

					out.println(isValid);
					out.flush();
					out.close();
				} catch (Exception ex) {
					if (ServletException.class.isInstance(ex)) {
						throw (ServletException) ex;
					} else {
						throw new ServletException(ex);
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
	
	private Boolean register(String username, String password, String passwordConfirm) {
		Boolean isValid = false;
		if(!password.equals(passwordConfirm)) {
			System.out.println("not equal");
			return isValid;
		}
		System.out.println("equal");
		if(UserDao.getInstance().getUserEqualUsername(username)!=null) {
			return isValid;
		}
		User user=new User();
		user.setUsername(username);
		user.setPassword(password);
		if(UserDao.getInstance().saveUser(user)) {
			isValid=true;
		}
		return isValid;
	}

}


