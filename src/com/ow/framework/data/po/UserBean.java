package com.ow.framework.data.po;

public class UserBean extends AbstractBean{
	private String userName;
	private String  orgName;
	public UserBean (){
		
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		
		if("1".equals(this.getDataType())){
			this.userName = userName +"sdfghjkl";
		}
		else if("0".equals(this.getDataType())){
			this.userName = userName +"sdfghjkl";
		}
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	
	
	
}
