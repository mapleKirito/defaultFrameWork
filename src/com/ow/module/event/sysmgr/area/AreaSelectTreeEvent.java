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

public class AreaSelectTreeEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public AreaSelectTreeEvent() {
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			if (!"".equals(sid))
			{
				try {
					List list = new ArrayList<Object>();
					List resultList =  eventExecutor.getSqlSession().selectList(sid, eventExecutor.getBaseAction().getParamMap());
					if (resultList != null && resultList.size() > 0){
						for (int i=0; i<resultList.size();i++){
							if (resultList.get(i) instanceof HashMap){
								Map<String, Object> maporg = new Hashtable<String, Object>(); 
								String areaID = ((HashMap)resultList.get(i)).get("areaID") == null? "" : ((HashMap)resultList.get(i)).get("areaID").toString();
								String areaName = ((HashMap)resultList.get(i)).get("areaName") == null? "" : ((HashMap)resultList.get(i)).get("areaName").toString();
								String areaIsChild = ((HashMap)resultList.get(i)).get("areaIsChild") == null? "" : ((HashMap)resultList.get(i)).get("areaIsChild").toString();
								maporg.put("id", areaID);
								maporg.put("name", areaName);
								if (areaIsChild.equals("0")){
									maporg.put("isParent", "false");
								}
								else{
									maporg.put("isParent", "true");
								}
								list.add(maporg);
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
			String error = DetailException.expDetail(e, AreaSelectTreeEvent.class);
			log.error(error);
			throw e;
		}
	}
}
