package com.ow.module.event.sysmgr.grade;

import java.io.File;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.UploadDataAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DateUtil;
import com.ow.framework.util.FileHelper;

public class GradeCreateEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	private static String fileSplit = "/";

	public GradeCreateEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String insert = eventExecutor.getSqlidByIndex(0);
			String selectRes = eventExecutor.getSqlidByIndex(1);
			if (!"".equals(insert)) {
				String grResourceType = paramMap.get("grResourceType") == null ? "" : (String)paramMap.get("grResourceType") ;
				String grResourceID = paramMap.get("grResourceID") == null ? "0" : (String)paramMap.get("grResourceID") ;
				List list = "0".equals(grResourceID) || "".equals(grResourceType) ? new ArrayList() : eventExecutor.getSqlSession().selectList(selectRes, paramMap) ;
				
				if(list.size() == 0) {
					int rvalue = eventExecutor.getSqlSession().insert(insert,paramMap);
					resultData.setIntResult(1);
					
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
				}
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, GradeCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
