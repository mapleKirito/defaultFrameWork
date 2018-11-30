package com.ow.module.event.student;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class StudentMyUnfinishedEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private HashMap renturnHashMap;
	public StudentMyUnfinishedEvent() { 
		resultData = new ResultData();
		renturnHashMap = new HashMap();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String selectTaskSqlId = eventExecutor.getSqlidByIndex(0);
			String selectUserCountSqlId = eventExecutor.getSqlidByIndex(1);
			String selectTaskUnFinishedCountSqlId = eventExecutor.getSqlidByIndex(2);
			String selectUpdateViewCountSqlId = eventExecutor.getSqlidByIndex(3);
			//根据任务ID，查询任务归属班级信息
			List list = eventExecutor.getSqlSession().selectList(selectTaskSqlId, paramMap);
			String classId = null,className = null,classNameTemp = null,taskTitle = null,resultId = null,
			taskContent = null,createTime = null,userName = null,userAccount = null,userCountTemp = null,isLock = null,isRecommand = null,userType="";
			if (list != null){
				for (int i=0; i<list.size(); i++){
					if (list.get(i) instanceof HashMap){
						className = ((HashMap)list.get(i)).get("orgName") == null ? "" : ((HashMap)list.get(i)).get("orgName").toString();
						if (classNameTemp == null){
							classNameTemp = className;
						}
						else{
							classNameTemp += "&nbsp;&nbsp;&nbsp;" + className;
						}
						userName = ((HashMap)list.get(i)).get("userName") == null ? "" : ((HashMap)list.get(i)).get("userName").toString();
						userAccount = ((HashMap)list.get(i)).get("userAccount") == null ? "" : ((HashMap)list.get(i)).get("userAccount").toString();
						classId = ((HashMap)list.get(i)).get("orgId") == null ? "" : ((HashMap)list.get(i)).get("orgId").toString();
						taskTitle = ((HashMap)list.get(i)).get("title") == null ? "" : ((HashMap)list.get(i)).get("title").toString();
						taskContent = ((HashMap)list.get(i)).get("content") == null ? "" : ((HashMap)list.get(i)).get("content").toString();
						createTime = ((HashMap)list.get(i)).get("createTime") == null ? "" : ((HashMap)list.get(i)).get("createTime").toString();
						isLock = ((HashMap)list.get(i)).get("isLock") == null ? "" : ((HashMap)list.get(i)).get("isLock").toString();
						isRecommand = ((HashMap)list.get(i)).get("isRecommend") == null ? "0" : ((HashMap)list.get(i)).get("isRecommend").toString();
						resultId = ((HashMap)list.get(i)).get("resultId") == null ? "0" : ((HashMap)list.get(i)).get("resultId").toString();
						userType = ((HashMap)list.get(i)).get("userType") == null ? "0" : ((HashMap)list.get(i)).get("userType").toString();
						//存储用户类型
						renturnHashMap.put("userType", userType);

						//存储用户名称
						if (renturnHashMap.get("userName") == null){
							renturnHashMap.put("userName", userName);
						}
						//存储用户帐号
						if (renturnHashMap.get("userAccount") == null){
							renturnHashMap.put("userAccount", userAccount);
						}
						//存储班级名称到返回map中
						renturnHashMap.put("className", classNameTemp);
						//存储作业标题
						if (renturnHashMap.get("taskTitle") == null){
							renturnHashMap.put("taskTitle", taskTitle);
						}
						//存储作业内容
						if (renturnHashMap.get("taskContent") == null){
							renturnHashMap.put("taskContent", taskContent);
						}
						//发表时间
						if (renturnHashMap.get("createTime") == null){
							renturnHashMap.put("createTime", createTime);
						}
						//锁定状态
						if (renturnHashMap.get("isLock") == null){
							renturnHashMap.put("isLock", isLock);
						}
						//是否推荐
						if (renturnHashMap.get("isRecommend") == null){
							renturnHashMap.put("isRecommend", isRecommand);
						}
						//推荐结果表主键
						if (renturnHashMap.get("resultId") == null){
							renturnHashMap.put("resultId", resultId);
						}
						//存储班级主键id到参数map中taskId
						paramMap.put("orgId", classId);
						//任务id
						String taskId = paramMap.get("taskId") == null ? "":paramMap.get("taskId").toString();
						if (renturnHashMap.get("taskId") == null){
							renturnHashMap.put("taskId",taskId );
						}
		
						//查询班级人数
						int userCount = 0;
						Object userCountObj = eventExecutor.getSqlSession().selectOne(selectUserCountSqlId, paramMap);
						if (userCountObj instanceof Integer){
							userCount = (Integer)userCountObj;
						}
						if (userCountTemp == null){
							userCountTemp = "" + userCount + "";
						}
						else{
							userCountTemp += "&nbsp;&nbsp;&nbsp;" + "" + userCount + "";
						}
						renturnHashMap.put("userCount", userCountTemp);
						//查询完成作业人数
						if (renturnHashMap.get("taskUnfinishedCount") == null){
							int taskUnFinishedCount = 0;
							Object taskUnFinishedCountObj = eventExecutor.getSqlSession().selectOne(selectTaskUnFinishedCountSqlId, paramMap);
							if (taskUnFinishedCountObj instanceof Integer){
								taskUnFinishedCount = (Integer)taskUnFinishedCountObj;
							}
							renturnHashMap.put("taskUnfinishedCount", taskUnFinishedCount);		
						}
					}					
				}
			}
			//记录查看次数
			eventExecutor.getSqlSession().update(selectUpdateViewCountSqlId,paramMap);
			resultData.setOne(renturnHashMap);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, StudentMyUnfinishedEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
