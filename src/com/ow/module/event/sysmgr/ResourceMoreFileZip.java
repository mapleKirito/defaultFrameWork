package com.ow.module.event.sysmgr;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.DownloadAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.FileHelper;

public class ResourceMoreFileZip implements EventListener {
	
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private static String fileSplit = "/";
	private ResultData resultData;

	public ResourceMoreFileZip() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
        try
        {
    		if(((DownloadAction)(eventExecutor.getBaseAction())).getInputPath()==null){
    			HashMap<String,String> hashMap = eventExecutor.getBaseAction().getParamMap();

    			String  fileRealPathl = ServletActionContext.getServletContext().getRealPath(fileSplit).replaceAll("\\\\", "/");
    					fileRealPathl = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "");
    			String resPath = hashMap.get("resPath") == null ? "" : hashMap.get("resPath") ;
    			String zipFileName = hashMap.get("resNo") == null ? "" : hashMap.get("resNo") ;
    			String inputFileName = resPath.substring(0,resPath.lastIndexOf("/"))+"/"+zipFileName.substring(zipFileName.length()-4);
    			File fto = new File(fileRealPathl + inputFileName + fileSplit + zipFileName+".zip");
				
    			if(!fto.exists()){
					FileHelper.zip(fileRealPathl+inputFileName+"/auxilifile/", fileRealPathl + inputFileName + fileSplit + zipFileName+".zip");
				}
    			
    			HttpServletResponse resp = ServletActionContext.getResponse();
				PrintWriter out = resp.getWriter();
				JSONObject json = new JSONObject(); 
				out.println(json);
				out.flush();
				out.close();
			
    		}
        }
        catch (Exception e)
        {
        	System.out.println(1);
			/** 执行器执行失败 */
			String error = DetailException.expDetail(e, ResourceMoreFileZip.class);
			log.error(error);
			throw e;
        }
		return resultData;
	}
}