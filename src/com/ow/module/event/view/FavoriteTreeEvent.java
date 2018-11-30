package com.ow.module.event.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class FavoriteTreeEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public FavoriteTreeEvent()
	{
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			String json = null;
			if (!"".equals(sid))
			{
				List favList = eventExecutor.getSqlSession().selectList(sid, eventExecutor.getBaseAction().getParamMap());
				try {
					List<Object> list = new ArrayList<Object>();
					if (favList != null && favList.size() > 0){
						for (int i=0; i<favList.size();i++) {
							if (favList.get(i) instanceof HashMap){
								Map<String, Object> maprole = new Hashtable<String, Object>();
								//树形参数
								String favId = ((HashMap)favList.get(i)).get("rfId") == null?"0":((HashMap)favList.get(i)).get("rfId").toString();
								String favParentID = ((HashMap)favList.get(i)).get("rfParentId") == null?"0":((HashMap)favList.get(i)).get("rfParentId").toString();
								String favName = ((HashMap)favList.get(i)).get("rfName") == null?"":((HashMap)favList.get(i)).get("rfName").toString();
								String path = ((HashMap)favList.get(i)).get("rfPath") == null?"":((HashMap)favList.get(i)).get("rfPath").toString();
								String sort = ((HashMap)favList.get(i)).get("rfSort") == null?"":((HashMap)favList.get(i)).get("rfSort").toString();
								String level = ((HashMap)favList.get(i)).get("rfLevel") == null?"":((HashMap)favList.get(i)).get("rfLevel").toString();
								maprole.put("id", Integer.parseInt(favId));
								maprole.put("pId",Integer.parseInt(favParentID));
								maprole.put("name", favName);
								maprole.put("path", path);
								maprole.put("sort", sort);
								maprole.put("level", level);
								list.add(maprole);
							}							
						}
					}
					json = JSONArray.fromObject(list).toString();
					resultData.setContent(json);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}					
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, FavoriteTreeEvent.class);
			log.error(error);
			throw e;
		}
	}
}
