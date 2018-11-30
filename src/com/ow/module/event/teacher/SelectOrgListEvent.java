package com.ow.module.event.teacher;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.SelectOneEvent;

public class SelectOrgListEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SelectOrgListEvent()
	{
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			String s_userLoginName = (String)map.get("s_userLoginName");
			String sid = "";
			if (s_userLoginName!=null && s_userLoginName.equals("admin")){
				sid = eventExecutor.getSqlidByIndex(0);
			}else{
				sid = eventExecutor.getSqlidByIndex(1);
			}
			if (!"".equals(sid))
			{
				List rlist = eventExecutor.getSqlSession().selectList(sid, eventExecutor.getBaseAction().getParamMap());
				resultData.setList(rlist);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SelectOneEvent.class);
			log.error(error);
			throw e;
		}
	}
}
