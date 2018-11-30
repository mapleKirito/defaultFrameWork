package com.ow.module.event.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class FunctionViewTreeEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public FunctionViewTreeEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
 			String selectsid = eventExecutor.getSqlidByIndex(0);
			String id = eventExecutor.getBaseAction().getId();
			String rootSign = eventExecutor.getBaseAction().getRootSign();
			List rlist = new ArrayList();
			if (id != null){
				eventExecutor.getBaseAction().getParamMap().put("id", id);
			}
			eventExecutor.getBaseAction().getParamMap().put("cateStatus", "1");
			List list = eventExecutor.getSqlSession().selectList(selectsid, eventExecutor.getBaseAction().getParamMap());
			for (int i=0; i<list.size();i++){
				if (list.get(i) instanceof HashMap){
					HashMap hashMap = new HashMap();
					String cid = ((HashMap)list.get(i)).get("cateID") == null?"":((HashMap)list.get(i)).get("cateID").toString();
					String cpid = ((HashMap)list.get(i)).get("cateParentID") == null?"":((HashMap)list.get(i)).get("cateParentID").toString();
					String cname = ((HashMap)list.get(i)).get("cateName") == null?"":((HashMap)list.get(i)).get("cateName").toString();
					String sign = ((HashMap)list.get(i)).get("cateSign") == null?"":((HashMap)list.get(i)).get("cateSign").toString();
					String ischild = ((HashMap)list.get(i)).get("cateIsChild") == null?"0":((HashMap)list.get(i)).get("cateIsChild").toString();
					String path = ((HashMap)list.get(i)).get("catePath") == null?"0":((HashMap)list.get(i)).get("catePath").toString();
					String level = ((HashMap)list.get(i)).get("cateLevel") == null?"1":((HashMap)list.get(i)).get("cateLevel").toString();
					hashMap.put("id", cid);
					hashMap.put("pId", cpid);
					hashMap.put("path", path);
					hashMap.put("name", cname);
					hashMap.put("sign", sign);
					hashMap.put("clevel", level);
					if (id == null){
						hashMap.put("rootSign", sign);
					}
					else{
						hashMap.put("rootSign", rootSign);
					}
					if (ischild.equals("1")){
						hashMap.put("isParent", true);
						hashMap.put("iconSkin", "pIcon01");
					}
					hashMap.put("ischild", ischild);
					rlist.add(hashMap);
				}
			}
			resultData.setList(rlist);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, FunctionViewTreeEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
