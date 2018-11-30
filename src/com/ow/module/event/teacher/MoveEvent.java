package com.ow.module.event.teacher;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;


public class MoveEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public MoveEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String deleteSql = eventExecutor.getSqlidByIndex(0);
			String insertSql = eventExecutor.getSqlidByIndex(1);
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			String userIds = (String) map.get("userID");
			String orgID =(String)map.get("orgID");
			if (userIds!=null){
				String []userId = userIds.split(",");
				if (userId!=null&&userId.length>0){
					for(int i=0;i<userId.length;i++){
						map.put("userID", userId[i]);
						eventExecutor.getSqlSession().delete(deleteSql, map);
						eventExecutor.getSqlSession().insert(insertSql, map);
					}
				}	
			}
			resultData.setIntResult(1);	
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, MoveEvent.class);
			log.error(error);
			throw e;
		}
	}
}
