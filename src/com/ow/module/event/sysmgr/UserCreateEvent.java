package com.ow.module.event.sysmgr;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.SmartServer.util.SmartWebServer;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.GODEvent;
import com.ow.framework.util.KeyHelper;
import com.unitecount.RegisterCount;




public class UserCreateEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private SmartWebServer dog = null;
	public UserCreateEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "unchecked", "unused" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			
			
			String password = (String)paramMap.get("password");
			password = GODEvent.getInstance(dog, password);
			paramMap.put("password", password);
			String autoPrimaryKey = KeyHelper.getKey();
			paramMap.put("autoPrimaryKey", autoPrimaryKey);
			
			String sid = eventExecutor.getSqlidByIndex(0);
			String sidorg = eventExecutor.getSqlidByIndex(1);
			String sidinfo = eventExecutor.getSqlidByIndex(2);
			if (!"".equals(sid) && !sidorg.equals("") && !sidinfo.equals(""))
			{
				int rvalue = eventExecutor.getSqlSession().insert(sid, paramMap);
				
				paramMap.put("userID", eventExecutor.getBaseAction().getParamMap().get("generatedKey"));
				int r = eventExecutor.getSqlSession().insert(sidinfo, paramMap);
				
				String userOrgID = paramMap.get("userOrgID") == null?"":paramMap.get("userOrgID").toString();
				if (!userOrgID.equals("")){
					String uoarr [] = userOrgID.split(",");
					for (int i=0; i<uoarr.length; i++){
						if (uoarr[i] != null && !uoarr[i].equals("")){
							paramMap.put("userOrgID", uoarr[i]);
							eventExecutor.getSqlSession().insert(sidorg, paramMap);
						}
					}
				}
				//统计信息
				String flag=(String)paramMap.get("type");
				String flag1="";
				if("1".equals(flag)){
					flag1="TEACHER";
				}else if("2".equals(flag)){
					flag1="STUDENT";
				}
				RegisterCount.sendMsg(flag1);
				resultData.setIntResult(rvalue);
				//绑定角色
				paramMap.put("urmRoleID",flag);
				int s = eventExecutor.getSqlSession().insert("userRole.insert", paramMap);
				
			}				
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, UserCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
