package com.ow.framework.filter;
import java.io.IOException;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.dispatcher.FilterDispatcher;
/**
 * 这个类用来解决struts2和fck冲突造成无法上传图片或文件 的问题，原
 * 因是struts在web.xml中配制的过滤器把fck的servlet请求转发了。
 * 用这个类替换掉web.xml中的struts过滤器类StrutsPrepareAndExecuteFilter就可以了
 * @author chunxiu
 */
public class ExtendStrutsFilter extends FilterDispatcher {
	public void doFilter(ServletRequest req, ServletResponse res,FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
        if (request.getRequestURI().indexOf("/js/fckeditor/editor/filemanager/connectors") > 0 
        		|| request.getRequestURI().indexOf("servlet/resourceManage")>0
        		|| request.getRequestURI().indexOf("RemoteRequestServlet/")>0
        		|| request.getRequestURI().indexOf("ModuleStatesServlet/")>0
        		|| request.getRequestURI().indexOf("SmartIpXmlServlet/")>0
        		|| request.getRequestURI().indexOf("uploadFile/")>0
        		|| request.getRequestURI().indexOf("SmallServlet/")>0
        		|| request.getRequestURI().indexOf("PreparingCenterTop/")>0
        		|| request.getRequestURI().indexOf("ckeditor/uploader")>0
        		|| request.getRequestURI().indexOf("show_page")>0
        		|| request.getRequestURI().indexOf("downQRcode")>0
        		|| request.getRequestURI().indexOf("DemoTrueF")>0
        		|| request.getRequestURI().indexOf("GotoDemo")>0)
        {
        	chain.doFilter(req, res);
        }else{
            super.doFilter(req, res, chain);
        }
	}
}
