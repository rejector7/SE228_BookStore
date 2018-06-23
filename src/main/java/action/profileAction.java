package action;

import dao.*;


import entity.*;

import java.util.List;

import com.opensymphony.xwork2.ActionSupport;

import org.apache.struts2.conversion.*;
import org.springframework.*;

import java.io.File;
import java.io.FileInputStream;
import java.util.regex.Pattern;

public class profileAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userid;
	private String username;
	private String phone;
	/*
	private String resource;
	
	
	private File file;
	private String fileFileName;
	*/
	private String richText;
	public String execute() throws Exception{
		User user=null;
		user=UserDao.getInstance().getUserById(Integer.parseInt(userid));
		Profile profile=new Profile();

		ProfileDao profileDao=new ProfileDao();
		
		if(user==null) {
			addActionError("The user is not present!");
			return ERROR;
		}
		else {
			user=UserDao.getInstance().getUserById(Integer.parseInt(userid));
			user.setUsername(username);
			user.setPhone(phone);
			
			UserDao.getInstance().updateUser(user);
			
			profile.setUserid(Integer.parseInt(userid));
			profile.setRichText(richText);
			
			if(profileDao.profileExistByUser(user)==true) {
				profileDao.update(profile);
			}else {
				profileDao.insert(profile);
			}
			/*
			Pattern imagePattern=Pattern.compile("^.*\\.(jpg|png|gif|bmp|jpeg|tiff|svg|webp)$",
                    Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE);
			if(!imagePattern.matcher(fileFileName).matches()) {
				addActionError("File extension not allowed");
				return ERROR;
			}
			*/
			/*
			profile.setResource(resource);
			profile.setUserid(Integer.parseInt(userid));
			profile.setId(System.currentTimeMillis());
			
			profileDao.insert(profile);
			*/
			
			
			/*
			 * 
			 * for profile
			 * 
			 * */
			addActionMessage("Update Succeed!");
			return SUCCESS;
		}
		
		
	}
	
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRichText() {
		return richText;
	}

	public void setRichText(String richText) {
		this.richText = richText;
	}

	
	/*
	public String getResource() {
		return resource;
	}
	public void setResource(String resource) {
		this.resource = resource;
	}
	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}
	public String getFilename() {
		return fileFileName;
	}

	public void setFilename(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	*/
	
	
	
}
