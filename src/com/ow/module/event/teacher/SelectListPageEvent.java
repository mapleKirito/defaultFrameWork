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

public class SelectListPageEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SelectListPageEvent()
	{
		resultData = new ResultData();
	}		 
	@SuppressWarnings("rawtypes")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String select_page = eventExecutor.getSqlidByIndex(0);
			String select_page_count = eventExecutor.getSqlidByIndex(1);
			HashMap<String, String> paramMap = eventExecutor.getBaseAction().getParamMap();
			paramMap.put("offset", "12");
			String userID=paramMap.get("userID");
			if (!"".equals(select_page))
			{
				List rlist = eventExecutor.getSqlSession().selectList(select_page, paramMap);
				resultData.setList(rlist);
			}
			Object obj = eventExecutor.getSqlSession().selectOne(select_page_count, paramMap);
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
			paramMap.put("cpage", cpage);
			int pageSize = 12;
			int pageCount = (int)Math.ceil(count/(double) pageSize);
			PaginatedData paginatedData =  new PaginatedData();
			paginatedData.setCurrentPage(currentPage);
			paginatedData.setPageCount(pageCount);
			paginatedData.setPageSize(pageSize);
			String gaParentId=paramMap.get("gaParentId");
			String code = "code="+eventExecutor.getBaseAction().getCode()+"&paramMap.userID="+userID+"&paramMap.gaParentId="+gaParentId;
			
			paginatedData.htmlPage(code);
			
			resultData.setPaginatedData(paginatedData);
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SelectListPageEvent.class);
			log.error(error);
			throw e;
		}
	}
}
