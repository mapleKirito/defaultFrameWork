package com.ow.module.event.sysmgr.story;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.StringUtil;

public class StoryViewDetailEvent  implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public StoryViewDetailEvent()
	{
		resultData = new ResultData();
	}
	
	@SuppressWarnings("unchecked")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String rrType = paramMap.get("rrType") == null ? "" : new String(((String)paramMap.get("rrType")).getBytes("ISO-8859-1"), "UTF-8");
			String roomname = paramMap.get("roomname") == null ? "" :  (String)paramMap.get("roomname");
			paramMap.put("rrType", rrType);
			paramMap.put(StringUtil.reResAbbreviated(roomname)+"ID", rrType);
			Object obj= eventExecutor.getSqlSession().selectOne(roomname+".select_by_ids", paramMap) ;
			resultData.setOne(obj);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, StoryViewDetailEvent.class);
			log.error(error);
		}
		return resultData;
	}
}

