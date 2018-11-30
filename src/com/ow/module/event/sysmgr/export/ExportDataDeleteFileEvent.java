package com.ow.module.event.sysmgr.export;

import java.io.File;
import java.net.MalformedURLException;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ExportDataDeleteFileEvent implements EventListener  {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ExportDataDeleteFileEvent(){
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
			
			String fileName = eventExecutor.getBaseAction().getParamMap().get("tableName") ;
			
			File file = new File(realPath + "/" + Constant.exprotFilePath + fileName + "." + Constant.exportFileType) ;
			if(file.exists()) {
				file.delete() ;
			}
			resultData.setIntResult(1);
		}catch(Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExportDataDeleteFileEvent.class);
			log.error(error);
			throw e;
		}
		
		return resultData ;
	}
}
