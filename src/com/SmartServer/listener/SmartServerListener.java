package com.SmartServer.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.SmartServer.util.SmartWebServer;

public class SmartServerListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent sce) {
		
	}

	public void contextInitialized(ServletContextEvent event) {
		SmartWebServer dog = SmartWebServer.getInstance();
		byte[] License = new byte[128];
		int rtn = dog.open();
		if(0==rtn){
			rtn = dog.GetAllModuleStates(License);
			if (0==rtn) {
				event.getServletContext().setAttribute("License", License);
			}else {
				System.out.println("获取所有模块状态失败, 错误码:"+rtn);
			}
		}else {
			System.out.println("打开加密锁失败, 错误码:"+rtn);
		}
	}

}
