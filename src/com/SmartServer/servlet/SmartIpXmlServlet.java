package com.SmartServer.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.SmartServer.Biz.biz;

public class SmartIpXmlServlet extends HttpServlet {
	
	public SmartIpXmlServlet() {
		super();
	}
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	private static final long serialVersionUID = 9121500361151457692L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		this.doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		JSONObject json = new JSONObject(); 
		PrintWriter out = response.getWriter();
		String ips = request.getParameter("ips");	
		String setIp = request.getParameter("setIp");	
		String xmlUrl=request.getSession().getServletContext().getRealPath("/xmlUrl.xml");
		String requestUrl=request.getSession().getServletContext().getRealPath("/requestUrl.xml");
		System.out.println(xmlUrl);
		System.out.println(requestUrl);
		biz b = new biz();
		String ip = null;
		if(ips.equals("getIp")){
			ip = b.getXml(xmlUrl);
			System.out.println(ip);
			json.put("ipd", ip);
			out.println(json);
			out.flush();
			out.close();
		}
		if(!(setIp=="")&&!(setIp==null)){
			if(setIp.equals("setIp")){
				b.setXml(ips, requestUrl);
				b.setXml(ips, xmlUrl);
			}
		}
		if(ips.equals("getLocalIp")){
			String ipd = getAllLocalHostIP();
			System.out.println(ipd);
			json.put("ipd", ipd);
			out.println(json);
			out.flush();
			out.close();
		}

	}
	public void init() throws ServletException {
		// Put your code here
	}
	public static String getAllLocalHostIP() {
        List<String> res = new ArrayList<String>();
        Enumeration netInterfaces;
        try {
            netInterfaces = NetworkInterface.getNetworkInterfaces();
            InetAddress ip = null;
            while (netInterfaces.hasMoreElements()) {
                NetworkInterface ni = (NetworkInterface) netInterfaces.nextElement();
                //System.out.println("---Name---:" + ni.getName());
                Enumeration nii = ni.getInetAddresses();
                while (nii.hasMoreElements()) {
                    ip = (InetAddress) nii.nextElement();
                    if (ip.getHostAddress().indexOf(":") == -1) {
                        res.add(ip.getHostAddress());
                        if(!"127.0.0.1".equals(ip.getHostAddress())){
                        	return ip.getHostAddress();
                        }
                    }
                }
            }
        } catch (SocketException e) { }		
        return "127.0.0.1";           
    }
}
