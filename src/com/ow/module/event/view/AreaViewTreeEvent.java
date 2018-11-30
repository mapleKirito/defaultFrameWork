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




public class AreaViewTreeEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public AreaViewTreeEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectsid = eventExecutor.getSqlidByIndex(0);
			String id = eventExecutor.getBaseAction().getId();
			eventExecutor.getBaseAction().getParamMap().put("areaIsShow", "1");
			List list = eventExecutor.getSqlSession().selectList(selectsid, eventExecutor.getBaseAction().getParamMap());
			
			List rlist = new ArrayList();
			if (id != null){
				eventExecutor.getBaseAction().getParamMap().put("id", id);
			}
			for (int i=0; i<list.size();i++){
				if (list.get(i) instanceof HashMap){
					HashMap hashMap = new HashMap();
					String cid = ((HashMap)list.get(i)).get("areaID") == null?"":((HashMap)list.get(i)).get("areaID").toString();
					String cpid = ((HashMap)list.get(i)).get("areaParentID") == null?"":((HashMap)list.get(i)).get("areaParentID").toString();
					String cname = ((HashMap)list.get(i)).get("areaName") == null?"":((HashMap)list.get(i)).get("areaName").toString();
					String path = ((HashMap)list.get(i)).get("areaPath") == null?"":((HashMap)list.get(i)).get("areaPath").toString();
					String ischild = ((HashMap)list.get(i)).get("areaIsChild") == null?"0":((HashMap)list.get(i)).get("areaIsChild").toString();
					hashMap.put("id", cid);
					hashMap.put("pId", cpid);
					hashMap.put("name", cname);
					if (ischild.equals("1")){
						hashMap.put("isParent", true);
						hashMap.put("iconSkin", "pIcon01");
					}
					hashMap.put("ischild", ischild);
					hashMap.put("path", path);
					rlist.add(hashMap);
				}
			}
			resultData.setList(rlist);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, AreaViewTreeEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
