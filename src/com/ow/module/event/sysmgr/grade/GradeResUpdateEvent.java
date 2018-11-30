package com.ow.module.event.sysmgr.grade;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

/**
 * 
 * 
 *
 */
public class GradeResUpdateEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public GradeResUpdateEvent()
	{
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String[] sid = eventExecutor.getSqlidArr();
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String grID = paramMap.get("grID") == null ? "" : (String)paramMap.get("grID") ;
			if (sid[0] != null && !sid[0].equals("")) {
				List list = "".equals(grID) ? new ArrayList() : eventExecutor.getSqlSession().selectList(sid[2], paramMap) ;
				if(list.size() == 0){ //判断是新增还是修改操作，如果是新增，需要修改资源表中IsGrade
					eventExecutor.getSqlSession().insert(sid[0], paramMap);
					resultData.setIntResult(1);
					String grResourceID = paramMap.get("grResourceID") == null ? "0" : (String)paramMap.get("grResourceID") ;
					String grResourceType = (String)paramMap.get("grResourceType") ;
					if("exhibition".equals(grResourceType)) {
						HashMap<String, Object> para = new HashMap<String, Object>() ;
						para.put("erID", grResourceID) ;
						para.put("erIsGrade", 1) ;
						eventExecutor.getSqlSession().update("exhibition.update_is_grade", para) ;
					}else if("observation".equals(grResourceType)) {
						HashMap<String, Object> para = new HashMap<String, Object>() ;
						para.put("orID", grResourceID) ;
						para.put("orIsGrade", 1) ;
						eventExecutor.getSqlSession().update("observation.update_is_grade", para) ;
					}else if("laboratory".equals(grResourceType)) {
						HashMap<String, Object> para = new HashMap<String, Object>() ;
						para.put("lrID", grResourceID) ;
						para.put("lrIsGrade", 1) ;
						eventExecutor.getSqlSession().update("laboratory.update_is_grade", para) ;
					}else if("projection".equals(grResourceType)) {
						HashMap<String, Object> para = new HashMap<String, Object>() ;
						para.put("prID", grResourceID) ;
						para.put("prIsGrade", 1) ;
						eventExecutor.getSqlSession().update("projection.update_is_grade", para) ;
					}else if("lovely".equals(grResourceType)) {
						HashMap<String, Object> para = new HashMap<String, Object>() ;
						para.put("crID", grResourceID) ;
						para.put("crIsGrade", 1) ;
						eventExecutor.getSqlSession().update("lovely.update_is_grade", para) ;
					}
				}else {
					eventExecutor.getSqlSession().update(sid[1], paramMap);
					resultData.setIntResult(1);
				}
			}	
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, GradeResUpdateEvent.class);
			log.error(error);
			throw e;
		}
	}
}
