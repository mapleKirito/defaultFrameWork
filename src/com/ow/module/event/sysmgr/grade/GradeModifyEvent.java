package com.ow.module.event.sysmgr.grade;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class GradeModifyEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public GradeModifyEvent()
	{
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String[] sid = eventExecutor.getSqlidArr();
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			if (sid[0] != null && !sid[0].equals("")) {
				//eventExecutor.getSqlSession().update(sid[0], paramMap);
				//resultData.setIntResult(1); 
				
				String oldGrades = (String)paramMap.get("oldGrades") ;
				String grGrade = (String)paramMap.get("grGrade");
				for(String grade : grGrade.split(",")){
					grade = grade.trim().replaceAll(" ", "") ;
					if(!"".equals(grade) && oldGrades.indexOf(grade) == -1) {
						paramMap.put("grGrade", grade) ;
						eventExecutor.getSqlSession().insert("grade.insert", paramMap) ;
					}
				}
			}	
			resultData.setIntResult(1); 
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, GradeModifyEvent.class);
			log.error(error);
			throw e;
		}
	}
}
