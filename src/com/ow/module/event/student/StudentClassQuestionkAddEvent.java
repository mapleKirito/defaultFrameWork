package com.ow.module.event.student;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

/**
 * 班级首页班级提问
 * @author new
 *
 */
public class StudentClassQuestionkAddEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public StudentClassQuestionkAddEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String taskInsertSqlId = eventExecutor.getSqlidByIndex(0);
			String taskOrgInsertSqlId = eventExecutor.getSqlidByIndex(1);
			String selectTeacherId = eventExecutor.getSqlidByIndex(2);
			List rlist = eventExecutor.getSqlSession().selectList(selectTeacherId, eventExecutor.getBaseAction().getParamMap());
			if (rlist!=null && rlist.size()>0){
				HashMap map = (HashMap)rlist.get(0);
				BigDecimal teacherId=(BigDecimal)map.get("userID");
				paramMap.put("teacherId", teacherId);
			}
			eventExecutor.getSqlSession().insert(taskInsertSqlId,paramMap);
			String oids = paramMap.get("s_userOrgID") == null ? "" : paramMap.get("s_userOrgID").toString();
			String orgArr [] = oids.split(",");
			for (int i=0; i<orgArr.length; i++){
				if (!orgArr[i].equals("")){
					paramMap.put("orgID", orgArr[i]);
					eventExecutor.getSqlSession().insert(taskOrgInsertSqlId,paramMap);
				}
			}
			resultData.setIntResult(1);
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, StudentClassQuestionkAddEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
