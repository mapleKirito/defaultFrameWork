package com.ow.upload.listener;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.ProgressListener;

import com.ow.upload.vo.UploadFileStatus;

public class UploadFileProgressListener implements ProgressListener {
	private HttpSession session;

	public UploadFileProgressListener(HttpServletRequest req) {
		session=req.getSession();
		UploadFileStatus status = new UploadFileStatus();
		session.setAttribute("status", status);
	}

	/* pBytesRead  到目前为止读取文件的比特数
	 * pContentLength 文件总大小
	 * pItems 目前正在读取第几个文件
	 */
	public void update(long pBytesRead, long pContentLength, int pItems) {
		// TODO Auto-generated method stub
		UploadFileStatus status = (UploadFileStatus) session.getAttribute("status");
		status.setPBytesRead(pBytesRead);
		status.setPContentLength(pContentLength);
		status.setPItems(pItems);
	}
}
