package com.staticHtml.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;


public class MakeHtml {

	private static long before=0;
	private static long after=0;
	private static long time=0;
	
	public static String getHtmlCode(String httpUrl){
		System.out.println("静态化页面请求："+httpUrl);
		Date beforeDate=new Date();
		before=beforeDate.getTime();
		StringBuffer str=new StringBuffer();
		InputStream in=null;
		try{
			URL url=new URL(httpUrl);
			HttpURLConnection huc=(HttpURLConnection)url.openConnection();
			huc.setRequestProperty("User-Agent", "Mozilla/4.0");
			huc.connect();
			in=huc.getInputStream();
			BufferedReader br=new BufferedReader(new InputStreamReader(in));
			String currentLine;
			while((currentLine=br.readLine())!=null){
				str.append(currentLine);
			}
		}catch (Exception e) {
			// TODO: handle exception
		}finally{
			Date afterDate=new Date();
			after=afterDate.getTime();
			time=after-before;
			System.out.println("用时"+time+"秒");
		}
		
		return str.toString();
		
	}
	/**
	 * 
	 * @param htmlPath
	 * @param htmlCode
	 * @param flag		if reflash
	 */
	public static synchronized void writeHtml(String htmlPath,String htmlCode,boolean flag){
		PrintWriter pw=null;
		try{
			File htmlFile=new File(htmlPath);
			if(!htmlFile.exists()){
				htmlFile.createNewFile();
			}else if(flag){
				htmlFile.delete();
				htmlFile.createNewFile();
			}
			
			pw=new PrintWriter(htmlFile);
			pw.print(htmlCode);
			pw.flush();
		}catch (Exception e) {
			// TODO: handle exception
		}finally{
			if(pw!=null)
				pw.close();
		}
	}
}
