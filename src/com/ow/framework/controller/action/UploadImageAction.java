package com.ow.framework.controller.action;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.ambow.base.grm.common.ConstantI;
import com.opensymphony.xwork2.ActionSupport;
import com.ow.framework.util.StringUtil;
import com.ow.module.event.sysmgr.laboratory.mod.Snno;

@SuppressWarnings("serial")
public class UploadImageAction extends ActionSupport  {  
	private static String persistence;
	private static int nameindex = 0;
	private static int nomodi = 0;
	private List<File> Filedata; // 默认的客户端文件对象,命名不符合java规范fileData  
	private List<String> FiledataFileName; // 客户端文件名  
	private List<String> imageContentType; // 客户端文件名类型  

	public String execute() throws Exception {  
    	nameindex++;
    	HttpServletRequest request = ServletActionContext.getRequest(); // 获得ServletRequest对象  
    	String Url = request.getSession().getServletContext().getRealPath("/WEB-INF/classes/jdbc.properties").replaceAll("%20", " ");
    	String path = request.getParameter("path");
    	String roomname = request.getParameter("roomname");
    	String filename = request.getParameter("filename");
    	/*persistence = filename;*/
    	persistence = new Date().getTime()+"";
    	String snno = Snno.getSnno(roomname, Url);
    	String snNO = StringUtil.intToSN(Integer.parseInt(snno), 8, "0") ; 
    	String foldername = snNO.substring(snNO.length()-4);
    	
    	String NoNum = request.getParameter("NoNum") == null ? "": request.getParameter("NoNum");
    	if(!NoNum.equals("")){
    		nomodi++;
    		foldername = NoNum;
    	}
    	if (Filedata == null || Filedata.size() == 0){return null;}  
        for (int i = 0; i < Filedata.size(); ++i) {  
           String fileName = FiledataFileName.get(i); // 文件真名  
           String filetype = fileName.substring(fileName.lastIndexOf("."));
           InputStream is = new  BufferedInputStream(new FileInputStream(Filedata.get(i)));    
           String filepath = ServletActionContext.getServletContext().getRealPath("/"); 
           		  filepath = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "");
           		  filepath += path + foldername + "/" + "auxilifile/";
           
           
           
           String zhu = "_";
           if(!NoNum.equals("")){
        	   zhu = "__"; 	   
           }
           filepath+=persistence + zhu + nameindex + filetype;
           File tempFile = new File(filepath);  
           FileUtils.forceMkdir(tempFile.getParentFile()); // 创建上传文件所在的父目录  
           OutputStream os = new BufferedOutputStream( new FileOutputStream(tempFile));  
           int len = 0;  
           byte[] buffer = new byte[500];  
           while (-1 != (len = is.read(buffer))){  
        	   os.write(buffer, 0, len);  
           }  
           is.close();  
           os.flush();  
           os.close();  
       }  
        return null;  
    }  
    public List<File> getFiledata(){return Filedata;}  
    public void setFiledata(List<File> filedata){Filedata = filedata; }  
    public List<String> getFiledataFileName(){ return FiledataFileName; }  
    public void setFiledataFileName(List<String> filedataFileName){ FiledataFileName = filedataFileName; }  
    public List<String> getImageContentType() { return imageContentType; }  
    public void setImageContentType(List<String> imageContentType) { this.imageContentType = imageContentType; }  
}  