package com.ow.module.event.sysmgr;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class SerialNumberSelectOneEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	public SerialNumberSelectOneEvent()
	{
		resultData = new ResultData();
	}	
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			if (!"".equals(sid))
			{
				Object one = eventExecutor.getSqlSession().selectOne(sid, eventExecutor.getBaseAction().getParamMap());
				if(one instanceof HashMap){
					
				}else {
					HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
					paramMap.put("snNO", 0) ;
					int rvalue = eventExecutor.getSqlSession().insert("serial.insert", paramMap) ;
					one = eventExecutor.getSqlSession().selectOne(sid, eventExecutor.getBaseAction().getParamMap());
				}
				resultData.setOne(one);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SerialNumberSelectOneEvent.class);
			log.error(error);
			throw e;
		}
	}

}
