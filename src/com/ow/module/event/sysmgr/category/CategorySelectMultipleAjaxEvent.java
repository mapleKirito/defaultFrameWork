package com.ow.module.event.sysmgr.category;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class CategorySelectMultipleAjaxEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public CategorySelectMultipleAjaxEvent() {
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			paramMap.put("cateName",java.net.URLDecoder.decode((String) paramMap.get("cateName"), "UTF-8"));
			
			List resultList =  eventExecutor.getSqlSession().selectList("category.check_cateName", paramMap);
			resultData.setList(resultList);
			return this.resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, CategorySelectMultipleAjaxEvent.class);
			log.error(error);
			throw e;
		}
	}
}
