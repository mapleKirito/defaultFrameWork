package com.ow.module.event.sysmgr.history;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DBUtil;

public class HistoryCreateEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public HistoryCreateEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			if (!"".equals(sid))
			{
				String historyContent = eventExecutor.getBaseAction().getParamMap().get("historyContent").replace("\r\n", "");
				eventExecutor.getBaseAction().getParamMap().remove("historyContent");
				eventExecutor.getBaseAction().getParamMap().put("historyContent", historyContent);
				System.out.println(eventExecutor.getBaseAction().getParamMap());
				int rvalue = eventExecutor.getSqlSession().insert(sid, eventExecutor.getBaseAction().getParamMap());
				
				DBUtil.findSN(eventExecutor, "todayonhistory");
				
				resultData.setIntResult(rvalue);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, HistoryCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}
}