package com.ow.module.event.sysmgr.observation;

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

public class ObservationViewDetailEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ObservationViewDetailEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			
			Object obj = eventExecutor.getSqlSession().selectOne(selectSqlId,map );

			resultData.setOne(obj);
			String orNo = ((HashMap)obj).get("orNO") == null ? "":((HashMap)obj).get("orNO").toString();
			map.put("orNO", orNo);
			/*信息统计开始*/
			if(ConstantI.ISCOUNT_KEY.equals("1")){
			String type=((HashMap)obj).get("orType") == null ? "":((HashMap)obj).get("orType").toString();
			ResourceCount.sendMsg(type,"BROWSE");
			}
			/*信息统计结束*/
			//根据查询类型返回面包屑
			//查询类别 1-按功能查询 2-按区域查询 3-按适用学段、年级查询 4-按资源查询
			String st = eventExecutor.getBaseAction().getParamMap().get("st") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("st");
			if("1".equals(st)){
				String orName = "",orID = "";
				if (obj != null){
					orName = ((HashMap)obj).get("orName") == null ? "":((HashMap)obj).get("orName").toString();
					orID = ((HashMap)obj).get("orID") == null ? "":((HashMap)obj).get("orID").toString();
					
				}
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnCategoryPath(eventExecutor, "orID", orName, orID));		
			}else if("2".equals(st)){
				String orName = "",orID = "";
				if (obj != null){
					orName = ((HashMap)obj).get("orName") == null ? "":((HashMap)obj).get("orName").toString();
					orID = ((HashMap)obj).get("orID") == null ? "":((HashMap)obj).get("orID").toString();
				}
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnAreaPath(eventExecutor, "orID", orName, orID));
			}else if("3".equals(st)){
				String orName = "",orID = "";
				if (obj != null){
					orName = ((HashMap)obj).get("orName") == null ? "":((HashMap)obj).get("orName").toString();
					orID = ((HashMap)obj).get("orID") == null ? "":((HashMap)obj).get("orID").toString();
				}
				String grGrade = eventExecutor.getBaseAction().getParamMap().get("grGrade") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("grGrade") ;
				eventExecutor.getBaseAction().setNavigation("") ;
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnGradePath(grGrade, "orID", orName, orID));
			}else if("4".equals(st)){
				String orName = "",orID = "";
				if (obj != null){
					orName = ((HashMap)obj).get("orName") == null ? "":((HashMap)obj).get("orName").toString();
					orID = ((HashMap)obj).get("orID") == null ? "":((HashMap)obj).get("orID").toString();
				}
				String rrType = eventExecutor.getBaseAction().getParamMap().get("rrType") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("rrType") ;
				eventExecutor.getBaseAction().setNavigation("") ;
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnResourcePath(rrType, "orID", orName, orID));
			}
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ObservationViewDetailEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
