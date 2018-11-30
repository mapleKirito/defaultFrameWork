package com.ow.module.event.sysmgr.area;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class AreaChildrenJsonEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public AreaChildrenJsonEvent() {
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String areaSelect = eventExecutor.getSqlidByIndex(0);
			String areaChildrenSelect = eventExecutor.getSqlidByIndex(0);
			if (!"".equals(areaSelect))
			{
				try {
					HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
					Object obj = eventExecutor.getSqlSession().selectOne(areaSelect, paramMap) ;
					List list = new ArrayList();
					if(obj != null) {
						if(obj instanceof HashMap) {
							paramMap.put("areaPath", ((HashMap)obj).get("areaPath")) ;
							List<HashMap> areaList =  eventExecutor.getSqlSession().selectList(areaChildrenSelect, paramMap);
							for(HashMap area : areaList) {
								Map<String, Object> map = new Hashtable<String, Object>(); 
								String areaID = ((HashMap)area).get("areaID") == null? "" : ((HashMap)area).get("areaID").toString();
								String areaName = ((HashMap)area).get("areaName") == null? "" : ((HashMap)area).get("areaName").toString();
								String areaIsChild = ((HashMap)area).get("areaIsChild") == null? "" : ((HashMap)area).get("areaIsChild").toString();
								String areaPath = ((HashMap)area).get("areaPath") == null? "" : ((HashMap)area).get("areaPath").toString();
								map.put("title", areaName);
								map.put("value", areaPath);
								if (areaIsChild.equals("0")){
									map.put("isParent", "false");
								}
								else{
									map.put("isParent", "true");
								}
								map.put("id", areaID) ;
								list.add(map) ;
							}
						}
					}
					
					resultData.setList(list);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}					
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, AreaChildrenJsonEvent.class);
			log.error(error);
			throw e;
		}
	}
}
