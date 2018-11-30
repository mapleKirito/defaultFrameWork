package com.ow.framework.listener.event.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.DownloadAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.ExcelHandler;
import com.ow.framework.util.KeyHelper;
import com.ow.framework.util.TxtHandler;
/**
 *DownLoad数据 
 */
public class DownloadEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	public DownloadEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
        try
        {
    		if(((DownloadAction)(eventExecutor.getBaseAction())).getInputPath()==null){
    			HashMap<String,String> hashMap = eventExecutor.getBaseAction().getParamMap();
        		List datas = eventExecutor.getSqlSession().selectList(eventExecutor.getSqlidByIndex(0),hashMap);
    			String filePath = ServletActionContext.getServletContext().getRealPath("/") + "download";
        		//String filePath = "/download";
				String fileType = hashMap.get("fileType") == null ? "" : hashMap.get("fileType").toString();			
				String fileName = KeyHelper.getKey() + "." + fileType;
				((DownloadAction)(eventExecutor.getBaseAction())).setInputPath(File.separator + "download" + File.separator + fileName);
		        String title = hashMap.get("title") == null ? "" : hashMap.get("title").toString();
		        String head[] = hashMap.get("columnName") == null ? new String[1] : hashMap.get("columnName").toString().split(",");
		        String cols[] = hashMap.get("column") == null ? new String[1] : hashMap.get("column").toString().split(",");
		        if (fileType.toLowerCase().equals("txt"))
		        {
					int rvalue = TxtHandler.getInstance().writeTxtFile(title, filePath, fileName, datas, head, cols);
					resultData.setIntResult(rvalue);
		        }
		        else if (fileType.toLowerCase().equals("xls"))
		        {
					int rvalue = ExcelHandler.getInstance().writeExcelFile(title, filePath, fileName, datas, head, cols);
					resultData.setIntResult(rvalue);		        	
		        }
    		}else{
				File f = new File(ServletActionContext.getServletContext().getRealPath("/")+((DownloadAction)(eventExecutor.getBaseAction())).getInputPath());
				if(!f.exists()){
					resultData.setIntResult(0);
				}
    		}
        }
        catch (Exception e)
        {
        	/** 执行器执行失败 */
			String error = DetailException.expDetail(e, DownloadEvent.class);
			log.error(error);
			throw e;
        }
		return resultData;
	}
}
