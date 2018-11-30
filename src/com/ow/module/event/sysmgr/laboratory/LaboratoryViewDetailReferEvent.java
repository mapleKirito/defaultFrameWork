package com.ow.module.event.sysmgr.laboratory;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.ContractNumber;
import com.ow.framework.util.StringUtil;
import com.ow.module.event.sysmgr.ResourceUtil;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class LaboratoryViewDetailReferEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public LaboratoryViewDetailReferEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectByResid=eventExecutor.getSqlidByIndex(0);
			HashMap mapmap = eventExecutor.getBaseAction().getParamMap();
			mapmap.put("referReferID", mapmap.get(StringUtil.reResAbbreviated((String)mapmap.get("roomtype"))+"ID"));
			mapmap.put("referReferType", "laboratory");
			
			List list=eventExecutor.getSqlSession().selectList(selectByResid, mapmap);
			resultData.setList(list);
			
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, LaboratoryViewDetailReferEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
