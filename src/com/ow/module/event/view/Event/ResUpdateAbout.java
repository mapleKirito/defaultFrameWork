package com.ow.module.event.view.Event;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.StringUtil;
import com.ow.module.event.view.ResSearchViewEvent;
import com.ow.upload.servlet.ComparatorToList;

public class ResUpdateAbout implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ResUpdateAbout()
	{
		resultData = new ResultData();
	}
	@SuppressWarnings("unchecked")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;	
			String reBname = paramMap.get("reBname") == null ? "" : (String)paramMap.get("reBname") ;	
			reBname =java.net.URLDecoder.decode(reBname, "UTF-8");
			paramMap.put("reBname", reBname);
			String IsView = paramMap.get("IsView") == null ? "" : (String)paramMap.get("IsView") ;	
			if(IsView.equals("0")){
				//插入：room id 1    资源room  资源 name  
				eventExecutor.getSqlSession().update("relate_about.insert", paramMap);			
				
			}else{
				//删除  ：room  id  0 资源room  资源 name
				eventExecutor.getSqlSession().update("relate_about.delete", paramMap);			
				
			}
					 
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ResSearchViewEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
