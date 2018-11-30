package com.ow.framework.controller.action;





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
public class CommonForwardAction extends BaseAction{
	private static final long serialVersionUID = 3211831001847405471L;
	private String tempCode;
	public String subExecute() {
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
