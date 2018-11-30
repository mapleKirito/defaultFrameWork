package com.ow.framework.controller.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.data.handler.config.PermissionConfig;
import com.ow.framework.exception.DetailException;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class AjaxCheckCodeAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4643555457909937907L;
	private String certCode = null;
	public String subExecute() throws Exception {
		try {
	        HttpServletRequest request = ServletActionContext.getRequest();  
			this.certCode = request.getSession().getAttribute(Constant.CERT_CODE) == null ?"":request.getSession().getAttribute(Constant.CERT_CODE).toString();
			return IAction.SUCCESS;
		} catch (Exception e) {
			String error = DetailException.expDetail(e, PermissionConfig.class);
			log.error(error);
			return IAction.FAIL;
		}		
	}


	public String getCertCode() {
		return certCode;
	}


	public void setCertCode(String certCode) {
		this.certCode = certCode;
	}
	
}
