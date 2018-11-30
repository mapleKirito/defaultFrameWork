package com.ow.module.event.view;

import java.io.File;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.data.handler.config.Permission;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DBUtil;




public class FunctionAreaViewEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private static String fileSplit = "/";
	public FunctionAreaViewEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap<String,String> paramMap = eventExecutor.getBaseAction().getParamMap() ;
			paramMap.put("start",paramMap.get("start1")); 			
			String path =  paramMap.get("path");
		    paramMap.put("cateID", paramMap.get("cateID")) ;
			paramMap.put("catePath", path) ;
					
			String selectSqlId = "exhibition.select_page" ;
			String selectCountSqlId = "exhibition.select_page_count" ;
			
			/*String cli = paramMap.get("erClimateID") == null ? "":(String)paramMap.get("erClimateID"); 
			if(!cli.equals("") && "52,53,54,55,56,57,58,59,60,61,992,993".indexOf((String)paramMap.get("erClimateID"))>-1){
				paramMap.put("erManyClimate", (String)paramMap.get("erClimateID")) ;
			}*/
		
			List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList(selectSqlId, paramMap);
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>() ;
			for(HashMap<String, Object> res : list1) {
				//System.out.println(res.toString());
				HashMap<String, Object> map = new HashMap<String, Object>() ;			
						map.put("name", res.get("erName")) ;
						map.put("id", res.get("erID")) ;
						map.put("upload", res.get("erUpload")) ;
						map.put("gangID", res.get("erGangID")) ;
						map.put("thumbnail", res.get("erThumbnail")) ;
						map.put("InThum", res.get("erInThum")) ;
						map.put("path", path) ;
						map.put("fileType", res.get("erType")) ;
						map.put("resType", "exhibition") ;
						map.put("creator", res.get("erCreator")) ;
						map.put("createTime", res.get("erCreateTime")) ;
						map.put("audio", res.get("erAudio"));
						map.put("room", "1");
					
				
				list.add(map) ;
			}
			if(paramMap.get("flag")==null){
				Object obj = eventExecutor.getSqlSession().selectOne(selectCountSqlId, paramMap);
				obj	= (Integer)obj;
				HashMap<String, Object> dd = new HashMap();
				dd.put("count", obj+"");
				list.add(dd); 
			}
			
			resultData.setList(list);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, FunctionAreaViewEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
