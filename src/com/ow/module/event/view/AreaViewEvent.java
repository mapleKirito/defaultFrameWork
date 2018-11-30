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




public class AreaViewEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public AreaViewEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			String selectCountSqlId = eventExecutor.getSqlidByIndex(1);
			String selectCNameSqlId = eventExecutor.getSqlidByIndex(2);
			String path = eventExecutor.getBaseAction().getPath() == null ? "" : eventExecutor.getBaseAction().getPath();
			
			HashMap paramMap =  eventExecutor.getBaseAction().getParamMap();
			
			String resType = paramMap.get("erCountry") == null ? "" : (String)paramMap.get("erCountry") ;
			String erProvince = paramMap.get("erProvince") == null ? "" : (String)paramMap.get("erProvince") ;
			String erCity = paramMap.get("erCity") == null ? "" : (String)paramMap.get("erCity") ;
			String erArea = paramMap.get("erArea") == null ? "" : (String)paramMap.get("erArea") ;
			
			List<HashMap<String, Object>> list = eventExecutor.getSqlSession().selectList(selectSqlId,paramMap);
			List<HashMap<String, Object>> list_ = new ArrayList<HashMap<String, Object>>() ;
			for(HashMap<String, Object> res : list) {
				HashMap<String, Object> map = new HashMap<String, Object>() ;
				map.put("name", res.get("erName")) ;
				map.put("id", res.get("erID")) ;
				map.put("upload", res.get("erUpload")) ;
				map.put("gangID", res.get("erGangID")) ;
				map.put("thumbnail", res.get("erThumbnail")) ;
				map.put("inthum", res.get("erInThum")) ;
				map.put("path", path) ;
				map.put("fileType", res.get("erType")) ;
				map.put("resType", "exhibition") ;
				map.put("creator", res.get("erCreator")) ;
				map.put("createTime", res.get("erCreateTime")) ;
				map.put("audio", res.get("erAudio"));
				map.put("countLike", res.get("erCountLike"));
				map.put("room", "1");
				list_.add(map) ;
			}
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
			paramMap.put("cpage", cpage);
			int pageCount = (int)Math.ceil(count/(double) pageSize);
			PaginatedData paginatedData =  new PaginatedData();
			paginatedData.setCurrentPage(currentPage);
			paginatedData.setPageCount(pageCount);
			paginatedData.setPageSize(pageSize);
			
			String code = "code="+eventExecutor.getBaseAction().getCode();			
			if(resType!=null){
				code = code + "&paramMap.erCountry=" + resType;
			}
			if(erProvince!=null){
				code = code + "&paramMap.erProvince="+erProvince;
			}
			if(erCity!=null){
				code = code + "&paramMap.erCity="+erCity;
			}
			if(erArea!=null){
				code = code + "&paramMap.erArea="+erArea;
			}
			code = code+ "&path="+path;
			paginatedData.htmlPage(code);
			resultData.setList(list_);
			resultData.setPaginatedData(paginatedData);
			
			String arrPath [] = path.split(",");
			String  bname = "";
			for (int i=0; i<arrPath.length; i++){
				if (arrPath[i] != null && !arrPath[i].equals("")){
					paramMap.put("areaID", arrPath[i]);
					Object one = eventExecutor.getSqlSession().selectOne(selectCNameSqlId,paramMap);
					if (one != null){
						String name = ((HashMap)one).get("areaName") == null?"" : ((HashMap)one).get("areaName").toString();
						if (bname.equals("")){
							bname = name;
						}
						else{
							bname +=" &gt; " + name;
						}
					}
				}
			}
			eventExecutor.getBaseAction().setBussessNavigation(bname);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, FunctionViewEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
