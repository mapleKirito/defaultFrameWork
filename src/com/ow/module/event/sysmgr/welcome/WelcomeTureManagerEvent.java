package com.ow.module.event.sysmgr.welcome;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class WelcomeTureManagerEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	public WelcomeTureManagerEvent() {
		resultData = new ResultData();
	}

	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String update_1024 = eventExecutor.getSqlidByIndex(0);
			String update_1920 = eventExecutor.getSqlidByIndex(1);	
			String list1SortOrder1024 = paramMap.get("list1SortOrder1024") == null ? "" : (String)paramMap.get("list1SortOrder1024") ;
			String list1SortOrder1920 = paramMap.get("list1SortOrder1920") == null ? "" : (String)paramMap.get("list1SortOrder1920") ;
			String list1Itemidx = paramMap.get("list1Itemidx") == null ? "" : (String)paramMap.get("list1Itemidx") ;
			String recomType = paramMap.get("recomType") == null ? "" : (String)paramMap.get("recomType") ;
			if(list1SortOrder1024!=null &&list1SortOrder1920!=null && list1Itemidx!=null&& !list1SortOrder1024.equals("") &&!list1SortOrder1920.equals("") && !list1Itemidx.equals("")){
				
				String[] SortOrder1024 = list1SortOrder1024.split("\\|");
				String[] SortOrder1920 = list1SortOrder1920.split("\\|");
				String[] Itemidx = list1Itemidx.split("\\|");
				
				Collections.reverse(Arrays.asList(SortOrder1024));
				Collections.reverse(Arrays.asList(SortOrder1920));
				
				if(SortOrder1024.length!=Itemidx.length||SortOrder1920.length!=Itemidx.length) {
					eventExecutor.getBaseAction().getPromptInfo().setResultDescInfo("操作"+paramMap.get("name")+"出错,长度不等。");
					resultData.setIntResult(-1);  
					return resultData ;
				}
				
				int index1024 = SortOrder1024.length;
				for(int i = 0;i < index1024; i++){
					paramMap.put("reID", SortOrder1024[i]);
					paramMap.put("reSort", Itemidx[i]);
					int rvalue = eventExecutor.getSqlSession().update(update_1024,paramMap);
				}
				int index1920 = SortOrder1920.length;
				for(int i = 0;i < index1920; i++){
					paramMap.put("reID", SortOrder1920[i]);
					paramMap.put("reSort", Itemidx[i]);
					int rvalue = eventExecutor.getSqlSession().update(update_1920,paramMap);
				}
				
			}
			resultData.setIntResult(1);
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, WelcomeTureManagerEvent.class);
			log.error(error);
		}
		return resultData;
	}

}