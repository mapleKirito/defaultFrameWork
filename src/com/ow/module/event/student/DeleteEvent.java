package com.ow.module.event.student;

import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class DeleteEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public DeleteEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String[] sid = eventExecutor.getSqlidArr();
			for(int i = 0 ; i < sid.length; i ++){
				if (sid[i] != null && !sid[i].equals("")){
					int rvalue = eventExecutor.getSqlSession().delete(sid[i], eventExecutor.getBaseAction().getParamMap());
					resultData.setIntResult(1);
				}	
			}
			
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, DeleteEvent.class);
			log.error(error);
			throw e;
		}
	}
}