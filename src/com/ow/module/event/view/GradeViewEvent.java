package com.ow.module.event.view;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.module.event.sysmgr.ResourceUtil;

public class GradeViewEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public GradeViewEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			String selectCountSqlId = eventExecutor.getSqlidByIndex(1);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			List list = eventExecutor.getSqlSession().selectList(selectSqlId,paramMap);
			Object obj = eventExecutor.getSqlSession().selectOne(selectCountSqlId, paramMap);
			//当前页
			int currentPage = 1;
			String cpage = eventExecutor.getBaseAction().getCurrentPage();
			try{
				currentPage = Integer.parseInt(cpage);
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
			paginatedData.setCurrentPage(currentPage);
			paginatedData.setPageCount(pageCount);
			paginatedData.setPageSize(pageSize);
			String code = "code="+eventExecutor.getBaseAction().getCode()+"&paramMap.grGrade="+paramMap.get("grGrade");
			if(paramMap.get("grJieIDSelf")!=null){
				code = code + "&paramMap.grJieIDSelf="+paramMap.get("grJieIDSelf");
			}
			if(paramMap.get("resTypeName")!=null){
				code = code + "&paramMap.resTypeName="+paramMap.get("resTypeName");
			}
			
			paginatedData.htmlPage(code);
			resultData.setList(list);
			resultData.setPaginatedData(paginatedData);
			String grGrade = eventExecutor.getBaseAction().getParamMap().get("grGrade") == null ? "" : (String)eventExecutor.getBaseAction().getParamMap().get("grGrade") ;
			String grJieIDSelf = eventExecutor.getBaseAction().getParamMap().get("grJieIDSelf") == null ? "" : (String)eventExecutor.getBaseAction().getParamMap().get("grJieIDSelf") ;
			if(grJieIDSelf.equals("")){
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnGradePath(grGrade, "", "", ""));
			}else{
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnGradePath(grJieIDSelf, "", "", ""));
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, GradeViewEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
