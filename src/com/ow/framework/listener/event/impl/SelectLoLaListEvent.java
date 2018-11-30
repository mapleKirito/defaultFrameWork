package com.ow.framework.listener.event.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class SelectLoLaListEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SelectLoLaListEvent()
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
				String val = "";
				map.put("areaDistriResID", map.get("erID"));
				List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList(sid, map);
				for(HashMap<String, Object> res : list1) {
					 String areaDistriLongitude = res.get("areaDistriLongitude").toString() ;
					 String areaDistriLatitude = res.get("areaDistriLatitude").toString() ;
					 val += "/" + areaDistriLongitude+","+areaDistriLatitude;
				}
				val = val.replaceFirst("/", "").replace("/", "|");
				map.put("erLoLa", val);
				resultData.setList(list1);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SelectLoLaListEvent.class);
			log.error(error);
			throw e;
		}
	}
}
