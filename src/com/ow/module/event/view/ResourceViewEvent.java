package com.ow.module.event.view;

import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.module.event.sysmgr.ResourceUtil;

public class ResourceViewEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ResourceViewEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			String selectCountSqlId = eventExecutor.getSqlidByIndex(1);
			List list = eventExecutor.getSqlSession().selectList(selectSqlId, eventExecutor.getBaseAction().getParamMap());
			Object obj = eventExecutor.getSqlSession().selectOne(selectCountSqlId, eventExecutor.getBaseAction().getParamMap());
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
			String resType = eventExecutor.getBaseAction().getParamMap().get("rrType") == null ? "" : (String)eventExecutor.getBaseAction().getParamMap().get("rrType") ;			
			int pageCount = (int)Math.ceil(count/(double) pageSize);
			PaginatedData paginatedData =  new PaginatedData();
			paginatedData.setCurrentPage(currentPage);
			paginatedData.setPageCount(pageCount);
			paginatedData.setPageSize(pageSize);
			paginatedData.htmlPage("code="+eventExecutor.getBaseAction().getCode() + "&paramMap.rrType=" + resType);
			resultData.setList(list);
			resultData.setPaginatedData(paginatedData);
			eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnResourceListPath(resType));
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ResourceViewEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
