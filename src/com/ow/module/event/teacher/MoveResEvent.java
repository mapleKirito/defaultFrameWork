package com.ow.module.event.teacher;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.InsertEvent;
import com.ow.framework.listener.event.impl.SelectOneEvent;
import com.ow.framework.util.KeyHelper;
import com.ow.module.event.sysmgr.UserModifyEvent;

public class MoveResEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public MoveResEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			if (!"".equals(sid))
			{
				String rfIds = eventExecutor.getBaseAction().getParamMap().get("frmId") == null?"":eventExecutor.getBaseAction().getParamMap().get("frmId").toString();
				if (!rfIds.equals("")){
					String uoarr [] = rfIds.split(",");
					for (int i=0; i<uoarr.length; i++){
						if (uoarr[i] != null && !uoarr[i].equals("")){
							HashMap map = eventExecutor.getBaseAction().getParamMap();
							map.put("frmId", uoarr[i]);
							int rvalue = eventExecutor.getSqlSession().update(sid,map);
						}
					}
				}				
				resultData.setIntResult(1);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, UserModifyEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
