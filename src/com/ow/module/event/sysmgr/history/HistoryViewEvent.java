package com.ow.module.event.sysmgr.history;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.module.event.sysmgr.ResourceUtil;

public class HistoryViewEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public HistoryViewEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings("rawtypes")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);			
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			Object obj = (HashMap)eventExecutor.getSqlSession().selectOne(selectSqlId, paramMap);
			
			//eventExecutor.getBaseAction().setNavigation("") ;
			//eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnHisListName(eventExecutor.getPermission().getName(), (String)paramMap.get("currentDate"), ((HashMap)obj).get("historyTitle").toString()));
			
			resultData.setOne(obj);
			return resultData;			
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, HistoryViewEvent.class);
			log.error(error);
		}
		return resultData;
	}
}