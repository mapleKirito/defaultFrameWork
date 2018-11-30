package com.ow.module.event.teacher;

import java.util.HashMap;
import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class FavoriteDeleteEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	public FavoriteDeleteEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String did = eventExecutor.getSqlidByIndex(0);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			if (!"".equals(did))
			{
				eventExecutor.getSqlSession().delete(did, paramMap);
				resultData.setIntResult(1);
			}				
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, FavoriteDeleteEvent.class);
			log.error(error);
			throw e;
		}
		return resultData;
	}
}