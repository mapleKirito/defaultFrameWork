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

public class SmallResPicViewEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SmallResPicViewEvent()
	{
		resultData = new ResultData();
	}
	@SuppressWarnings("unchecked")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String roomtype = paramMap.get("roomtype") == null ? "" : (String)paramMap.get("roomtype") ;
			
			String typehead = StringUtil.reResAbbreviated(roomtype);
			
			
			String _id = paramMap.get(typehead + "ID") == null ? "" : (String)paramMap.get(typehead + "ID");
				
			Map mapmap = new HashMap();
			mapmap.put(typehead + "ID", _id);
			Object obj = eventExecutor.getSqlSession().selectOne(roomtype + ".select_by_id",mapmap);
			paramMap.put("Remarks", ((HashMap)obj).get(typehead+"Remarks"));
			paramMap.put("name", ((HashMap)obj).get(typehead+"Name"));
			if("exhibition".equals(roomtype)){
					if("".equals(((HashMap)obj).get("erGenusID"))|| ((HashMap)obj).get("erGenusID") == null){
						if("".equals(((HashMap)obj).get("erCategory")) || ((HashMap)obj).get("erCategory") == null){
							if("".equals(((HashMap)obj).get("erOrderID")) || ((HashMap)obj).get("erOrderID") == null){
								if("".equals(((HashMap)obj).get("erGangID")) || ((HashMap)obj).get("erGangID") == null){
									if("".equals(((HashMap)obj).get("erChorID")) || ((HashMap)obj).get("erChorID") == null){
										if("".equals(((HashMap)obj).get("erJieID")) || ((HashMap)obj).get("erJieID") == null){
											
										}else{
											mapmap.put("erJieID", ((HashMap)obj).get("erJieID"));
										}
									}else{
										mapmap.put("erChorID", ((HashMap)obj).get("erChorID"));
									}
								}else{
									mapmap.put("erGangID", ((HashMap)obj).get("erGangID"));
								}
							}else{
								mapmap.put("erOrderID", ((HashMap)obj).get("erOrderID"));
							}
						}else{
							mapmap.put("erCategory", ((HashMap)obj).get("erCategory"));
						}
					}else{
						mapmap.put("erGenusID", ((HashMap)obj).get("erGenusID"));
					}
					if(!"".equals(((HashMap)obj).get(typehead+"About")) && ((HashMap)obj).get(typehead+"About") != null){
						String about = (String) ((HashMap)obj).get(typehead+"About");
						mapmap.put(typehead+"About", about.substring(0,about.length()-1));
					}
			}else if("observation".equals(roomtype)){
				
				if("".equals(((HashMap)obj).get("orCateTwLevel")) || ((HashMap)obj).get("orCateTwLevel") == null){
					if("".equals(((HashMap)obj).get("orCategory")) || ((HashMap)obj).get("orCategory") == null){
						
					}else{
						mapmap.put("orCategory", ((HashMap)obj).get("orCategory"));
					}
				}else{
					mapmap.put("orCateTwLevel", ((HashMap)obj).get("orCateTwLevel"));
				}
				
				if(!"".equals(((HashMap)obj).get(typehead+"About")) && ((HashMap)obj).get(typehead+"About") != null){
					String about = (String) ((HashMap)obj).get(typehead+"About");
					mapmap.put(typehead+"About", about.substring(0,about.length()-1));
				}
			}else if("laboratory".equals(roomtype)){
				
				if("".equals(((HashMap)obj).get("lrCateTwLevel")) || ((HashMap)obj).get("lrCateTwLevel") == null){
					if("".equals(((HashMap)obj).get("lrCategory")) || ((HashMap)obj).get("lrCategory") == null){
						
					}else{
						mapmap.put("lrCategory", ((HashMap)obj).get("lrCategory"));
					}
				}else{
					mapmap.put("lrCateTwLevel", ((HashMap)obj).get("lrCateTwLevel"));
				}
				if(!"".equals(((HashMap)obj).get(typehead+"About")) && ((HashMap)obj).get(typehead+"About") != null){
					String about = (String) ((HashMap)obj).get(typehead+"About");
					mapmap.put(typehead+"About", about.substring(0,about.length()-1));
				}
			}else if("projection".equals(roomtype)){
				if("".equals(((HashMap)obj).get("prCateTwLevel")) || ((HashMap)obj).get("prCateTwLevel") == null){
					if("".equals(((HashMap)obj).get("prCategory")) || ((HashMap)obj).get("prCategory") == null){
						
					}else{
						mapmap.put("prCategory", ((HashMap)obj).get("prCategory"));
					}
				}else{
					mapmap.put("prCateTwLevel", ((HashMap)obj).get("prCateTwLevel"));
				}
				if(!"".equals(((HashMap)obj).get(typehead+"About")) && ((HashMap)obj).get(typehead+"About") != null){
					String about = (String) ((HashMap)obj).get(typehead+"About");
					mapmap.put(typehead+"About", about.substring(0,about.length()-1));
				}
			}else if("lovely".equals(roomtype)){
				if("".equals(((HashMap)obj).get("crCateTwLevel")) || ((HashMap)obj).get("crCateTwLevel") == null){
					if("".equals(((HashMap)obj).get("crCategory")) || ((HashMap)obj).get("crCategory") == null){
						
					}else{
						mapmap.put("crCategory", ((HashMap)obj).get("crCategory"));
					}
				}else{
					mapmap.put("crCateTwLevel", ((HashMap)obj).get("crCateTwLevel"));
				}
				if(!"".equals(((HashMap)obj).get(typehead+"About")) && ((HashMap)obj).get(typehead+"About") != null){
					String about = (String) ((HashMap)obj).get(typehead+"About");
					mapmap.put(typehead+"About", about.substring(0,about.length()-1));
				}
			}
			mapmap.put(typehead + "Type", "1011");
			
			int listtotal = 0,index1 = 0;
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>() ;
			if("exhibition".equals(roomtype)) {
			
				List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList("exhibition.select_page_category_pic", mapmap);//文物博览室
				//int li1 = list1.size();
				for(HashMap<String, Object> res : list1) {
					HashMap<String, Object> map = new HashMap<String, Object>() ;
					map.put("name", res.get("erName")) ;
					map.put("id", res.get("erID")) ;
					map.put("code",res.get("erCode")) ;
					map.put("upload", res.get("erUpload")) ;
					map.put("thumbnail", res.get("erThumbnail")) ;
					map.put("inThum", res.get("erInThum")) ;
					map.put("description", res.get("erDescription")) ;
					map.put("path", res.get("erPath")) ;
					map.put("gangID", res.get("erGangID")) ;
					map.put("fileType", res.get("erType")) ;
					map.put("resType", "exhibition") ;
					map.put("creator", res.get("erCreator")) ;
					map.put("createTime", res.get("erCreateTime")) ;
					map.put("audio", res.get("erAudio"));
					map.put("Remarks", res.get("erRemarks")) ;
					map.put("room", "1");
					list.add(map);
				}
			}
			if("observation".equals(roomtype)) {
				List<HashMap<String, Object>> list2 = eventExecutor.getSqlSession().selectList("observation.select_page_category_pic", mapmap);//专题研读室
				//int li2 = list2.size();
				for(HashMap<String, Object> res : list2) {
						HashMap<String, Object> map1 = new HashMap<String, Object>() ;
						map1.put("name", res.get("orName")) ;
						map1.put("id", res.get("orID")) ;
						map1.put("code", res.get("orNo"));
						map1.put("upload", res.get("orUpload")) ;
						map1.put("thumbnail", res.get("orThumbnail")) ;
						map1.put("inThum", res.get("orInThum")) ;
						map1.put("description", res.get("orDescription")) ;
						map1.put("path", res.get("orPath")) ;
						map1.put("fileType", res.get("orType")) ;
						map1.put("resType", "observation") ;
						map1.put("custom", res.get("orCustom")) ;
						map1.put("creator", res.get("orCreator")) ;
						map1.put("createTime", res.get("orCreateTime")) ;
						map1.put("audio", res.get("orAudio"));
						map1.put("fileSwf", res.get("orFileSwf"));
						map1.put("Remarks", res.get("orRemarks")) ;
						map1.put("room", "2");
						list.add(map1);
				}
			}
			if("laboratory".equals(roomtype)) {
				List<HashMap<String, Object>> list3 = eventExecutor.getSqlSession().selectList("laboratory.select_page_category_pic", mapmap);//教学研究室
				//int li3 = list3.size();
				for(HashMap<String, Object> res : list3) {
					if(res.get("lrType").equals("1011")){
						HashMap<String, Object> map2 = new HashMap<String, Object>() ;
						map2.put("name", res.get("lrName")) ;
						map2.put("id", res.get("lrID")) ;
						map2.put("code",  res.get("lrNo"));
						map2.put("upload", res.get("lrUpload")) ;
						map2.put("thumbnail", res.get("lrThumbnail")) ;
						map2.put("inThum", res.get("lrInThum")) ;
						map2.put("path", res.get("lrPath")) ;
						map2.put("fileType", res.get("lrType")) ;
						map2.put("resType", "laboratory") ;
						map2.put("creator", res.get("lrCreator")) ;
						map2.put("fileSwf", res.get("lrFileSwf"));
						map2.put("createTime", res.get("lrCreateTime")) ;
						map2.put("Remarks", res.get("lrRemarks")) ;
						list.add(map2);
					}
				}
			}
			if("projection".equals(roomtype)) {
				List<HashMap<String, Object>> list4 = eventExecutor.getSqlSession().selectList("projection.select_page_category_pic", mapmap);//影像资料室
				//int li4 = list4.size();
				for(HashMap<String, Object> res : list4) {
					HashMap<String, Object> map3 = new HashMap<String, Object>() ;
					map3.put("name", res.get("prName")) ;
					map3.put("id", res.get("prID")) ;
					map3.put("code",  res.get("prNo"));
					map3.put("upload", res.get("prUpload")) ;
					map3.put("thumbnail", res.get("prThumbnail")) ;
					map3.put("path",res.get("prPath")) ;
					map3.put("fileType", res.get("prType")) ;
					map3.put("resType", "projection") ;
					map3.put("creator", res.get("prCreator")) ;
					map3.put("fileSwf", res.get("prFileSwf"));
					map3.put("createTime", res.get("prCreateTime")) ;
					list.add(map3);
				}
			}
			if("lovely".equals(roomtype)) {

				List<HashMap<String, Object>> list4 = eventExecutor.getSqlSession().selectList("lovely.select_page_category_pic", mapmap);//影像资料室
				//int li4 = list4.size();
				for(HashMap<String, Object> res : list4) {
					HashMap<String, Object> map3 = new HashMap<String, Object>() ;
					map3.put("name", res.get("crName")) ;
					map3.put("id", res.get("crID")) ;
					map3.put("code", res.get("crNo"));
					map3.put("upload", res.get("crUpload")) ;
					map3.put("thumbnail", res.get("crThumbnail")) ;
					map3.put("inThum", res.get("crInThum")) ;
					map3.put("path", res.get("crPath")) ;
					map3.put("fileType", res.get("crType")) ;
					map3.put("resType", "crojection") ;
					map3.put("creator", res.get("crCreator")) ;
					map3.put("fileSwf", res.get("crFileSwf"));
					map3.put("createTime", res.get("crCreateTime")) ;
					list.add(map3);
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
