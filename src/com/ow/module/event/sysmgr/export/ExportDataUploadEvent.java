package com.ow.module.event.sysmgr.export;

import java.io.File;
import java.net.MalformedURLException;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.UploadAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.UploadEvent;
import com.ow.framework.util.DateUtil;
import com.ow.framework.util.FileHelper;
import com.ow.framework.util.ZipUtil;

public class ExportDataUploadEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	public ExportDataUploadEvent() {
		resultData = new ResultData();
	}

	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			if ((UploadAction) eventExecutor.getBaseAction() instanceof UploadAction) {
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
				File[] srcFiles = ((UploadAction) eventExecutor.getBaseAction())
						.getUploadify();
				String rootFold = ServletActionContext.getServletContext()
						.getRealPath(
								((UploadAction) eventExecutor.getBaseAction())
										.getSavePath());
				FileHelper.createFolder(rootFold);
				for (int i = 0; i < srcFiles.length; i++) {
					String dstPath = rootFold
							+ File.separator
							+ ((UploadAction) eventExecutor.getBaseAction()).getUploadifyFileName()[i];
					boolean temp = FileHelper.writeFile(new File(dstPath),
							srcFiles[i]);
					if (temp) {
						File upload = new File(dstPath) ;
						if(upload.exists()) {
							ZipUtil.unzip(dstPath, realPath + File.separator) ;
						}else {
							eventExecutor.getBaseAction().getPromptInfo().setResultDescInfo("上传文件失败，请重新上传！");
							resultData.setIntResult(0);
							return resultData;
						}
						
						resultData.setIntResult(1);
					} else {
						resultData.setIntResult(-1);
					}
				}
			} else {
				resultData.setIntResult(-1);
			}
			return resultData;
		} catch (Exception e) {
			/** 执行器执行失败 */
			String error = DetailException.expDetail(e, ExportDataUploadEvent.class);
			log.error(error);
			throw e;
		}
	}
}
