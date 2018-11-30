package com.ow.module.event.sysmgr.category;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class CategoryCreateEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	public CategoryCreateEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String insertsid = eventExecutor.getSqlidByIndex(0);
			String updateid = eventExecutor.getSqlidByIndex(1);
			String ischild = eventExecutor.getSqlidByIndex(2);
			String catePath = eventExecutor.getSqlidByIndex(3);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String parentRelation = null; 
			String cateParentID = paramMap.get("cateParentID") == null ? "0":paramMap.get("cateParentID").toString();
			HashMap paramentMap = new HashMap() ;
			paramentMap.put("cateID", cateParentID) ;
			if (!"".equals(insertsid)) {
				if(cateParentID.equals("0")){
					//设置是否有子分类字段
					paramMap.put("cateIsChild", "0");
					paramMap.put("cateLevel", 1);
					paramMap.put("catePath", ",0,");
					int rvalue = eventExecutor.getSqlSession().insert(insertsid,paramMap);
					resultData.setIntResult(1);
				}else {
					//根据父级分类ID查询父级分类orgGrade和orgRelation
					Object category = eventExecutor.getSqlSession().selectOne(catePath,paramentMap);
					if(category instanceof HashMap){
	                    //获取父级分类的catePath					
						parentRelation = ((HashMap)category).get("catePath").toString();
						//获取父级分类的cateLevel
						String parentOrgGrade = ((HashMap)category).get("cateLevel").toString();
						//计算要插入分类的的cateLevel
						if(parentOrgGrade!=null&&!"".equals(parentOrgGrade))
						{
							try{
								int orgGrade = Integer.valueOf(parentOrgGrade);
								paramMap.put("cateLevel", orgGrade+1);
							}catch(Exception e){}
						}
						else {
							paramMap.put("cateLevel",0);
						}
						//设置是否有子分类字段
						paramMap.put("cateIsChild", "0");
						//catePath 默认值
						paramMap.put("catePath", ",0,");
						//执行插入操作
						eventExecutor.getSqlSession().insert(insertsid,paramMap);
					}
					
					//修改父级分类存在子节点
					paramentMap.put("cateIsChild", "1");
					eventExecutor.getSqlSession().update(ischild,paramentMap);
					resultData.setIntResult(1);
				}
				//获取插入的主键7
				String generatedKey = paramMap.get("generatedKey") == null ? "0":paramMap.get("generatedKey").toString();
				int nkey = 0;
				try{
					int k = Integer.parseInt(generatedKey);
					nkey = k + 1;
				}catch(Exception e){}
				//拼接插入的分类的catePath
				if (cateParentID.equals("0")){
					paramMap.put("catePath", ",0,"+generatedKey + ",");
					paramentMap.put("catePath", ",0,"+generatedKey + ",");
				}
				else{
					if(parentRelation!=null&&!"".equals(parentRelation)){
						paramMap.put("catePath", parentRelation + generatedKey + ",");
						paramentMap.put("catePath", parentRelation + generatedKey + ",");
					}
				}
				//修改catePath字段
				paramentMap.put("cateID", generatedKey) ;
				eventExecutor.getSqlSession().update(updateid,paramentMap);
			}
			
			return resultData;
		}
		catch (Exception e)
		{
			/**出现异常设置执行器执行失败*/
			if (e.getMessage() != null && e.getMessage().toLowerCase() != null && (e.getMessage().toLowerCase().indexOf("ora-00001") > -1
				|| e.getMessage().toLowerCase().indexOf("duplicate") > -1
				|| e.getMessage().toLowerCase().indexOf("unique key") > -1 
				|| e.getMessage().toLowerCase().indexOf("unique constraint") > -1)){
				resultData.setIntResult(2);
			}
			else{
				resultData.setIntResult(0);
			}
			String error = DetailException.expDetail(e, CategoryCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
