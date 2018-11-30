package com.ow.module.event.student;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class StudentQuestionEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public StudentQuestionEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			String selectCountSqlId = eventExecutor.getSqlidByIndex(1);
			paramMap.put("type", "2");
			
			String start = paramMap.get("start").toString();
			String cpage = paramMap.get("questionCurrentPage") == null ? "1" : paramMap.get("questionCurrentPage").toString();
			if(!cpage.equals("") && Integer.parseInt(cpage)>1){
				paramMap.put("start", (Integer.parseInt(cpage) - 1) * Integer.parseInt(eventExecutor.getBaseAction().getPageSize())); 
			}
			
			String change_type = paramMap.get("change_type") == null ? "_" : paramMap.get("change_type").toString();
			if(!change_type.equals("3") ){
				paramMap.put("start", "0"); 
			}
			
			List list = eventExecutor.getSqlSession().selectList(selectSqlId, paramMap);
			Object obj = eventExecutor.getSqlSession().selectOne(selectCountSqlId, paramMap);
			//当前页
			int questionCurrentPage = 1;
			String ucpage = eventExecutor.getBaseAction().getCurrentPage();
			try{
				questionCurrentPage = Integer.parseInt(ucpage);
				
				if(!change_type.equals("3") ){
					questionCurrentPage = 1;
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
			int pageSize = 8;
			String psize = eventExecutor.getBaseAction().getPageSize(); 
			try{
				pageSize = Integer.parseInt(psize);
			}
			catch (Exception e){
			}
			int pageCount = (int)Math.ceil(count/(double) pageSize);
			PaginatedData paginatedData =  new PaginatedData();
			paginatedData.setCurrentPage(questionCurrentPage);
			paginatedData.setPageCount(pageCount);
			paginatedData.setPageSize(pageSize);
			paginatedData.setSelfPageName("paramMap.questionCurrentPage");
			paginatedData.setContextName("questionPaginated");
			paginatedData.htmlPage("code="+eventExecutor.getBaseAction().getCode());
			resultData.setList(list);
			resultData.setPaginatedData(paginatedData);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, StudentQuestionEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
