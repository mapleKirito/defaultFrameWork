package com.ow.framework.controller.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class ChildrenDecorateAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String childrenname;	

	public String getChildrenname() {
		return childrenname;
	}


	public void setChildrenname(String childrenname) {
		this.childrenname = childrenname;
	}


	public String execute() {
		HttpServletRequest request = ServletActionContext.getRequest();   
		String childrenpath = request.getParameter("cutchangepage");
		if(!"".equals("")){
			childrenname = childrenpath;	
			return SUCCESS;	
		}else{
			return ERROR;
		}
				
	}
}