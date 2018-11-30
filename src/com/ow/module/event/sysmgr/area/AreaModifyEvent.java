package com.ow.module.event.sysmgr.area;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class AreaModifyEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK); 
	private ResultData resultData;
	
	public AreaModifyEvent(){
		resultData = new ResultData();
	}
	
	/**
	 * 修改当前地区子地区的areaPath字段以及areaLevel字段
	   修改新父级地区的areaIsChild字段(设置为1)，并修改当前地区的areaPath字段以及areaLevel字段
	   修改原来父级地区的areaIsChild字段
	 */
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		//修改原来父级地区的areaIsChild字段(根据父级地区的areaPath进行模糊查询，统计父级地区的子地区数目)
		try { 
			String newRelation = null;
			String[] sid = eventExecutor.getSqlidArr();
		    HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
		    //第一步：修改修改当前地区子地区的areaPath字段以及areaLevel字段
		    Object area = eventExecutor.getSqlSession().selectOne(sid[1],paramMap);
		    if(area!=null){
			    if(area instanceof HashMap){
			    	if(((HashMap)area).get("areaParentID").toString()!=null&&!"".equals(((HashMap)area).get("areaParentID").toString()))
			    	{
				    	//拼接新的areaPath信息
				    	String parentRelation = ((HashMap)area).get("areaPath")==null?"":((HashMap)area).get("areaPath").toString();
				        newRelation = parentRelation.concat(paramMap.get("areaID").toString()).concat(",");
				    	paramMap.put("areaPath", newRelation);
				    	//获取新父级地区的areaLevel
				    	String parentOrgGrade = ((HashMap)area).get("areaLevel")==null?"1":((HashMap)area).get("areaLevel").toString();
				    	Integer areaLevel = null;
				    	if(parentOrgGrade!=null&&!"".equals(parentOrgGrade)){
				    		areaLevel = Integer.valueOf(parentOrgGrade)+1;
				    	}
				    	paramMap.put("areaLevel", areaLevel);
				    	//更新当前地区的所有信息
					    eventExecutor.getSqlSession().update(sid[0],paramMap);
					    //查询当前地区的所有子地区,并且更新所有子地区的org_relation,orgGrade
					    updateChildCategory(eventExecutor, sid, newRelation,areaLevel, paramMap);
			    	}
			    	String ischild = eventExecutor.getSqlidByIndex(4);
					//修改新父级地区存在子节点
			    	if("1".equals(((HashMap) area).get("areaIsChild"))){}
			    	else{
			    		HashMap paramerMap = new HashMap() ;
			    		paramerMap.put("areaID", ((HashMap)area).get("areaID")) ;
			    		paramerMap.put("areaIsChild", "1");
			    		eventExecutor.getSqlSession().update(ischild,paramerMap);
			    	}
			    	//修改原来父级地区的isChild字段(根据父级地区的relation进行模糊查询，统计父级地区的子地区数目)
			    	HashMap paramerMap = new HashMap() ;
			    	paramerMap.put("areaPath",paramMap.get("oldCateParentID"));
			    	Integer num = (Integer)eventExecutor.getSqlSession().selectOne(eventExecutor.getSqlidByIndex(5), paramerMap);
			    	if(num==1){
			    		paramMap.put("areaIsChild", "0");
			    		eventExecutor.getSqlSession().update(ischild,paramMap);
			    	}
			    }
		    }
		    //说明当前地区为顶级地区，直接更新相关信息
		    else {
		    	//更新当前地区的所有信息
			    eventExecutor.getSqlSession().update(sid[0],paramMap);
		    }
		   
		   resultData.setIntResult(1);
		   return resultData;
		}
		catch(Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, AreaModifyEvent.class);
			log.error(error);
			throw e;
		}
	}
	
	
	//更新当前地区子地区的areaPath和areaLevel字段
	public void updateChildCategory(EventExecutor eventExecutor,String[] sid,String relation,Integer areaLevel,HashMap paramMap){
		ArrayList list = (ArrayList)eventExecutor.getSqlSession().selectList(sid[2], paramMap);
    	for(int i=0;i<list.size();i++){
    		paramMap.put("areaID", ((HashMap)list.get(i)).get("areaID").toString());
    		Integer childCateLevel = null;
    		if(areaLevel!=null){
    			childCateLevel = areaLevel+1;
    		}
    		paramMap.put("areaLevel", childCateLevel==null?1:childCateLevel);
	    	String childRelation = relation+((HashMap)list.get(i)).get("areaID").toString()+",";
	    	paramMap.remove("areaPath");
	    	paramMap.put("areaPath",childRelation);
	    	eventExecutor.getSqlSession().update(sid[3],paramMap);
	    	paramMap.put("areaID",((HashMap)list.get(i)).get("areaID").toString());
	    	//递归查询相应的下级地区
	    	ArrayList childList = (ArrayList)eventExecutor.getSqlSession().selectList(sid[2],paramMap);
	    	for(int j=0;j<childList.size();j++){
	    		updateChildCategory(eventExecutor, sid, childRelation,childCateLevel, paramMap);
	    	}
    	}

		
	}

}
