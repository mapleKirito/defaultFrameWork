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
import com.ow.framework.util.Encrypt;
import com.unitecount.RegisterCount;




public class UserRegisterEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private SmartWebServer dog = null;
	public UserRegisterEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap hashMap = eventExecutor.getBaseAction().getParamMap();
			String password = hashMap.get("password").toString();
			password = GODEvent.getInstance(dog, password);
			/*if (password != null && !"".equals(password))
				password = Encrypt.getMD5(password.trim());*/
			hashMap.put("password", password);
			
			String sid = eventExecutor.getSqlidByIndex(0);
			String sidRole = eventExecutor.getSqlidByIndex(1);
			String sidRoleInsert = eventExecutor.getSqlidByIndex(2);
			String sidUserRoleInsert = eventExecutor.getSqlidByIndex(3);
			String sidRoleAuthInsert = eventExecutor.getSqlidByIndex(4);
			String sidUserOrgInsert = eventExecutor.getSqlidByIndex(5);
			if (!"".equals(sid))
			{
				
				//插入用户数据
				int rvalue = eventExecutor.getSqlSession().insert(sid, hashMap);
				hashMap.put("userID", eventExecutor.getBaseAction().getParamMap().get("generatedKey"));
				hashMap.put("userImg", "images/default/default_student.jpg");
				int r = eventExecutor.getSqlSession().insert("user_info.isnert_info", hashMap);
				//设置用户角色绑定关系
				//根据名称判断角色是否存在
				//HashMap roleMap = Constant.ROLE_MAP;
				String roleName = Constant.ROLE_MAP.get("roleName") == null?"":Constant.ROLE_MAP.get("roleName").toString();
				String roleDesc = Constant.ROLE_MAP.get("roleDesc") == null?"":Constant.ROLE_MAP.get("roleDesc").toString();
				hashMap.put("roleName", roleName);
				hashMap.put("roleDesc", roleDesc);
				hashMap.put("roleStatus", "1");
				hashMap.put("roleIndex","One");
				Object one = eventExecutor.getSqlSession().selectOne(sidRole,hashMap);
				if (one == null){
					//插入新角色
					hashMap.put("roleCreator", "system");
					eventExecutor.getSqlSession().insert(sidRoleInsert,hashMap);
					//插入用户角色关系信息
					eventExecutor.getSqlSession().insert(sidUserRoleInsert,hashMap);
					//读取默认角色对应的权限代码
					String acode = Constant.ROLE_MAP.get("roleAuth") == null?"":Constant.ROLE_MAP.get("roleAuth").toString();
					String acodeArr [] = acode.split(",");
					for (int i=0; i<acodeArr.length; i++){
						if (acodeArr[i] != null && !acodeArr[i].equals("")){
							hashMap.put("acode", acodeArr[i]);
							System.out.println(acodeArr[i]);
							//插入角色权限关系
							eventExecutor.getSqlSession().insert(sidRoleAuthInsert,hashMap);	
						}
					}
				}
				else{
					String roleID = null;
					if (one instanceof HashMap){
						roleID = ((HashMap)one).get("roleID") == null ? "":((HashMap)one).get("roleID").toString();
						if (!roleID.equals("")){
							hashMap.put("roleID", roleID);
							//插入用户角色关系信息
							
							eventExecutor.getSqlSession().insert(sidUserRoleInsert,hashMap);
						}
					}
				}
				//插入用户机构关系
				eventExecutor.getSqlSession().insert(sidUserOrgInsert,hashMap);	
				resultData.setIntResult(1);
			}		
			//统计信息
			RegisterCount.sendMsg("STUDENT");
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, UserRegisterEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
