package com.ow.module.event.teacher;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.module.event.student.StudentTaskEvent;




public class UnFinshedTaskUserEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public UnFinshedTaskUserEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			String selectCountSqlId = eventExecutor.getSqlidByIndex(1);
			String selectTitleByTaskID = eventExecutor.getSqlidByIndex(2);
	
			List list = eventExecutor.getSqlSession().selectList(selectSqlId, paramMap);
			Object obj = eventExecutor.getSqlSession().selectOne(selectCountSqlId, paramMap);
			
			//得到作业标题在查看未完成学生列表页面。
			paramMap.put("title", ((HashMap)eventExecutor.getSqlSession().selectOne(selectTitleByTaskID, paramMap)).get("title"));
			
			//当前页
			int taskCurrentPage = 1;
			String tcpage = eventExecutor.getBaseAction().getCurrentPage();
			try{
				taskCurrentPage = Integer.parseInt(tcpage);
			}
			catch (Exception e){
			}
			int count = 0;
			if (obj != null){
				if (obj instanceof Integer){
					count = (Integer)obj;
				}
			}
			//每页显示记录数
			int pageSize=8;
			String psize = eventExecutor.getBaseAction().getPageSize(); 
			try{
				pageSize = Integer.parseInt(psize);
			}
			catch (Exception e){
			}
			int pageCount = (int)Math.ceil(count/(double) pageSize);
			PaginatedData paginatedData =  new PaginatedData();
			paginatedData.setCurrentPage(taskCurrentPage);
			paginatedData.setPageCount(pageCount);
			paginatedData.setPageSize(pageSize);
			paginatedData.setSelfPageName("paramMap.taskCurrentPage");
			paginatedData.setContextName("taskPaginated");
			String code = "code="+eventExecutor.getBaseAction().getCode();
			if(paramMap.get("taskId")!=null)
				code+="&paramMap.taskId="+(String)paramMap.get("taskId");
			paginatedData.htmlPage(code);
			resultData.setList(list);
			resultData.setPaginatedData(paginatedData);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, UnFinshedTaskUserEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
