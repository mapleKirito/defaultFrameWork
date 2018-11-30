package com.ow.framework.listener.event.impl;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class SelectOneEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	public SelectOneEvent()
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
				Object one = eventExecutor.getSqlSession().selectOne(sid, map);
				if("exhibition.select_by_id".equals(sid)){
					String keyword = ((HashMap)one).get("erKeywords") == null ? "":((HashMap)one).get("erKeywords").toString();
					if(!"".equals(keyword)){
						((HashMap)one).put("erKeywords", keyword.substring(1, keyword.length()-1));
					}
					
				}
				if("observation.select_by_id".equals(sid)){
					String keyword = ((HashMap)one).get("orKeywords") == null ? "":((HashMap)one).get("orKeywords").toString();
					if(!"".equals(keyword)){
						((HashMap)one).put("orKeywords", keyword.substring(1, keyword.length()-1));
					}
				}
				if("laboratory.select_by_id".equals(sid)){
					String keyword = ((HashMap)one).get("lrKeywords") == null ? "":((HashMap)one).get("lrKeywords").toString();
					if(!"".equals(keyword)){
						((HashMap)one).put("lrKeywords", keyword.substring(1, keyword.length()-1));
					}
				}
				if("projection.select_by_id".equals(sid)){
					String keyword = ((HashMap)one).get("prKeywords") == null ? "":((HashMap)one).get("prKeywords").toString();
					if(!"".equals(keyword)){
						((HashMap)one).put("prKeywords", keyword.substring(1, keyword.length()-1));
					}
				}
				if("lovely.select_by_id".equals(sid)){
					String keyword = ((HashMap)one).get("crKeywords") == null ? "":((HashMap)one).get("crKeywords").toString();
					if(!"".equals(keyword)){
						((HashMap)one).put("crKeywords", keyword.substring(1, keyword.length()-1));
					}
				}
				resultData.setOne(one);
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
