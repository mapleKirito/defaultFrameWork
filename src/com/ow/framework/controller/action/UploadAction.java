package com.ow.framework.controller.action;

import java.io.File;

import com.ow.framework.listener.event.ExecutorResult;

/**
 * 文件上传
 * 
 * @author XINGBAO
 */
public class UploadAction extends BaseAction {
	private static final long serialVersionUID = -7315391073818691587L;
	private String title;
	private File[] uploadify;
	private String[] uploadifyFileName;
	private String[] uploadifyContentType;
	private String savePath;

	public String subExecute() throws Exception {
		ExecutorResult executorResult = this.eventExecutor.generalEventExecutor();
		if(executorResult.getResult() != null && executorResult.getResult().equals("1")) {
			return IAction.SUCCESS;
		} else {
			return INPUT;
		}
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}



	public File[] getUploadify() {
		return uploadify;
	}

	public void setUploadify(File[] uploadify) {
		this.uploadify = uploadify;
	}

	public String[] getUploadifyFileName() {
		return uploadifyFileName;
	}

	public void setUploadifyFileName(String[] uploadifyFileName) {
		this.uploadifyFileName = uploadifyFileName;
	}

	public String[] getUploadifyContentType() {
		return uploadifyContentType;
	}

	public void setUploadifyContentType(String[] uploadifyContentType) {
		this.uploadifyContentType = uploadifyContentType;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
}
