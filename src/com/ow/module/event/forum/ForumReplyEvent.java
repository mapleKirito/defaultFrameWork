package com.ow.module.event.forum;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ForumReplyEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ForumReplyEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String forumReplySqlId = eventExecutor.getSqlidByIndex(0);
			String forumReplyCountSqlId = eventExecutor.getSqlidByIndex(1);
			String forumFinishTashSqlId = eventExecutor.getSqlidByIndex(2);
			paramMap.put("tiType", "1");
			eventExecutor.getSqlSession().insert(forumReplySqlId, paramMap);
			eventExecutor.getSqlSession().update(forumReplyCountSqlId, paramMap);
			eventExecutor.getSqlSession().update(forumFinishTashSqlId, paramMap);
			resultData.setIntResult(1);
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ForumReplyEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
