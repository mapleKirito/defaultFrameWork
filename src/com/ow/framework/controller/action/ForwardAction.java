package com.ow.framework.controller.action;

import java.io.UnsupportedEncodingException;





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
public class ForwardAction extends BaseAction{
	private static final long serialVersionUID = 3211831001847405471L;
	private String tempCode;
	public String subExecute() {
		String rname = super.getParamMap().get("resname") == null? "" :super.getParamMap().get("resname").toString();
		try {
			if (!rname.equals("")){
				super.getParamMap().put("resname", new String(rname.toString().getBytes("ISO-8859-1"),"utf-8"));
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		/**执行初始化事件*/
		this.eventExecutor.initEventExecutor();
		return IAction.MODULE;
	}
	public String getTempCode() {
		return tempCode;
	}
	public void setTempCode(String tempCode) {
		this.tempCode = tempCode;
	}
	
}
