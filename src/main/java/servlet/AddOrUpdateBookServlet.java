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
 * Servlet implementation class AddBookServlet
 */
@WebServlet("/AddOrUpdateBookServlet")
public class AddOrUpdateBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddOrUpdateBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String bookname=request.getParameter("bookname");
		String price=request.getParameter("price");
		String stock=request.getParameter("stock");
		String description=request.getParameter("description");
		String bookid=null;
		
		Book book=new Book();
		book.setBookname(bookname);
		book.setPrice(Double.parseDouble(price));
		book.setStock(Integer.parseInt(stock));
		book.setDescription(description);
		
		if(request.getParameter("bookid")!=null) {
			bookid=request.getParameter("bookid");
			book.setBookid(Integer.parseInt(bookid));
			boolean flag= BookDao.getInstance().updateBook(book);
			PrintWriter out = response.getWriter();
			if(flag==true) {
				out.print("updateBookT");
			}
			else {
				out.print("updateBookF");
			}
			return;
		}
		
		boolean flag= BookDao.getInstance().saveBook(book);
		PrintWriter out = response.getWriter();
		if(flag==true) {
			out.print("saveBookT");
		}
		else {
			out.print("saveBookF");
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
