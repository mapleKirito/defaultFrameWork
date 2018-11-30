package com.ow.module.event.sysmgr.settings;

import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class SettingsGlobeParamEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SettingsGlobeParamEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			
			String parepa = (String)eventExecutor.getBaseAction().getParamMap().get("srOperaPath") == null ? "" : (String)eventExecutor.getBaseAction().getParamMap().get("srOperaPath");
			parepa = parepa.replace("\\", "/");
			eventExecutor.getBaseAction().getParamMap().put("srOperaPath",parepa);
			eventExecutor.getSqlSession().update(selectSqlId, eventExecutor.getBaseAction().getParamMap());
			resultData.setIntResult(1);
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, SettingsGlobeParamEvent.class);
			log.error(error);
		}
		return resultData;
	}
}