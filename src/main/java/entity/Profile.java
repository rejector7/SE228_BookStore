package entity;


public class Profile {
	private int userid;
	private String richText;
	
	public Profile() {
		this.userid=0;
		this.richText="";
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getRichText() {
		return richText;
	}
	public void setRichText(String richText) {
		this.richText = richText;
	}
	
	
	
	
}
