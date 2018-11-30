package com.ow.module.event.sysmgr.area;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;


/**
 * 用于检测新添加地区是否重复的执行器
 * @author linktones
 *
 */
public class AreaSelectMultipleAjaxEvent implements EventListener {
	
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public AreaSelectMultipleAjaxEvent() {
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			paramMap.put("areaName",java.net.URLDecoder.decode((String) paramMap.get("areaName"), "UTF-8"));
			
			List resultList =  eventExecutor.getSqlSession().selectList("area.check_areaName", paramMap);
			resultData.setList(resultList);
			return this.resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, AreaSelectMultipleAjaxEvent.class);
			log.error(error);
			throw e;
		}
	}
	

}
