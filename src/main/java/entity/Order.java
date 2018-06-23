package entity;

import java.util.*;

public class Order {
	private int orderid,userid,status;
	private String address,phone;
	private Date date;
	private ArrayList<Orderitem> orderitems;
	public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public ArrayList<Orderitem> getOrderitems() {
		return orderitems;
	}
	public void setOrderitems(ArrayList<Orderitem> orderitems) {
		this.orderitems = orderitems;
	}
	
	
}
