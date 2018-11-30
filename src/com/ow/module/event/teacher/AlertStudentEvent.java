package com.ow.module.event.teacher;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class AlertStudentEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	public AlertStudentEvent() {
		resultData = new ResultData();
	}

	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			String userIds = (String) map.get("studentID");					
			if (userIds != null) {
				String[] userIdArr = userIds.split(",");
				if (userIdArr != null && userIdArr.length > 0) {
					for (int i = 0; i < userIdArr.length; i++) {
						String studentID = userIdArr[i];
						String insertTaskAndUserSql = eventExecutor.getSqlidByIndex(0);
						String insertTaskAndUserSql1 = eventExecutor.getSqlidByIndex(1);
						HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
						paramMap.put("userID", studentID);
					
						int value = eventExecutor.getSqlSession().insert(insertTaskAndUserSql,paramMap);
						int value1 = eventExecutor.getSqlSession().update(insertTaskAndUserSql1,paramMap);
						resultData.setIntResult(value);
					}
				}				
			}
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, AlertStudentEvent.class);
			log.error(error);
			throw e;
		}
	}
}
