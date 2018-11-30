package com.ow.module.event.sysmgr.test;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class TestViewListEvent_Xx03 implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public TestViewListEvent_Xx03()
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
			String courselistavalue = paramMap.get("courselistavalue") == null ? "_" : paramMap.get("courselistavalue").toString();
			if(!courselistavalue.equals("6") ){
				paramMap.put("start", "0"); 
			}
			
			List<HashMap<String, Object>> list = eventExecutor.getSqlSession().selectList(select_page, paramMap);			
			Object obj = eventExecutor.getSqlSession().selectOne(select_page_count, paramMap);
			int currentPage = 1;
			String cpage = eventExecutor.getBaseAction().getCurrentPage();
			try{
				currentPage = Integer.parseInt(cpage);
				
				if(!courselistavalue.equals("6") ){
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
			
			paginatedData.setContextName("xx03Paginated");
			paginatedData.htmlPage("code="+eventExecutor.getBaseAction().getCode());
			resultData.setList(list);
			resultData.setPaginatedData(paginatedData);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, TestViewListEvent_Xx03.class);
			log.error(error);
		}
		return resultData;
	}
}