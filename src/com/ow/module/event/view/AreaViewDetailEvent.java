package com.ow.module.event.view;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class AreaViewDetailEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public AreaViewDetailEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			String selectCNameSqlId = eventExecutor.getSqlidByIndex(1);
			Object obj = eventExecutor.getSqlSession().selectOne(selectSqlId, eventExecutor.getBaseAction().getParamMap());
			resultData.setOne(obj);
			String path = eventExecutor.getBaseAction().getPath() == null ? "" : eventExecutor.getBaseAction().getPath();
			String arrPath [] = path.split(",");
			String  bname = "";
			for (int i=0; i<arrPath.length; i++){
				if (arrPath[i] != null && !arrPath[i].equals("")){
					eventExecutor.getBaseAction().getParamMap().put("areaID", arrPath[i]);
					Object one = eventExecutor.getSqlSession().selectOne(selectCNameSqlId, eventExecutor.getBaseAction().getParamMap());
					if (one != null){
						String name = ((HashMap)one).get("areaName") == null?"" : ((HashMap)one).get("areaName").toString();
						if (bname.equals("")){
							bname = name;
						}
						else{
							bname +=" &gt; " + name;
						}
					}
				}
			}
			String erName = "",erID = "";
			if (obj != null){
				erName = ((HashMap)obj).get("erName") == null ? "":((HashMap)obj).get("erName").toString();
				erID = ((HashMap)obj).get("erID") == null ? "":((HashMap)obj).get("erID").toString();
			}
			if (!erName.equals(""))
				bname += " &gt; " + erName;
			eventExecutor.getBaseAction().setBussessNavigation(bname);			
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, AreaViewDetailEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
