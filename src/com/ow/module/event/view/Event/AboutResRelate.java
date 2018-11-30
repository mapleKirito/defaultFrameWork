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

public class AboutResRelate implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public AboutResRelate()
	{
		resultData = new ResultData();
	}
	@SuppressWarnings("unchecked")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String excute = (String) paramMap.get("excute");
			String Aname = (String) paramMap.get("Aname");
			Aname =java.net.URLDecoder.decode(Aname, "UTF-8");
			paramMap.put("Aname",Aname ) ;
			if("insert".equals(excute)){
				eventExecutor.getSqlSession().insert("relate.insert", paramMap);				
			}else{
				eventExecutor.getSqlSession().delete("relate.delete", paramMap);				
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
