package com.SmartServer.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.SmartServer.Biz.biz;
import com.SmartServer.util.SmartWebServer;
import com.util.RemoteUtil;

public class RemoteRequestServlet extends HttpServlet {
	private static final long serialVersionUID = -7809480749283389348L;
	public RemoteRequestServlet() {
		super();
	}
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		JSONObject json = new JSONObject(); 
		PrintWriter out = response.getWriter();
		String RemoteResponse = request.getParameter("RemoteResponse");
		biz b = new biz();
		String s;
		if(null==RemoteResponse||"".equals(RemoteResponse)){
			s = b.getChangeRequest();
			json.put("s", s);
			out.println(json);
			out.flush();
			out.close();
		}else {
			System.out.println(RemoteResponse);
			s = b.setRemote(RemoteResponse);
			if(s=="YES"){
				
				SmartWebServer.writeroot();
				RemoteUtil.remoteSystem();
				json.put("s", s);
				out.println(json);
				out.close();
			}else{
				json.put("s", s);
				out.println(json);
				out.flush();
				out.close();
			}
		}
	}
	public void init() throws ServletException {
		// Put your code here
	}

}
