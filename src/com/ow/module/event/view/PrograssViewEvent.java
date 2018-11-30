package com.ow.module.event.view;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class PrograssViewEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public PrograssViewEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			/*String  anamep = "";
			String cpcode = eventExecutor.getPermission().getCode();
			int len = cpcode.length();
			int div = ((int)len/3);
			for (int i=0; i<div; i++){
				String tempCode =  cpcode.substring(0,(i+1)*3);
				System.out.println(tempCode);
				anamep += eventExecutor.getPermission(tempCode).getName();
			}
			
			eventExecutor.getBaseAction().setNavigation("") ;
			eventExecutor.getBaseAction().setBussessNavigation(anamep);*/
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, PrograssViewEvent.class);
			log.error(error);
		}
		return resultData;
	}
}