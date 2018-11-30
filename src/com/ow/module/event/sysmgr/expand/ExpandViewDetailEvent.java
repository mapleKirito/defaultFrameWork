package com.ow.module.event.sysmgr.expand;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.module.event.sysmgr.ResourceUtil;

public class ExpandViewDetailEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ExpandViewDetailEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			Object obj = eventExecutor.getSqlSession().selectOne(selectSqlId, eventExecutor.getBaseAction().getParamMap());
			resultData.setOne(obj);
						
			String nameother = ((HashMap)obj).get("erName").toString();
			eventExecutor.getBaseAction().session.put("nameother",nameother);
			
			
			//根据查询类型返回面包屑
			//查询类别 1-按功能查询 2-按区域查询 3-按适用学段、年级查询 4-按资源查询
			String st = eventExecutor.getBaseAction().getParamMap().get("st") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("st");
			if("1".equals(st)){
				String erName = "",erID = "";
				if (obj != null){
					erName = ((HashMap)obj).get("erName") == null ? "":((HashMap)obj).get("erName").toString();
					erID = ((HashMap)obj).get("erID") == null ? "":((HashMap)obj).get("erID").toString();
				}
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnCategoryPath(eventExecutor, "erID", erName, erID));		
			}else if("2".equals(st)){
				String erName = "",erID = "";
				if (obj != null){
					erName = ((HashMap)obj).get("erName") == null ? "":((HashMap)obj).get("erName").toString();
					erID = ((HashMap)obj).get("erID") == null ? "":((HashMap)obj).get("erID").toString();
				}
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnAreaPath(eventExecutor, "erID", erName, erID));
			}else if("3".equals(st)){
				String erName = "",erID = "";
				if (obj != null){
					erName = ((HashMap)obj).get("erName") == null ? "":((HashMap)obj).get("erName").toString();
					erID = ((HashMap)obj).get("erID") == null ? "":((HashMap)obj).get("erID").toString();
				}
				String grGrade = eventExecutor.getBaseAction().getParamMap().get("grGrade") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("grGrade") ;
				eventExecutor.getBaseAction().setNavigation("") ;
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnGradePath(grGrade, "erID", erName, erID));
			}else if("4".equals(st)){
				String erName = "",erID = "";
				if (obj != null){
					erName = ((HashMap)obj).get("erName") == null ? "":((HashMap)obj).get("erName").toString();
					erID = ((HashMap)obj).get("erID") == null ? "":((HashMap)obj).get("erID").toString();
				}
				String rrType = eventExecutor.getBaseAction().getParamMap().get("rrType") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("rrType") ;
				eventExecutor.getBaseAction().setNavigation("") ;
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnResourcePath(rrType, "erID", erName, erID));
			}
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExpandViewDetailEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
