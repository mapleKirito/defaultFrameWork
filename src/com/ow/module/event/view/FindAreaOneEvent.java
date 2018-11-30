package com.ow.module.event.view;

import java.io.File;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.data.handler.config.Permission;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DBUtil;




public class FindAreaOneEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private static String fileSplit = "/";
	public FindAreaOneEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
	
			String exhibition = eventExecutor.getSqlidByIndex(0);
			
				List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList(exhibition, eventExecutor.getBaseAction().getParamMap());
				resultData.setList(list1);
				return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, FindAreaOneEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
