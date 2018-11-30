package com.ow.module.event.sysmgr.category;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.UpdateEvent;

public class CategoryModifyEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK); 
	private ResultData resultData;
	
	public CategoryModifyEvent(){
		resultData = new ResultData();
	}
	
	/**
	 * 修改当前分类子分类的catePath字段以及cateLevel字段
	   修改新父级分类的cateIsChild字段(设置为1)，并修改当前分类的catePath字段以及cateLevel字段
	   修改原来父级分类的cateIsChild字段
	 */
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		//修改原来父级分类的cateIsChild字段(根据父级分类的catePath进行模糊查询，统计父级分类的子分类数目)
		try { 
			String newRelation = null;
			String[] sid = eventExecutor.getSqlidArr();
		    HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
		    //第一步：修改修改当前分类子分类的catePath字段以及cateLevel字段
		    Object category = eventExecutor.getSqlSession().selectOne(sid[1],paramMap);
		    if(category!=null){
			    if(category instanceof HashMap){
			    	if(((HashMap)category).get("cateParentID").toString()!=null&&!"".equals(((HashMap)category).get("cateParentID").toString()))
			    	{
				    	//拼接新的catePath信息
				    	String parentRelation = ((HashMap)category).get("catePath")==null?"":((HashMap)category).get("catePath").toString();
				        newRelation = parentRelation.concat(paramMap.get("cateID").toString()).concat(",");
				    	paramMap.put("catePath", newRelation);
				    	//获取新父级分类的cateLevel
				    	String parentOrgGrade = ((HashMap)category).get("cateLevel")==null?"1":((HashMap)category).get("cateLevel").toString();
				    	Integer cateLevel = null;
				    	if(parentOrgGrade!=null&&!"".equals(parentOrgGrade)){
				    		cateLevel = Integer.valueOf(parentOrgGrade)+1;
				    	}
				    	paramMap.put("cateLevel", cateLevel);
				    	//更新当前分类的所有信息
					    eventExecutor.getSqlSession().update(sid[0],paramMap);
					    //查询当前分类的所有子分类,并且更新所有子分类的org_relation,orgGrade
					    updateChildCategory(eventExecutor, sid, newRelation,cateLevel, paramMap);
			    	}
			    	String ischild = eventExecutor.getSqlidByIndex(4);
					//修改新父级分类存在子节点
			    	if("1".equals(((HashMap) category).get("cateIsChild"))){}
			    	else{
			    		HashMap paramerMap = new HashMap() ;
			    		paramerMap.put("cateID", ((HashMap)category).get("cateID")) ;
			    		paramerMap.put("cateIsChild", "1");
			    		eventExecutor.getSqlSession().update(ischild,paramerMap);
			    	}
			    	//修改原来父级分类的isChild字段(根据父级分类的relation进行模糊查询，统计父级分类的子分类数目)
			    	HashMap paramerMap = new HashMap() ;
			    	paramerMap.put("catePath",paramMap.get("oldCateParentID"));
			    	Integer num = (Integer)eventExecutor.getSqlSession().selectOne(eventExecutor.getSqlidByIndex(5), paramerMap);
			    	if(num==1){
			    		paramMap.put("cateIsChild", "0");
			    		eventExecutor.getSqlSession().update(ischild,paramMap);
			    	}
			    }
		    }
		    //说明当前分类为顶级分类，直接更新相关信息
		    else {
		    	//更新当前分类的所有信息
			    eventExecutor.getSqlSession().update(sid[0],paramMap);
		    }
		   
		   resultData.setIntResult(1);
		   return resultData;
		}
		catch(Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, CategoryModifyEvent.class);
			log.error(error);
			throw e;
		}
	}
	
	
	//更新当前分类子分类的catePath和cateLevel字段
	public void updateChildCategory(EventExecutor eventExecutor,String[] sid,String relation,Integer cateLevel,HashMap paramMap){
		ArrayList list = (ArrayList)eventExecutor.getSqlSession().selectList(sid[2], paramMap);
    	for(int i=0;i<list.size();i++){
    		paramMap.put("cateID", ((HashMap)list.get(i)).get("cateID").toString());
    		Integer childCateLevel = null;
    		if(cateLevel!=null){
    			childCateLevel = cateLevel+1;
    		}
    		paramMap.put("cateLevel", childCateLevel==null?1:childCateLevel);
	    	String childRelation = relation+((HashMap)list.get(i)).get("cateID").toString()+",";
	    	paramMap.remove("catePath");
	    	paramMap.put("catePath",childRelation);
	    	eventExecutor.getSqlSession().update(sid[3],paramMap);
	    	paramMap.put("cateID",((HashMap)list.get(i)).get("cateID").toString());
	    	//递归查询相应的下级分类
	    	ArrayList childList = (ArrayList)eventExecutor.getSqlSession().selectList(sid[2],paramMap);
	    	for(int j=0;j<childList.size();j++){
	    		updateChildCategory(eventExecutor, sid, childRelation,childCateLevel, paramMap);
	    	}
    	}

		
	}
}
