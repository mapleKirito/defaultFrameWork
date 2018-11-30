package com.ambow.base.grm.servlet;



import java.io.File;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import com.ambow.base.grm.common.ConstantI;

/**
 * 
 * 未使用
 *
 */
public class InitServlet extends HttpServlet
{
	private static final long serialVersionUID = 2994828437175265025L;

	public void init(ServletConfig param) throws ServletException
	{
		try
		{
			Locale locale =  new Locale("zh","CN");
			String configFile = "conf"+File.separator+"orm-params";
			ResourceBundle rb = ResourceBundle.getBundle(configFile); 
			//通过哪一种方式进行转换  1:openoffice  2:libreoffice
			ConstantI.TRANSFORTYPEFLAG_KEY = rb.getString("orm.transforTypeFlag");
			//获得pdf转换jar包路径
			ConstantI.PDFJARPATH_KEY = rb.getString("orm.pdfJarPath");
			//获得swf服务地址
			ConstantI.SWFTOOLSPATH_KEY = rb.getString("orm.swfToolsPath");
			//获得能够转换的文件类型
			ConstantI.ONLINEREADFILETYPE_KEY = rb.getString("orm.onlineReadFileType");
			//获得在线阅读页面
			ConstantI.ONLINEREADPATH_KEY = rb.getString("orm.onlineReadPath");
//			System.out.println(ConstantI.TRANSFORTYPEFLAG_KEY);
//			System.out.println(ConstantI.PDFJARPATH_KEY);
//			System.out.println(ConstantI.SWFTOOLSPATH_KEY );
//			System.out.println(ConstantI.ONLINEREADFILETYPE_KEY);
//			System.out.println(ConstantI.ONLINEREADPATH_KEY);
		}
		catch (Exception e)
		{
			System.out.println(e);
		}
	}
    
    
	public void destroy()
	{
		
	}
}


