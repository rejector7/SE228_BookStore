package action;

import dao.*;

import entity.*;

import java.util.List;

import com.opensymphony.xwork2.ActionSupport;

public class UserRegisterAction extends ActionSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String username;
	private String password;
	private String phone;
	
	
	public String execute() throws Exception{
		List<User> users=UserDao.getInstance().getUserEqualUsername(username);
		if(users!=null) {
			addActionError("The username has been occupied!");
			return ERROR;
		}
		User user=new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setPhone(phone);
		UserDao.getInstance().saveUser(user);
		addActionMessage("Register Succeed!");
		return SUCCESS;
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
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}


}


