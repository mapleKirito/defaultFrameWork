package com.ow.framework.listener.event.impl;

import java.io.File;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.UploadAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DateUtil;
import com.ow.framework.util.FileHelper;

/**  
 * 文件上传业务处理
 * 
 * @author Administrator
 */
public class UploadEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	public UploadEvent() {
		resultData = new ResultData();
	}

	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			if ((UploadAction) eventExecutor.getBaseAction() instanceof UploadAction) {
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
							+ DateUtil.sDateFormat()
							+ ((UploadAction) eventExecutor.getBaseAction()).getUploadifyFileName()[i];
					boolean temp = FileHelper.writeFile(new File(dstPath),
							srcFiles[i]);
					if (temp) {
						resultData.setIntResult(0);
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
			String error = DetailException.expDetail(e, UploadEvent.class);
			log.error(error);
			throw e;
		}
	}
}
