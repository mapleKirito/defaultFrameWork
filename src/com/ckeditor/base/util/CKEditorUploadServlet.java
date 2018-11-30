package com.ckeditor.base.util;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.common.Constant;
import com.ow.framework.exception.DetailException;
import com.ow.framework.util.StringUtil;
import com.ow.module.event.sysmgr.news.DBConnection;

@SuppressWarnings("serial")
public class CKEditorUploadServlet extends HttpServlet {

	DBConnection DBConn = new DBConnection();
	private static String baseDir = "/upload/";// CKEditor的根目录
	private static boolean debug = false;// 是否debug模式
	private static boolean enabled = false;// 是否开启CKEditor上传
	private static Hashtable allowedExtensions;// 允许的上传文件扩展名
	private static Hashtable deniedExtensions;// 阻止的上传文件扩展名
	private static SimpleDateFormat dirFormatter;// 目录命名格式:yyyyMM
	private static SimpleDateFormat fileFormatter;// 文件命名格式:yyyyMMddHHmmssSSS
	private static String NEWS = "news";
	private static String TodayOnHistory = "history";
	private static String USERFILE = "userFile";
	private static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	
	/**
	 * Servlet初始化方法
	 */
	public void init() throws ServletException {
		// 从web.xml中读取debug模式
		debug = (new Boolean(getInitParameter("debug"))).booleanValue();
		if (debug)
			System.out.println("\r\n---- SimpleUploaderServlet initialization started ----");
		
		// 格式化目录和文件命名方式
		dirFormatter = new SimpleDateFormat("yyyyMM");
		fileFormatter = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		
		// 从web.xml中获取根目录名称
		/*baseDir = getInitParameter("baseDir");*/
		
		// 从web.xml中获取是否可以进行文件上传
		enabled = (new Boolean(getInitParameter("enabled"))).booleanValue();
		/*if (baseDir == null)
			baseDir = "/upload/";
		
		String realBaseDir = getServletContext().getRealPath(baseDir);
		File baseFile = new File(realBaseDir);
		if (!baseFile.exists()) {
			baseFile.mkdirs();
		}*/
		
		// 实例化允许的扩展名和阻止的扩展名
		allowedExtensions = new Hashtable(3);
		deniedExtensions = new Hashtable(3);
		
		// 从web.xml中读取配置信息
		allowedExtensions.put("File", stringToArrayList(getInitParameter("AllowedExtensionsFile")));
		deniedExtensions.put("File", stringToArrayList(getInitParameter("DeniedExtensionsFile")));
		allowedExtensions.put("Image", stringToArrayList(getInitParameter("AllowedExtensionsImage")));
		deniedExtensions.put("Image", stringToArrayList(getInitParameter("DeniedExtensionsImage")));
		allowedExtensions.put("Flash", stringToArrayList(getInitParameter("AllowedExtensionsFlash")));
		deniedExtensions.put("Flash",  stringToArrayList(getInitParameter("DeniedExtensionsFlash")));
		
		if (debug)
			System.out.println("---- SimpleUploaderServlet initialization completed ----\r\n");
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (debug)
			System.out.println("--- BEGIN DOPOST ---");
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		
		// 从请求参数中获取上传文件的类型：File/Image/Flash
		String typeStr = request.getParameter("Type");
		if (typeStr == null) {
			typeStr = "File";
		}
		if (debug)
			System.out.println(typeStr);
		
		// 从请求参数中获取上传文件的科室：exhibition/observation/laboratory/projection/expand
		String typeRoom = request.getParameter("TypeRoom");
		if (typeRoom == null) {
			System.out.println(typeRoom + " is null");
		}
		
		String currentPath = "",snno = "",userfileID = "";
		Connection Conn = DBConn.getConn();
	    Statement stmt;
	   
	    if(typeRoom.contains(TodayOnHistory)){
			try {
				stmt = Conn.createStatement(1004,1007);
				String sql = "select ssn.SN_NO from sys_serial_number as ssn where ssn.SN_Name = 'todayonhistory'";
			    ResultSet rs = stmt.executeQuery(sql);
			    rs.last();
			    snno  = rs.getString(1);
			 } catch (SQLException e) {
				String error = DetailException.expDetail(e, CKEditorUploadServlet.class);
				log.error(error);
			}
			
			// 修改资源。获取当前资源snno,重置snno.
			String typeupdate_snno= request.getParameter("todayno");
			if (typeupdate_snno != null && !typeupdate_snno.equals("")){
				if(snno.length()>=4){
					snno = typeupdate_snno;
				}
			}
			
			if(snno.length()>=4){
				snno = snno.substring(snno.length()-4);
			}
			// 设定上传文件路径
			currentPath = baseDir + "/" + "today/" + snno;
		}else if(typeRoom.contains(NEWS)){
			try {
				stmt = Conn.createStatement(1004,1007);
				String sql = "select ssn.SN_NO from sys_serial_number as ssn where ssn.SN_Name = 'globenews'";
			    ResultSet rs = stmt.executeQuery(sql);
			    rs.last();
			    snno  = rs.getString(1);
			 } catch (SQLException e) {
				String error = DetailException.expDetail(e, CKEditorUploadServlet.class);
				log.error(error);
			}
			
			// 修改资源。获取当前资源snno,重置snno.
			String typeupdate_snno= request.getParameter("newsno");
			if (typeupdate_snno != null && !typeupdate_snno.equals("")){
				if(snno.length()>=4){
					snno = typeupdate_snno;
				}
			}
			
			if(snno.length()>=4){
				snno = snno.substring(snno.length()-4);
			}
			// 设定上传文件路径
			currentPath = baseDir + "/" + "news/" + snno;
		}else if(typeRoom.contains(USERFILE)){
			userfileID = request.getParameter(USERFILE+"ID");
			currentPath = baseDir + "/" + USERFILE + "/" + userfileID + "/" + typeStr;
		}else{
			try {
				stmt = Conn.createStatement(1004,1007);
				String sql = "select ssn.SN_NO from sys_serial_number as ssn where ssn.SN_Name = '"+typeRoom+"'";
			    ResultSet rs = stmt.executeQuery(sql);
			    rs.last();
			    snno  = rs.getString(1);
			} catch (SQLException e) {
				String error = DetailException.expDetail(e, CKEditorUploadServlet.class);
				log.error(error);
			}
			
			// 修改资源。获取当前资源snno,重置snno.
			String typeupdate_snno= request.getParameter(StringUtil.reResAbbreviated(typeRoom)+"no");
			if (typeupdate_snno != null && !typeupdate_snno.equals("")) {
				snno = typeupdate_snno.substring(typeupdate_snno.length()-7);
			}
			
			// 设定上传文件路径
			currentPath = baseDir + "/" + StringUtil.reResTypeThum(typeRoom) + "/story/" + snno + "/" + typeStr;
		}
		
		
		
		// 获得web应用的上传路径
		String currentDirPath = getServletContext().getRealPath(currentPath);
		currentDirPath = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "") + currentPath.replace("//", "/");
		// 判断文件夹是否存在，不存在则创建
		File dirTest = new File(currentDirPath);
		if (!dirTest.exists()) {
			dirTest.mkdirs();
		}
		
		// 将路径前加上web应用名
		currentPath = request.getContextPath() + currentPath;
		if (debug)
			System.out.println(currentDirPath);
		
		// 文件名和文件真实路径
		String newName = "";
		String fileUrl = "";
		if (enabled) {
			// 使用Apache Common组件中的fileupload进行文件上传
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				List items = upload.parseRequest(request);
				Map fields = new HashMap();
				Iterator iter = items.iterator();
				while (iter.hasNext()) {
					FileItem item = (FileItem) iter.next();
					if (item.isFormField())
						fields.put(item.getFieldName(), item.getString());
					else
						fields.put(item.getFieldName(), item);
				}
				
				// CEKditor中file域的name值是upload
				FileItem uplFile = (FileItem) fields.get("upload");
				
				// 获取文件名并做处理
				String fileNameLong = uplFile.getName();
				fileNameLong = fileNameLong.replace('\\', '/');
				String[] pathParts = fileNameLong.split("/");
				String fileName = pathParts[pathParts.length - 1];
				
				// 获取文件扩展名
				String ext = getExtension(fileName);
				
				// 设置上传文件名
				if(typeRoom.contains(TodayOnHistory)){
					fileName = "today_" + snno +"_" + fileFormatter.format(new Date()) + "." + ext;
				}else if(typeRoom.contains(NEWS)){
					fileName = "news_" + snno +"_" + fileFormatter.format(new Date()) + "." + ext;
				}else if(typeRoom.contains(USERFILE)){
					fileName = userfileID +"_" + fileFormatter.format(new Date()) + "." + ext;
				}else{
					fileName = StringUtil.reResTypeThum(typeRoom) + "_story" + snno +"_" + fileFormatter.format(new Date()) + "." + ext;	
				}
				
				// 获取文件名(无扩展名)
				String nameWithoutExt = getNameWithoutExtension(fileName);

				File pathToSave = new File(currentDirPath, fileName);
				fileUrl = currentPath + "/" + fileName;
				if (extIsAllowed(typeStr, ext)) {
					int counter = 1;
					while (pathToSave.exists()) {
						newName = nameWithoutExt + "_" + counter + "." + ext;
						fileUrl = currentPath + "/" + newName;
						pathToSave = new File(currentDirPath, newName);
						counter++;
					}
					uplFile.write(pathToSave);
				} else {
					if (debug)
						System.out.println("无效的文件类型： " + ext);
				}
			} catch (Exception ex) {
				if (debug)
					ex.printStackTrace();
			}
		} else {
			if (debug)
				System.out.println("未开启CKEditor上传功能");
		}
		
		// CKEditorFuncNum是回调时显示的位置，这个参数必须有
		String callback = request.getParameter("CKEditorFuncNum");
		out.println("<script type=\"text/javascript\">");
		out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + fileUrl + "',''" + ")");
		out.println("</script>");
		out.flush();
		out.close();
		if (debug)
			System.out.println("--- END DOPOST ---");
	}

	/**
	 * 获取文件名的方法
	 */
	private static String getNameWithoutExtension(String fileName) {
		return fileName.substring(0, fileName.lastIndexOf("."));
	}

	/**
	 * 获取扩展名的方法
	 */
	private String getExtension(String fileName) {
		return fileName.substring(fileName.lastIndexOf(".") + 1);
	}

	/**
	 * 字符串像ArrayList转化的方法
	 */

	private ArrayList stringToArrayList(String str) {
		if (debug)
			System.out.println(str);
		String[] strArr = str.split("\\|");
		ArrayList tmp = new ArrayList();
		if (str.length() > 0) {
			for (int i = 0; i < strArr.length; ++i) {
				if (debug)
					System.out.println(i + " - " + strArr[i]);
				tmp.add(strArr[i].toLowerCase());
			}
		}
		return tmp;
	}

	/**
	 * 判断扩展名是否允许的方法
	 */
	private boolean extIsAllowed(String fileType, String ext) {
		ext = ext.toLowerCase();
		ArrayList allowList = (ArrayList) allowedExtensions.get(fileType);
		ArrayList denyList = (ArrayList) deniedExtensions.get(fileType);
		if (allowList.size() == 0) {
			if (denyList.contains(ext)) {
				return false;
			} else {
				return true;
			}
		}
		if (denyList.size() == 0) {
			if (allowList.contains(ext)) {
				return true;
			} else {
				return false;
			}
		}
		return false;
	}

}
