package com.ow.module.event.sysmgr;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.Encrypt;
import com.ow.framework.util.KeyHelper;




public class ActCreateEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ActCreateEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String autoPrimaryKey = KeyHelper.getKey();
			eventExecutor.getBaseAction().getParamMap().put("autoPrimaryKey", autoPrimaryKey);
			
			String sid = eventExecutor.getSqlidByIndex(0);
			String sidorg = eventExecutor.getSqlidByIndex(1);
			if (!"".equals(sid))
			{
				Object orgnization = eventExecutor.getSqlSession().selectOne(sidorg,eventExecutor.getBaseAction().getParamMap());
				if(orgnization instanceof HashMap){
					eventExecutor.getBaseAction().getParamMap().put("orgCode", ((HashMap)orgnization).get("orgCode") == null ? "0" : ((HashMap)orgnization).get("orgCode").toString());
				}
				int rvalue = eventExecutor.getSqlSession().insert(sid, eventExecutor.getBaseAction().getParamMap());
				resultData.setIntResult(rvalue);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ActCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
