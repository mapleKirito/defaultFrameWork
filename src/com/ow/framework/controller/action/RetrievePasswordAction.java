package com.ow.framework.controller.action;

import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.opensymphony.xwork2.Action;


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
public class RetrievePasswordAction extends BaseAction{


	/**
	 * 
	 */
	private static final long serialVersionUID = 1519947234719477624L;

	public ResultData[] resultData;
	
	public ResultData[] getResultData() {
		return resultData;
	}

	public void setResultData(ResultData[] resultData) {
		this.resultData = resultData;
	}

	
	public String subExecute() {
		try{
			this.eventExecutor.generalEventExecutor();
			if (this.eventExecutor.getExecutorResult() != null
					&& this.eventExecutor.getExecutorResult().getResult() != null
					&& this.eventExecutor.getExecutorResult().getResult().equals("1")){
				return IAction.SUCCESS;
			}
			else{
				return IAction.FAIL;
			}
		}catch(Exception e){
			DetailException.expDetail(e, this.getClass());
			return IAction.FAIL;
		}
	}
}
