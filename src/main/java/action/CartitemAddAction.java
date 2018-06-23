package action;

import dao.*;


import entity.*;
import java.util.*;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class CartitemAddAction extends ActionSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int userid;
	private int bookid;
	private int booknum;
	
	private String bookname;
	private int stock;
	private double price;
	private String description;
	
	

	public String execute() throws Exception{
		Cartitem cartitem=new Cartitem();
		cartitem.setUserid(userid);
		cartitem.setBookid(bookid);
		cartitem.setBooknum(booknum);
		/* the stock is changable , so it is not important now.
		Book book=null;
		book=BookDao.getInstance().getBookById(bookid);
		if(book!=null) {
			if(book.getStock()<booknum) {
				addActionError("Not Enough Stock! Change Your Number Please!");
				return ERROR;
			}
		}
		*/
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setAttribute("userid", userid);
		request.setAttribute("bookid", bookid);
		boolean flag=CartitemDao.getInstance().saveCartitem(cartitem);
		if(flag==true) {
			addActionMessage("Cartitem Add Succeed!");
			return SUCCESS;
		}
		else {
			addActionError("Cartitem Add Failed!");
			return ERROR;
		}
		
	}
	
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public int getBookid() {
		return bookid;
	}
	public void setBookid(int bookid) {
		this.bookid = bookid;
	}
	public int getBooknum() {
		return booknum;
	}
	public void setBooknum(int booknum) {
		this.booknum = booknum;
	}

	public String getBookname() {
		return bookname;
	}

	public void setBookname(String bookname) {
		this.bookname = bookname;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
