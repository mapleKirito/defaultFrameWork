package com.ow.module.event.sysmgr.news;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DBUtil;

public class NewsCreateEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public NewsCreateEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			if (!"".equals(sid))
			{
				String newsContent = eventExecutor.getBaseAction().getParamMap().get("newsContent").replace("\r\n", "");
				eventExecutor.getBaseAction().getParamMap().remove("newsContent");
				eventExecutor.getBaseAction().getParamMap().put("newsContent", newsContent);
				int rvalue = eventExecutor.getSqlSession().insert(sid, eventExecutor.getBaseAction().getParamMap());
				
				DBUtil.findSN(eventExecutor, "globenews");
				
				resultData.setIntResult(rvalue);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, NewsCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}
}