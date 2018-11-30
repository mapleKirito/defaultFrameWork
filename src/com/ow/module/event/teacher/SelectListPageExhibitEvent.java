package com.ow.module.event.teacher;

import java.text.SimpleDateFormat;
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

public class SelectListPageExhibitEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SelectListPageExhibitEvent()
	{
		resultData = new ResultData();
	}		 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String select_page = eventExecutor.getSqlidByIndex(0);
			String select_page_count = eventExecutor.getSqlidByIndex(1);
			String userId=eventExecutor.getBaseAction().session.get("s_userID")==null?"":eventExecutor.getBaseAction().session.get("s_userID").toString();
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			paramMap.put("tableName", "exhibition");
			paramMap.put("ruserid", userId);
			paramMap.put("userID", userId);
			
			String start = paramMap.get("start").toString();
			String change_type = paramMap.get("change_type") == null ? "_" : paramMap.get("change_type").toString();
			String cpage = paramMap.get("exhibitCurrentPage") == null ? "1" : paramMap.get("exhibitCurrentPage").toString();
			
			if(!cpage.equals("") && Integer.parseInt(cpage)>1){
				paramMap.put("start", (Integer.parseInt(cpage) - 1) * Integer.parseInt(eventExecutor.getBaseAction().getPageSize())); 
			}
			
			if(!change_type.equals("0") ){
				paramMap.put("start", "0"); 
			}
			String tmp_sql="user_info.select_by_userid";
			HashMap tmp_map=(HashMap)eventExecutor.getSqlSession().selectOne(tmp_sql, paramMap);
			Object obj=null;
			if(!(tmp_map.get("resLike")!=null&&!tmp_map.get("resLike").toString().equals(""))){
				List<HashMap<String, Object>> list = new ArrayList();
				resultData.setList(list);
			}else{
				String str=tmp_map.get("resLike").toString();
				String[] str_=str.split(",");
				String values="";
				for (String string : str_) {
					values+="or exhibition.ER_Name like '%"+string+"%' ";
				}
				values="and ("+values.substring(values.indexOf("exhibition"))+")";
				paramMap.put("values", values);
				List<HashMap<String, Object>> list = eventExecutor.getSqlSession().selectList(select_page, paramMap);
				obj = eventExecutor.getSqlSession().selectOne(select_page_count, paramMap);
				resultData.setList(list);
			}
			
			
			
			//当前页
			int exhibitCurrentPage = 1;
			String ecpage = eventExecutor.getBaseAction().getCurrentPage();
			try{
				exhibitCurrentPage = Integer.parseInt(ecpage);
				
				if(!change_type.equals("0") ){
					exhibitCurrentPage = 1;
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
			paginatedData.setCurrentPage(exhibitCurrentPage);
			paginatedData.setPageCount(pageCount);
			paginatedData.setPageSize(pageSize);
			paginatedData.setSelfPageName("paramMap.exhibitCurrentPage");
			paginatedData.setContextName("exhibitPaginated");
			paginatedData.htmlPage("code="+eventExecutor.getBaseAction().getCode());
			resultData.setPaginatedData(paginatedData);
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SelectListPageExhibitEvent.class);
			log.error(error);
			throw e;
		}
	}
}
