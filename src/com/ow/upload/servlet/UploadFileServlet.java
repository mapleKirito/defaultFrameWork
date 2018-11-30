package com.ow.upload.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.ambow.base.grm.common.ConstantI;
import com.ow.upload.listener.UploadFileProgressListener;

public class UploadFileServlet extends HttpServlet {

	private static final long serialVersionUID = -6909493046832011898L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//factory.setSizeThreshold(2048 * 1024);
		UploadFileProgressListener getBarListener = new UploadFileProgressListener(req);
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setProgressListener(getBarListener);
		try {
			List formList = upload.parseRequest(req);
			Iterator<Object> formItem = formList.iterator();
			String realFilePath = getServletContext().getRealPath("/") ;
			// 将进度监听器加载进去
			String fileName = "" ;
			String filePath = "" ;
			
			String filePathaa = this.getServletConfig().getServletContext().getRealPath("/");  
			//realFilePath = DBUtil.TogeUpload(filePathaa) + "/"; 
				realFilePath = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "") + "/";
			
			while (formItem.hasNext()) {
				FileItem item = (FileItem) formItem.next();
				if (item.isFormField()) {
					//System.out.println("Field Name:" + item.getFieldName());
					if("uploadFileName".equals(item.getFieldName())) {
						fileName = item.getString("UTF-8") ;
					}
					if("uploadFilePath".equals(item.getFieldName())) {
						filePath = item.getString("UTF-8") ;
						File tmpFile = new File(realFilePath + filePath) ;
						if(!tmpFile.exists()) {
							tmpFile.mkdirs() ;
						}
					}
				} else {
					String oldFileName = item.getName().substring(item.getName().lastIndexOf("\\") + 1);
					File file = new File(realFilePath + filePath + fileName);
					OutputStream out = item.getOutputStream();
					InputStream in = item.getInputStream();
					req.getSession().setAttribute("outPutStream", out);
					req.getSession().setAttribute("inPutStream", in);
					item.write(file);

				}
			}
		} catch (FileUploadException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
	}
}
