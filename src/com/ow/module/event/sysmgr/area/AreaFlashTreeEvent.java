package com.ow.module.event.sysmgr.area;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class AreaFlashTreeEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public AreaFlashTreeEvent() {
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			
			String cid = eventExecutor.getSqlidByIndex(0);
			String pid = eventExecutor.getSqlidByIndex(1);
			String id = eventExecutor.getBaseAction().getId();
			HashMap hashMap = eventExecutor.getBaseAction().getParamMap();
			List resultList =  null;
			if (!"".equals(pid))
			{
				if (id != null && !id.equals("0")){
					hashMap.put("id", id);
				}
				else{
					hashMap.put("id", "0");
				}
				String ischild = hashMap.get("areaIsChild") == null? "1":hashMap.get("areaIsChild").toString();
				HashMap hashMapTemp = new HashMap();
				if (ischild.equals("0")){
					Object obj =  eventExecutor.getSqlSession().selectOne(cid, hashMap);
					if (obj instanceof HashMap){
						String cateID = ((HashMap)obj).get("areaID") == null? "":((HashMap)obj).get("areaID").toString();
						String cateName = ((HashMap)obj).get("areaName") == null? "":((HashMap)obj).get("areaName").toString();
						String catePath = ((HashMap)obj).get("areaPath") == null? "":((HashMap)obj).get("areaPath").toString();
						hashMapTemp.put("areaID", cateID);
						hashMapTemp.put("areaName", cateName);
						hashMapTemp.put("areaPath", catePath);
						hashMapTemp.put("code", "-801");
					}
				}
				else{
					//hashMap.put("areaIsShow", "1");
					resultList =  eventExecutor.getSqlSession().selectList(pid, hashMap);
					hashMapTemp.put("areaDateList", resultList);
				}
				resultData.setOne(hashMapTemp);
			}					
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, AreaFlashTreeEvent.class);
			log.error(error);
			throw e;
		}
	}
}
