package action;

import dao.*;


import entity.*;
import java.util.*;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class UserLoginAction extends ActionSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String username;
	private String password;
	
	public String execute() throws Exception{
		List<User> users=UserDao.getInstance().getUserEqualUsername(username);
		if(users!=null) {
			for(int i=0;i<users.size();i++) {
				if(users.get(i).getPassword().equals(password)) {
					Integer userid=users.get(i).getUserid();
					HttpServletRequest request=ServletActionContext.getRequest();
					request.setAttribute("userid", userid);
					return SUCCESS;
				}
				else continue;
			}
		}
		addActionError("Wrong username or password!");
		return ERROR;
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}


