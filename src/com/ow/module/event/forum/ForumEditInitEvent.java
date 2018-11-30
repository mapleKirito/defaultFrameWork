package com.ow.module.event.forum;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ForumEditInitEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private HashMap newResultMap;
	public ForumEditInitEvent() {
		resultData = new ResultData();
		newResultMap = new HashMap();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String taskSelectSqlid = eventExecutor.getSqlidByIndex(0);
			String taskInfoSelectSqlid = eventExecutor.getSqlidByIndex(1);
			Object obj  =  null;
			String content = null;
			if (paramMap.get("tId") != null){
				obj = eventExecutor.getSqlSession().selectOne(taskSelectSqlid, paramMap);	
				content = ((HashMap)obj).get("content") == null? "":((HashMap)obj).get("content").toString();
			}
			if (paramMap.get("tiId") != null){
				obj  = eventExecutor.getSqlSession().selectOne(taskInfoSelectSqlid, paramMap);	
				content = ((HashMap)obj).get("tiContent") == null? "":((HashMap)obj).get("tiContent").toString();
			}
			newResultMap.put("content", content);
			resultData.setOne(newResultMap);
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ForumEditInitEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
