package com.ow.framework.controller.action;

public interface IAction {
	/**登录错误*/
	public static final String LOGINERROR = "login_error";
	/**退出系统*/
	public static final String LOGINOUT = "loginout";
	/**操作成功跳转变量*/
	public static final String SUCCESS = "success";
	/**操作失败跳转变量*/
	public static final String FAIL = "fail";
	/**action通用跳转变量*/
	public static final String MODULE = "module";
	/**action通用跳转变量*/
	public static final String CONFIRM = "confirm";
	
}
