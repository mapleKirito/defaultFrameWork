package com.ow.module.event.sysmgr.htask;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class HtaskDeleteEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	public HtaskDeleteEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "unused", "unchecked", "rawtypes" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String delete = eventExecutor.getSqlidByIndex(0);		
			HashMap mapid = eventExecutor.getBaseAction().getParamMap();
			String htaskID = (String) mapid.get("htaskID");
			String a[] = htaskID.split(",");
			String longhtaskid = "";
			if(a!=null){
				for(int h = 0;h < a.length;h++){
					mapid.put("htaskSplitID", a[h]);
					eventExecutor.getSqlSession().delete("histask.delete", mapid);
					eventExecutor.getSqlSession().delete(delete, mapid);
				}
			}
			
			resultData.setIntResult(1);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, HtaskDeleteEvent.class);
			log.error(error);
			throw e;
		}
	}
}