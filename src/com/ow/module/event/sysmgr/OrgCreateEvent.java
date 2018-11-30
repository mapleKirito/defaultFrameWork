package com.ow.module.event.sysmgr;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class OrgCreateEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public OrgCreateEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String insertsid = eventExecutor.getSqlidByIndex(0);
			String updateid = eventExecutor.getSqlidByIndex(1);
			String ischild = eventExecutor.getSqlidByIndex(2);
			String sidorg = eventExecutor.getSqlidByIndex(3);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String parentRelation = null;
			String orgParentID = paramMap.get("orgParentID") == null ? "0":paramMap.get("orgParentID").toString();
			if (!"".equals(insertsid))
			{
				//根据父级机构ID查询父级机构orgGrade和orgRelation
				Object orgnization = eventExecutor.getSqlSession().selectOne(sidorg,paramMap);
				if(orgnization instanceof HashMap){
                    //获取父级机构的orgrelation					
					parentRelation = ((HashMap)orgnization).get("orgRelation").toString();
					//获取父级机构的orgGrade
					String parentOrgGrade = ((HashMap)orgnization).get("orgLevel").toString();
					//计算要插入机构的的orgGrade
					if(parentOrgGrade!=null&&!"".equals(parentOrgGrade))
					{
						try{
							int orgLevel = Integer.valueOf(parentOrgGrade);
							paramMap.put("orgLevel", orgLevel+1);
						}catch(Exception e){}
					}
					else {
						paramMap.put("orgLevel",0);
					}
					//设置是否有子机构字段
					paramMap.put("orgIsChild", "0");
					//执行插入操作
					eventExecutor.getSqlSession().insert(insertsid,paramMap);
				}
					
					//获取插入的主键7
					String generatedKey = paramMap.get("generatedKey") == null ? "0":paramMap.get("generatedKey").toString();
					int nkey = 0;
					try{
						int k = Integer.parseInt(generatedKey);
						nkey = k;
					}catch(Exception e){}
					//拼接插入的机构的orgRelation
					if (orgParentID.equals("0")){
						paramMap.put("orgRelation", ",0,"+String.valueOf(nkey) + ",");
					}
					else{
						if(parentRelation!=null&&!"".equals(parentRelation)){
							paramMap.put("orgRelation", parentRelation + String.valueOf(nkey)+",");
						}
					}
					//修改orgRelation字段
					eventExecutor.getSqlSession().update(updateid,paramMap);
					paramMap.put("orgIsChild", "1");
					//修改父级机构存在子节点
					eventExecutor.getSqlSession().update(ischild,paramMap);
					resultData.setIntResult(1);
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
			String error = DetailException.expDetail(e, OrgCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
