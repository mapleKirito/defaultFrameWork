package com.ow.framework.listener.timer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.quartz.CronExpression;
import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.impl.StdSchedulerFactory;


/**
 * 说明: 定时处理数据servlet    已过时
 * CronTrigger 定时参数说明
"0 0 12 * * ? " 				每天12点运行
"0 15 10 ? * *" 				每天10:15运行
"0 15 10 * * ?"					每天10:15运行
"0 15 10 * * ? *"				每天10:15运行
"0 15 10 * * ? 2008"			在2008年的每天10：15运行
"0 * 14 * * ?"					每天14点到15点之间每分钟运行一次，开始于14:00，结束于14:59。
"0 0/5 14 * * ?"				每天14点到15点每5分钟运行一次，开始于14:00，结束于14:55。
"0 0/5 14,18 * * ?"				每天14点到15点每5分钟运行一次，此外每天18点到19点每5钟也运行一次。
"0 0-5 14 * * ?"				每天14:00点到14:05，每分钟运行一次。
"0 10,44 14 ? 3 WED"			3月每周三的14:10分到14:44，每分钟运行一次。
"0 15 10 ? * MON-FRI"			每周一，二，三，四，五的10:15分运行。
"0 15 10 15 * ?"				每月15日10:15分运行。
"0 15 10 L * ?"					每月最后一天10:15分运行。
"0 15 10 ? * 6L" 				每月最后一个星期五10:15分运行。
"0 15 10 ? * 6L 2007-2009" 		在2007,2008,2009年每个月的最后一个星期五的10:15分运行。
"0 15 10 ? * 6#3"  				每月第三个星期五的10:15分运行。
 */
public class TimerJobServlet extends HttpServlet {
	
	public void init() throws ServletException 
	{
		Scheduler scheduler = null; 
		try {
			scheduler = StdSchedulerFactory.getDefaultScheduler();//初始化job运行容器			
			System.out.println("TimerJobServlet--init");
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		
		JobDetail jobDetail = new JobDetail("TaskTerminateJob", Scheduler.DEFAULT_GROUP,com.ow.framework.listener.timer.job.TaskTerminateJob.class);//创建更新job实例  
		CronTrigger cronTrigger= new CronTrigger("TaskTerminateJob", "tgroup");
		CronExpression cexp;
		try {
			String str = "1 0 0 * * ?";//每天零点过一秒执行
			cexp = new CronExpression(str);
			cronTrigger.setCronExpression(cexp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
        try {
			scheduler.scheduleJob(jobDetail, cronTrigger);//执行job
		} catch (SchedulerException e) {
			e.printStackTrace();		}
        try {
			scheduler.start();//定时任务开始
			
			System.out.println("TimerJobServlet--start");
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
}
