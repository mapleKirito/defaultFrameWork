package com.ow.module.event.forum;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.ConverterToChar;

public class ForumRecommendEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ForumRecommendEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String taskSelectSqlId = eventExecutor.getSqlidByIndex(0);
			String forumReplySqlId = eventExecutor.getSqlidByIndex(1);
			String ecpandInsertSqlId = eventExecutor.getSqlidByIndex(2);
			String delete_by_taskId = eventExecutor.getSqlidByIndex(3);
			String taskId = paramMap.get("taskId") == null?"":paramMap.get("taskId").toString();
			paramMap.put("tId", taskId);
			Object obj = eventExecutor.getSqlSession().selectOne(taskSelectSqlId, paramMap);
			String title = "";
			if (obj instanceof HashMap){
				title = ((HashMap)obj).get("title") == null ?"":((HashMap)obj).get("title").toString();
			}
			paramMap.put("erResType", "1098");
			paramMap.put("erChar", ConverterToChar.getNameByChine(title));
			paramMap.put("erCateTwLevel", "1098");
			paramMap.put("erCateTwLevelName", "已推荐作业");
			
			paramMap.put("erConType", "2");
			paramMap.put("erThumbnail", "images/resImage/file_type_12.jpg");
			paramMap.put("erInThum", "images/resImage/file_type_12.jpg");
			paramMap.put("erName", title);
			paramMap.put("erContent", "decorateForwardAction.action?paramMap.taskId="+taskId);
			paramMap.put("erType", "3036");
			paramMap.put("erTaskId", taskId);
			String isRecommend = (String)paramMap.get("isRecommend");
			if (isRecommend!=null&&!isRecommend.equals("0")){
				eventExecutor.getSqlSession().insert(ecpandInsertSqlId, paramMap);				
			}else{
				eventExecutor.getSqlSession().delete(delete_by_taskId, paramMap);		
			}
			eventExecutor.getSqlSession().update(forumReplySqlId, paramMap);
			resultData.setIntResult(1);
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ForumRecommendEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
