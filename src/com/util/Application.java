package com.util;

public class Application{ 
	public static String getRootPath(){ 
	String result = Application.class.getResource("Application.class").toString(); 
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
	result = result.substring(0,result.lastIndexOf("/"));
	result = result.substring(0,result.lastIndexOf("/"));
	return result; 
	} 
}