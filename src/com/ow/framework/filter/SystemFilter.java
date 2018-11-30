package com.ow.framework.filter;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.dispatcher.FilterDispatcher;

import com.SmartServer.util.ModuleStatesUtils;
import com.ambow.base.grm.common.ConstantI;
/**
 * 判断加密狗状态
 */
public class SystemFilter extends FilterDispatcher {
	public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain) throws IOException, ServletException {
		String states=ConstantI.SYSTEM_STATUS;
		String jump="";
		
		HttpServletRequest req = (HttpServletRequest) request;  
		HttpServletResponse resp = (HttpServletResponse) response; 
		System.out.println(req.getRequestURI());
		System.out.println(req.getRequestURI().endsWith(".action"));
        if (req.getRequestURI().endsWith(".action") 
        		|| req.getRequestURI().endsWith("index.jsp")
        		|| req.getRequestURI().endsWith("dm/"))
        {
        	System.out.println("check:"+states);
        	if(states!=null&&!states.equals("")){
    			if (states.equals("1")|| states.equals("2")) {
    				jump ="/SmartServerRemoteRequest.jsp";
    			}else if (states.equals("4")) {
    				jump = "/dmangetime.jsp";
    			}else if (states.equals("3")) {
    				jump = "/overclick.jsp";
    			}else if (states.equals("5")) {
    				jump= "/overtime.jsp";
    			}else if (states.equals("6")) {
    				jump = "/overchange.jsp"; //硬件改动
    			}else if (states.equals("demo0")) {
    				jump = "/demoinfoNew.jsp"; //硬件改动
    			}else if (states.equals("demo1")) {
    				jump = "/demoinfoNew.jsp"; //硬件改动
    			}else if (states.equals("demo2")) {
    				jump = "/demoinfoNew.jsp"; //硬件改动
    			}
    			System.out.println(jump);
    			
    		}
        	
        	if(!jump.equals("")){
				
				String path = req.getContextPath();
				String basePath = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+path; 
				resp.sendRedirect(basePath+jump);  
			}else{
				chain.doFilter(request, response);
			}
        }else{
        	chain.doFilter(request, response);
    		
        }
		
	}
}
