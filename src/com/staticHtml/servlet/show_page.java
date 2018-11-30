package com.staticHtml.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.staticHtml.bean.News;



/**
 * Servlet implementation class show_news
 */
public class show_page extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public show_page() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id=request.getParameter("id");
		String pageName=request.getParameter("pageName");
		System.out.println("page/scanner/"+id+"/"+pageName+".html");
		request.getRequestDispatcher("page/scanner/"+id+"/"+pageName+".html").forward(request, response);
		//response.sendRedirect("upload/page/scanner/"+id+"/"+pageName+".html");
		
	}

}
