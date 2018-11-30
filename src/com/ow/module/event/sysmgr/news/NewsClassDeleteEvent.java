package com.ow.module.event.sysmgr.news;

import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class NewsClassDeleteEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public NewsClassDeleteEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid1 = eventExecutor.getSqlidByIndex(0);
			String sid2 = eventExecutor.getSqlidByIndex(1);
			if (!"".equals(sid1) && !"".equals(sid2))
			{
				int rvalue1 = eventExecutor.getSqlSession().delete(sid1,eventExecutor.getBaseAction().getParamMap());
				int rvalue2 = eventExecutor.getSqlSession().delete(sid2,eventExecutor.getBaseAction().getParamMap());
				resultData.setIntResult(1);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, NewsClassDeleteEvent.class);
			log.error(error);
		}
		return resultData;
	}
}