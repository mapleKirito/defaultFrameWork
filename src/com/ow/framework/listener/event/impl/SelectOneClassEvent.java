package com.ow.framework.listener.event.impl;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class SelectOneClassEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	public SelectOneClassEvent()
	{
		resultData = new ResultData();
	}	
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			HashMap<String, String> map = eventExecutor.getBaseAction().getParamMap();
			if (!"".equals(sid) && ((String)map.get("userType").trim()).equals("2"))
			{
				Object one = eventExecutor.getSqlSession().selectOne(sid, map);
				resultData.setOne(one);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SelectOneClassEvent.class);
			log.error(error);
			throw e;
		}
	}

}
