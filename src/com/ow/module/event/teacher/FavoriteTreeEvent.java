package com.ow.module.event.teacher;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class FavoriteTreeEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public FavoriteTreeEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			if (!"".equals(sid))
			{
				HashMap map = eventExecutor.getBaseAction().getParamMap();
				String rfParentId = (String)map.get("parentID");
				if (rfParentId == null || rfParentId.equals("")){
					eventExecutor.getBaseAction().getParamMap().put("parentID","0");
				}
				List rlist = eventExecutor.getSqlSession().selectList(sid, eventExecutor.getBaseAction().getParamMap());
				resultData.setList(rlist);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, FavoriteTreeEvent.class);
			log.error(error);
			throw e;
		}
	}

}
