package com.ow.module.event.student;

import java.util.HashMap;
import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

/**
 * 修改提问内容
 * @author new
 *
 */
public class StudentClassQuestionkModifyEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public StudentClassQuestionkModifyEvent() {
		resultData = new ResultData();
	}
	
	@SuppressWarnings("rawtypes")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String taskInsertSqlId = eventExecutor.getSqlidByIndex(0);
			eventExecutor.getSqlSession().update(taskInsertSqlId,paramMap);
			resultData.setIntResult(1);
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, StudentClassQuestionkModifyEvent.class);
			log.error(error);
		}
		return resultData;
	}
}