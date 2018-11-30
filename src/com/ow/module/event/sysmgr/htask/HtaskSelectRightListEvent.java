package com.ow.module.event.sysmgr.htask;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.GODEvent;

public class HtaskSelectRightListEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	public HtaskSelectRightListEvent()
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
			HashMap keyObj = (HashMap)eventExecutor.getSqlSession().selectOne("histask.select_by_id", paramMap);
			String createkeywords = (String)keyObj.get("htaskKeywords") == null? "": (String)keyObj.get("htaskKeywords");
			String keyurl = "(";
			if(!"".equals(createkeywords)){
				//createkeywords = GODEvent.getKeyWords(createkeywords);
				createkeywords = java.net.URLDecoder.decode(createkeywords,"UTF-8");
				String keywords[] = createkeywords.split("\\、");
				for(String key : keywords){
					keyurl += " or a.HTASK_KEYWORDS like '%" + key + "%'";
				}
				keyurl+=")";
				paramMap.put("keywords", keyurl.replaceFirst("or", ""));
			}
			
			List<HashMap<String, Object>> list = eventExecutor.getSqlSession().selectList(select_page, paramMap);
			List<HashMap<String, Object>> list1 = new ArrayList<HashMap<String,Object>>();
			for(HashMap<String, Object> square : list){
				HashMap map = new HashMap(); 
				map.put("htaskID", square.get("htaskID"));
				map.put("htaskTitle", square.get("htaskTitle"));
				map.put("htaskUserCreate", square.get("htaskUserCreate"));
				map.put("htaskKeywords", square.get("htaskKeywords"));
				map.put("htaskIssplit", square.get("htaskIssplit"));
				list1.add(map);
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
			int pageSize = 8;
			int pageCount = (int)Math.ceil(count/(double) pageSize);
			PaginatedData paginatedData =  new PaginatedData();
			paginatedData.setCurrentPage(currentPage);
			paginatedData.setPageCount(pageCount);
			paginatedData.setPageSize(pageSize);
			paginatedData.htmlPage("code="+eventExecutor.getBaseAction().getCode());
			resultData.setList(list1);
			resultData.setPaginatedData(paginatedData);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, HtaskSelectRightListEvent.class);
			log.error(error);
		}
		return resultData;
	}
}