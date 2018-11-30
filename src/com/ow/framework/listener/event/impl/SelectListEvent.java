package com.ow.framework.listener.event.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class SelectListEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SelectListEvent()
	{
		resultData = new ResultData();
	}		 
	@SuppressWarnings("rawtypes")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			HashMap<String, String> map = eventExecutor.getBaseAction().getParamMap();
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			map.put("TtcCreateTime", format.format(new Date()));
			
			
			String historyNum = map.get("currentDate").toString().substring(4,10);
			String num = historyNum;
			map.put("historyNumZero", num);
			num = num.replace("-0","-");
			map.put("historyNum", num);
			num = num.replace("-","/");
			map.put("historyNumother", num);
			if (!"".equals(sid))
			{
				List rlist = eventExecutor.getSqlSession().selectList(sid, map);
				resultData.setList(rlist);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SelectListEvent.class);
			log.error(error);
			throw e;
		}
	}
}
