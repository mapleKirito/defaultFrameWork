package com.ow.module.event.forum;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ForumEditEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ForumEditEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String taskUpdateSqlid = eventExecutor.getSqlidByIndex(0);
			String taskInfoUpdateSqlid = eventExecutor.getSqlidByIndex(1);
			//根据任务ID，查询任务归属班级信息
			String content = paramMap.get("content") == null? "" :paramMap.get("content").toString();
			if (paramMap.get("taskId") != null){
				eventExecutor.getSqlSession().update(taskUpdateSqlid, paramMap);	
			}
			if (paramMap.get("tiId") != null){
				paramMap.put("tiContent", content);
				eventExecutor.getSqlSession().update(taskInfoUpdateSqlid, paramMap);	
			}				
			resultData.setIntResult(1);
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ForumEditEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
