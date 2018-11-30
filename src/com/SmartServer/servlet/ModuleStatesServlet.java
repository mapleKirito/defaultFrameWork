package com.SmartServer.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.longmai.smartserveradm.SmartServerAdminLib;

import net.sf.json.JSONObject;

import com.SmartServer.Biz.biz;
import com.SmartServer.util.SmartWebServer;
import com.ow.framework.listener.event.impl.GODEvent;
import com.ow.framework.listener.event.impl.KeyTransition;
import com.util.RemoteUtil;

public class ModuleStatesServlet extends HttpServlet {
	private static final long serialVersionUID = -2601613054164742002L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		this.doPost(request, response);
	}
	@SuppressWarnings({ })
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int[] indexKey = KeyTransition.decode();
		JSONObject json = new JSONObject();
		String no = request.getParameter("no");
		
		if(no.equals("index")){
			biz b = new biz();
			int key = indexKey[indexKey.length-1];
			String s = Integer.toString((b.getModuleStates(key)));
			
			if(GODEvent.getInstancegod()){
				//演示版状态 -1非演示版
				int DemoState=KeyTransition.getDemoState();
				if(DemoState==-1){
					/*String read_s = b.StoreRead(0,32).trim();
					String value = SmartWebServer.writerootvalue();*/
					/*老版本绑定机器到加密狗*/
					/*if(s.equals("1") || !read_s.equals(value)){*/
					//新版本绑定注册机器
					if(s.equals("1") ||RemoteUtil.getRemoteInfo()==-1){
						json.put("key","1");
						/*
						Date t = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
						byte[] pBuffer = sdf.format(t).getBytes();
						String write_s = b.StoreWrite(4, pBuffer);//写入第一次登录时间
		*/				
					}else if(RemoteUtil.getRemoteInfo()==1){
						json.put("key","6");
						
					}else{
						if(SmartWebServer.getInstancegodTime()==0){
							json.put("key","3");
						}else if(SmartWebServer.getInstancegodTime()==2){
							json.put("key","4");
						}
					}
					
				}else{
					if(DemoState==0){
						json.put("key","demo0");
					}else if(DemoState==1){
						json.put("key","demo1");
					}else if(DemoState==2){
						json.put("key","demo2");
					}
					
				}
				
				
			}else{
				json.put("key","5");
			}
			
			if (request.getParameter("callback") != null)
		        out.println(request.getParameter("callback") + "(" + json + ")");
		      else {
		        out.println(json);
		      }
			
			out.flush();
			out.close();
		}	
	}
}