package com.ow.module.event.sysmgr.history;

import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class HistoryModifyEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public HistoryModifyEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			if (!"".equals(sid))
			{
				String newsContent = eventExecutor.getBaseAction().getParamMap().get("historyContent").replace("\r\n", "");
				eventExecutor.getBaseAction().getParamMap().remove("historyContent");
				eventExecutor.getBaseAction().getParamMap().put("historyContent", newsContent);
				int rvalue = eventExecutor.getSqlSession().update(sid,eventExecutor.getBaseAction().getParamMap());
				resultData.setIntResult(rvalue);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, HistoryModifyEvent.class);
			log.error(error);
		}
		return resultData;
	}
}