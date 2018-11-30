package com.ow.module.event.view;

import java.io.File;
import java.util.HashMap;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.DownloadAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class AreaViewDownloadEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public AreaViewDownloadEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
        try
        {
    		if(((DownloadAction)(eventExecutor.getBaseAction())).getInputPath()==null){
    			HashMap<String,String> hashMap = eventExecutor.getBaseAction().getParamMap();
    			String selectSqlId = eventExecutor.getSqlidByIndex(0);
    			Object obj = eventExecutor.getSqlSession().selectOne(selectSqlId, hashMap);    
    			String resPath = "";
    			if (obj != null){
    				resPath = ((HashMap)obj).get("erUpload") == null ? "" : ((HashMap)obj).get("erUpload").toString();
    			}
    			if (!resPath.equals("")){
	    			int index = resPath.lastIndexOf("/");
	    			String downloadFileName = resPath.substring(index+1, resPath.length());
	    			((DownloadAction)(eventExecutor.getBaseAction())).setDownloadFileName(downloadFileName);
    			}
				((DownloadAction)(eventExecutor.getBaseAction())).setInputPath(resPath);
				resultData.setIntResult(1);
    		}else{
    			String rpath = ServletActionContext.getServletContext().getRealPath("/");
    				  // rpath = DBUtil.TogeUpload(rpath)+"/";
    				rpath = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "");
				File f = new File(rpath +((DownloadAction)(eventExecutor.getBaseAction())).getInputPath());
				if(!f.exists()){
					resultData.setIntResult(0);
				}
				else{
					resultData.setIntResult(1);
				}
    		}
        }
        catch (Exception e)
        {
			/** 执行器执行失败 */
			String error = DetailException.expDetail(e, AreaViewDownloadEvent.class);
			log.error(error);
			throw e;
        }
		return resultData;		
	}

}
