package com.ow.framework.listener.timer.job;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.ow.framework.data.dao.SessionFactory;

/**
 * 任务定时结束 已过时
 * 操作日志记录在c:/TaskTerminateLog下
 */
public class TaskTerminateJob implements Job{
	Logger log = Logger.getLogger(TaskTerminateJob.class.getName());
	public void execute(JobExecutionContext jobexecutioncontext)
			throws JobExecutionException {
		log.info("**********************************");
		log.info("--------TaskTerminateJob开始--------");
		
		try
		{
			String configFile = "config" + File.separator + "framework.properties";
			Properties props = Resources.getResourceAsProperties(configFile);
			String dsname = props.getProperty("framework.datasource.name") == null ? "" : props.getProperty("framework.datasource.name").trim();
			SqlSession sqlSession = SessionFactory.getInstance().getSQLSession(dsname,ExecutorType.REUSE,true);
			List allTasks = sqlSession.selectList("taskInfo.select_all_running_tasks");
			if(allTasks==null||allTasks.size()==0){
				log.info("没有要结束的任务!");
			}else{
				int count = 0;
				for(int i=0;i<allTasks.size();i++){
					HashMap task = (HashMap)allTasks.get(i);
					String taskId = task.get("taskId").toString();
					String interval = sqlSession.selectOne("taskInfo.endDate_minus_now",task).toString();
					if(interval.indexOf("-")!=-1){//即endDate-now<0
						//任务过期结束
						sqlSession.update("taskInfo.task_terminate",task);
						log.info("taskId为"+taskId+"的任务已结束。");
						count++;
					}
				}
				if(count==0){
					log.info("没有要结束的任务!");
				}else{
					log.info("本次操作共结束了"+count+"项到期任务。");
				}
			}
			log.info("--------TaskTerminateJob成功--------");
			log.info("**********************************");
		}
		catch (Exception e)
		{
			e.printStackTrace();
			log.info("--------TaskTerminateJob失败--------");
			log.info("**********************************");
		}
		
		
	}
	
}
