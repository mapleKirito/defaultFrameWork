package com.ow.module.event.sysmgr;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.SmartServer.util.SmartWebServer;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.GODEvent;




public class PasswordModifyEvent implements EventListener{

	
	/**异常处理*/
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData = new ResultData();
	private SmartWebServer dog = null;
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {

		try
		{ 
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String oldPassword = paramMap.get("oldPassword") == null?"":paramMap.get("oldPassword").toString();
			String newPassword = paramMap.get("newPassword") == null ? "": paramMap.get("newPassword").toString();
			
			newPassword = GODEvent.getInstance(dog, newPassword);
			oldPassword = GODEvent.getInstance(dog, oldPassword);
			
			String sid = eventExecutor.getSqlidByIndex(0);
			String uid = eventExecutor.getSqlidByIndex(1);		
		
			/**验证原密码*/
			String userID = eventExecutor.getBaseAction().session.get("s_userID").toString();
			Map map = new HashMap();
			map.put("s_userID", userID);
			//添加userID查找条件
			map.put("userID", userID);
			map.put("newPassword", newPassword);
			Object one = eventExecutor.getSqlSession().selectOne(sid, map);
			if(one != null){
				
				if (one instanceof HashMap)
				{
					String pwd = ((HashMap)one).get("userPassword").toString();
					if (!oldPassword.equals(pwd))
					{
						/**原密码错误信息*/
						eventExecutor.getBaseAction().getPromptInfo().setResultDescInfo(eventExecutor.getBaseAction().getText("old_password_error"));
						resultData.setIntResult(0);  
						//throw new Exception ("old password error");
					}else{
						/**设置新密码*/
						if (!"".equals(uid))
						{
							int rvalue = eventExecutor.getSqlSession().update(uid, map);
							resultData.setIntResult(rvalue);
						}
						resultData.setIntResult(1);
					}
				}
				return resultData;
			}else{
				eventExecutor.getBaseAction().getPromptInfo().setResultDescInfo(eventExecutor.getBaseAction().getText("not_login"));
				resultData.setIntResult(0); 
				throw new Exception ("user not login");
			}
		}
		catch (Exception e)
		{
			/**执行器执行失败*/
			String error = DetailException.expDetail(e, PasswordModifyEvent.class);
			log.error(error);
			throw e;
		}
	}

}
