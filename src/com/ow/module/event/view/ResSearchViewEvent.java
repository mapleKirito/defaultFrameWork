package com.ow.module.event.view;

import java.text.SimpleDateFormat;
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

public class ResSearchViewEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ResSearchViewEvent()
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
			
			
			String keyword = paramMap.get("keyword") == null ? "" : new String(((String)paramMap.get("keyword")).getBytes("ISO-8859-1"), "UTF-8") ;
			paramMap.put("keyword", keyword.trim()) ;
			String resType = paramMap.get("resType") == null ? "" : (String)paramMap.get("resType") ;
			String s_userType = (String)paramMap.get("s_userType");
			
			//当前页
			int currentPage = 1;
			String cpage = eventExecutor.getBaseAction().getCurrentPage();
			try{
				currentPage = Integer.parseInt(cpage);
			}
			catch (Exception e){
			}
			
			String furr = (String)paramMap.get("currentF") == null ? "" : (String)paramMap.get("currentF");
			if(currentPage >= 2 || (furr.equals("true"))){
				String name = paramMap.get(StringUtil.reResAbbreviated(resType) + "Name") == null ? "" : new String(((String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Name")).getBytes("ISO-8859-1"), "UTF-8") ;
				paramMap.put(StringUtil.reResAbbreviated(resType) + "Name", name);	
				
				String Genus = paramMap.get(StringUtil.reResAbbreviated(resType) + "Genus") == null ? "" : new String(((String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Genus")).getBytes("ISO-8859-1"), "UTF-8") ;
				paramMap.put(StringUtil.reResAbbreviated(resType) + "Genus", Genus);	

				String BiologicalReserve = paramMap.get(StringUtil.reResAbbreviated(resType) + "BiologicalReserve") == null ? "" : new String(((String)paramMap.get(StringUtil.reResAbbreviated(resType) + "BiologicalReserve")).getBytes("ISO-8859-1"), "UTF-8") ;
				paramMap.put(StringUtil.reResAbbreviated(resType) + "BiologicalReserve", BiologicalReserve);	
				
				String ExperimentSupplies = paramMap.get(StringUtil.reResAbbreviated(resType) + "ExperimentSupplies") == null ? "" : new String(((String)paramMap.get(StringUtil.reResAbbreviated(resType) + "ExperimentSupplies")).getBytes("ISO-8859-1"), "UTF-8") ;
				paramMap.put(StringUtil.reResAbbreviated(resType) + "ExperimentSupplies", ExperimentSupplies);	
				
				paramMap.put("currentF", "true");	
			}
			
			
			
			String selectSqlId = "exhibition.select_page" ;
			String selectCountSqlId = "exhibition.select_page_count" ;
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>() ;
			Object obj = null;
			
			if(!resType.equals("-1101")){
				bname += "高级查询" ;
			}else{
				bname += "查询";
			}
			if(!resType.equals("-1101")){
				if("exhibition".equals(resType)) {
					String erArea = paramMap.get("erArea") == null ? "" : (String)paramMap.get("erArea") ;
					paramMap.put("erArea", "0".equals(erArea) ? "" : erArea) ;
					selectSqlId = "exhibition.select_page_quick" ;
					selectCountSqlId = "exhibition.select_page_quick_count" ;
					bname += " &gt; 文物博览室查询" ;
				}else if("observation".equals(resType)) {
					selectSqlId = "observation.select_page_quick" ;
					selectCountSqlId = "observation.select_page_quick_count" ;
					bname += " &gt; 专题研读室查询" ;
				}else if("laboratory".equals(resType)) {
					selectSqlId = "laboratory.select_page_quick" ;
					selectCountSqlId = "laboratory.select_page_quick_count" ;
					bname += " &gt; 教学研究室查询" ;
				}else if("projection".equals(resType)) {
					selectSqlId = "projection.select_page_quick" ;
					selectCountSqlId = "projection.select_page_quick_count" ;
					bname += " &gt; 影像资料室查询" ;
				}else if("lovely".equals(resType)) {
					selectSqlId = "lovely.select_page_quick" ;
					selectCountSqlId = "lovely.select_page_quick_count" ;
					bname += " &gt;情系家园查询" ;
					String expName = paramMap.get("expName") == null ? "" : (String)paramMap.get("expName") ;
					paramMap.put("crName", expName) ;
					paramMap.remove("expName");
				}
			
				List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList(selectSqlId, paramMap);
				int b = list1.size();
				for(HashMap<String, Object> res : list1) {
					HashMap<String, Object> map = new HashMap<String, Object>() ;
					if("exhibition".equals(resType)) {
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
					}else if("observation".equals(resType)) {
						map.put("name", res.get("orName")) ;
						map.put("id", res.get("orID")) ;
						map.put("upload", res.get("orUpload")) ;
						map.put("thumbnail", res.get("orThumbnail")) ;
						map.put("inthum", res.get("orInThum")) ;						
						map.put("path", res.get("orPath")) ;							
						map.put("fileType", res.get("orType")) ;
						map.put("resType", "observation") ;
						map.put("creator", res.get("orCreator")) ;
						map.put("createTime", res.get("orCreateTime")) ;
						map.put("audio", res.get("orAudio"));
						map.put("room", "2");
					}else if("laboratory".equals(resType)) {
						map.put("name", res.get("lrName")) ;
						map.put("id", res.get("lrID")) ;
						map.put("upload", res.get("lrUpload")) ;
						map.put("thumbnail", res.get("lrThumbnail")) ;
						map.put("inthum", res.get("lrInThum")) ;						
						map.put("path", res.get("lrPath")) ;							
						map.put("fileType", res.get("lrType")) ;
						map.put("resType", "laboratory") ;
						map.put("creator", res.get("lrCreator")) ;
						map.put("createTime", res.get("lrCreateTime")) ;
					}else if("projection".equals(resType)) {
						map.put("name", res.get("prName")) ;
						map.put("id", res.get("prID")) ;
						map.put("upload", res.get("prUpload")) ;
						map.put("thumbnail", res.get("prThumbnail"));
						map.put("inthum", res.get("prInThum")) ;	
						map.put("path", res.get("prPath")) ;							
						map.put("fileType", res.get("prType")) ;
						map.put("resType", "projection") ;
						map.put("creator", res.get("prCreator")) ;
						map.put("createTime", res.get("prCreateTime")) ;
					}else if("lovely".equals(resType)) {
						map.put("name", res.get("crName")) ;
						map.put("id", res.get("crID")) ;
						map.put("upload", res.get("crUpload")) ;
						map.put("thumbnail", res.get("crThumbnail")) ;
						map.put("inthum", res.get("crInThum")) ;						
						map.put("path", res.get("crPath")) ;							
						map.put("fileType", res.get("crType")) ;
						map.put("resType", "lovely") ;
						map.put("creator", res.get("crCreator")) ;
						map.put("createTime", res.get("crCreateTime")) ;
						map.put("crContent", res.get("crContent")) ;
						map.put("crTaskId", res.get("crTaskId")) ;
					}
					list.add(map) ;
				}
				obj = eventExecutor.getSqlSession().selectOne(selectCountSqlId, paramMap);
			}else{
			/**/
				// 快速查找
				if(paramMap.get("-1101")!=null){
					paramMap.put("start","0");
					paramMap.put("offset","15");
				}
				List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList("exhibition.select_page_smallselect", paramMap);
				int li1 = list1.size();
				for(HashMap<String, Object> res : list1) {
				
					HashMap<String, Object> map = new HashMap<String, Object>() ;
					/*if("exhibition".equals(resType)) {*/
						map.put("name", res.get("erName")) ;
						map.put("id", res.get("erID")) ;
						map.put("upload", res.get("erUpload")) ;
						map.put("thumbnail", res.get("erThumbnail")) ;
						map.put("inthum", res.get("erInThum")) ;	
						//if(!s_userType.equals("3")){
							map.put("path", res.get("erPath")) ;							
						//}else{
						//	map.put("path", res.get("")) ;
						//}
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
				List<HashMap<String, Object>> list2 = eventExecutor.getSqlSession().selectList("observation.select_page_smallselect", paramMap);
				int li2 = list2.size();
				for(HashMap<String, Object> res : list2) {
					
					HashMap<String, Object> map1 = new HashMap<String, Object>() ;
					/*if("observation".equals(resType)) {*/
						map1.put("name", res.get("orName")) ;
						map1.put("id", res.get("orID")) ;
						map1.put("upload", res.get("orUpload")) ;
						map1.put("thumbnail", res.get("orThumbnail")) ;
						map1.put("inthum", res.get("orInThum")) ;	
						//if(!s_userType.equals("3")){
							map1.put("path", res.get("orPath")) ;							
						//}else{
						//	map1.put("path", res.get("")) ;
						//}
						map1.put("fileType", res.get("orType")) ;
						map1.put("resType", "observation") ;
						map1.put("creator", res.get("orCreator")) ;
						map1.put("createTime", res.get("orCreateTime")) ;
						map1.put("audio", res.get("orAudio"));
						map1.put("room", "2");
					
					/*}*/
					list.add(map1);
				}
				List<HashMap<String, Object>> list3 = eventExecutor.getSqlSession().selectList("laboratory.select_page_smallselect", paramMap);
				int li3 = list3.size();
				for(HashMap<String, Object> res : list3) {
			
					HashMap<String, Object> map2 = new HashMap<String, Object>() ;
					
					/*if("laboratory".equals(resType)) {*/
						map2.put("name", res.get("lrName")) ;
						map2.put("id", res.get("lrID")) ;
						map2.put("upload", res.get("lrUpload")) ;
						map2.put("thumbnail", res.get("lrThumbnail")) ;
						map2.put("inthum", res.get("lrInThum")) ;	
						//if(!s_userType.equals("3")){
							map2.put("path", res.get("lrPath")) ;							
						//}else{
						//	map2.put("path", res.get("")) ;
						//}
						map2.put("fileType", res.get("lrType")) ;
						map2.put("resType", "laboratory") ;
						map2.put("creator", res.get("lrCreator")) ;
						map2.put("createTime", res.get("lrCreateTime")) ;
					
					/*}*/
					list.add(map2);
				}
				List<HashMap<String, Object>> list4 = eventExecutor.getSqlSession().selectList("projection.select_page_smallselect", paramMap);
				int li4 = list4.size();
				for(HashMap<String, Object> res : list4) {
					HashMap<String, Object> map3 = new HashMap<String, Object>() ;
					
					/*if("projection".equals(resType)) {*/
						map3.put("name", res.get("prName")) ;
						map3.put("id", res.get("prID")) ;
						map3.put("upload", res.get("prUpload")) ;
						map3.put("thumbnail", res.get("prThumbnail")) ;
						map3.put("inthum", res.get("prInThum")) ;	
						//if(!s_userType.equals("3")){
							map3.put("path", res.get("prPath")) ;							
						//}else{
						//	map3.put("path", res.get("")) ;
						//}
						map3.put("fileType", res.get("prType")) ;
						map3.put("resType", "projection") ;
						map3.put("creator", res.get("prCreator")) ;
						map3.put("createTime", res.get("prCreateTime")) ;
						
					/*}*/
					list.add(map3);
				}
				List<HashMap<String, Object>> list5 = eventExecutor.getSqlSession().selectList("lovely.select_page_smallselect", paramMap);
				int li5 = list5.size();
				for(HashMap<String, Object> res : list5) {
					
					HashMap<String, Object> map4 = new HashMap<String, Object>() ;
					/*if("expand".equals(resType)) {*/
						map4.put("name", res.get("crName")) ;
						map4.put("id", res.get("crID")) ;
						map4.put("upload", res.get("crUpload")) ;
						map4.put("thumbnail", res.get("crThumbnail")) ;
						map4.put("inthum", res.get("crInThum")) ;	
						//if(!s_userType.equals("3")){
							map4.put("path", res.get("crPath")) ;							
						//}else{
						//	map4.put("path", res.get("")) ;
						//}
						map4.put("fileType", res.get("crType")) ;
						map4.put("resType", "lovely") ;
						map4.put("creator", res.get("crCreator")) ;
						map4.put("createTime", res.get("crCreateTime")) ;
						map4.put("crContent", res.get("crContent")) ;
						map4.put("crTaskId", res.get("crTaskId")) ;
					
					/*}*/
					list.add(map4);
				}
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				//  testinfo
				List<HashMap<String, Object>> list6 = eventExecutor.getSqlSession().selectList("test.select_page_smallselect", paramMap);
				int li6 = list6.size();
				for(HashMap<String, Object> res : list6) {
					
					HashMap<String, Object> map6 = new HashMap<String, Object>() ;
					/*if("expand".equals(resType)) {*/
						map6.put("name", res.get("testName")) ;
						map6.put("id", res.get("testID")) ;
						map6.put("testGrades", res.get("testGrades")) ;
						map6.put("testNum", res.get("testNum")) ;
						map6.put("resType", "question") ;
						map6.put("code", "1701") ;
						map6.put("thumbnail", "images/rs.jpg") ;
						if(res.get("testCreateTime")!= null){
						map6.put("createTime", sdf.format(sdf.parse(res.get("testCreateTime").toString()))) ;
						}
					/*}*/
					list.add(map6);
				}
				
				
				List<HashMap<String, Object>> list7 = eventExecutor.getSqlSession().selectList("histask.select_isAccpet_end_list_search", paramMap);
				int li7 = list7.size();
				for(HashMap<String, Object> res : list7) {
					
					HashMap<String, Object> map7 = new HashMap<String, Object>() ;
					/*if("expand".equals(resType)) {*/
					map7.put("name", res.get("htaskTitle")) ;
					map7.put("id", res.get("htaskID")) ;
					map7.put("createkeywords", res.get("createkeywords")) ;
					map7.put("resType", "question") ;
					map7.put("code", "1890002") ;
					map7.put("thumbnail", "images/gc.jpg") ;
					map7.put("createTime", sdf.format(res.get("htaskCreatetime"))) ;
					
					/*}*/
					list.add(map7);
				}
				
				List<HashMap<String, Object>> list8 = eventExecutor.getSqlSession().selectList("histask.select_task_by_splitidis0_search", paramMap);
				int li8 = list8.size();
				for(HashMap<String, Object> res : list8) {
					
					HashMap<String, Object> map8 = new HashMap<String, Object>() ;
					/*if("expand".equals(resType)) {*/
					map8.put("name", res.get("htaskTitle")) ;
					map8.put("id", res.get("htaskID")) ;
					map8.put("htaskKeywords", res.get("htaskKeywords")) ;
					map8.put("resType", "question") ;
					map8.put("code", "1890003") ;
					map8.put("thumbnail", "images/cg.jpg") ;
					map8.put("createTime", sdf.format(res.get("htaskCreatetime"))) ;
					
					/*}*/
					list.add(map8);
				}
				
				
				
				
				obj = li1 + li2+ li3+ li4+ li5 +li6 +li7 +li8;
			}
			
			int count = 0;
			if (obj != null){
				if (obj instanceof Integer){
					if(!resType.equals("-1101")){
						count = (Integer)obj;
					}else{
					count = list.size();
					}
				}
			}
			
			//每页显示记录数
			int pageSize = 8;
			String psize = eventExecutor.getBaseAction().getPageSize(); 
			try{
				pageSize = Integer.parseInt(psize);
			}
			catch (Exception e){
			}
			int pageCount = (int)Math.ceil(count/(double) pageSize);			
			PaginatedData paginatedData =  new PaginatedData();
			
			
			ArrayList nlist = new ArrayList();	
			
			if(!resType.equals("-1101")){
				paginatedData.setCurrentPage(currentPage);
				paginatedData.setPageCount(pageCount);
				paginatedData.setPageSize(pageSize);
			}else{
				int startidx = (currentPage - 1)*pageSize;	
				int endidx =  (currentPage)*pageSize-1;
				
				for (int i =startidx;i<=endidx; i++ ){
					if (i < count){
						if(list.get(i)==null){
							break;
						}
						nlist.add(list.get(i));
					}
					
				}
				paginatedData.setCurrentPage(currentPage);
				paginatedData.setPageCount(pageCount);
				paginatedData.setPageSize(pageSize);
				
			}
			
			
			String baseURL = "code="+eventExecutor.getBaseAction().getCode() + "&paramMap.resType=" + resType;
			
			if(currentPage >=2 || (furr.equals("true"))){
				baseURL +="&paramMap.currentF=true";
			}
			
			if(!resType.equals("-1101")){
				if(paramMap.get("resType").equals("observation")){
					
					if(paramMap.get("orType")!=null){
						baseURL = baseURL +"&paramMap.orType="+paramMap.get("orType");
					}
					if(paramMap.get("orNO")!=null){
						baseURL = baseURL +"&paramMap.orNO="+paramMap.get("orNO");
					}
					if(paramMap.get("orCategory")!=null){
						baseURL = baseURL +"&paramMap.orCategory="+paramMap.get("orCategory");
					}
					if(paramMap.get("orCateTwLevel")!=null){
						baseURL = baseURL +"&paramMap.orCateTwLevel="+paramMap.get("orCateTwLevel");
					}
					if(paramMap.get("orCateThLevel")!=null){
						baseURL = baseURL +"&paramMap.orCateThLevel="+paramMap.get("orCateThLevel");
					}
					if(paramMap.get("orCateFoLevel")!=null){
						baseURL = baseURL +"&paramMap.orCateFoLevel="+paramMap.get("orCateFoLevel");
					}
					if(paramMap.get("orCateFiveLevel")!=null){
						baseURL = baseURL +"&paramMap.orCateFiveLevel="+paramMap.get("orCateFiveLevel");
					}
					
					if(paramMap.get("orName")!=null){
						baseURL = baseURL +"&paramMap.orName="+paramMap.get("orName");
					}
					if(paramMap.get("orLatinName")!=null){
						baseURL = baseURL +"&paramMap.orLatinName="+paramMap.get("orLatinName");
					}
					
				}else if(paramMap.get("resType").equals("laboratory")){
					
					if(paramMap.get("lrNO")!=null){
						baseURL = baseURL +"&paramMap.lrNO="+paramMap.get("lrNO");
					}
					
					if(paramMap.get("lrName")!=null){
						baseURL = baseURL +"&paramMap.lrName="+paramMap.get("lrName");
					}
					if(paramMap.get("lrType")!=null){
						baseURL = baseURL +"&paramMap.lrType="+paramMap.get("lrType");
					}
					if(paramMap.get("lrCategory")!=null){
						baseURL = baseURL +"&paramMap.lrCategory="+paramMap.get("lrCategory");
					}
					if(paramMap.get("lrCateTwLevel")!=null){
						baseURL = baseURL +"&paramMap.lrCateTwLevel="+paramMap.get("lrCateTwLevel");
					}
					if(paramMap.get("lrExperimentSupplies")!=null){
						baseURL = baseURL +"&paramMap.lrExperimentSupplies="+paramMap.get("lrExperimentSupplies");
					}
			
				}else if(paramMap.get("resType").equals("projection")){

					if(paramMap.get("prName")!=null){
						baseURL = baseURL +"&paramMap.prName="+paramMap.get("prName");
					}
					if(paramMap.get("prType")!=null){
						baseURL = baseURL +"&paramMap.prType="+paramMap.get("prType");
					}
					
					if(paramMap.get("prCategory")!=null){
						baseURL = baseURL +"&paramMap.prCategory="+paramMap.get("prCategory");
					}
					if(paramMap.get("prCateTwLevel")!=null){
						baseURL = baseURL +"&paramMap.prCateTwLevel="+paramMap.get("prCateTwLevel");
					}
					
				}else if(paramMap.get("resType").equals("lovely")){
				
					if(paramMap.get("crName")!=null){
						baseURL = baseURL +"&paramMap.crName="+paramMap.get("crName");
					}
				
					if(paramMap.get("crResType")!=null){
						baseURL = baseURL +"&paramMap.crResType="+paramMap.get("crResType");
					}
					
					if(paramMap.get("crCateTwLevel")!=null){
						baseURL = baseURL +"&paramMap.crCateTwLevel="+paramMap.get("crCateTwLevel");
					}
					
				}else if(paramMap.get("resType").equals("exhibition")){
					
					if(paramMap.get("erCode")!=null ){
						baseURL = baseURL +"&paramMap.erCode="+paramMap.get("erCode");
					}
					if(paramMap.get("erName")!=null ){
						baseURL = baseURL +"&paramMap.erName="+paramMap.get("erName");
					}
					if(paramMap.get("erType")!=null ){
						baseURL = baseURL +"&paramMap.erType="+paramMap.get("erType");
					}
					if(paramMap.get("erTotalID")!=null ){
						baseURL = baseURL +"&paramMap.erTotalID="+paramMap.get("erTotalID");
					}
					if(paramMap.get("erJieID")!=null ){
						baseURL = baseURL +"&paramMap.erJieID="+paramMap.get("erJieID");
					}
					if(paramMap.get("erChorID")!=null ){
						baseURL = baseURL +"&paramMap.erChorID="+paramMap.get("erChorID");
					}
					if(paramMap.get("erGangID")!=null ){
						baseURL = baseURL +"&paramMap.erGangID="+paramMap.get("erGangID");
					}
					if(paramMap.get("erOrderID")!=null){
						baseURL = baseURL +"&paramMap.erOrderID="+paramMap.get("erOrderID");
					}
					if(paramMap.get("erCategory")!=null){
						baseURL = baseURL +"&paramMap.erCategory="+paramMap.get("erCategory");
					}
					if(paramMap.get("erGenus")!=null){
						baseURL = baseURL +"&paramMap.erGenus="+paramMap.get("erGenus");
					}
					if(paramMap.get("erBiologicalReserve")!=null ){
						baseURL = baseURL +"&paramMap.erBiologicalReserve="+paramMap.get("erBiologicalReserve");
					}
					if(paramMap.get("erCountry")!=null ){
						baseURL = baseURL +"&paramMap.erCountry="+paramMap.get("erCountry");
					}
					if(paramMap.get("erProvince")!=null){
						baseURL = baseURL +"&paramMap.erProvince="+paramMap.get("erProvince");
					}
					if(paramMap.get("erCity")!=null){
						baseURL = baseURL +"&paramMap.erCity="+paramMap.get("erCity");
					}
					
				}
			}else{
				baseURL = baseURL + "&paramMap.keyword="+paramMap.get("keyword");
			}
			
			paginatedData.htmlPage(baseURL);
			if(!resType.equals("-1101")){
				//System.out.println(list.size());
				resultData.setList(list);
			}else{
				resultData.setList(nlist);
			}
			resultData.setPaginatedData(paginatedData);
			eventExecutor.getBaseAction().setBussessNavigation(bname);
			
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
