package com.ow.module.event.view;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class PicViewEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public PicViewEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try{
			String exhibition = eventExecutor.getSqlidByIndex(0);
			String expand = eventExecutor.getSqlidByIndex(1);
			String laboratory = eventExecutor.getSqlidByIndex(2);
			String observation = eventExecutor.getSqlidByIndex(3);
			String projection = eventExecutor.getSqlidByIndex(4);
			String roomType = eventExecutor.getBaseAction().getParamMap().get("roomType") == null?"":eventExecutor.getBaseAction().getParamMap().get("roomType").toString();
			Object obj = null;
			if (roomType.equals("exhibition")){
				obj = eventExecutor.getSqlSession().selectOne(exhibition, eventExecutor.getBaseAction().getParamMap());
			}
			else if (roomType.equals("expand")){
				obj = eventExecutor.getSqlSession().selectOne(expand, eventExecutor.getBaseAction().getParamMap());
			}
			else  if (roomType.equals("laboratory")){
				obj = eventExecutor.getSqlSession().selectOne(laboratory, eventExecutor.getBaseAction().getParamMap());
			}
			else  if (roomType.equals("observation")){
				obj = eventExecutor.getSqlSession().selectOne(observation, eventExecutor.getBaseAction().getParamMap());
			}	
			else  if (roomType.equals("projection")){
				obj = eventExecutor.getSqlSession().selectOne(projection, eventExecutor.getBaseAction().getParamMap());
			}		
			resultData.setOne(obj);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, FunctionViewEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
