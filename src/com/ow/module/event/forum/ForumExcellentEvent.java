package com.ow.module.event.forum;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ForumExcellentEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ForumExcellentEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
//			String opttype = paramMap.get("opttype") == null? "":paramMap.get("opttype").toString();
//			if (!opttype.equals("")){
				String forumReplySqlId = eventExecutor.getSqlidByIndex(0);
				//根据任务ID，查询任务归属班级信息
				eventExecutor.getSqlSession().insert(forumReplySqlId, paramMap);			
				resultData.setIntResult(1);
//			}
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ForumExcellentEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
