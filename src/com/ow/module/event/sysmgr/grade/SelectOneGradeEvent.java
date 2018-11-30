package com.ow.module.event.sysmgr.grade;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.SelectOneEvent;

public class SelectOneGradeEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	public SelectOneGradeEvent()
	{
		resultData = new ResultData();
	}	
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			if (!"".equals(sid))
			{
				Object one = eventExecutor.getSqlSession().selectOne(sid, paramMap);
				resultData.setOne(one);
				
				if(one != null ){
					String grResourceType = (String)((HashMap)one).get("grResourceType") ;
					BigDecimal grResourceID = (BigDecimal)((HashMap)one).get("grResourceID") ;
					BigDecimal grGrade = (BigDecimal)((HashMap)one).get("grGrade") ;
					HashMap param = new HashMap() ;
					param.put("grResourceType", grResourceType) ;
					param.put("grResourceID", grResourceID) ;
					List<HashMap<String, Object>> list = eventExecutor.getSqlSession().selectList("grade.select_by_res", param) ;
					String grGrades = "," + grGrade.toString() + "," ;
					for(HashMap<String, Object> map : list) {
						BigDecimal bd = (BigDecimal)map.get("grGrade") ;
						grGrades += bd.toString() + "," ;
					}
					eventExecutor.getBaseAction().getInitMap().put("grGrades", grGrades) ;
				}
			}				
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SelectOneGradeEvent.class);
			log.error(error);
			throw e;
		}
	}
}
