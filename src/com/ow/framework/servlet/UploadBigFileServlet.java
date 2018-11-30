package com.ow.framework.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.dao.SessionFactory;
import com.ow.framework.util.FileHelper;

public class UploadBigFileServlet extends HttpServlet {

	private static final long serialVersionUID = -2237665721894155877L;
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
    
	protected void service(HttpServletRequest request,  
            HttpServletResponse response) throws ServletException, IOException {  
        String filePath = getServletContext().getRealPath("/") + "/upload_tmp/" ;  
//        int num = FileHelper.uploadBigFile(getServletContext(), request, filePath) ;
        
        SqlSessionFactory sf = (SqlSessionFactory)SessionFactory.getInstance().getSqlSessionFactoryMap().get("MYSQL_datasource") ;
        List list = sf.openSession().selectList("exhibition.select") ;
        
        System.out.println(list.size());
    }
	
	
}
