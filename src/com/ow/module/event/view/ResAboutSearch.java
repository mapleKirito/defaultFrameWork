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
import com.ow.framework.util.StringUtil;

public class ResAboutSearch implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ResAboutSearch()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings("unchecked")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectCategoryByID = eventExecutor.getSqlidByIndex(0);
			String selectCNameSqlId = eventExecutor.getSqlidByIndex(1);
			String bname = "" ;
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			
			String Aname = paramMap.get("Aname") == null ? "" : (String)paramMap.get("Aname") ;
			Aname =java.net.URLDecoder.decode(Aname, "UTF-8");
			paramMap.put("Aname", Aname.trim()) ;			
		
			String keyword = paramMap.get("keyword") == null ? "" : (String)paramMap.get("keyword") ;
			keyword =java.net.URLDecoder.decode(keyword, "UTF-8");
			paramMap.put("keyword", keyword.trim()) ;			
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>() ;			
			List<HashMap<String, Object>> list7 = eventExecutor.getSqlSession().selectList("relate.select_name", paramMap);
			List<String> relateexhibition = new ArrayList();
			List<String> relateobservation = new ArrayList();
			List<String> relatelaboratory = new ArrayList();
			List<String> relateprojection = new ArrayList();
			List<String> relatelovely = new ArrayList();
	 		for(HashMap<String, Object> res : list7) {
				HashMap<String, Object> map3 = new HashMap<String, Object>() ;
				HashMap<String, Object> map4 = new HashMap<String, Object>() ;
				String rrRoom=(String) res.get("rrBroom");
				String rrId=(String) res.get("rrBid");
				if("exhibition".equals(rrRoom)){
					relateexhibition.add(rrId);
				}else if("observation".equals(rrRoom)){
					relateobservation.add(rrId);
				}else if("laboratory".equals(rrRoom)){
					relatelaboratory.add(rrId);
				}else if("projection".equals(rrRoom)){
					relateprojection.add(rrId);
				}else if("expand".equals(rrRoom)){
					relatelovely.add(rrId);
				}	
			}
			List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList("exhibition.select_page_recom_select", paramMap);
			int li1 = list1.size();
			for(HashMap<String, Object> res : list1) {
			
				HashMap<String, Object> map = new HashMap<String, Object>() ;
				/*if("exhibition".equals(resType)) {*/
					if(relateexhibition.contains(res.get("erID").toString())){
						map.put("relate", "1") ;
					}else{
						map.put("relate", "0") ;
					}
					map.put("name", res.get("erName")) ;
					map.put("id", res.get("erID")) ;
					map.put("upload", res.get("erUpload")) ;
					map.put("thumbnail", res.get("erThumbnail")) ;
					map.put("inthum", res.get("erInThum")) ;	
					map.put("path", res.get("erPath")) ;							
					map.put("gangID", res.get("erGangID")) ;
					map.put("fileType", res.get("erType")) ;
					map.put("resType", "exhibition") ;
					map.put("creator", res.get("erCreator")) ;
					map.put("createTime", res.get("erCreateTime")) ;
					map.put("audio", res.get("erAudio"));
					map.put("room", "1");
					
				/*}*/
				
				list.add(map);
			}
			List<HashMap<String, Object>> list2 = eventExecutor.getSqlSession().selectList("observation.select_page_recom_select", paramMap);
			int li2 = list2.size();
			for(HashMap<String, Object> res : list2) {
				
				HashMap<String, Object> map1 = new HashMap<String, Object>() ;
					if(relateobservation.contains(res.get("orID").toString())){
						map1.put("relate", "1") ;
					}else{
						map1.put("relate", "0") ;
					}
					map1.put("name", res.get("orName")) ;
					map1.put("id", res.get("orID")) ;
					map1.put("upload", res.get("orUpload")) ;
					map1.put("thumbnail", res.get("orThumbnail")) ;
					map1.put("inthum", res.get("orInThum")) ;	
					map1.put("path", res.get("orPath")) ;							
					map1.put("fileType", res.get("orType")) ;
					map1.put("resType", "observation") ;
					map1.put("creator", res.get("orCreator")) ;
					map1.put("createTime", res.get("orCreateTime")) ;
					map1.put("audio", res.get("orAudio"));
					map1.put("room", "2");
				
				/*}*/
				list.add(map1);
			}
			List<HashMap<String, Object>> list3 = eventExecutor.getSqlSession().selectList("laboratory.select_page_recom_select", paramMap);
			int li3 = list3.size();
			for(HashMap<String, Object> res : list3) {
		
				HashMap<String, Object> map2 = new HashMap<String, Object>() ;
				
					if(relatelaboratory.contains(res.get("lrID").toString())){
						map2.put("relate", "1") ;
					}else{
						map2.put("relate", "0") ;
					}
					map2.put("name", res.get("lrName")) ;
					map2.put("id", res.get("lrID")) ;
					map2.put("upload", res.get("lrUpload")) ;
					map2.put("thumbnail", res.get("lrThumbnail")) ;
					map2.put("inthum", res.get("lrInThum")) ;	
					map2.put("path", res.get("lrPath")) ;							
					map2.put("fileType", res.get("lrType")) ;
					map2.put("resType", "laboratory") ;
					map2.put("creator", res.get("lrCreator")) ;
					map2.put("createTime", res.get("lrCreateTime")) ;				
				list.add(map2);
			}
			List<HashMap<String, Object>> list4 = eventExecutor.getSqlSession().selectList("projection.select_page_recom_select", paramMap);
			int li4 = list4.size();
			for(HashMap<String, Object> res : list4) {
				HashMap<String, Object> map3 = new HashMap<String, Object>() ;
					if(relateprojection.contains(res.get("prID").toString())){
						map3.put("relate", "1") ;
					}else{
						map3.put("relate", "0") ;
					}
				
					map3.put("name", res.get("prName")) ;
					map3.put("id", res.get("prID")) ;
					map3.put("upload", res.get("prUpload")) ;
					map3.put("thumbnail", res.get("prThumbnail")) ;
					map3.put("inthum", res.get("prInThum")) ;	
					map3.put("path", res.get("prPath")) ;							
					map3.put("fileType", res.get("prType")) ;
					map3.put("resType", "projection") ;
					map3.put("creator", res.get("prCreator")) ;
					map3.put("createTime", res.get("prCreateTime")) ;
					
				/*}*/
				list.add(map3);
			}
			List<HashMap<String, Object>> list5 = eventExecutor.getSqlSession().selectList("lovely.select_page_recom_select", paramMap);
			int li5 = list5.size();
			for(HashMap<String, Object> res : list5) {
				
				HashMap<String, Object> map4 = new HashMap<String, Object>() ;				
					if(relatelovely.contains(res.get("crID").toString())){
						map4.put("relate", "1") ;
					}else{
						map4.put("relate", "0") ;
					}
					map4.put("name", res.get("crName")) ;
					map4.put("id", res.get("crID")) ;
					map4.put("upload", res.get("crUpload")) ;
					map4.put("thumbnail", res.get("crThumbnail")) ;
					map4.put("inthum", res.get("crInThum")) ;	
					map4.put("path", res.get("crPath")) ;							
					map4.put("fileType", res.get("crType")) ;
					map4.put("resType", "lovely") ;
					map4.put("creator", res.get("crCreator")) ;
					map4.put("createTime", res.get("crCreateTime")) ;
				
				/*}*/
				list.add(map4);
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
