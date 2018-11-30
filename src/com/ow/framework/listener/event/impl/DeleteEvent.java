package com.ow.framework.listener.event.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.FileHelper;

public class DeleteEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private String UPLOAD = "/upload/";
	private String USERFILE = "/userFile/";
	
	public DeleteEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "unused", "rawtypes", "unchecked" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String userID = eventExecutor.getBaseAction().getParamMap().get("userID");
			String fileRealPath = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "");
			FileHelper.deleteDirectory(fileRealPath+UPLOAD+USERFILE+userID);
			new File(fileRealPath+UPLOAD+USERFILE+userID).delete();
			
			
			String userType = eventExecutor.getBaseAction().getParamMap().get("userType") == null ? "": eventExecutor.getBaseAction().getParamMap().get("userType");
			if(!userType.equals("")){
				eventExecutor.getSqlSession().delete("favorite.delete_parent_by_userid", eventExecutor.getBaseAction().getParamMap());
			}
			
			int rvalue_utam_id = eventExecutor.getSqlSession().delete("utam.delete_by_task_id", eventExecutor.getBaseAction().getParamMap());
			resultData.setIntResult(1);
			
			int rvalue_taskFinshed = eventExecutor.getSqlSession().delete("taskFinshed.delete_by_userId", eventExecutor.getBaseAction().getParamMap());
			resultData.setIntResult(1);
			
			List list_task_byorg = eventExecutor.getSqlSession().selectList("taskOrg.select_task_by_orgId", eventExecutor.getBaseAction().getParamMap());
			
			int rvalue_taskOrg_task = eventExecutor.getSqlSession().delete("taskOrg.delete_by_taskId", eventExecutor.getBaseAction().getParamMap());
			resultData.setIntResult(1);
			
			int rvalue_taskOrg_oid = eventExecutor.getSqlSession().delete("taskOrg.delete_by_oid", eventExecutor.getBaseAction().getParamMap());
			resultData.setIntResult(1);
			
			List list_taskInfo = eventExecutor.getSqlSession().selectList("taskInfo.select_array_by_userID", eventExecutor.getBaseAction().getParamMap());
			for(int i=0;i<list_taskInfo.size();i++){
				HashMap map = new HashMap();
				map.put("tiID", ((HashMap)list_taskInfo.get(i)).get("tiID"));
				int rvalue = eventExecutor.getSqlSession().delete("taskInfo.delete_by_id", map);
				resultData.setIntResult(1);
			}
			
			String isdeleorg = eventExecutor.getBaseAction().getParamMap().get("isdeleorg") == null ? "": eventExecutor.getBaseAction().getParamMap().get("isdeleorg");
			if(!isdeleorg.equals("")){
				for(int i=0;i<list_task_byorg.size();i++){
					HashMap map = new HashMap();
					map.put("taskId", ((HashMap)list_task_byorg.get(i)).get("taskId"));
					
					int delete_by_id = eventExecutor.getSqlSession().delete("task.delete_by_id", map);
					resultData.setIntResult(1);
				}				
			}
			
			
			
			int rvalue_utam = eventExecutor.getSqlSession().delete("utam.delete_user_by_user_id", eventExecutor.getBaseAction().getParamMap());
			resultData.setIntResult(1);
			
			int rvalue_task = eventExecutor.getSqlSession().delete("task.delete_by_userId", eventExecutor.getBaseAction().getParamMap());
			resultData.setIntResult(1);
			
			List task_isRecommend = eventExecutor.getSqlSession().selectList("task.select_task_isRecommend", eventExecutor.getBaseAction().getParamMap());
			if(task_isRecommend !=null){
				for(int i = 0;i<task_isRecommend.size();i++){
					HashMap taskid = (HashMap)task_isRecommend.get(i);
					if(taskid!=null && !(taskid.get("isRecommend")+"").trim().equals("0")){
						HashMap map = new HashMap();
						map.put("crTaskId", eventExecutor.getBaseAction().getParamMap().get("taskId"));
						int rvalue_isRecommend = eventExecutor.getSqlSession().delete("lovely.delete_by_taskId", map);
						resultData.setIntResult(1);
					}
				}
			}
			
			String[] sid = eventExecutor.getSqlidArr();
			for(int i = 0 ; i < sid.length; i ++){
				if (sid[i] != null && !sid[i].equals("")){
					int rvalue = eventExecutor.getSqlSession().delete(sid[i], eventExecutor.getBaseAction().getParamMap());
					resultData.setIntResult(1);
				}	
			}
			
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, DeleteEvent.class);
			log.error(error);
			throw e;
		}
	}
}