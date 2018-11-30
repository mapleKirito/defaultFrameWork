package com.ow.module.event.sysmgr.lovely;

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

public class LovelyViewDetailEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public LovelyViewDetailEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			HashMap map = eventExecutor.getBaseAction().getParamMap();
		
			System.out.println(map.toString());
			Object obj = eventExecutor.getSqlSession().selectOne(selectSqlId, eventExecutor.getBaseAction().getParamMap());
			resultData.setOne(obj);
			String nameother = ((HashMap)obj).get("crName").toString();
			eventExecutor.getBaseAction().session.put("nameother",nameother);
			/*信息统计开始*/
			if(ConstantI.ISCOUNT_KEY.equals("1")){
			String type=((HashMap)obj).get("crType") == null ? "":((HashMap)obj).get("crType").toString();
			ResourceCount.sendMsg(type,"BROWSE");
			}
			/*信息统计结束*/
			//根据查询类型返回面包屑
			//查询类别 1-按功能查询 2-按区域查询 3-按适用学段、年级查询 4-按资源查询
			String st = eventExecutor.getBaseAction().getParamMap().get("st") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("st");
			if("1".equals(st)){
				String crName = "",crID = "";
				if (obj != null){
					crName = ((HashMap)obj).get("crName") == null ? "":((HashMap)obj).get("crName").toString();
					crID = ((HashMap)obj).get("crID") == null ? "":((HashMap)obj).get("crID").toString();
				}
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnCategoryPath(eventExecutor, "crID", crName, crID));		
			}else if("2".equals(st)){
				String crName = "",crID = "";
				if (obj != null){
					crName = ((HashMap)obj).get("crName") == null ? "":((HashMap)obj).get("crName").toString();
					crID = ((HashMap)obj).get("crID") == null ? "":((HashMap)obj).get("crID").toString();
				}
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnAreaPath(eventExecutor, "crID", crName, crID));
			}else if("3".equals(st)){
				String crName = "",crID = "";
				if (obj != null){
					crName = ((HashMap)obj).get("crName") == null ? "":((HashMap)obj).get("crName").toString();
					crID = ((HashMap)obj).get("crID") == null ? "":((HashMap)obj).get("crID").toString();
				}
				String grGrade = eventExecutor.getBaseAction().getParamMap().get("grGrade") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("grGrade") ;
				eventExecutor.getBaseAction().setNavigation("") ;
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnGradePath(grGrade, "crID", crName, crID));
			}else if("4".equals(st)){
				String crName = "",crID = "";
				if (obj != null){
					crName = ((HashMap)obj).get("crName") == null ? "":((HashMap)obj).get("crName").toString();
					crID = ((HashMap)obj).get("crID") == null ? "":((HashMap)obj).get("crID").toString();
				}
				String rrType = eventExecutor.getBaseAction().getParamMap().get("rrType") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("rrType") ;
				eventExecutor.getBaseAction().setNavigation("") ;
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnResourcePath(rrType, "crID", crName, crID));
			}
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, LovelyViewDetailEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
