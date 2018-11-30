package com.ow.module.event.sysmgr.htask;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.SmartServer.util.SmartWebServer;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.GODEvent;

public class HtaskSquareList01ViewEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private SmartWebServer dog = null;
	
	public HtaskSquareList01ViewEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String select_page = eventExecutor.getSqlidByIndex(0);
			String select_page_count = eventExecutor.getSqlidByIndex(1);
			
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String start = paramMap.get("start").toString();
			String htaskSquarelistavalue = paramMap.get("htaskSquarelistavalue") == null ? "_" : paramMap.get("htaskSquarelistavalue").toString();
			if(!htaskSquarelistavalue.equals("1") ){
				paramMap.put("start", "0"); 
			}
			
			List<HashMap<String, Object>> list = eventExecutor.getSqlSession().selectList(select_page, paramMap);
			List<HashMap<String, Object>> list1 = new ArrayList<HashMap<String,Object>>();
			for(HashMap<String, Object> square : list){
				HashMap map = new HashMap(); 
				map.put("htaskID", square.get("htaskID"));
				map.put("htaskUserCreate", square.get("htaskUserCreate"));
				map.put("htaskIssplit", square.get("htaskIssplit"));
				map.put("htaskID", square.get("htaskID"));
				map.put("htaskTitle", square.get("htaskTitle"));
				map.put("htaskhdCount", square.get("htaskhdCount"));
				map.put("htaskUserAccount", square.get("htaskUserAccount"));
				map.put("htaskCreatetime", square.get("htaskCreatetime"));
				map.put("htaskKeywords", GODEvent.setKeyWords((String)square.get("htaskKeywords")));
				list1.add(map);
			}
			
			Object obj = eventExecutor.getSqlSession().selectOne(select_page_count, paramMap);
			int currentPage = 1;
			String cpage = eventExecutor.getBaseAction().getCurrentPage();
			try{
				currentPage = Integer.parseInt(cpage);
				
				if(!htaskSquarelistavalue.equals("1") ){
					currentPage = 1;
					paramMap.put("start", start);
				}
			}
			catch (Exception e){
			}
			int count = 0;
			if (obj != null){
				if (obj instanceof Integer){
					count = (Integer)obj;
				}
			}
			paramMap.put("cpage", cpage);
			int pageSize = 8;
			int pageCount = (int)Math.ceil(count/(double) pageSize);
			PaginatedData paginatedData =  new PaginatedData();
			paginatedData.setCurrentPage(currentPage);
			paginatedData.setPageCount(pageCount);
			paginatedData.setPageSize(pageSize);
			
			paginatedData.setContextName("HtaskSquareList01");
			paginatedData.htmlPage("code="+eventExecutor.getBaseAction().getCode());
			resultData.setList(list1);
			resultData.setPaginatedData(paginatedData);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, HtaskSquareList01ViewEvent.class);
			log.error(error);
		}
		return resultData;
	}
}