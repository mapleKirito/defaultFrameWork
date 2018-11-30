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

public class FunctionViewEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public FunctionViewEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectCategoryByID = eventExecutor.getSqlidByIndex(0);
			String selectCNameSqlId = eventExecutor.getSqlidByIndex(1);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String path = eventExecutor.getBaseAction().getPath() == null ? "" : eventExecutor.getBaseAction().getPath();
			if(path==""){
				path=(String) paramMap.get("path");
			}
			String cateID = path.split(",").length > 1 ? path.split(",")[path.split(",").length - 1] : "" ;
			String parentCateID = path.split(",").length > 1 ? path.split(",")[2] : "" ;
			String expResType=paramMap.get("expResType")== null ? "" : (String) paramMap.get("expResType");
			String erCateTwLevel=paramMap.get("erCateTwLevel")== null ? "" : (String) paramMap.get("erCateTwLevel");
		
			paramMap.put("cateID", parentCateID) ;
			paramMap.put("catePath", path) ;			
			
			Object category = eventExecutor.getSqlSession().selectOne(selectCategoryByID, paramMap);
			String resType = "" ;
			if(category != null) {
				resType = (String)((HashMap)category).get("cateSign") ;
			}
			paramMap.put("cateSign", resType) ;
			
			String selectSqlId = "exhibition.select_page" ;
			String selectCountSqlId = "exhibition.select_page_count" ;
			if("exhibition".equals(resType)) {
				String erArea = paramMap.get("erArea") == null ? "" : (String)paramMap.get("erArea") ;
				paramMap.put("erArea", "0".equals(erArea) ? "" : erArea) ;
				selectSqlId = "exhibition.select_page" ;
				selectCountSqlId = "exhibition.select_page_count" ;
			}else if("observation".equals(resType)) {
				selectSqlId = "observation.select_page" ;
				selectCountSqlId = "observation.select_page_count" ;
			}else if("laboratory".equals(resType)) {
				selectSqlId = "laboratory.select_page" ;
				selectCountSqlId = "laboratory.select_page_count" ;
			}else if("projection".equals(resType)) {
				selectSqlId = "projection.select_page" ;
				selectCountSqlId = "projection.select_page_count" ;
			}else if("lovely".equals(resType)) {
				selectSqlId = "lovely.select_page" ;
				selectCountSqlId = "lovely.select_page_count" ;
			}
			
			
			List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList(selectSqlId, paramMap);
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>() ;
			for(HashMap<String, Object> res : list1) {
				HashMap<String, Object> map = new HashMap<String, Object>() ;
				if("exhibition".equals(resType)) {
					map.put("code", res.get("erCode")) ;
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
				}else if("observation".equals(resType)) {
					map.put("code", res.get("orCode")) ;
					map.put("name", res.get("orName")) ;
					map.put("id", res.get("orID")) ;
					map.put("upload", res.get("orUpload")) ;
					map.put("thumbnail", res.get("orThumbnail")) ;
					map.put("inthum", res.get("orInThum")) ;
					map.put("path", path) ;
					map.put("fileType", res.get("orType")) ;
					map.put("resType", "observation") ;
					map.put("creator", res.get("orCreator")) ;
					map.put("createTime", res.get("orCreateTime")) ;
					map.put("audio", res.get("orAudio"));
					map.put("countLike", res.get("orCountLike"));
					map.put("cateThLevel", res.get("orCateTLevel"));
					map.put("cateFoLevel", res.get("orCateFoLevel"));
					map.put("room", "2");
				}else if("laboratory".equals(resType)) {
					map.put("code", res.get("lrCode")) ;
					map.put("name", res.get("lrName")) ;
					map.put("id", res.get("lrID")) ;
					map.put("upload", res.get("lrUpload")) ;
					map.put("thumbnail", res.get("lrThumbnail")) ;
					map.put("inthum", res.get("lrInThum")) ;
					map.put("path", path) ;
					map.put("fileType", res.get("lrType")) ;
					map.put("resType", "laboratory") ;
					map.put("creator", res.get("lrCreator")) ;
					map.put("createTime", res.get("lrCreateTime")) ;
					map.put("countLike", res.get("lrCountLike"));
					map.put("referType", res.get("lrReferType")) ;
				}else if("projection".equals(resType)) {
					map.put("code", res.get("prCode")) ;
					map.put("name", res.get("prName")) ;
					map.put("id", res.get("prID")) ;
					map.put("upload", res.get("prUpload")) ;
					map.put("thumbnail", res.get("prThumbnail")) ;
					map.put("inthum", res.get("prInThum")) ;
					map.put("path", path) ;
					map.put("fileType", res.get("prType")) ;
					map.put("countLike", res.get("prCountLike"));
					map.put("resType", "projection") ;
					map.put("creator", res.get("prCreator")) ;
					map.put("createTime", res.get("prCreateTime")) ;
				}else if("lovely".equals(resType)) {
					map.put("code", res.get("crCode")) ;
					map.put("name", res.get("crName")) ;
					map.put("id", res.get("crID")) ;
					map.put("upload", res.get("crUpload")) ;
					map.put("thumbnail", res.get("crThumbnail")) ;
					map.put("inthum", res.get("crInThum")) ;
					map.put("path", path) ;
					map.put("erContent", res.get("crContent")) ;
					map.put("erTaskId", res.get("crTaskId")) ;
					map.put("fileType", res.get("crType")) ;
					map.put("resType", "lovely") ;
					map.put("creator", res.get("crCreator")) ;
					map.put("createTime", res.get("crCreateTime")) ;
					map.put("referType", res.get("crReferType")) ;
					map.put("countLike", res.get("crCountLike"));
				}
				list.add(map) ;
			}
			Object obj = eventExecutor.getSqlSession().selectOne(selectCountSqlId, paramMap);
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
			paramMap.put("cpage", cpage);
			int pageSize = 8;
			int pageCount = (int)Math.ceil(count/(double) pageSize);
			PaginatedData paginatedData =  new PaginatedData();
			paginatedData.setCurrentPage(currentPage);
			paginatedData.setPageCount(pageCount);
			paginatedData.setPageSize(pageSize);
			String code = "code="+eventExecutor.getBaseAction().getCode() + "&paramMap.selectscreenidtr4v="+(String) paramMap.get("selectscreenidtr4v")+"&paramMap.selectscreenidtr="+(String) paramMap.get("selectscreenidtr")+"&paramMap.cateLevel="+(String)paramMap.get("cateLevel")+"&path=" + path+"&paramMap.expResType=" + expResType+"&paramMap.erCateTwLevel=" + erCateTwLevel;
			
			if(paramMap.get("cateSign").equals("observation")){
				if(paramMap.get("orCategory")!=null){
					code = code +"&paramMap.orCategory="+paramMap.get("orCategory");
				}
				if(paramMap.get("orCateTwLevel")!=null){
					code = code +"&paramMap.orCateTwLevel="+paramMap.get("orCateTwLevel");
				}
				if(paramMap.get("orCateTHLevel")!=null){
					code = code +"&paramMap.orCateTHLevel="+paramMap.get("orCateTHLevel");
				}
				if(paramMap.get("orCateFoLevel")!=null){
					code = code +"&paramMap.orCateFoLevel="+paramMap.get("orCateFoLevel");
				}

			}else if(paramMap.get("cateSign").equals("laboratory")){
				if(paramMap.get("lrCategory")!=null){
					code = code +"&paramMap.lrCategory="+paramMap.get("lrCategory");
				}
				if(paramMap.get("lrCateTwLevel")!=null){
					code = code +"&paramMap.lrCateTwLevel="+paramMap.get("lrCateTwLevel");
				}
			}else if(paramMap.get("cateSign").equals("projection")){
				if(paramMap.get("prCategory")!=null){
					code = code +"&paramMap.prCategory="+paramMap.get("prCategory");
				}
				if(paramMap.get("prCateTwLevel")!=null){
					code = code +"&paramMap.prCateTwLevel="+paramMap.get("prCateTwLevel");
				}
			}else if(paramMap.get("cateSign").equals("lovely")){
				if(paramMap.get("crResType")!=null){
					code = code +"&paramMap.crResType="+paramMap.get("crResType");
				}
				if(paramMap.get("crCateTwLevel")!=null ){
					code = code +"&paramMap.crCateTwLevel="+paramMap.get("crCateTwLevel");
				}
			}else if(paramMap.get("cateSign").equals("exhibition")){
				if(paramMap.get("erTotalID")!=null ){
					code = code +"&paramMap.erTotalID="+paramMap.get("erTotalID");
				}
				if(paramMap.get("erJieID")!=null ){
					code = code +"&paramMap.erJieID="+paramMap.get("erJieID");
				}
				if(paramMap.get("erChorID")!=null ){
					code = code +"&paramMap.erChorID="+paramMap.get("erChorID");
				}
				if(paramMap.get("erGangID")!=null ){
					code = code +"&paramMap.erGangID="+paramMap.get("erGangID");
				}
				if(paramMap.get("erOrderID")!=null){
					code = code +"&paramMap.erOrderID="+paramMap.get("erOrderID");
				}
				if(paramMap.get("erCategory")!=null){
					code = code +"&paramMap.erCategory="+paramMap.get("erCategory");
				}
			}
			paginatedData.htmlPage(code);
			resultData.setList(list);
			resultData.setPaginatedData(paginatedData);
			
			String subpath = (String)paramMap.get(ResourceUtil.returnResourceListPathText("exhibition",(String)paramMap.get("cateLevel")))+",";
			
			String arrPath [] = path.split(",");
			String  bname = "";
			for (int i=0; i<arrPath.length; i++){
				if (arrPath[i] != null && !arrPath[i].equals("")){
					eventExecutor.getBaseAction().getParamMap().put("cateID", arrPath[i]);
					Object one = eventExecutor.getSqlSession().selectOne(selectCNameSqlId, eventExecutor.getBaseAction().getParamMap());
					if (one != null){
						String name = ((HashMap)one).get("cateName") == null?"" : ((HashMap)one).get("cateName").toString();
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