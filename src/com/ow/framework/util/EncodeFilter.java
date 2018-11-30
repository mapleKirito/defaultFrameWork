package com.ow.framework.util;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class EncodeFilter extends HttpServlet implements Filter {
 
	private static final long serialVersionUID = 386682946847952549L;
	private FilterConfig filterConfig;
    private String encode;
    //Handle the passed-in FilterConfig
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        encode = filterConfig.getInitParameter("encoding");
    }

    //Process the request/response pair
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) {
        try {
            request.setCharacterEncoding(encode);
            filterChain.doFilter(request, response);
        } catch (ServletException sx) {
            filterConfig.getServletContext().log(sx.getMessage());
        } catch (IOException iox) {
            filterConfig.getServletContext().log(iox.getMessage());
        }
    }

    //Clean up resources
    public void destroy() {
    }
}
