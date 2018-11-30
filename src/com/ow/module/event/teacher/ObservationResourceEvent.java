package com.ow.module.event.teacher;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ObservationResourceEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ObservationResourceEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			String selectCountSqlId = eventExecutor.getSqlidByIndex(1);
			String userId=eventExecutor.getBaseAction().session.get("s_userID")==null?"":eventExecutor.getBaseAction().session.get("s_userID").toString();
			if(paramMap.get("personalShare")==null){
				paramMap.put("userID", userId);
			}else{
				
			}
			String start = paramMap.get("start").toString();
			String change_type = paramMap.get("change_type") == null ? "_" : paramMap.get("change_type").toString();
			String cpage = paramMap.get("observationCurrentPage") == null ? "1" : paramMap.get("observationCurrentPage").toString();
			
			if(!cpage.equals("") && Integer.parseInt(cpage)>1){
				paramMap.put("start", (Integer.parseInt(cpage) - 1) * Integer.parseInt(eventExecutor.getBaseAction().getPageSize())); 
			}
			
			if(!change_type.equals("1") ){
				paramMap.put("start", "0"); 
			}
			
			List list = eventExecutor.getSqlSession().selectList(selectSqlId, paramMap);
			Object obj = eventExecutor.getSqlSession().selectOne(selectCountSqlId, paramMap);
			//当前页
			int observationCurrentPage = 1;
			String obscpage = eventExecutor.getBaseAction().getCurrentPage();
			try{
				observationCurrentPage = Integer.parseInt(obscpage);
				
				if(!change_type.equals("1") ){
					observationCurrentPage = 1;
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
			//每页显示记录数
			int pageSize=8;
			String psize = eventExecutor.getBaseAction().getPageSize(); 
			try{
				pageSize = Integer.parseInt(psize);
			}
			catch (Exception e){
			}
			int pageCount = (int)Math.ceil(count/(double) pageSize);
			PaginatedData paginatedData =  new PaginatedData();
			paginatedData.setCurrentPage(observationCurrentPage);
			paginatedData.setPageCount(pageCount);
			paginatedData.setPageSize(pageSize);
			paginatedData.setSelfPageName("paramMap.observationCurrentPage");
			paginatedData.setContextName("observationPaginated");
			paginatedData.htmlPage("code="+eventExecutor.getBaseAction().getCode());
			resultData.setList(list);
			resultData.setPaginatedData(paginatedData);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ObservationResourceEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
