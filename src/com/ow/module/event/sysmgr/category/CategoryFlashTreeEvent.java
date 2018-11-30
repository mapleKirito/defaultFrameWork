package com.ow.module.event.sysmgr.category;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class CategoryFlashTreeEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public CategoryFlashTreeEvent() {
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			
			String cid = eventExecutor.getSqlidByIndex(0);
			String cpid = eventExecutor.getSqlidByIndex(1);
			String id = eventExecutor.getBaseAction().getId();
			HashMap hashMap = eventExecutor.getBaseAction().getParamMap();
			List resultList =  null;
			if (!"".equals(cpid) && !"".equals(cid))
			{
				if (id != null && !id.equals("0")){
					hashMap.put("id", id);
					hashMap.remove("cateSign");
				}
				else{
					hashMap.put("id", "0");
				}	
				String ischild = hashMap.get("cateIsChild") == null? "1":hashMap.get("cateIsChild").toString();
				HashMap hashMapTemp = new HashMap();
				if (ischild.equals("0")){
					Object obj =  eventExecutor.getSqlSession().selectOne(cid, hashMap);
					if (obj instanceof HashMap){
						String cateID = ((HashMap)obj).get("cateID") == null? "":((HashMap)obj).get("cateID").toString();
						String cateName = ((HashMap)obj).get("cateName") == null? "":((HashMap)obj).get("cateName").toString();
						String cateSign = ((HashMap)obj).get("cateSign") == null? "":((HashMap)obj).get("cateSign").toString();
						String catePath = ((HashMap)obj).get("catePath") == null? "":((HashMap)obj).get("catePath").toString();
						hashMapTemp.put("cateID", cateID);
						hashMapTemp.put("cateName", cateName);
						hashMapTemp.put("cateSign", cateSign);
						hashMapTemp.put("catePath", catePath);
						hashMapTemp.put("code", "-701");
					}
				}
				else{
					hashMap.put("cateStatus", "1");
					resultList =  eventExecutor.getSqlSession().selectList(cpid, hashMap);
					hashMapTemp.put("cateDateList", resultList);
				}
				resultData.setOne(hashMapTemp);
			}					
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, CategoryFlashTreeEvent.class);
			log.error(error);
			throw e;
		}
	}
}
