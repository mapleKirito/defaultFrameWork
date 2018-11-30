package com.ow.module.event.sysmgr.grade;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class GradeDeleteEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public GradeDeleteEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String[] sid = eventExecutor.getSqlidArr();
			
			for(int i = 0 ; i < sid.length; i ++){
				if (sid[i] != null && !sid[i].equals(""))
				{
					Object grade = eventExecutor.getSqlSession().selectOne("", eventExecutor.getBaseAction().getParamMap()) ;
					if(grade instanceof HashMap){
						String grResourceType = (String)((HashMap)grade).get("grResourceType") ;
						String grResourceID = ((HashMap)grade).get("grResourceID") == null ? "0" : (String)((HashMap)grade).get("grResourceID") ;
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
					int rvalue = eventExecutor.getSqlSession().delete(sid[i], eventExecutor.getBaseAction().getParamMap());
					resultData.setIntResult(1);
				}	
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, GradeDeleteEvent.class);
			log.error(error);
			throw e;
		}
	}
}
