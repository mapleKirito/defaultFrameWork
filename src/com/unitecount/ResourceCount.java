package com.unitecount;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;

public class ResourceCount {
    public static void sendMsg(String type,String flag){
    	String path=null;
    	ActionContext ac = ActionContext.getContext();
    	HttpServletRequest request =(HttpServletRequest)ac.get(ServletActionContext.HTTP_REQUEST);
        String pathIp=getIpAddr(request);
		if(type.equals("1011")){//图片
			path="http://localhost:8086/UniteCount-school/SourceCountServlet?flag="+flag;
		}else if(type.equals("1073")){//音频
			path="http://localhost:8086/UniteCount-school/SourceCountServlet?flag="+flag;
		}else if(type.equals("1005")){//动画类素材
			path="http://localhost:8086/UniteCount-school/SourceCountServlet?flag="+flag;
		}else if(type.equals("1006")){//其它素材
			path="http://localhost:8086/UniteCount-school/SourceCountServlet?flag="+flag;
		}else if(type.equals("1084")){//高清视频
			path="http://localhost:8086/UniteCount-school/SourceCountServlet?flag="+flag;
		}else if(type.equals("2002")){//动画类课件
			path="http://localhost:8086/UniteCount-school/CoursewareCountServlet?flag="+flag;
		}else if(type.equals("2004")){//其他课件
			path="http://localhost:8086/UniteCount-school/CoursewareCountServlet?flag="+flag;
		}else if(type.equals("1022")){//3D图片
			path="http://localhost:8086/UniteCount-school/SourceCountServlet?flag="+flag;
		}else if(type.equals("2041")){//ppt
			path="http://localhost:8086/UniteCount-school/CoursewareCountServlet?flag="+flag;
		}else if(type.equals("2033")){//word
			path="http://localhost:8086/UniteCount-school/CoursewareCountServlet?flag="+flag;
		}else if(type.equals("2055")){//pdf
			path="http://localhost:8086/UniteCount-school/CoursewareCountServlet?flag="+flag;
		}else if(type.equals("3034")){//资料图书
			path="http://localhost:8086/UniteCount-school/CoursewareCountServlet?flag="+flag;
		}
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
