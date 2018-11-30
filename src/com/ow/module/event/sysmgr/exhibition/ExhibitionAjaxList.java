package com.ow.module.event.sysmgr.exhibition;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ExhibitionAjaxList implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	public ExhibitionAjaxList(){
		resultData = new ResultData();
	}
	@Override
	public ResultData event(EventExecutor eventExecutor){
		try
		{
			String selectList = eventExecutor.getSqlidByIndex(0);
			
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String path = paramMap.get("path")== null ? "" : (String)paramMap.get("path");
			String start = paramMap.get("ajaxstart")== null ? "" : (String)paramMap.get("ajaxstart");
			String offset = paramMap.get("ajaxoffset")== null ? "" : (String)paramMap.get("ajaxoffset");
			//System.out.println(start);
			String cateID = path.split(",").length > 1 ? path.split(",")[path.split(",").length - 1] : "" ;
			String parentCateID = path.split(",").length > 1 ? path.split(",")[2] : "" ;
			paramMap.put("cateID", parentCateID) ;
			paramMap.put("catePath", path) ;
			paramMap.put("start", start) ;
			paramMap.put("offset", offset) ;
			List<HashMap<String, Object>> list = eventExecutor.getSqlSession().selectList(selectList, paramMap);
//			if(obj != null) {
//				eventExecutor.getBaseAction().getParamMap().put("grResourceType", "exhibition") ;
//				eventExecutor.getBaseAction().getParamMap().put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("erID")) ;
//				Object obj2 = eventExecutor.getSqlSession().selectList(selectGradeSqlId, eventExecutor.getBaseAction().getParamMap());
//				if(obj2 != null){
//					((HashMap)obj).put("grGrade", ((HashMap)obj2).get("grGrade")) ;
//				}					
//			}
			//System.out.println(list.size());
			List<HashMap<String, Object>> list2=new ArrayList<HashMap<String, Object>>();
			for (HashMap<String, Object> res : list) {
				HashMap<String, Object> map = new HashMap<String, Object>() ;
				map.put("pcode", "-701003") ;
				if("1011".equals(res.get("erType"))){
					map.put("pcode", "-701001") ;
				}
				if("1073".equals(res.get("erType"))||"1084".equals(res.get("erType"))){
					map.put("pcode", "-701002") ;
				}
				if("2041".equals(res.get("erType"))||"2033".equals(res.get("erType"))||"2055".equals(res.get("erType"))){
					map.put("pcode", "-701018") ;
				}
				map.put("name", res.get("erName")) ;
				map.put("id", res.get("erID")) ;
				map.put("broomname", "er") ;
				map.put("pname", "erID") ;
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
				map.put("room", "1");
				list2.add(map);
			}
			resultData.setList(list2);
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExhibitionViewDetailEventSmall.class);
			log.error(error);
		}
		return resultData;
	}

}
