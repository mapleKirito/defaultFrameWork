package com.ow.framework.listener.event;

import java.util.HashMap;

import com.ow.framework.controller.action.BaseAction;
import com.ow.framework.data.handler.config.Permission;
import com.opensymphony.xwork2.ActionSupport;

public interface Executor {
	public ExecutorResult generalEventExecutor();
	public void initEventExecutor();
	public ExecutorResult getExecutorResult();
	public String getSqlidByIndex(int index);
	public Permission getPermission() ;
	public BaseAction getBaseAction() ;
	public String getCode();
	public String getPromptInfo(String code, HashMap<String, String> paramMap,
			ActionSupport actionSupport, String suffix);
}
