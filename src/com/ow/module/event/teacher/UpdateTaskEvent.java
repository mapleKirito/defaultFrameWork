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
import com.ow.module.event.sysmgr.UserModifyEvent;

public class UpdateTaskEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public UpdateTaskEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			String sidorgdel = eventExecutor.getSqlidByIndex(1);
			String sidorg = eventExecutor.getSqlidByIndex(2);
			String deleteTaskFinshed = eventExecutor.getSqlidByIndex(3);
			String insertTaskFinished = eventExecutor.getSqlidByIndex(4);
			String selectStudent = eventExecutor.getSqlidByIndex(5);
			HashMap map = eventExecutor.getBaseAction().getParamMap();

			if (!"".equals(sid))
			{
				int rvalue = eventExecutor.getSqlSession().update(sid, map);				
				String orgIds = eventExecutor.getBaseAction().getParamMap().get("orgID") == null?"":map.get("orgID").toString();
				map.put("taskId", map.get("taskId"));

				if (!orgIds.equals("")){
					eventExecutor.getSqlSession().delete(sidorgdel,map);
					eventExecutor.getSqlSession().delete(deleteTaskFinshed,map);
					String uoarr [] = orgIds.split(",");
					for (int i=0; i<uoarr.length; i++){
						if (uoarr[i] != null && !uoarr[i].equals("")){
							map.put("orgID", uoarr[i]);
							eventExecutor.getSqlSession().insert(sidorg,map);
							List slist = eventExecutor.getSqlSession().selectList(selectStudent,eventExecutor.getBaseAction().getParamMap());
							if (slist!=null && slist.size()>0){
								for(int j=0; j<slist.size(); j++){
									HashMap mapTemp = (HashMap)slist.get(j);
									BigDecimal studentID = (BigDecimal)mapTemp.get("userID");
									map.put("studentID", studentID);
									eventExecutor.getSqlSession().insert(insertTaskFinished,map);
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
			String error = DetailException.expDetail(e, UserModifyEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
