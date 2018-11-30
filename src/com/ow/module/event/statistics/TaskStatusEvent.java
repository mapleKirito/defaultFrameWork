package com.ow.module.event.statistics;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class TaskStatusEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private HashMap newResult;
	public TaskStatusEvent()
	{
		resultData = new ResultData();
		newResult = new HashMap();
	}	
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String unfinishCorrectTaskSqlid = eventExecutor.getSqlidByIndex(0);
			String todayTaskSqlid = eventExecutor.getSqlidByIndex(1);
			String yestodayTaskSqlid = eventExecutor.getSqlidByIndex(2);
			String lastweekTaskSqlid = eventExecutor.getSqlidByIndex(3);
			String laskmonthTaskSqlid = eventExecutor.getSqlidByIndex(4);
			Object unfinishCorrectTaskObj = eventExecutor.getSqlSession().selectOne(unfinishCorrectTaskSqlid,paramMap);
			Object todayTaskObj = eventExecutor.getSqlSession().selectOne(todayTaskSqlid,paramMap);
			Object yestodayTaskObj = eventExecutor.getSqlSession().selectOne(yestodayTaskSqlid,paramMap);
			Object lastweekTaskObj = eventExecutor.getSqlSession().selectOne(lastweekTaskSqlid,paramMap);
			Object lastmonthTaskObj = eventExecutor.getSqlSession().selectOne(laskmonthTaskSqlid,paramMap);
			String userType = paramMap.get("s_userType") == null?"0":paramMap.get("s_userType").toString();
			//未完成或未批改
			if (unfinishCorrectTaskObj instanceof Integer){
				newResult.put("unfinishCorrectTaskCount", (Integer)unfinishCorrectTaskObj);
			}
			//当天作业
			if (todayTaskObj instanceof Integer){
				newResult.put("todayTaskCount", (Integer)todayTaskObj);
			}	
			//昨天作业
			if (yestodayTaskObj instanceof Integer){
				newResult.put("yestodayTaskCount", (Integer)yestodayTaskObj);
			}
			//上周作业
			if (lastweekTaskObj instanceof Integer){
				newResult.put("lastweekTaskCount", (Integer)lastweekTaskObj);
			}	
			//上月作业
			if (lastmonthTaskObj instanceof Integer){
				newResult.put("lastmonthTaskCount", (Integer)lastmonthTaskObj);
			}	
			newResult.put("userType", userType);
			resultData.setOne(newResult);
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, TaskStatusEvent.class);
			log.error(error);
			throw e;
		}
	}

}
