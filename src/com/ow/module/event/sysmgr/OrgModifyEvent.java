package com.ow.module.event.sysmgr;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.type.IntegerTypeHandler;
import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.UpdateEvent;

public class OrgModifyEvent implements EventListener {
 
	static Logger log = Logger.getLogger(Constant.FRAMEWORK); 
	private ResultData resultData;
	
	public OrgModifyEvent(){
		resultData = new ResultData();
	}
	
	/**
	 * 修改当前机构子机构的relation字段以及orgGrade字段
	   修改新父级机构的isChild字段(设置为1)，并修改当前机构的relation字段以及orgGrade字段
	   修改原来父级机构的isChild字段
	 */
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		//修改原来父级机构的isChild字段(根据父级机构的relation进行模糊查询，统计父级机构的子机构数目)
		try
		{ 
			String newRelation = null;
			String[] sid = eventExecutor.getSqlidArr();
		    HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
//		    String orgLevel = paramMap.get("orgGrade") == null ? "1":paramMap.get("orgGrade").toString();
//			int clevel = 1;
//			try{
//				clevel = Integer.parseInt(orgLevel) + 1;
//			}
//			catch(Exception e){}
//			paramMap.put("orgGrade", clevel);
		    //第一步：修改修改当前机构子机构的relation字段以及orgGrade字段
		    Object orgnization = eventExecutor.getSqlSession().selectOne(sid[1],paramMap);
		    if(orgnization!=null){
			    if(orgnization instanceof HashMap){
			    	if(((HashMap)orgnization).get("orgParentID").toString()!=null&&!"".equals(((HashMap)orgnization).get("orgParentID").toString()))
			    	{
				    	//拼接新的org_relation信息
				    	String parentRelation = ((HashMap)orgnization).get("orgRelation")==null?"":((HashMap)orgnization).get("orgRelation").toString();
				        newRelation = parentRelation.concat(paramMap.get("orglID").toString()).concat(",");
				    	paramMap.put("orgRelation", newRelation);
				    	//获取新父级机构的orgGrade
				    	String parentOrgGrade = ((HashMap)orgnization).get("orgGrade")==null?"1":((HashMap)orgnization).get("orgGrade").toString();
				    	Integer orgGrade = null;
				    	if(parentOrgGrade!=null&&!"".equals(parentOrgGrade)){
				    		orgGrade = Integer.valueOf(parentOrgGrade)+1;
				    	}
				    	paramMap.put("orgGrade", orgGrade);
				    	//更新当前机构的所有信息
					    eventExecutor.getSqlSession().update(sid[0],paramMap);
					    //查询当前机构的所有子机构,并且更新所有子机构的org_relation,orgGrade
					    updateChildOrgnization(eventExecutor, sid, newRelation,orgGrade, paramMap);
					    /**
					    ArrayList list = (ArrayList)eventExecutor.getSqlSession().selectList(sid[2], paramMap);
				    	for(int i=0;i<list.size();i++){
				    		paramMap.put("orgID", ((HashMap)list.get(i)).get("orgID").toString());
					    	String childRelation = newRelation+((HashMap)list.get(i)).get("orgID").toString()+",";
					    	paramMap.remove("orgRelation");
					    	paramMap.put("orgRelation",childRelation);
					    	eventExecutor.getSqlSession().update(sid[3],paramMap);
				    	}
				    	*/
			    	}
			    	String ischild = eventExecutor.getSqlidByIndex(4);
					//修改新父级机构存在子节点
			    	if("1".equals(((HashMap) orgnization).get("orgIsChild"))){}
			    	else{
			    		paramMap.put("orgIsChild", "1");
			    		eventExecutor.getSqlSession().update(ischild,paramMap);
			    	}
			    	//修改原来父级机构的isChild字段(根据父级机构的relation进行模糊查询，统计父级机构的子机构数目)
			    	paramMap.put("orgParentID",paramMap.get("oldOrgParentID"));
			    	Integer num = (Integer)eventExecutor.getSqlSession().selectOne(eventExecutor.getSqlidByIndex(5), paramMap);
			    	if(num==1){
			    		paramMap.put("orgIsChild", "0");
			    		eventExecutor.getSqlSession().update(ischild,paramMap);
			    	}
			    }
		    }
		    //说明当前机构为顶级机构，直接更新相关信息
		    else {
		    	//更新当前机构的所有信息
			    eventExecutor.getSqlSession().update(sid[0],paramMap);
		    }
		   
		   resultData.setIntResult(1);
		   return resultData;
		}
		catch(Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, UpdateEvent.class);
			log.error(error);
			throw e;
		}
	}
	
	
	//更新当前机构子机构的OrgRelation和OrgGrade字段
	public void updateChildOrgnization(EventExecutor eventExecutor,String[] sid,String relation,Integer orgGrade,HashMap paramMap){
		ArrayList list = (ArrayList)eventExecutor.getSqlSession().selectList(sid[2], paramMap);
    	for(int i=0;i<list.size();i++){
    		paramMap.put("orgID", ((HashMap)list.get(i)).get("orgID").toString());
    		Integer childOrgGrade = null;
    		if(orgGrade!=null){
    			 childOrgGrade = orgGrade+1;
    		}
    		paramMap.put("orgGrade", childOrgGrade==null?1:childOrgGrade);
	    	String childRelation = relation+((HashMap)list.get(i)).get("orgID").toString()+",";
	    	paramMap.remove("orgRelation");
	    	paramMap.put("orgRelation",childRelation);
	    	eventExecutor.getSqlSession().update(sid[3],paramMap);
	    	paramMap.put("orglID",((HashMap)list.get(i)).get("orgID").toString());
	    	//递归查询相应的下级机构
	    	ArrayList childList = (ArrayList)eventExecutor.getSqlSession().selectList(sid[2],paramMap);
	    	for(int j=0;j<childList.size();j++){
	    		updateChildOrgnization(eventExecutor, sid, childRelation,childOrgGrade, paramMap);
	    	}
    	}

		
	}
}
