package com.ow.module.event.sysmgr;

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

public class ResourceMoreFileDownload  implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	
	private static String fileSplit = "/";
	private ResultData resultData;
	
	public ResourceMoreFileDownload()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
        try
        {
    		if(((DownloadAction)(eventExecutor.getBaseAction())).getInputPath()==null){
    			HashMap<String,String> hashMap = eventExecutor.getBaseAction().getParamMap();
    			String resPath = hashMap.get("resPath") == null ? "" : hashMap.get("resPath") ;
    			
    			String  fileRealPathl = ServletActionContext.getServletContext().getRealPath(fileSplit).replaceAll("\\\\", "/");
    				fileRealPathl = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "");
    			String zipFileName = hashMap.get("resNo") == null ? "" : hashMap.get("resNo") ;
    			String inputFileName = resPath.substring(0,resPath.lastIndexOf("/"))+"/"+zipFileName.substring(zipFileName.length()-4);
    			
    			if (!resPath.equals("")){
	    			String downloadFileName = zipFileName+".zip";
	    			((DownloadAction)(eventExecutor.getBaseAction())).setDownloadFileName(downloadFileName);
    			}else {
					eventExecutor.getBaseAction().getPromptInfo().setResultDescInfo("资源文件不存在！");
					resultData.setIntResult(0);
					return resultData;
				}
    			
    			File f = new File(fileRealPathl + inputFileName + fileSplit + zipFileName+".zip");
				if(f.exists()){
					((DownloadAction)(eventExecutor.getBaseAction())).setInputPath(inputFileName + fileSplit + zipFileName+".zip");
					resultData.setIntResult(1);
				}else {
					eventExecutor.getBaseAction().getPromptInfo().setResultDescInfo("参考资源zip已经不存在！");
					resultData.setIntResult(0);
					return resultData;		
				}
    			
			}else{
				File f = new File(ServletActionContext.getServletContext().getRealPath("/")+((DownloadAction)(eventExecutor.getBaseAction())).getInputPath());
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
        	System.out.println(3);
			String error = DetailException.expDetail(e, ResourceMoreFileDownload.class);
			log.error(error);
			throw e;
        }
		return resultData;		
	}
}