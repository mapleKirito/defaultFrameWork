package com.ow.module.event.sysmgr.projection;

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

public class ProjectionViewDetailEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ProjectionViewDetailEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings("rawtypes")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			HashMap<String,String> map = eventExecutor.getBaseAction().getParamMap();
			
			Object obj = eventExecutor.getSqlSession().selectOne(selectSqlId, map);
			String orNo = ((HashMap)obj).get("prJieProName") == null ? "":((HashMap)obj).get("prJieProName").toString();
			map.put("prJieProName", orNo);
			resultData.setOne(obj);
			/*信息统计开始*/
			if(ConstantI.ISCOUNT_KEY.equals("1")){
			String type=((HashMap)obj).get("prType") == null ? "":((HashMap)obj).get("prType").toString();
			ResourceCount.sendMsg(type,"BROWSE");
			}
			/*信息统计结束*/
			//根据查询类型返回面包屑
			//查询类别 1-按功能查询 2-按区域查询 3-按适用学段、年级查询 4-按资源查询
			String st = eventExecutor.getBaseAction().getParamMap().get("st") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("st");
			if("1".equals(st)){
				String prName = "",prID = "";
				if (obj != null){
					prName = ((HashMap)obj).get("prName") == null ? "":((HashMap)obj).get("prName").toString();
					prID = ((HashMap)obj).get("prID") == null ? "":((HashMap)obj).get("prID").toString();
				}
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnCategoryPath(eventExecutor, "prID", prName, prID));		
			}else if("2".equals(st)){
				String prName = "",prID = "";
				if (obj != null){
					prName = ((HashMap)obj).get("prName") == null ? "":((HashMap)obj).get("prName").toString();
					prID = ((HashMap)obj).get("prID") == null ? "":((HashMap)obj).get("prID").toString();
				}
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnAreaPath(eventExecutor, "prID", prName, prID));
			}else if("3".equals(st)){
				String prName = "",prID = "";
				if (obj != null){
					prName = ((HashMap)obj).get("prName") == null ? "":((HashMap)obj).get("prName").toString();
					prID = ((HashMap)obj).get("prID") == null ? "":((HashMap)obj).get("prID").toString();
				}
				String grGrade = eventExecutor.getBaseAction().getParamMap().get("grGrade") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("grGrade") ;
				eventExecutor.getBaseAction().setNavigation("") ;
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnGradePath(grGrade, "prID", prName, prID));
			}else if("4".equals(st)){
				String prName = "",prID = "";
				if (obj != null){
					prName = ((HashMap)obj).get("prName") == null ? "":((HashMap)obj).get("prName").toString();
					prID = ((HashMap)obj).get("prID") == null ? "":((HashMap)obj).get("prID").toString();
				}
				String rrType = eventExecutor.getBaseAction().getParamMap().get("rrType") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("rrType") ;
				eventExecutor.getBaseAction().setNavigation("") ;
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnResourcePath(rrType, "prID", prName, prID));
			}
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ProjectionViewDetailEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
