package com.staticHtml.util;

import com.ambow.base.grm.common.ConstantI;

public class GetProjectPath {
	public static String getRootPath(){ 
		String result = GetProjectPath.class.getResource("GetProjectPath.class").toString(); 
		int index = result.indexOf("WEB-INF"); 
		if(index == -1){ 
		index = result.indexOf("bin"); 
		} 
		result = result.substring(0,index); 
		if(result.startsWith("jar")){ 
		// 当class文件在jar文件中时，返回"jar:file:/F:/ ..."样的路径 
		result = result.substring(10); 
		}else if(result.startsWith("file")){ 
		// 当class文件在class文件中时，返回"file:/F:/ ..."样的路径 
		result = result.substring(6); 
		} 
		if(result.endsWith("/"))result = result.substring(0,result.length()-1);//不包含最后的"/" 
		return result; 
		} 
	
	public static String getUploadPath(){
		return ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "")+"upload";
	}
}
