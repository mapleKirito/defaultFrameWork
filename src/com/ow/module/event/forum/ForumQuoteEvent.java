package com.ow.module.event.forum;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ForumQuoteEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ForumQuoteEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String forumReplySqlId = eventExecutor.getSqlidByIndex(0);
			paramMap.put("tiType", "1");
			String tiQuotePath = paramMap.get("tiQuotePath") == null ?"":paramMap.get("tiQuotePath").toString();
			String quoteId = null;
			String quotetId = paramMap.get("taskId") == null ?"":paramMap.get("taskId").toString();
			String quotetiId = paramMap.get("tiId") == null ?"":paramMap.get("tiId").toString();
			if (!quotetId.equals("") && quotetiId.equals("")){
				quoteId = "t_" + quotetId;
			}
			if (!quotetId.equals("") && !quotetiId.equals("")){
				quoteId = "ti_" + quotetiId;
			}			
			if (!tiQuotePath.equals("")){
				paramMap.put("tiQuotePath", tiQuotePath+","+quoteId);
			}
			else{
				paramMap.put("tiQuotePath", quoteId);
			}
			eventExecutor.getSqlSession().insert(forumReplySqlId, paramMap);			
			resultData.setIntResult(1);
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ForumQuoteEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
