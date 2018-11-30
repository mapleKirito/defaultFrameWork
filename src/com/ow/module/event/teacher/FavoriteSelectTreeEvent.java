package com.ow.module.event.teacher;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class FavoriteSelectTreeEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public FavoriteSelectTreeEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectsid = eventExecutor.getSqlidByIndex(0);
			String id = eventExecutor.getBaseAction().getId();
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
				hashMapTemp.put("name", "设为顶级收藏夹");
				hashMapTemp.put("isPath", "1");
				hashMapTemp.put("isParent", false);
				hashMapTemp.put("ischild", "0");
//				hashMapTemp.put("open", true);
//				hashMapTemp.put("iconSkin", "pIcon01");
				rlist.add(hashMapTemp);					
			}
			
			List list = eventExecutor.getSqlSession().selectList(selectsid, eventExecutor.getBaseAction().getParamMap());
			if (list != null && list.size() > 0){
				for (int i=0; i<list.size();i++){
					if (list.get(i) instanceof HashMap){
						HashMap hashMap = new HashMap();
						String cid = ((HashMap)list.get(i)).get("rfId") == null?"":((HashMap)list.get(i)).get("rfId").toString();
						String cpid = ((HashMap)list.get(i)).get("rfParentId") == null?"":((HashMap)list.get(i)).get("rfParentId").toString();
						String cname = ((HashMap)list.get(i)).get("rfName") == null?"":((HashMap)list.get(i)).get("rfName").toString();
						String ischild = ((HashMap)list.get(i)).get("rfIsChild") == null?"0":((HashMap)list.get(i)).get("rfIsChild").toString();
						String path = ((HashMap)list.get(i)).get("rfPath") == null?"0":((HashMap)list.get(i)).get("rfPath").toString();
						String sort = ((HashMap)list.get(i)).get("rfSort") == null?"0":((HashMap)list.get(i)).get("rfSort").toString();
						String isPath = ((HashMap)list.get(i)).get("rfIsPath") == null?"0":((HashMap)list.get(i)).get("rfIsPath").toString();
						hashMap.put("id", cid);
						hashMap.put("pId", cpid);
						hashMap.put("path", path);
						hashMap.put("sort", sort);
						hashMap.put("name", cname);
						hashMap.put("isPath", isPath);
						if (ischild.equals("1")){
							hashMap.put("isParent", true);
	//						hashMap.put("iconSkin", "pIcon01");
						}
						hashMap.put("ischild", ischild);
						rlist.add(hashMap);
					}
				}
			}
			resultData.setList(rlist);
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, FavoriteSelectTreeEvent.class);
			log.error(error);
			throw e;
		}
		return resultData;
	}

}
