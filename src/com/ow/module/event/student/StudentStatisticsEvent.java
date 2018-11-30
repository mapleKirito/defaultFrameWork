package com.ow.module.event.student;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class StudentStatisticsEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private HashMap newResult;
	public StudentStatisticsEvent() {
		resultData = new ResultData();
		newResult = new HashMap();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String selectTaskSqlId = eventExecutor.getSqlidByIndex(0);
			String selectTaskLockSqlId = eventExecutor.getSqlidByIndex(1);
			String selectTaskRecommendSqlId = eventExecutor.getSqlidByIndex(2);
			String selectTaskExcellentSqlId = eventExecutor.getSqlidByIndex(3);
			Object taskCountObj = eventExecutor.getSqlSession().selectOne(selectTaskSqlId, paramMap);
			Object lockObj = eventExecutor.getSqlSession().selectOne(selectTaskLockSqlId, paramMap);
			Object recommendObj = eventExecutor.getSqlSession().selectOne(selectTaskRecommendSqlId, paramMap);
			Object excellentObj = eventExecutor.getSqlSession().selectOne(selectTaskExcellentSqlId, paramMap);
			if(taskCountObj instanceof Integer){
				int tcount = 0;
				try{
					tcount = (Integer)taskCountObj;
				}
				catch (Exception e){
					
				}
				newResult.put("taskCount", tcount);
			}
			if(lockObj instanceof Integer){
				int lcount = 0;
				try{
					lcount = (Integer)lockObj;
				}
				catch (Exception e){
					
				}
				newResult.put("lockCount", lcount);
			}
			if(recommendObj instanceof Integer){
				int rcount = 0;
				try{
					rcount = (Integer)recommendObj;
				}
				catch (Exception e){
					
				}
				newResult.put("recommendCount", rcount);
			}
			if(excellentObj instanceof Integer){
				int ecount = 0;
				try{
					ecount = (Integer)excellentObj;
				}
				catch (Exception e){
					
				}
				newResult.put("excellentCount", ecount);
			}			
			resultData.setOne(newResult);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, StudentStatisticsEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
