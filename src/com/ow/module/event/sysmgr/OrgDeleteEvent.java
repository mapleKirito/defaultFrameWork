package com.ow.module.event.sysmgr;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class OrgDeleteEvent implements EventListener {
	static Logger  log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public OrgDeleteEvent()
	{
		resultData = new ResultData();
	}

	
	public ResultData event(EventExecutor eventExecutor) throws Exception 
	{
		//分两步:首先删除当前记录及其相关记录(用户记录，子机构相关记录)，
		//然后查询当前记录的父节点是否还有子机构
		//如果有，则不进行任何操作。否则，父节点的isChild字段值为0
		try
		{	
			String deleteUser = eventExecutor.getSqlidByIndex(0);
			String deleteOrg = eventExecutor.getSqlidByIndex(1);
			String orgUpdate = eventExecutor.getSqlidByIndex(2);
			String orgCount = eventExecutor.getSqlidByIndex(3);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			eventExecutor.getSqlSession().delete(deleteUser,paramMap);
			eventExecutor.getSqlSession().delete(deleteOrg,paramMap);
			int  number = (Integer) eventExecutor.getSqlSession().selectOne(orgCount, paramMap);
			if(number==1){
				//父类机构的isChild字段变为1
				paramMap.put("orgIsChild","0");
				eventExecutor.getSqlSession().update(orgUpdate,paramMap);
			}
			resultData.setIntResult(1);
			return resultData;
			
		} catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, OrgDeleteEvent.class);
			log.error(error);
			throw e;
		}
		
	}
	
}
