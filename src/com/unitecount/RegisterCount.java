package com.unitecount;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;

public class RegisterCount {
	
	 public static void sendMsg(String flag){
		/* ActionContext ac = ActionContext.getContext();
	    	HttpServletRequest request =(HttpServletRequest)ac.get(ServletActionContext.HTTP_REQUEST);
	        String pathIp=getIpAddr(request);*/
	    	String path="http://localhost:8086/UniteCount-school/RegisterInfoCountServlet?flag="+flag;
			 try {

	             URL url = new URL(path);

	             url.openStream();

	      } catch (MalformedURLException e) {
	               System.out.println("连接统计服务器时出现了一个小问题！");
	             e.printStackTrace();

	      } catch (IOException e) {
	    	  System.out.println("连接统计服务器时出现问题！");
	             e.printStackTrace();

	      }
	    }
	   public static String getIpAddr(HttpServletRequest request) {  
	        String ip = request.getHeader("X-Forwarded-For");  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = request.getHeader("Proxy-Client-IP");  
	        }  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = request.getHeader("WL-Proxy-Client-IP");  
	        }  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = request.getHeader("HTTP_CLIENT_IP");  
	        }  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
	        }  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = request.getRemoteAddr();  
	        }  
	        return ip;  
	    }
}
