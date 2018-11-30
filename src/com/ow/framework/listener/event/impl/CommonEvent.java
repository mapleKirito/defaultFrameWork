package com.ow.framework.listener.event.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.apache.log4j.Logger;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class CommonEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	public CommonEvent()
	{
		resultData = new ResultData();
	}	
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			
			
			
			HashMap<String, String> map = eventExecutor.getBaseAction().getParamMap();
			String sid = eventExecutor.getSqlidByIndex(0);
			map.put("version", ConstantI.VERSION_KEY);
			map.put("welcome", "decorateForwardAction.action?code=004&paramMap.historyNum="+new java.text.SimpleDateFormat("MM-dd").format(new java.util.Date()));
			if (!"".equals(sid))
			{
				List rlist = eventExecutor.getSqlSession().selectList(sid, map);
				resultData.setList(rlist);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);		
			String error = DetailException.expDetail(e, CommonEvent.class);
			log.error(error);
			return resultData;
		}
	}

}
