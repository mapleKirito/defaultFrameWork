package com.staticHtml.bean;

public class ShiyanBean {
	private String shiyanPath;
	private String shiyanName;
	public String getShiyanPath() {
		return shiyanPath;
	}
	public void setShiyanPath(String shiyanPath) {
		this.shiyanPath = shiyanPath;
	}
	public String getShiyanName() {
		return shiyanName;
	}
	public void setShiyanName(String shiyanName) {
		this.shiyanName = shiyanName;
	}
	public ShiyanBean(String shiyanPath, String shiyanName) {
		super();
		this.shiyanPath = shiyanPath;
		this.shiyanName = shiyanName;
	}
	
	
}
