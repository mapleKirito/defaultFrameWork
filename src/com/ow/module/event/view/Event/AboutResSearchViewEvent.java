
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

public class AboutResSearchViewEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public AboutResSearchViewEvent()
	{
		resultData = new ResultData();
	}
	@SuppressWarnings("unchecked")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String keyword = paramMap.get("nname") == null ? "" : new String(((String)paramMap.get("nname")).getBytes("ISO-8859-1"), "UTF-8") ;
			String roomType = (String) paramMap.get("roomType");
			String totalID = (String)paramMap.get("cateID");
			
			Map mapmap = new HashMap();
			
			if("exhibition".equals(roomType)){
				mapmap.put("keyword", keyword);
				mapmap.put("erTotalID" ,totalID);
			}else if("observation".equals(roomType)){
				mapmap.put("keyword", keyword);
				mapmap.put("orCategory" ,totalID);
			}else if("lovely".equals(roomType)){
				mapmap.put("keyword", keyword);
				mapmap.put("crTotalID" ,totalID);
			}else if("grade".equals(roomType)){
				mapmap.put("keyword", keyword);
				mapmap.put("grTotalID" ,totalID);
			}else if("laboratory".equals(roomType)){
				mapmap.put("keyword", keyword);
				mapmap.put("LrCateTwLevel" ,totalID);
			}else if("projection".equals(roomType)){
				mapmap.put("keyword", keyword);
				mapmap.put("prCategory" ,totalID);
			}
			
			int listtotal = 0,index1 = 0;
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>() ;
			List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList("exhibition.select_about", mapmap);//文物博览室
			//int li1 = list1.size();
			for(HashMap<String, Object> res : list1) {
				if(res.get("erType").equals("1011")){
					index1++;
				}
				HashMap<String, Object> map = new HashMap<String, Object>() ;
				map.put("name", res.get("erName")) ;
				map.put("id", res.get("erID")) ;
				map.put("code", "BLS");
				map.put("upload", res.get("erUpload")) ;
				map.put("thumbnail", res.get("erThumbnail")) ;
				map.put("inThum", res.get("erInThum")) ;
				map.put("description", res.get("erDescription")) ;
				map.put("path", "") ;
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
			List<HashMap<String, Object>> list2 = eventExecutor.getSqlSession().selectList("observation.select_about", mapmap);//专题研读室
			//int li2 = list2.size();
			for(HashMap<String, Object> res : list2) {
				if(res.get("orType").equals("1011")){
					index1++;
				}
				HashMap<String, Object> map1 = new HashMap<String, Object>() ;
				map1.put("name", res.get("orName")) ;
				map1.put("id", res.get("orID")) ;
				map1.put("code", "YDS");
				map1.put("upload", res.get("orUpload")) ;
				map1.put("thumbnail", res.get("orThumbnail")) ;
				map1.put("inThum", res.get("orInThum")) ;
				map1.put("description", res.get("orDescription")) ;
				map1.put("path", "") ;
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
			List<HashMap<String, Object>> list5 = eventExecutor.getSqlSession().selectList("lovely.select_about", mapmap);//自主探究室
		
			for(HashMap<String, Object> res : list5) {
				if(res.get("crType").equals("1011")){
					index1++;
				}
				HashMap<String, Object> map4 = new HashMap<String, Object>() ;
				map4.put("name", res.get("crName")) ;
				map4.put("id", res.get("crID")) ;
				map4.put("code","XJY");
				map4.put("upload", res.get("crUpload")) ;
				map4.put("thumbnail", res.get("crThumbnail")) ;
				map4.put("inThum", res.get("crInThum")) ;
				map4.put("path", "") ;
				map4.put("fileType", res.get("crType")) ;
				map4.put("resType", "lovely") ;
				map4.put("creator", res.get("crCreator")) ;
				map4.put("fileSwf", res.get("crFileSwf"));
				map4.put("createTime", res.get("crCreateTime")) ;
				list.add(map4);
			}
			List<HashMap<String, Object>> list3 = eventExecutor.getSqlSession().selectList("laboratory.select_about", mapmap);//教学研究室
			
			for(HashMap<String, Object> res : list3) {
				if(res.get("lrType").equals("1011")){
					index1++;
				}
				HashMap<String, Object> map2 = new HashMap<String, Object>() ;
				map2.put("name", res.get("lrName")) ;
				map2.put("id", res.get("lrID")) ;
				map2.put("code", "YJS");
				map2.put("upload", res.get("lrUpload")) ;
				map2.put("thumbnail", res.get("lrThumbnail")) ;
				map2.put("inThum", res.get("lrInThum")) ;
				map2.put("path", "") ;
				map2.put("fileType", res.get("lrType")) ;
				map2.put("resType", "laboratory") ;
				map2.put("creator", res.get("lrCreator")) ;
				map2.put("fileSwf", res.get("lrFileSwf"));
				map2.put("createTime", res.get("lrCreateTime")) ;
				map2.put("Remarks", res.get("lrRemarks")) ;
				list.add(map2);
			}
			List<HashMap<String, Object>> list4 = eventExecutor.getSqlSession().selectList("projection.select_about", mapmap);//影像资料室
			
			for(HashMap<String, Object> res : list4) {
				if(res.get("prType").equals("1011")){
					index1++;
				}
				HashMap<String, Object> map3 = new HashMap<String, Object>() ;
				map3.put("name", res.get("prName")) ;
				map3.put("id", res.get("prID")) ;
				map3.put("code", "ZLS");
				map3.put("upload", res.get("prUpload")) ;
				map3.put("thumbnail", res.get("prThumbnail")) ;
				map3.put("inThum", res.get("prInThum")) ;
				map3.put("path", "") ;
				map3.put("fileType", res.get("prType")) ;
				map3.put("resType", "projection") ;
				map3.put("creator", res.get("prCreator")) ;
				map3.put("fileSwf", res.get("prFileSwf"));
				map3.put("createTime", res.get("prCreateTime")) ;
				list.add(map3);
			}
		
			
			Collections.sort(list, new ComparatorToList());
			eventExecutor.getBaseAction().session.put("listnoequalpic",(list.size()-index1));
			eventExecutor.getBaseAction().session.put("listtotal",index1);
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
