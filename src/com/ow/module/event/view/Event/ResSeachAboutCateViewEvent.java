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

public class ResSeachAboutCateViewEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ResSeachAboutCateViewEvent()
	{
		resultData = new ResultData();
	}
	@SuppressWarnings("unchecked")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			//图片资源会执行
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>() ;

			if("1011".equals(paramMap.get("resType"))){
				
				String roomtype = paramMap.get("roomtype") == null ? "" : (String)paramMap.get("roomtype") ;
				
				String typehead = StringUtil.reResAbbreviated(roomtype);
				
				
				String _id = paramMap.get(typehead + "ID") == null ? "" : (String)paramMap.get(typehead + "ID");
				if("".equals(_id)||_id == null){
					Map mapmap = new HashMap();
					if("".equals(((HashMap)paramMap).get("s_start"))|| ((HashMap)paramMap).get("s_start") == null){
						mapmap.put("start", paramMap.get("start"));
					}else{
						mapmap.put("start", paramMap.get("s_start"));
					}
					mapmap.put("offset", paramMap.get("offsetAbout"));
				
					
					mapmap.put(typehead + "ID", _id);
					
				
					if("exhibition".equals(roomtype)){
							if("".equals(((HashMap)paramMap).get("erGenusID"))|| ((HashMap)paramMap).get("erGenusID") == null){
								if("".equals(((HashMap)paramMap).get("erCategory")) || ((HashMap)paramMap).get("erCategory") == null){
									if("".equals(((HashMap)paramMap).get("erOrderID")) || ((HashMap)paramMap).get("erOrderID") == null){
										if("".equals(((HashMap)paramMap).get("erGangID")) || ((HashMap)paramMap).get("erGangID") == null){
											if("".equals(((HashMap)paramMap).get("erChorID")) || ((HashMap)paramMap).get("erChorID") == null){
												if("".equals(((HashMap)paramMap).get("erJieID")) || ((HashMap)paramMap).get("erJieID") == null){
													if("".equals(((HashMap)paramMap).get("erTotalID")) || ((HashMap)paramMap).get("erTotalID") == null){
														
													}else{
														mapmap.put("erTotalID", ((HashMap)paramMap).get("erTotalID"));
													}
												}else{
													mapmap.put("erJieID", ((HashMap)paramMap).get("erJieID"));
												}
											}else{
												mapmap.put("erChorID", ((HashMap)paramMap).get("erChorID"));
											}
										}else{
											mapmap.put("erGangID", ((HashMap)paramMap).get("erGangID"));
										}
									}else{
										mapmap.put("erOrderID", ((HashMap)paramMap).get("erOrderID"));
									}
								}else{
									mapmap.put("erCategory", ((HashMap)paramMap).get("erCategory"));
								}
							}else{
								mapmap.put("erGenusID", ((HashMap)paramMap).get("erGenusID"));
							}
						}else if("observation".equals(roomtype)){
						
						if("".equals(((HashMap)paramMap).get("orCateTwLevel")) || ((HashMap)paramMap).get("orCateTwLevel") == null){
							if("".equals(((HashMap)paramMap).get("orCategory")) || ((HashMap)paramMap).get("orCategory") == null){
								
							}else{
								mapmap.put("orCategory", ((HashMap)paramMap).get("orCategory"));
							}
						}else{
							mapmap.put("orCateTwLevel", ((HashMap)paramMap).get("orCateTwLevel"));
						}
				
					}else if("laboratory".equals(roomtype)){
						
						if("".equals(((HashMap)paramMap).get("lrCateTwLevel")) || ((HashMap)paramMap).get("lrCateTwLevel") == null){
							if("".equals(((HashMap)paramMap).get("lrCategory")) || ((HashMap)paramMap).get("lrCategory") == null){
								
							}else{
								mapmap.put("lrCategory", ((HashMap)paramMap).get("lrCategory"));
							}
						}else{
							mapmap.put("lrCateTwLevel", ((HashMap)paramMap).get("lrCateTwLevel"));
						}
					
					}else if("projection".equals(roomtype)){
						if("".equals(((HashMap)paramMap).get("prCateTwLevel")) || ((HashMap)paramMap).get("prCateTwLevel") == null){
							if("".equals(((HashMap)paramMap).get("prCategory")) || ((HashMap)paramMap).get("prCategory") == null){
								
							}else{
								mapmap.put("prCategory", ((HashMap)paramMap).get("prCategory"));
							}
						}else{
							mapmap.put("prCateTwLevel", ((HashMap)paramMap).get("prCateTwLevel"));
						}
						
					}else if("lovely".equals(roomtype)){
						if("".equals(((HashMap)paramMap).get("crCateTwLevel")) || ((HashMap)paramMap).get("crCateTwLevel") == null){
							if("".equals(((HashMap)paramMap).get("crCategory")) || ((HashMap)paramMap).get("crCategory") == null){
								
							}else{
								mapmap.put("crCategory", ((HashMap)paramMap).get("crCategory"));
							}
						}else{
							mapmap.put("crCateTwLevel", ((HashMap)paramMap).get("crCateTwLevel"));
						}
						
					}
					mapmap.put(typehead + "Type", "1011");
					
					int listtotal = 0,index1 = 0;
					if("exhibition".equals(roomtype)) {
					
						List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList("exhibition.select_page_category_about", mapmap);//文物博览室
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
							map.put("viewflag", "1") ;
							list.add(map);
						}
					}
					if("observation".equals(roomtype)) {
						List<HashMap<String, Object>> list2 = eventExecutor.getSqlSession().selectList("observation.select_page_category_about", mapmap);//专题研读室
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
								map1.put("viewflag", "1") ;
								list.add(map1);
								
						}
					}
					if("lovely".equals(roomtype)) {
						List<HashMap<String, Object>> list5 = eventExecutor.getSqlSession().selectList("lovely.select_page_category_about", mapmap);//自主探究室
						//int li5 = list5.size();
						for(HashMap<String, Object> res : list5) {
							if(res.get("erType").equals("1011")){
								HashMap<String, Object> map4 = new HashMap<String, Object>() ;
								map4.put("name", res.get("crName")) ;
								map4.put("id", res.get("crID")) ;
								map4.put("code",res.get("crNo"));
								map4.put("upload", res.get("crUpload")) ;
								map4.put("thumbnail", res.get("crThumbnail")) ;
								map4.put("inThum", res.get("crInThum")) ;
								map4.put("path", res.get("crPath")) ;
								map4.put("fileType", res.get("crType")) ;
								map4.put("resType", "lovely") ;
								map4.put("creator", res.get("crCreator")) ;
								map4.put("fileSwf", res.get("crFileSwf"));
								map4.put("createTime", res.get("crCreateTime")) ;
								map4.put("viewflag", "1") ;
								
								list.add(map4);
								
							}
						}
					}
					if("laboratory".equals(roomtype)) {
						List<HashMap<String, Object>> list3 = eventExecutor.getSqlSession().selectList("laboratory.select_page_category_about", mapmap);//教学研究室
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
								map2.put("viewflag", "1") ;
								list.add(map2);
							}
						}
					}
					if("projection".equals(roomtype)) {
						List<HashMap<String, Object>> list4 = eventExecutor.getSqlSession().selectList("projection.select_page_category_about", mapmap);//影像资料室
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
							map3.put("viewflag", "1") ;
							list.add(map3);
						}
					}
					if("lovely".equals(roomtype)) {

						List<HashMap<String, Object>> list4 = eventExecutor.getSqlSession().selectList("lovely.select_page_category_about", mapmap);//影像资料室
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
							map3.put("viewflag", "1") ;
							list.add(map3);
						}
					}
				}else{
					Map mapmap = new HashMap();
					mapmap.put("start", paramMap.get("start"));
					mapmap.put("offset", paramMap.get("offsetAbout"));
				
					
					mapmap.put(typehead + "ID", _id);
					
					Object obj = eventExecutor.getSqlSession().selectOne(roomtype + ".select_by_id",mapmap);			
				
					if("exhibition".equals(roomtype)){
							if("".equals(((HashMap)paramMap).get("erGenusID"))|| ((HashMap)paramMap).get("erGenusID") == null){
								if("".equals(((HashMap)paramMap).get("erCategory")) || ((HashMap)paramMap).get("erCategory") == null){
									if("".equals(((HashMap)paramMap).get("erOrderID")) || ((HashMap)paramMap).get("erOrderID") == null){
										if("".equals(((HashMap)paramMap).get("erGangID")) || ((HashMap)paramMap).get("erGangID") == null){
											if("".equals(((HashMap)paramMap).get("erChorID")) || ((HashMap)paramMap).get("erChorID") == null){
												if("".equals(((HashMap)paramMap).get("erJieID")) || ((HashMap)paramMap).get("erJieID") == null){
													
												}else{
													mapmap.put("erJieID", ((HashMap)paramMap).get("erJieID"));
												}
											}else{
												mapmap.put("erChorID", ((HashMap)paramMap).get("erChorID"));
											}
										}else{
											mapmap.put("erGangID", ((HashMap)paramMap).get("erGangID"));
										}
									}else{
										mapmap.put("erOrderID", ((HashMap)paramMap).get("erOrderID"));
									}
								}else{
									mapmap.put("erCategory", ((HashMap)paramMap).get("erCategory"));
								}
							}else{
								mapmap.put("erGenusID", ((HashMap)paramMap).get("erGenusID"));
							}
							if(!"".equals(((HashMap)obj).get(typehead+"About")) && ((HashMap)obj).get(typehead+"About") != null){
								String about = (String) ((HashMap)obj).get(typehead+"About");
								mapmap.put(typehead+"About", about.substring(0,about.length()-1));
							}
					}else if("observation".equals(roomtype)){
						
						if("".equals(((HashMap)paramMap).get("orCateTwLevel")) || ((HashMap)paramMap).get("orCateTwLevel") == null){
							if("".equals(((HashMap)paramMap).get("orCategory")) || ((HashMap)paramMap).get("orCategory") == null){
								
							}else{
								mapmap.put("orCategory", ((HashMap)paramMap).get("orCategory"));
							}
						}else{
							mapmap.put("orCateTwLevel", ((HashMap)paramMap).get("orCateTwLevel"));
						}
						if(!"".equals(((HashMap)obj).get(typehead+"About")) && ((HashMap)obj).get(typehead+"About") != null){
							String about = (String) ((HashMap)obj).get(typehead+"About");
							mapmap.put(typehead+"About", about.substring(0,about.length()-1));
						}
					}else if("laboratory".equals(roomtype)){
						
						if("".equals(((HashMap)paramMap).get("lrCateTwLevel")) || ((HashMap)paramMap).get("lrCateTwLevel") == null){
							if("".equals(((HashMap)paramMap).get("lrCategory")) || ((HashMap)paramMap).get("lrCategory") == null){
								
							}else{
								mapmap.put("lrCategory", ((HashMap)paramMap).get("lrCategory"));
							}
						}else{
							mapmap.put("lrCateTwLevel", ((HashMap)paramMap).get("lrCateTwLevel"));
						}
						if(!"".equals(((HashMap)obj).get(typehead+"About")) && ((HashMap)obj).get(typehead+"About") != null){
							String about = (String) ((HashMap)obj).get(typehead+"About");
							mapmap.put(typehead+"About", about.substring(0,about.length()-1));
						}
					}else if("projection".equals(roomtype)){
						if("".equals(((HashMap)paramMap).get("prCateTwLevel")) || ((HashMap)paramMap).get("prCateTwLevel") == null){
							if("".equals(((HashMap)paramMap).get("prCategory")) || ((HashMap)paramMap).get("prCategory") == null){
								
							}else{
								mapmap.put("prCategory", ((HashMap)paramMap).get("prCategory"));
							}
						}else{
							mapmap.put("prCateTwLevel", ((HashMap)paramMap).get("prCateTwLevel"));
						}
						if(!"".equals(((HashMap)obj).get(typehead+"About")) && ((HashMap)obj).get(typehead+"About") != null){
							String about = (String) ((HashMap)obj).get(typehead+"About");
							mapmap.put(typehead+"About", about.substring(0,about.length()-1));
						}
					}else if("lovely".equals(roomtype)){
						if("".equals(((HashMap)paramMap).get("crCateTwLevel")) || ((HashMap)paramMap).get("crCateTwLevel") == null){
							if("".equals(((HashMap)paramMap).get("crCategory")) || ((HashMap)paramMap).get("crCategory") == null){
								
							}else{
								mapmap.put("crCategory", ((HashMap)paramMap).get("crCategory"));
							}
						}else{
							mapmap.put("crCateTwLevel", ((HashMap)paramMap).get("crCateTwLevel"));
						}
						if(!"".equals(((HashMap)obj).get(typehead+"About")) && ((HashMap)obj).get(typehead+"About") != null){
							String about = (String) ((HashMap)obj).get(typehead+"About");
							mapmap.put(typehead+"About", about.substring(0,about.length()-1));
						}
					}
					mapmap.put(typehead + "Type", "1011");
					
					int listtotal = 0,index1 = 0;
					if("exhibition".equals(roomtype)) {
					
						List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList("exhibition.select_page_category_about", mapmap);//文物博览室
						//int li1 = list1.size();
						for(HashMap<String, Object> res : list1) {
							HashMap<String, Object> map = new HashMap<String, Object>() ;
							map.put("name", res.get("erName")) ;
							if(((HashMap)obj).get(typehead+"About")==null || "".equals(((HashMap)obj).get(typehead+"About"))){
								map.put("viewflag", "1") ;
							}else{
								if(((HashMap)obj).get(typehead+"About").toString().startsWith(res.get(typehead+"ID").toString()+",")){
									map.put("viewflag", "0") ;
								}else{
									if(((HashMap)obj).get(typehead+"About").toString().contains(res.get(typehead+"ID").toString())){
										map.put("viewflag", "0") ;
									}else{
										map.put("viewflag", "1") ;
									}
								}
							}
							
							
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
						List<HashMap<String, Object>> list2 = eventExecutor.getSqlSession().selectList("observation.select_page_category_about", mapmap);//专题研读室
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
								if(((HashMap)obj).get(typehead+"About")==null || "".equals(((HashMap)obj).get(typehead+"About"))){
									map1.put("viewflag", "1") ;
								}else{
									if(((HashMap)obj).get(typehead+"About").toString().startsWith(res.get(typehead+"ID").toString()+",")){
										map1.put("viewflag", "0") ;
									}else{
										if(((HashMap)obj).get(typehead+"About").toString().contains(res.get(typehead+"ID").toString())){
											map1.put("viewflag", "0") ;
										}else{
											map1.put("viewflag", "1") ;
										}
									}
								}
								
								list.add(map1);
								
						}
					}
					if("lovely".equals(roomtype)) {
						List<HashMap<String, Object>> list5 = eventExecutor.getSqlSession().selectList("lovely.select_page_category_about", mapmap);//自主探究室
						//int li5 = list5.size();
						for(HashMap<String, Object> res : list5) {
							if(res.get("erType").equals("1011")){
								HashMap<String, Object> map4 = new HashMap<String, Object>() ;
								map4.put("name", res.get("crName")) ;
								map4.put("id", res.get("ccrID")) ;
								map4.put("code",res.get("crNo"));
								map4.put("upload", res.get("crUpload")) ;
								map4.put("thumbnail", res.get("crThumbnail")) ;
								map4.put("inThum", res.get("crInThum")) ;
								map4.put("path", res.get("crPath")) ;
								map4.put("fileType", res.get("crType")) ;
								map4.put("resType", "lovely") ;
								map4.put("creator", res.get("crCreator")) ;
								map4.put("fileSwf", res.get("crFileSwf"));
								map4.put("createTime", res.get("crCreateTime")) ;
								if(((HashMap)obj).get(typehead+"About")==null || "".equals(((HashMap)obj).get(typehead+"About"))){
									map4.put("viewflag", "1") ;
								}else{
									if(((HashMap)obj).get(typehead+"About").toString().startsWith(res.get(typehead+"ID").toString()+",")){
										map4.put("viewflag", "0") ;
									}else{
										if(((HashMap)obj).get(typehead+"About").toString().contains(res.get(typehead+"ID").toString())){
											map4.put("viewflag", "0") ;
										}else{
											map4.put("viewflag", "1") ;
										}
									}
								}
								
								
								list.add(map4);
								
							}
						}
					}
					if("laboratory".equals(roomtype)) {
						List<HashMap<String, Object>> list3 = eventExecutor.getSqlSession().selectList("laboratory.select_page_category_about", mapmap);//教学研究室
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
								
								if(((HashMap)obj).get(typehead+"About")==null || "".equals(((HashMap)obj).get(typehead+"About"))){
									map2.put("viewflag", "1") ;
								}else{
									if(((HashMap)obj).get(typehead+"About").toString().startsWith(res.get(typehead+"ID").toString()+",")){
										map2.put("viewflag", "0") ;
									}else{
										if(((HashMap)obj).get(typehead+"About").toString().contains(res.get(typehead+"ID").toString())){
											map2.put("viewflag", "0") ;
										}else{
											map2.put("viewflag", "1") ;
										}
									}
								}
								
								list.add(map2);
							}
						}
					}
					if("projection".equals(roomtype)) {
						List<HashMap<String, Object>> list4 = eventExecutor.getSqlSession().selectList("projection.select_page_category_about", mapmap);//影像资料室
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
							
							if(((HashMap)obj).get(typehead+"About")==null || "".equals(((HashMap)obj).get(typehead+"About"))){
								map3.put("viewflag", "1") ;
							}else{
								if(((HashMap)obj).get(typehead+"About").toString().startsWith(res.get(typehead+"ID").toString()+",")){
									map3.put("viewflag", "0") ;
								}else{
									if(((HashMap)obj).get(typehead+"About").toString().contains(res.get(typehead+"ID").toString())){
										map3.put("viewflag", "0") ;
									}else{
										map3.put("viewflag", "1") ;
									}
								}
							}
							
							list.add(map3);
						}
					}
					if("lovely".equals(roomtype)) {

						List<HashMap<String, Object>> list4 = eventExecutor.getSqlSession().selectList("lovely.select_page_category_about", mapmap);//影像资料室
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
							
							if(((HashMap)obj).get(typehead+"About")==null || "".equals(((HashMap)obj).get(typehead+"About"))){
								map3.put("viewflag", "1") ;
							}else{
								if(((HashMap)obj).get(typehead+"About").toString().startsWith(res.get(typehead+"ID").toString()+",")){
									map3.put("viewflag", "0") ;
								}else{
									if(((HashMap)obj).get(typehead+"About").toString().contains(res.get(typehead+"ID").toString())){
										map3.put("viewflag", "0") ;
									}else{
										map3.put("viewflag", "1") ;
									}
								}
							}
							
							list.add(map3);
						}
					}
				}
				
			
			}else{
				//不是图片资源，无需该列表数据
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
