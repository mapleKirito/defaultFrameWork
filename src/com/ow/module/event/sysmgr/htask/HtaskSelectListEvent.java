package com.ow.module.event.sysmgr.htask;

import java.util.HashMap;
import java.util.List;
import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class HtaskSelectListEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public HtaskSelectListEvent()
	{
		resultData = new ResultData();
	}		 
	@SuppressWarnings("rawtypes")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			HashMap<String, String> map = eventExecutor.getBaseAction().getParamMap();
			if (!"".equals(sid))
			{
				List rlist = eventExecutor.getSqlSession().selectList(sid, map);
				resultData.setList(rlist);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, HtaskSelectListEvent.class);
			log.error(error);
			throw e;
		}
	}
}
