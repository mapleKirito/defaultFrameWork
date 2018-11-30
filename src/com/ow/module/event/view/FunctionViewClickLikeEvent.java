package com.ow.module.event.view;

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
import com.ow.module.event.sysmgr.ResourceUtil;

public class FunctionViewClickLikeEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public FunctionViewClickLikeEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			String updateSqlId= "";
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String resType =  paramMap.get("roomtype") == null ? "" : (String)paramMap.get("roomtype");
			String resHead = "";
			if("exhibition".equals(resType)) {
				selectSqlId = "exhibition.select_by_id" ;
				updateSqlId= "exhibition.update_clickLile" ;
				paramMap.put("erID", paramMap.get("id") == null ? "" : (String)paramMap.get("id"));
				resHead= "er";
			}else if("observation".equals(resType)) {
				resHead= "or";
				selectSqlId = "observation.select_by_id" ;
				updateSqlId= "observation.update_clickLile" ;
				paramMap.put("orID", paramMap.get("id") == null ? "" : (String)paramMap.get("id"));

			}else if("laboratory".equals(resType)) {
				resHead= "lr";
				selectSqlId = "laboratory.select_by_id" ;
				updateSqlId= "laboratory.update_clickLile" ;
				paramMap.put("lrID", paramMap.get("id") == null ? "" : (String)paramMap.get("id"));

			}else if("projection".equals(resType)) {
				resHead= "pr";
				selectSqlId = "projection.select_by_id" ;	
				updateSqlId= "projection.update_clickLile" ;
				paramMap.put("prID", paramMap.get("id") == null ? "" : (String)paramMap.get("id"));

			}else if("expand".equals(resType)) {
				resHead= "er";
				selectSqlId = "expand.select_by_id" ;
				updateSqlId= "expand.update_clickLile" ;
				paramMap.put("erID", paramMap.get("id") == null ? "" : (String)paramMap.get("id"));

			}else if("lovely".equals(resType)) {
				resHead= "er";
				selectSqlId = "lovely.select_by_id" ;
				updateSqlId= "lovely.update_clickLile" ;
				paramMap.put("crID", paramMap.get("id") == null ? "" : (String)paramMap.get("id"));

			}
			
			Object obj = eventExecutor.getSqlSession().selectOne(selectSqlId,paramMap);
			String CountLike = ((HashMap)obj).get(resHead+"CountLike") == null ? "":((HashMap)obj).get(resHead+"CountLike").toString();			
			if(CountLike=="" ||CountLike==null){
				CountLike="0";
			}
			paramMap.put(resHead+"CountLike", Integer.parseInt(CountLike)+1);
			int rows = eventExecutor.getSqlSession().update(updateSqlId,paramMap);
			HashMap<String, Object> map_count = new HashMap<String, Object>() ;
			List<HashMap<String, Object>> list_count = new ArrayList<HashMap<String, Object>>() ;
			
			map_count.put("count", paramMap.get(resHead+"CountLike"));
			list_count.add(map_count);
			resultData.setList(list_count);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, FunctionViewClickLikeEvent.class);
			log.error(error);
		}
		return resultData;
	}
}