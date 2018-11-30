package com.ow.module.event.teacher;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.InsertEvent;
import com.ow.framework.listener.event.impl.SelectOneEvent;
import com.ow.framework.util.KeyHelper;

public class InsertTaskEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public InsertTaskEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{

			String sid = eventExecutor.getSqlidByIndex(0);
			String sidorg = eventExecutor.getSqlidByIndex(1);
			String selectStudent=eventExecutor.getSqlidByIndex(2);
			String insertTaskFinished=eventExecutor.getSqlidByIndex(3);

			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();

			if(sid!=null&&!sid.equals("")){
				int rvalue = eventExecutor.getSqlSession().insert(sid, paramMap);	
				paramMap.put("generatedKey",eventExecutor.getBaseAction().getParamMap().get("generatedKey"));
				paramMap.put("taskId",eventExecutor.getBaseAction().getParamMap().get("generatedKey"));

				String orgIds = eventExecutor.getBaseAction().getParamMap().get("orgID") == null?"":eventExecutor.getBaseAction().getParamMap().get("orgID").toString();

				if (!orgIds.equals("")){
					String uoarr [] = orgIds.split(",");
					for (int i=0; i<uoarr.length; i++){
						if (uoarr[i] != null && !uoarr[i].equals("")){
							paramMap.put("orgID", uoarr[i]);
							eventExecutor.getSqlSession().insert(sidorg,paramMap);
							List slist = eventExecutor.getSqlSession().selectList(selectStudent,paramMap);
							if (slist!=null && slist.size()>0){
								for(int j=0; j<slist.size(); j++){
									HashMap mapTemp = (HashMap)slist.get(j);
									BigDecimal studentID = (BigDecimal)mapTemp.get("userID");
									paramMap.put("studentID", studentID);
									eventExecutor.getSqlSession().insert(insertTaskFinished,paramMap);
								}
							}
						}
					}
				}
				resultData.setIntResult(rvalue);
			}			
			return resultData;
		}	
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, InsertTaskEvent.class);
			log.error(error);
			throw e;
		}
	}
}
