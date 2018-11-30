package com.ow.module.event.teacher;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class AlertEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	public AlertEvent() {
		resultData = new ResultData();
	}

	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			String userIds = (String) map.get("userID");
			int rvalue = 0;
			
			if (userIds != null) {
				String[] userIdArr = userIds.split(",");
				if (userIdArr != null && userIdArr.length > 0) {
					for (int i = 0; i < userIdArr.length; i++) {
						String userID = userIdArr[i];
						String selectOrgSql = eventExecutor.getSqlidByIndex(0);// 根据用户查机构
						String selectTaskSql = eventExecutor.getSqlidByIndex(1);// 根据机构查任务
						String selectTaskAndUserSql = eventExecutor.getSqlidByIndex(2);// 根据任务和用户查判断完成情况没有完成的插入一条数据在用户和任务表里面写入数据
						String insertTaskAndUserSql = eventExecutor.getSqlidByIndex(3);
						HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
						paramMap.put("userID", userID);
						Object one = eventExecutor.getSqlSession().selectOne(selectOrgSql,paramMap);
						if (one != null) {
							paramMap.put("orgID",((HashMap) one).get("orgID"));
							List taskList = eventExecutor.getSqlSession().selectList(selectTaskSql, paramMap);
							if (taskList==null||taskList.size()==0){
								continue;
							}
							if (taskList != null && taskList.size() > 0) {
								for (int j = 0; i < taskList.size();j++) {
									HashMap mapTemp = (HashMap) taskList.get(j);
									paramMap.put("tID", mapTemp.get("taskId"));
									Object oneTemp = eventExecutor.getSqlSession().selectOne(selectTaskAndUserSql,paramMap);
									if (oneTemp != null) {
										continue;
									} else {
										int value = eventExecutor.getSqlSession().insert(insertTaskAndUserSql,paramMap);
										rvalue++;
									}
								}
							}
						}
					}
				}
				if(rvalue==0){
					rvalue=1;//选中的学生没有没做的作业
				}
				resultData.setIntResult(rvalue);
			}
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, AlertEvent.class);
			log.error(error);
			throw e;
		}
	}
}
