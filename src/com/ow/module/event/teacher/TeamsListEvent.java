package com.ow.module.event.teacher;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class TeamsListEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public TeamsListEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectsid = eventExecutor.getSqlidByIndex(0);
			List rlist = new ArrayList();
			
			List list = eventExecutor.getSqlSession().selectList(selectsid, eventExecutor.getBaseAction().getParamMap());
			resultData.setList(rlist);
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, TeamsListEvent.class);
			log.error(error);
			throw e;
		}
		return resultData;
	}

}
