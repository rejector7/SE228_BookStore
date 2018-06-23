package servlet;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.*;
import dao.*;
/**
 * Servlet implementation class WXLoginServlet
 */
@WebServlet("/WXLoginServlet")
public class WXLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WXLoginServlet() {
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
			};
			String password = "";
			if(request.getParameter("pwd")!=null) {
				password=request.getParameter("pwd");
			}
			
			Boolean isValid = login(username, password);
			if(isValid==true) {
				int userid=0;
				userid=UserDao.getInstance().getUserEqualUsername(username).get(0).getUserid();
				out.print(userid);
			}else {
				out.print(isValid);
			}
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
	
	private Boolean login(String username, String password) {
		Boolean isValid = false;
		List<User> users = (List<User>) UserDao.getInstance().getUserEqualUsername(username);
		if(users!=null) {
			User user=new User();
			for(int i=0;i<users.size();i++) {
				user=users.get(i);
				if(user.getPassword().equals(password)) {
					isValid=true;
					break;
				}
				else continue;
			}
		}
		
		return isValid;
	}

}
