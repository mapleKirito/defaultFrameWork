package com.ow.framework.listener.event.impl;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.KeyHelper;




public class InsertEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public InsertEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings("unchecked")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String autoPrimaryKey = KeyHelper.getKey();
			eventExecutor.getBaseAction().getParamMap().put("autoPrimaryKey", autoPrimaryKey);
			String[] sid = eventExecutor.getSqlidArr();
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			for(int i = 0 ; i < sid.length; i ++){
				if (!"".equals(sid))
				{	
					paramMap.put("roleIndex", paramMap.get("indextotal"));
					int rvalue = eventExecutor.getSqlSession().insert(sid[i],paramMap);
					resultData.setIntResult(1);
				}	
			}
			return resultData;
		}	
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, InsertEvent.class);
			log.error(error);
			throw e;
		}
	}

}
