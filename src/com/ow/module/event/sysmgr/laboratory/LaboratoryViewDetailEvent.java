package com.ow.module.event.sysmgr.laboratory;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.module.event.sysmgr.ResourceUtil;
import com.unitecount.ResourceCount;

public class LaboratoryViewDetailEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public LaboratoryViewDetailEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			HashMap mapmap = eventExecutor.getBaseAction().getParamMap();
			
			if((String)mapmap.get("temppid") != null && (String)mapmap.get("duyi") != null){
				String lridother = (String)mapmap.get("idother");
				mapmap.put("lrID",lridother);
			}
			
			Object obj = eventExecutor.getSqlSession().selectOne(selectSqlId,mapmap);
		
			String nameother = ((HashMap)obj).get("lrName").toString();
			eventExecutor.getBaseAction().session.put("nameother",nameother);
			
			resultData.setOne(obj);
			/*信息统计开始*/
			if(ConstantI.ISCOUNT_KEY.equals("1")){
			String type=((HashMap)obj).get("lrType") == null ? "":((HashMap)obj).get("lrType").toString();
			ResourceCount.sendMsg(type,"BROWSE");
			}
			/*信息统计结束*/
			//根据查询类型返回面包屑
			//查询类别 1-按功能查询 2-按区域查询 3-按适用学段、年级查询 4-按资源查询
			String st = eventExecutor.getBaseAction().getParamMap().get("st") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("st");
			if("1".equals(st)){
				String lrName = "",lrID = "";
				if (obj != null){
					lrName = ((HashMap)obj).get("lrName") == null ? "":((HashMap)obj).get("lrName").toString();
					lrID = ((HashMap)obj).get("lrID") == null ? "":((HashMap)obj).get("lrID").toString();
				}
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnCategoryPath(eventExecutor, "lrID", lrName, lrID));		
			}else if("2".equals(st)){
				String lrName = "",lrID = "";
				if (obj != null){
					lrName = ((HashMap)obj).get("lrName") == null ? "":((HashMap)obj).get("lrName").toString();
					lrID = ((HashMap)obj).get("lrID") == null ? "":((HashMap)obj).get("lrID").toString();
				}
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnAreaPath(eventExecutor, "lrID", lrName, lrID));
			}else if("3".equals(st)){
				String lrName = "",lrID = "";
				if (obj != null){
					lrName = ((HashMap)obj).get("lrName") == null ? "":((HashMap)obj).get("lrName").toString();
					lrID = ((HashMap)obj).get("lrID") == null ? "":((HashMap)obj).get("lrID").toString();
				}
				String grGrade = eventExecutor.getBaseAction().getParamMap().get("grGrade") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("grGrade") ;
				eventExecutor.getBaseAction().setNavigation("") ;
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnGradePath(grGrade, "lrID", lrName, lrID));
			}else if("4".equals(st)){
				String lrName = "",lrID = "";
				if (obj != null){
					lrName = ((HashMap)obj).get("lrName") == null ? "":((HashMap)obj).get("lrName").toString();
					lrID = ((HashMap)obj).get("lrID") == null ? "":((HashMap)obj).get("lrID").toString();
				}
				String rrType = eventExecutor.getBaseAction().getParamMap().get("rrType") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("rrType") ;
				eventExecutor.getBaseAction().setNavigation("") ;
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnResourcePath(rrType, "lrID", lrName, lrID));
			}
			
			
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, LaboratoryViewDetailEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
