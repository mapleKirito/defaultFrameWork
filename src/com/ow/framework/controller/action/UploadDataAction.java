package com.ow.framework.controller.action;

import java.io.File;
import com.ow.framework.listener.event.ExecutorResult;

/**
 * 数据上传
 * 
 * @author XINGBAO
 */
public class UploadDataAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	private String title;
	private File[] upload;
	private String[] uploadContentType;
	private String[] uploadFileName;
	private String savePath;
	private String filePath;
	private String fileType;
	private Object singleData;//这个变量用来传非list的值
	
	public String subExecute() throws Exception {
		ExecutorResult executorResult = this.eventExecutor.generalEventExecutor();
		if (executorResult.getResult() != null && executorResult.getResult().equals("1")) {
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

	public File[] getUpload() {
		return upload;
	}

	public void setUpload(File[] upload) {
		this.upload = upload;
	}

	public String[] getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String[] uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public String[] getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String[] uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public Object getSingleData() {
		return singleData;
	}

	public void setSingleData(Object singleData) {
		this.singleData = singleData;
	}

}
