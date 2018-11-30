package com.staticHtml.Filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.staticHtml.util.GetProjectPath;
import com.staticHtml.util.To_Html;



/**
 * Servlet Filter implementation class URL_rewrite
 */
public class URL_rewrite_new implements Filter {

    /**
     * Default constructor. 
     */
    public URL_rewrite_new() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("abcdefg");
		String flag=request.getParameter("flag");
		String directory=request.getParameter("directory");
		String pageName=request.getParameter("pageName")+".html";
		if(flag==null){
			//if(directory!=null){
			if(true){
				//String[] directorys=directory.split("_");
				//String directoryPath="";
				String directoryPath="scanner/"+request.getParameter("id")+"/";
				/*for (String string : directorys) {
					directoryPath+=string+"/";
				}*/
				System.out.println("Filter:请求页面文件"+directoryPath+pageName);
				java.io.File temp_page=new java.io.File(GetProjectPath.getRootPath()+"/page/"+directoryPath+pageName);
				if(temp_page.exists()){
					request.getRequestDispatcher("/page/"+directoryPath+pageName).forward(request, response);
				}else{
					To_Html.create_to_html(directory, pageName, ((HttpServletRequest)request).getRequestURL().toString()+"?flag=1&"+((HttpServletRequest)request).getQueryString());
					chain.doFilter(request, response);
				}
			}else{
				chain.doFilter(request, response);
			}
		}else{
			chain.doFilter(request, response);
		}
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
