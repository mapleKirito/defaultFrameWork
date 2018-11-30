package com.ow.module.event.sysmgr.grade;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class GradeResSelectEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public GradeResSelectEvent()
	{
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			if (sid != null && !sid.equals("")) {
				HashMap<String, String> para = new HashMap<String, String>() ;
				String grResourceType = paramMap.get("grResourceType") == null ? "0" : (String)paramMap.get("grResourceType") ;
				String grResourceID = "" ;
				if("exhibition".equals(grResourceType)) {
					grResourceID = paramMap.get("erID") == null ? "" : (String)paramMap.get("erID") ;
				}else if("observation".equals(grResourceType)) {
					grResourceID = paramMap.get("orID") == null ? "" : (String)paramMap.get("orID") ;
				}else if("laboratory".equals(grResourceType)) {
					grResourceID = paramMap.get("lrID") == null ? "" : (String)paramMap.get("lrID") ;
				}else if("projection".equals(grResourceType)) {
					grResourceID = paramMap.get("prID") == null ? "" : (String)paramMap.get("prID") ;
				}else if("expand".equals(grResourceType)) {
					grResourceID = paramMap.get("erID") == null ? "" : (String)paramMap.get("erID") ;
				}
				para.put("grResourceID", "".equals(grResourceID) ? "0" : grResourceID) ;
				para.put("grResourceType", grResourceType) ;
				Object one = eventExecutor.getSqlSession().selectOne(sid, para);
				eventExecutor.getBaseAction().getInitMap().put("gradeInfo", one) ;
				resultData.setOne(one);
			}	
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, GradeResSelectEvent.class);
			log.error(error);
			throw e;
		}
	}
}
