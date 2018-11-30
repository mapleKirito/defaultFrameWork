package com.ow.upload.servlet;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ow.upload.vo.UploadFileStatus;


public class ProgressFileServlet extends HttpServlet {
	
	private static final long serialVersionUID = -8015123750214579082L;
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		UploadFileStatus status = (UploadFileStatus) session.getAttribute("status");
		try {
			response.reset();
			if(status!= null) {
				response.getWriter().write("{\"pBytesRead\":"+status.getPBytesRead()+",\"pContentLength\":"+status.getPContentLength()+"}");
	//			System.out.println("{\"pBytesRead\":" +status.getPBytesRead()+",\"pContentLength\":"+status.getPContentLength()+"}");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		this.doPost(request,response);
		
	}
}
