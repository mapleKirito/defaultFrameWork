package com.ow.module.event.view.Event;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.module.event.view.FunctionViewEvent;

public class AreaResSearchViewEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	public AreaResSearchViewEvent() {
		resultData = new ResultData();
	}

	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			  String selectSqlId = eventExecutor.getSqlidByIndex(0);
		      HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
	
		      String name = URLDecoder.decode((String)paramMap.get("keyword"), "UTF-8");
		      paramMap.put("keyword", name);
	
		      List list = eventExecutor.getSqlSession().selectList(selectSqlId, paramMap);
		      this.resultData.setList(list);
		      return this.resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException
					.expDetail(e, FunctionViewEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
