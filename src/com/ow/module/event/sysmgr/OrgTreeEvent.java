package com.ow.module.event.sysmgr;

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




public class OrgTreeEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public OrgTreeEvent()
	{
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			String sid2 = eventExecutor.getSqlidByIndex(1);
			String sid3 = eventExecutor.getSqlidByIndex(2);
			String json = null;
			HashMap mapmap = (HashMap)eventExecutor.getBaseAction().getParamMap();
			List dis = (List)eventExecutor.getSqlSession().selectList("org.select_only_me_org", mapmap);
			if (!"".equals(sid) && !"".equals(sid2))
			{
				String utype = mapmap.get(Constant.S_USER_TYPE) == null?"0":mapmap.get(Constant.S_USER_TYPE).toString();
				List orgList = null;
//				if (utype.equals("0")){
					orgList = eventExecutor.getSqlSession().selectList(sid, mapmap);
//				}
//				else{
//					orgList = eventExecutor.getSqlSession().selectList(sid2, mapmap);
//				}
				List disOrgList = eventExecutor.getSqlSession().selectList(sid3, mapmap);
				try {
					List<Object> list = new ArrayList<Object>();
					if (orgList != null && orgList.size() > 0){
						if (disOrgList != null){
							for (int i=0; i<orgList.size();i++) {
								if (orgList.get(i) instanceof HashMap){
									Map<String, Object> maprole = new Hashtable<String, Object>();
									//树形参数
									String orgId = ((HashMap)orgList.get(i)).get("orgID") == null?"0":((HashMap)orgList.get(i)).get("orgID").toString();
									String orgParentID = ((HashMap)orgList.get(i)).get("orgParentID") == null?"0":((HashMap)orgList.get(i)).get("orgParentID").toString();
									String orgName = ((HashMap)orgList.get(i)).get("orgName") == null?"":((HashMap)orgList.get(i)).get("orgName").toString();
									maprole.put("id", Integer.parseInt(orgId));
									maprole.put("pId",Integer.parseInt(orgParentID));
									maprole.put("name", orgName);
									if (disOrgList != null){
										//如果存在登录用户具有的权限信息和已经授权角色的权限信息一致
										//设置此权限为选中状态
										for (int j=0;j<disOrgList.size();j++){
											if (disOrgList.get(j) instanceof HashMap){
												String mm = (String)mapmap.get("typezuotype");
												if(mm==null || !mm.equals("modifyisrole")){
													String orgIdTemp = ((HashMap)disOrgList.get(j)).get("orgID") == null?"":((HashMap)disOrgList.get(j)).get("orgID").toString();
													if (orgId != null && orgId.equals(orgIdTemp)){
														//设置为选中
														maprole.put("checked", true);
														break;
													}
												}else{
													if(dis!=null){
														String disorg ="";
														for (int h=0; h<dis.size();h++) {
															disorg = ((HashMap)dis.get(h)).get("orgID") == null?"0":((HashMap)dis.get(h)).get("orgID").toString();
															if (orgId != null && orgId.equals(disorg)){
																maprole.put("checked", true);
															}														
														}
													}
													
													
												}
											}
										}
									}
									list.add(maprole);
								}							
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
			String error = DetailException.expDetail(e, OrgTreeEvent.class);
			log.error(error);
			throw e;
		}
	}
}
