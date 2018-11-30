package com.ow.module.event.forum;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ForumCommentEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ForumCommentEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String forumCommentSqlId = eventExecutor.getSqlidByIndex(0);
			String taskStatusSqlId = eventExecutor.getSqlidByIndex(1);
			eventExecutor.getSqlSession().insert(forumCommentSqlId, paramMap);	
			eventExecutor.getSqlSession().update(taskStatusSqlId, paramMap);	
			resultData.setIntResult(1);
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ForumCommentEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
