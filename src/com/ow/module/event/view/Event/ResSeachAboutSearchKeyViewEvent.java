package com.ow.module.event.view.Event;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.StringUtil;
import com.ow.module.event.view.ResSearchViewEvent;
import com.ow.upload.servlet.ComparatorToList;

public class ResSeachAboutSearchKeyViewEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ResSeachAboutSearchKeyViewEvent()
	{
		resultData = new ResultData();
	}
	@SuppressWarnings("unchecked")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String keyword = paramMap.get("keyword") == null ? "" : (String)paramMap.get("keyword") ;
			keyword =java.net.URLDecoder.decode(keyword, "UTF-8");
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>() ;

			//关键字匹配
			
			if("".equals(keyword.trim()) || keyword ==null){
				
			}else{
				
			
					HashMap<String, Object> map = new HashMap<String, Object>() ;
					map.put("keyword", keyword);
					if("".equals(((HashMap)paramMap).get("s_start"))|| ((HashMap)paramMap).get("s_start") == null){
						map.put("start", paramMap.get("start"));
					}else{
						map.put("start", paramMap.get("s_start"));
					}
					map.put("offset", "10");
					List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList(selectSqlId, map);//文物博览室
					if("".equals(((HashMap)paramMap).get("relations"))|| ((HashMap)paramMap).get("relations") == null){
						for(HashMap<String, Object> res : list1) {
							HashMap<String, Object> map2 = new HashMap<String, Object>() ;
							map2.put("thumbnail", res.get("Thumbnail")) ;
							map2.put("roomtype", res.get("rTable")) ;
							map2.put("id", res.get("Id")) ;
							map2.put("name", res.get("rName")) ;
							map2.put("flag","0"); 
							list.add(map2);
						}
					}else{
						String relations =  paramMap.get("relations") == null ? "" : (String)paramMap.get("relations") ;
						for(HashMap<String, Object> res : list1) {
							HashMap<String, Object> map2 = new HashMap<String, Object>() ;
							if(relations.contains( res.get("rTable")+"-"+res.get("Id"))){
								map2.put("flag","1") ;
							}else{
								map2.put("flag","0") ;
							}
							map2.put("thumbnail", res.get("Thumbnail")) ;
							map2.put("roomtype", res.get("rTable")) ;
							map2.put("id", res.get("Id")) ;
							map2.put("name", res.get("rName")) ;
							list.add(map2);
						}
					}
					
					
			}
		
			
			resultData.setList(list);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ResSearchViewEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
