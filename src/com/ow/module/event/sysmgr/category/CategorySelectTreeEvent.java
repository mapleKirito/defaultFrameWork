package com.ow.module.event.sysmgr.category;

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

public class CategorySelectTreeEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public CategorySelectTreeEvent() {
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			String id = eventExecutor.getBaseAction().getId();
			if (!"".equals(sid))
			{
				List rlist = new ArrayList();
				if (id != null){
					eventExecutor.getBaseAction().getParamMap().put("id", id);
				}
				else{
					eventExecutor.getBaseAction().getParamMap().put("id", "0");
					HashMap hashMapTemp = new HashMap();
					hashMapTemp.put("id", "0");
					hashMapTemp.put("pId", "0");
					hashMapTemp.put("path", ",0,");
				    hashMapTemp.put("name", "设为顶级分类");
					hashMapTemp.put("isPath", "1");
					hashMapTemp.put("isParent", false);
					hashMapTemp.put("ischild", "0");
					//rlist.add(hashMapTemp);		
				}	  	
				try {
					List resultList =  eventExecutor.getSqlSession().selectList(sid, eventExecutor.getBaseAction().getParamMap());
					if (resultList != null && resultList.size() > 0){
						for (int i=0; i<resultList.size();i++){
							if (resultList.get(i) instanceof HashMap){
								Map<String, Object> maporg = new Hashtable<String, Object>(); 
								String cateID = ((HashMap)resultList.get(i)).get("cateID") == null? "" : ((HashMap)resultList.get(i)).get("cateID").toString();
								String cpid = ((HashMap)resultList.get(i)).get("cateParentID") == null?"":((HashMap)resultList.get(i)).get("cateParentID").toString();
								String cateName = ((HashMap)resultList.get(i)).get("cateName") == null? "" : ((HashMap)resultList.get(i)).get("cateName").toString();
								String cateIsChild = ((HashMap)resultList.get(i)).get("cateIsChild") == null? "" : ((HashMap)resultList.get(i)).get("cateIsChild").toString();
								String path = ((HashMap)resultList.get(i)).get("catePath") == null?"0":((HashMap)resultList.get(i)).get("catePath").toString();
								maporg.put("id", cateID);
								maporg.put("pId", cpid);
								maporg.put("name", cateName);
								maporg.put("path", path);
								if (cateIsChild.equals("0")){
									maporg.put("isParent", "false");
								}
								else{
									maporg.put("isParent", "true");
								}
								maporg.put("ischild", cateIsChild);
								rlist.add(maporg);
							}
						}
					}
					resultData.setList(rlist);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}					
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, CategorySelectTreeEvent.class);
			log.error(error);
			throw e;
		}
	}
}
