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

public class ResSeachAboutKeyViewEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ResSeachAboutKeyViewEvent()
	{
		resultData = new ResultData();
	}
	@SuppressWarnings("unchecked")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String keyword = paramMap.get("keyWords") == null ? "" : (String)paramMap.get("keyWords") ;
			keyword =java.net.URLDecoder.decode(keyword, "UTF-8");
			paramMap.put("keyword",keyword );
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>() ;

			//关键字匹配
			
			if("".equals(keyword.trim()) || keyword ==null){
				
			}else{
				
			
				String[] keywords = keyword.split("、");
				
				for(int i = 0; i < keywords.length;i++){
					
					HashMap<String, Object> map = new HashMap<String, Object>() ;
					map.put("keyword", keywords[i]);
					if("".equals(((HashMap)paramMap).get("s_start"))|| ((HashMap)paramMap).get("s_start") == null){
						map.put("start", paramMap.get("start"));
					}else{
						map.put("start", paramMap.get("s_start"));
					}
					map.put("offset", "10");
					List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList(selectSqlId, map);//文物博览室
					 if(selectSqlId.equals("restable.select_page_keywords")){
						for(HashMap<String, Object> res : list1) {
							HashMap<String, Object> map2 = new HashMap<String, Object>() ;
							map2.put("thumbnail", res.get("Thumbnail")) ;
							map2.put("roomType", res.get("rTable")) ;
							map2.put("name", res.get("rName")) ;
							list.add(map2);
						}
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
