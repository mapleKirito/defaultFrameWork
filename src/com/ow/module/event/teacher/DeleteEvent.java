package com.ow.module.event.teacher;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class DeleteEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public DeleteEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String deleteSql = eventExecutor.getSqlidByIndex(0);
			String deleteSql1 = eventExecutor.getSqlidByIndex(1);
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			String sidStr =(String)map.get("taskId");
			if (sidStr!=null ){
				String [] ids=sidStr.split(",");
				for(int i = 0 ; i < ids.length; i ++){
					if (ids[i] != null && !ids[i].equals(""))
					{
						int rvalue = eventExecutor.getSqlSession().delete(deleteSql,map );
						int rvalue1 = eventExecutor.getSqlSession().delete(deleteSql1,map );
						resultData.setIntResult(1);
					}	
				}
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, DeleteEvent.class);
			log.error(error);
			throw e;
		}
	}
}
