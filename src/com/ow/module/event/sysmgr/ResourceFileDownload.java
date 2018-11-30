package com.ow.module.event.sysmgr;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
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
import com.unitecount.ResourceCount;

public class ResourceFileDownload  implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private static String fileSplit = "/";
	private ResultData resultData;
	public ResourceFileDownload()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
        try
        {
    		if(((DownloadAction)(eventExecutor.getBaseAction())).getInputPath()==null){
    			HashMap<String,String> hashMap = eventExecutor.getBaseAction().getParamMap();
    			String resPath = hashMap.get("resPath") == null ? "" : hashMap.get("resPath") ;
    			String resDownType = hashMap.get("resDownType") == null ? "" : hashMap.get("resDownType") ;
    			String resDownRoom = hashMap.get("resDownRoom") == null ? "" : hashMap.get("resDownRoom") ;
               //配合统计模块进行统计
    			if(ConstantI.ISCOUNT_KEY.equals("1")){
    			ResourceCount.sendMsg(resDownType, "DOWNLOAD");
    			}
              //统计模块所需代码结束
    			
    			if (!resPath.equals("")){
	    			int index = resPath.lastIndexOf("/");
	    			String downloadFileName = resPath.substring(index+1, resPath.length());
	    			((DownloadAction)(eventExecutor.getBaseAction())).setDownloadFileName(downloadFileName);
    			}else {
					eventExecutor.getBaseAction().getPromptInfo().setResultDescInfo("暂无资源");
					resultData.setIntResult(0);
					return resultData;
				}
    			String fileName = null;
				//tomcat获取服务器路径
				String  fileRealPathl = ServletActionContext.getServletContext().getRealPath(fileSplit);
				//webLogic获取服务器路径
				if(fileRealPathl==null){
					try {
						fileRealPathl = ServletActionContext.getServletContext().getResource(fileSplit).toString();
					} catch (MalformedURLException e) {
						e.printStackTrace();
					}
				}
				
				//fileRealPathl = DBUtil.TogeUpload(fileRealPathl);
					fileRealPathl = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "");
    			File f = new File(fileRealPathl + "/" + resPath);
				if(f.exists()){
					((DownloadAction)(eventExecutor.getBaseAction())).setInputPath(resPath);
					resultData.setIntResult(1);
				}else {
					eventExecutor.getBaseAction().getPromptInfo().setResultDescInfo("暂无资源！");
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
        	/** 执行器执行失败 */
			String error = DetailException.expDetail(e, ResourceFileDownload.class);
			log.error(error);
			throw e;
        }
		return resultData;		
	}
}
