package com.ow.framework.listener.event.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.StringUtil;




public class IsReferResEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public IsReferResEvent()
	{
		resultData = new ResultData();
	}		 
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			HashMap<String, String> map = eventExecutor.getBaseAction().getParamMap();
			
			if (!"".equals(sid))
			{
				
				String reRecommendType = StringUtil.reResAbbreviated((String)map.get("cateSign"));
				map.put("referReferID", (String)map.get(reRecommendType+"ID"));
				map.put("referReferType", (String)map.get("cateSign"));
				
				List rlist = eventExecutor.getSqlSession().selectList(sid, map);
				
				resultData.setList(rlist);
			}					
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SelectOneEvent.class);
			log.error(error);
			throw e;
		}
	}
}
