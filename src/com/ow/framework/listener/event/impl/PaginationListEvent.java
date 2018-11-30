package com.ow.framework.listener.event.impl;

import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;



/**
 * 分页方法 
 * rlist 返回结果集
 * obj   对应结果集数量
 * @author sunny
 *
 */
public class PaginationListEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public PaginationListEvent()
	{
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			String sidCount = eventExecutor.getSqlidByIndex(1);
			if (!"".equals(sid) && !"".equals(sidCount))
			{
				List rlist = eventExecutor.getSqlSession().selectList(sid, eventExecutor.getBaseAction().getParamMap());
				Object obj = eventExecutor.getSqlSession().selectOne(sidCount,eventExecutor.getBaseAction().getParamMap());
				resultData.setList(rlist);
				int cnt = 0;
				if (obj instanceof Integer) 
					cnt = ((Integer)obj).intValue();
				eventExecutor.getPaginatedData().setRecordCount(cnt);
				resultData.setPaginatedData(eventExecutor.getPaginatedData());
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
