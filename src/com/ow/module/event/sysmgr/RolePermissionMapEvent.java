package com.ow.module.event.sysmgr;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.KeyHelper;




public class RolePermissionMapEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public RolePermissionMapEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String autoPrimaryKey = KeyHelper.getKey();
			eventExecutor.getBaseAction().getParamMap().put("autoPrimaryKey", autoPrimaryKey);
			String deletesid = eventExecutor.getSqlidByIndex(0);
			String insertsid = eventExecutor.getSqlidByIndex(1);
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			if (deletesid != null && !deletesid.equals(""))
			{
				eventExecutor.getSqlSession().delete(deletesid, map);
			}		
			if (insertsid != null && !insertsid.equals(""))
			{
				String pmsArr [] = eventExecutor.getBaseAction().getParamMap().get("treeCheckboxVal") == null ?new String[1]:eventExecutor.getBaseAction().getParamMap().get("treeCheckboxVal").split(",");
				String index[] = {"001","002","003"};
				int indextotal_=0;
				String indextotal="--";
				for (int i=0; i<pmsArr.length; i++)
				{
					if (pmsArr[i] != null && !pmsArr[i].equals("")){
						pmsArr[i] = pmsArr[i].trim().replaceAll("pmsCode=", "");
						for(int a=0;a<index.length;a++){
							if(pmsArr[i].equals(index[a])){
								indextotal = pmsArr[i];		
								indextotal_++;
							};
						}
						eventExecutor.getBaseAction().getParamMap().put("rpmPmsCode", pmsArr[i]);
						eventExecutor.getSqlSession().insert(insertsid, eventExecutor.getBaseAction().getParamMap());
					}
				}
				
				HashMap mapmap = new HashMap();
				mapmap.put("roleID", map.get("roleID"));
				mapmap.put("roleGrant", indextotal);
				
				if(indextotal_==1){
					mapmap.put("roleIndex", "One");
				}else if(indextotal_==2){
					mapmap.put("roleIndex", "Two");
				}else if(indextotal_==3){
					mapmap.put("roleIndex", "Three");
				}else if(indextotal_==0){
					mapmap.put("roleIndex", "Zero");
				}
				
				eventExecutor.getSqlSession().update("role.update_index", mapmap);
			}	
			resultData.setIntResult(1);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, RolePermissionMapEvent.class);
			log.error(error);
		}
		return resultData;
	}
}