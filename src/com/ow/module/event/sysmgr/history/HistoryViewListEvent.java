package com.ow.module.event.sysmgr.history;

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
import com.ow.framework.util.DBUtil;
import com.ow.module.event.sysmgr.ResourceUtil;

public class HistoryViewListEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public HistoryViewListEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			String selectCountSqlId = eventExecutor.getSqlidByIndex(1);			
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String numNoFormat = paramMap.get("historyNum").toString();
			String num = paramMap.get("historyNum").toString();
			String findMonth = paramMap.get("findMonth").toString();
			String findDay = paramMap.get("findDay").toString();
			paramMap.put("historyNumZero", num);
			num = num.replace("-0","-");
			paramMap.put("historyNum", num);
			num = num.replaceAll("-","/");
			paramMap.put("historyNumother", num);
			List<HashMap<String, Object>> list  =  eventExecutor.getSqlSession().selectList(selectSqlId, paramMap);
			List<HashMap<String, Object>> list1 = new ArrayList<HashMap<String, Object>>() ;
			for(HashMap<String, Object> res : list) {
				HashMap<String, Object> map = new HashMap<String, Object>() ;
				map.put("historyID", res.get("historyID"));
				map.put("historyTitle", res.get("historyTitle"));
				map.put("historyNum", res.get("historyNum").toString().replace("-", "/"));
				map.put("historyInfo", res.get("historyInfo"));
				map.put("historyTime", res.get("historyTime"));
				/*if(res.get("historyContent").toString().contains("img")){
					String img = res.get("historyContent").toString();
					    int start = img.indexOf("img");
					    img = img.substring(start-1, img.length());
					    int end = img.indexOf("/>");
					    img = img.substring(0,end+2);
					    int t =  img.indexOf("src=");
					    img = img.substring(t+9, img.length());
					    int end2 = img.indexOf("\"");
					    img = img.substring(0, end2);
					    img = img.replaceAll("//", "/");
					    map.put("img", img);
					//System.out.println(res.get("historyContent"));
				 }*/
				list1.add(map) ;
			}
			
			Object obj = eventExecutor.getSqlSession().selectOne(selectCountSqlId, paramMap);
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
			
			String code = "code="+eventExecutor.getBaseAction().getCode()+"&paramMap.historyNum="+numNoFormat+"&paramMap.findMonth="+findMonth+"&paramMap.findDay="+findDay;			
			paginatedData.htmlPage(code);
			resultData.setPaginatedData(paginatedData);
			resultData.setList(list1);
		
			eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnHisListName(eventExecutor.getPermission().getName(), (String)paramMap.get("currentDate"),""));
			
			return resultData;
			
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, HistoryViewListEvent.class);
			log.error(error);
		}
		return resultData;
	}
}