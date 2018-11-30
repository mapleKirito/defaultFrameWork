package com.ow.module.event.sysmgr.export;

import java.io.File;
import java.net.MalformedURLException;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.DownloadAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.ZipUtil;

public class ExportDataDownloadEvent implements EventListener  {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ExportDataDownloadEvent(){
		resultData = new ResultData();
	}
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try{
			String fileSplit = Constant.fileSplit ;
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
			//文件的真实路径
			String realPath = fileRealPathl + fileSplit;
			
			String zipName = "export.zip" ;
			
			File download = new File(realPath + Constant.downloadPath + zipName) ;
			
			ZipUtil.zip(new File(realPath + Constant.exprotFilePath), download) ;
			
			if(download.exists()) {
    			((DownloadAction)(eventExecutor.getBaseAction())).setDownloadFileName(zipName);
				((DownloadAction)(eventExecutor.getBaseAction())).setInputPath(Constant.downloadPath + zipName);
				resultData.setIntResult(1);
			}else {
				eventExecutor.getBaseAction().getPromptInfo().setResultDescInfo("文件不存在,请重试,或者联系管理员！");
				resultData.setIntResult(0);
				return resultData;
			}
		}catch(Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExportDataDownloadEvent.class);
			log.error(error);
			throw e;
		}
		
		return resultData ;
	}
}
