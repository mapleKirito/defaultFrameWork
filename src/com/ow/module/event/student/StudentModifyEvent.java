package com.ow.module.event.student;

import java.io.File;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.UploadDataAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DateUtil;
import com.ow.framework.util.FileHelper;
import com.ow.module.event.sysmgr.observation.ObservationCreateEvent;

public class StudentModifyEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	private static String fileSplit = "/";

	public StudentModifyEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String update = eventExecutor.getSqlidByIndex(0);
			if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
				/***************处理缩略图***************/
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
				//文件的真实路径
				String realPath = fileRealPathl+ ((UploadDataAction) eventExecutor.getBaseAction()).getSavePath() + fileSplit;
				
				File[] files = ((UploadDataAction) eventExecutor.getBaseAction()).getUpload();
				if (files != null) {
					List<String> tempPath = getTempPath(eventExecutor
							.getBaseAction().getParamMap().get("swapPath"),
							files.length);
					if(files.length > 0) {
						int i = 0;
						// 文件原始名字
						String oldFileName = ((UploadDataAction) eventExecutor
								.getBaseAction()).getUploadFileName()[i];
						// 文件在服务器重名字(修改过的名字)
						fileName = DateUtil.sDateFormat() + oldFileName.substring(oldFileName.lastIndexOf("."));
						// upload下的路径
						String resUploadPath = DateUtil.getCurrentDateString("yyyyMMdd") + "/" ;
						
						FileHelper.createFolder(realPath + tempPath.get(i)
								+ fileSplit + resUploadPath);
						if (!FileHelper.writeFile(
								new File(realPath + tempPath.get(i) + fileSplit
										+ resUploadPath + fileName), files[i])) {
							resultData.setIntResult(-1);
							return resultData;
						}
						String fileRealPath = new String();
						// fileRealPath = realPath.substring(0,
						// realPath.length()-1)+ "\\" +fileName;
						fileRealPath = realPath.substring(0,
								realPath.length() - 1);
						paramMap.put("userPhone", resUploadPath + fileName);
						
					}
				}
				/***************处理缩略图***************/
				if (!"".equals(update)) {	
					int rvalue = eventExecutor.getSqlSession().update(update,paramMap);
					resultData.setIntResult(1);
				}	
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ObservationCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}
	
	/** 对多文件上传的路径处理方法 */
	private List<String> getTempPath(String str, int length) {
		List<String> returnList = new ArrayList<String>();
		/** 当隐藏域没有配置 */
		if (str == null) {
			for (int i = 0; i < length; i++) {
				returnList.add(fileSplit);
			}
			return returnList;
		} else {
			/** 当上传多文件的时候两种情况 */
			String strs[] = str.split("&");
			if (strs.length > 0 && strs.length < length) {
				for (int i = 0; i < strs.length; i++) {
					returnList.add(strs[i] + fileSplit);
				}
				for (int j = 0; j < length - strs.length; j++) {
					returnList.add(fileSplit);
				}
				return returnList;
			} else {
				returnList.add(str);
				for (int i = 0; i < length - 1; i++) {
					returnList.add(fileSplit);
				}
				return returnList;
			}
		}
	}
}
