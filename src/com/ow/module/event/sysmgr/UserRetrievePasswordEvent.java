package com.ow.module.event.sysmgr;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.SmartServer.util.SmartWebServer;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.GODEvent;
import com.ow.framework.util.Encrypt;
import com.ow.framework.util.KeyHelper;




public class UserRetrievePasswordEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private SmartWebServer dog = null;
	public UserRetrievePasswordEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{ 
			String newPassword = eventExecutor.getBaseAction().getParamMap().get("newPassword");
			newPassword = GODEvent.getInstance(dog, newPassword);
			eventExecutor.getBaseAction().getParamMap().put("newPassword", newPassword);
			/**设置新密码*/
			String sid = eventExecutor.getSqlidByIndex(0);
			if (!"".equals(sid))
			{
				int rvalue = eventExecutor.getSqlSession().update(sid, eventExecutor.getBaseAction().getParamMap());
				resultData.setIntResult(rvalue);
			}
			resultData.setIntResult(1);
			return resultData;
				
		}
		catch (Exception e)
		{
			/**执行器执行失败*/
			String error = DetailException.expDetail(e, PasswordModifyEvent.class);
			log.error(error);
			throw e;
		}
	}

}
