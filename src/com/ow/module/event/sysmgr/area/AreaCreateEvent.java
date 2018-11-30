package com.ow.module.event.sysmgr.area;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class AreaCreateEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	public AreaCreateEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String insertsid = eventExecutor.getSqlidByIndex(0);
			String updateid = eventExecutor.getSqlidByIndex(1);
			String ischild = eventExecutor.getSqlidByIndex(2);
			String areaPath = eventExecutor.getSqlidByIndex(3);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String parentRelation = null; 
			String areaParentID = paramMap.get("areaParentID") == null ? "0":paramMap.get("areaParentID").toString();
			HashMap paramentMap = new HashMap() ;
			paramentMap.put("areaID", areaParentID) ;
			if (!"".equals(insertsid)) {
				if(areaParentID.equals("0")){
					//设置是否有子地区字段
					paramMap.put("areaIsChild", "0");
					paramMap.put("areaLevel", 1);
					paramMap.put("areaPath", ",0,");
					int rvalue = eventExecutor.getSqlSession().insert(insertsid,paramMap);
					resultData.setIntResult(1);
				}else {
					//根据父级地区ID查询父级地区orgGrade和orgRelation
					Object area = eventExecutor.getSqlSession().selectOne(areaPath,paramentMap);
					if(area instanceof HashMap){
	                    //获取父级地区的areaPath					
						parentRelation = ((HashMap)area).get("areaPath").toString();
						//获取父级地区的areaLevel
						String parentOrgGrade = ((HashMap)area).get("areaLevel").toString();
						//计算要插入地区的的areaLevel
						if(parentOrgGrade!=null&&!"".equals(parentOrgGrade))
						{
							try{
								int orgGrade = Integer.valueOf(parentOrgGrade);
								paramMap.put("areaLevel", orgGrade+1);
							}catch(Exception e){}
						}
						else {
							paramMap.put("areaLevel",0);
						}
						//设置是否有子地区字段
						paramMap.put("areaIsChild", "0");
						//areaPath 默认值
						paramMap.put("areaPath", ",0,");
						//执行插入操作
						eventExecutor.getSqlSession().insert(insertsid,paramMap);
					}
					
					//修改父级地区存在子节点
					paramentMap.put("areaIsChild", "1");
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
				//拼接插入的地区的areaPath
				if (areaParentID.equals("0")){
					paramMap.put("areaPath", ",0,"+generatedKey + ",");
					paramentMap.put("areaPath", ",0,"+generatedKey + ",");
				}
				else{
					if(parentRelation!=null&&!"".equals(parentRelation)){
						paramMap.put("areaPath", parentRelation + generatedKey + ",");
						paramentMap.put("areaPath", parentRelation + generatedKey + ",");
					}
				}
				//修改areaPath字段
				paramentMap.put("areaID", generatedKey) ;
				eventExecutor.getSqlSession().update(updateid,paramentMap);
			}
			
			return resultData;
		}
		catch (Exception e)
		{
			/**出现异常设置执行器执行失败*/
			if (e.getMessage() != null && e.getMessage().toLowerCase() != null && (e.getMessage().toLowerCase().indexOf("ora-00001") > -1
				|| e.getMessage().toLowerCase().indexOf("dupliarea") > -1
				|| e.getMessage().toLowerCase().indexOf("unique key") > -1 
				|| e.getMessage().toLowerCase().indexOf("unique constraint") > -1)){
				resultData.setIntResult(2);
			}
			else{
				resultData.setIntResult(0);
			}
			String error = DetailException.expDetail(e, AreaCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}
}