package com.ow.framework.listener.event.impl;

import java.util.HashMap;
import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class PreparingCenter implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public PreparingCenter()
	{
		resultData = new ResultData();
	}		
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String idsql =  eventExecutor.getSqlidByIndex(0);
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			String srOperaPath =(String)map.get("srOperaPath");
			if (srOperaPath!=null ){
				eventExecutor.getSqlSession().update(idsql, map);
				resultData.setIntResult(1);
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, PreparingCenter.class);
			log.error(error);
			throw e;
		}
	}
}
