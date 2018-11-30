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
public class LoginAction extends BaseAction{
    
	public LoginAction(){
		
	}
	
	private static final long serialVersionUID = -6051180931889331167L;
	public String subExecute() {
		this.eventExecutor.generalEventExecutor();
		if(this.eventExecutor.getExecutorResult().getResultData(0).getIntResult() > 0){
			return IAction.SUCCESS;
		}
		return IAction.FAIL;
	}   
}


