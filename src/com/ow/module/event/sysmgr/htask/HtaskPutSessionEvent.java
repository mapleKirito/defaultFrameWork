package com.ow.module.event.sysmgr.htask;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class HtaskPutSessionEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	public HtaskPutSessionEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "unchecked" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String filepath = eventExecutor.getBaseAction().getDirectFile();
			eventExecutor.getBaseAction().session.put("cutchangepage", filepath);
			
			resultData.setIntResult(1);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, HtaskPutSessionEvent.class);
			log.error(error);
			throw e;
		}
	}
}