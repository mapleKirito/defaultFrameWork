package com.ow.module.event.sysmgr;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class ActModifyEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ActModifyEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			String sidorg = eventExecutor.getSqlidByIndex(1);
			if (!"".equals(sid))
			{
				Object orgnization = eventExecutor.getSqlSession().selectOne(sidorg,eventExecutor.getBaseAction().getParamMap());
				if(orgnization instanceof HashMap){
					eventExecutor.getBaseAction().getParamMap().put("orgCode", ((HashMap)orgnization).get("orgCode") == null ? "0" : ((HashMap)orgnization).get("orgCode").toString());
				}
				int rvalue = eventExecutor.getSqlSession().update(sid, eventExecutor.getBaseAction().getParamMap());
				resultData.setIntResult(rvalue);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ActModifyEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
