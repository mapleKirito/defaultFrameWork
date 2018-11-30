package com.ambow.base.grm.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;

public class FileUtil {
	/**
	 * 判断该路径是否存在，不存在创建
	 * @param filePath
	 */
	public static void createFolder(String filePath) {
		File file = new File(filePath);
		if (!file.exists()) {
			file.mkdirs();
		}
	}
	/**
	 * 文件复制方法
	 * @param oldPath  原文件
	 * @param targetFilePath 复制的目标文件
	 */
	public static void copySwfFile(String oldPath,String targetFilePath){
	       try  {  
	           int  byteread  =  0;  
	           File  oldfile  =  new  File(oldPath);  
	           if  (oldfile.exists())  {  //文件存在时  
	               InputStream  inStream  =  new  FileInputStream(oldPath);  //读入原文件  
	               FileOutputStream  fs  =  new  FileOutputStream(targetFilePath);  
	               byte[]  buffer  =  new  byte[1444];  
	               while  (  (byteread  =  inStream.read(buffer))  !=  -1)  {  
	                   fs.write(buffer,  0,  byteread);  
	               }  
	               inStream.close();  
	           }  
	       }  
	       catch  (Exception  e)  {  
	           System.out.println("复制单个文件操作出错");  
	           e.printStackTrace();  
	 
	       } 
	}
	/**
	 * 验证是否存在相同文件
	 * @param filePath 文件路径
	 * @param fileName 验证文件名 
	 * @return 文件名存在 true , otherwhise false;
	 */
	public static boolean validSwfFileName(String filePath,String fileName){
		File testPath = new File(filePath);
		File[] fileArr = testPath.listFiles();
		boolean returnFlag = false;
		for(int i = 0 ; i < fileArr.length ;i++){
			File tempFile = fileArr[i];
			//有相同文件
			if(tempFile.getName().equals(fileName)){
				returnFlag = true;
				break;
			}
		}
		return returnFlag;
	}
}
