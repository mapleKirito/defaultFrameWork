package com.ow.module.event.forum;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ForumScoreEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ForumScoreEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String forumScoreSelectSqlId = eventExecutor.getSqlidByIndex(0);
			String forumScoreInsertSqlId = eventExecutor.getSqlidByIndex(1);
			String forumScoreUpateSqlId = eventExecutor.getSqlidByIndex(2);
			Object obj = eventExecutor.getSqlSession().selectOne(forumScoreSelectSqlId, paramMap);
			if (obj == null){
				eventExecutor.getSqlSession().insert(forumScoreInsertSqlId, paramMap);
				String tisGood = paramMap.get("tisGood") == null ?"":paramMap.get("tisGood").toString();
				String tisMedium = paramMap.get("tisMedium") == null ?"":paramMap.get("tisMedium").toString();
				String tisDifferential = paramMap.get("tisDifferential") == null ?"":paramMap.get("tisDifferential").toString();
				if (tisGood.equals("1")){
					paramMap.put("tiGoodScore", "1");
				}
				if (tisMedium.equals("1")){
					paramMap.put("tiMediumScore", "1");
				}
				if (tisDifferential.equals("1")){
					paramMap.put("tiDifferentialScore", "1");
				}	
				eventExecutor.getSqlSession().update(forumScoreUpateSqlId, paramMap);
				resultData.setOne("0");
			}
			else{
				resultData.setOne("1");
			}
			resultData.setIntResult(1);
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ForumScoreEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
