package com.ow.module.event.sysmgr;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class UserModifyEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public UserModifyEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			String sidorgdel = eventExecutor.getSqlidByIndex(1);
			String sidorg = eventExecutor.getSqlidByIndex(2);
			if (!"".equals(sid))
			{
				int rvalue = eventExecutor.getSqlSession().update(sid, eventExecutor.getBaseAction().getParamMap());				
				String userOrgID = eventExecutor.getBaseAction().getParamMap().get("userOrgID") == null?"":eventExecutor.getBaseAction().getParamMap().get("userOrgID").toString();
				if (!userOrgID.equals("")){
					eventExecutor.getSqlSession().delete(sidorgdel,eventExecutor.getBaseAction().getParamMap());
					String uoarr [] = userOrgID.split(",");
					for (int i=0; i<uoarr.length; i++){
						if (uoarr[i] != null && !uoarr[i].equals("")){
							eventExecutor.getBaseAction().getParamMap().put("orgID", uoarr[i]);
							eventExecutor.getSqlSession().insert(sidorg, eventExecutor.getBaseAction().getParamMap());
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
