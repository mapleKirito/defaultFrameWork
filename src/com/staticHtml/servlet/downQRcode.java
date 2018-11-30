package com.staticHtml.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.staticHtml.util.GetProjectPath;
import com.staticHtml.util.QRcode;

/**
 * Servlet implementation class downQRcode
 */
public class downQRcode extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public downQRcode() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String content=request.getParameter("content");
		String code=request.getParameter("code");
		String pageName=request.getParameter("pageName");
		content+="&pageName="+pageName;
		String path=GetProjectPath.getRootPath()+"/page/scanner/"+code+"/";
		
		File file=new File(path,"qrcode.jpg");
		if(!file.exists()){
			QRcode.createQRImg(content, path);
		}
		FileInputStream is = new FileInputStream(file);
		response.setHeader("Content-Disposition","attachment;filename="+file.getName());
		ServletOutputStream out = response.getOutputStream();
		byte[] buffer = new byte[1024];
        int len = 0;
        while ((len = is.read(buffer)) != -1) {
            out.write(buffer, 0, len);
        }
        is.close();
        out.flush();
        out.close();
	}

}
