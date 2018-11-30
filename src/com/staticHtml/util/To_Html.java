package com.staticHtml.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import com.staticHtml.bean.DuoweiBean;
import com.staticHtml.bean.ImgBean;
import com.staticHtml.bean.PageInfoBean;
import com.staticHtml.bean.ShiyanBean;
import com.staticHtml.bean.TableBean;
import com.staticHtml.bean.VideoBean;
import com.staticHtml.bean.WendangBean;



public class To_Html {
	public static void test_to_html(String title,String content,String pageName){
		//模板文件路径
		String Modelpath=GetProjectPath.getRootPath()+"/Page.html";
		//输出文件路径
		String Outputpath=GetProjectPath.getRootPath()+"/news/"+pageName+".html";
		//html代码
		String htmlCode="";
		/*System.out.println("title:"+title);
		System.out.println("content:"+content);
		System.out.println(Outputpath);*/
		
		//开始静态化
		FileInputStream fileinputstream;
		try {
			fileinputstream = new FileInputStream(Modelpath);
			FileOutputStream fileoutputstream = new FileOutputStream(Outputpath);// 建立文件输出流
			// 读取模板文件
		    int lenght = fileinputstream.available();
		    byte bytes[] = new byte[lenght];
		    fileinputstream.read(bytes);
		    fileinputstream.close();
		    htmlCode = new String(bytes);
		    htmlCode=new String(htmlCode.getBytes(), "utf-8");
		    htmlCode=htmlCode.replaceAll("###title###", title);
		    htmlCode=htmlCode.replaceAll("###content###", content);
			/*System.out.println("html代码:\n"+htmlCode);*/
			//生成html
			byte tag_bytes[] = htmlCode.getBytes("utf-8");
		    fileoutputstream.write(tag_bytes);
		    fileoutputstream.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"没有找到");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"读取错误");
		}
	}
	
	public static void reslink_html(String content,String pageName,String pageID){
		//模板文件路径
		String Modelpath=GetProjectPath.getRootPath()+"/page/html/reslink.html";
		//输出文件路径
		String OutputpathDir=GetProjectPath.getRootPath()+"/page/scanner/"+pageID+"/";
		//String OutputpathDir=GetProjectPath.getUploadPath()+"/page/scanner/"+pageID+"/";
		String Outputpath=OutputpathDir+pageName+".html";
		File dirFile=new File(OutputpathDir);
		if(!dirFile.exists()){
			dirFile.mkdirs();
		}
		//html代码
		String htmlCode="";
		/*System.out.println("content:"+content);
		System.out.println(Outputpath);*/
		
		//开始静态化
		FileInputStream fileinputstream;
		try {
			fileinputstream = new FileInputStream(Modelpath);
			FileOutputStream fileoutputstream = new FileOutputStream(Outputpath);// 建立文件输出流
			// 读取模板文件
		    int lenght = fileinputstream.available();
		    byte bytes[] = new byte[lenght];
		    fileinputstream.read(bytes);
		    fileinputstream.close();
		    htmlCode = new String(bytes);
		    htmlCode=new String(htmlCode.getBytes(), "utf-8");
		    htmlCode=htmlCode.replaceAll("###content###", content);
			/*System.out.println("html代码:\n"+htmlCode);*/
			//生成html
			byte tag_bytes[] = htmlCode.getBytes("utf-8");
		    fileoutputstream.write(tag_bytes);
		    fileoutputstream.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"没有找到");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"读取错误");
		}
	}
	
	public static void test_to_html(String content,PageInfoBean pib,String pageName){
		//模板文件路径
		String Modelpath=GetProjectPath.getRootPath()+"/page/html/123.html";
		//输出文件路径
		String Outputpath=GetProjectPath.getRootPath()+"/page/scanner/"+pageName+".html";
		//html代码
		String htmlCode="";
		/*System.out.println("content:"+content);
		System.out.println(Outputpath);*/
		
		//开始静态化
		FileInputStream fileinputstream;
		try {
			fileinputstream = new FileInputStream(Modelpath);
			FileOutputStream fileoutputstream = new FileOutputStream(Outputpath);// 建立文件输出流
			// 读取模板文件
		    int lenght = fileinputstream.available();
		    byte bytes[] = new byte[lenght];
		    fileinputstream.read(bytes);
		    fileinputstream.close();
		    htmlCode = new String(bytes);
		    htmlCode=new String(htmlCode.getBytes(), "utf-8");
		    htmlCode=htmlCode.replaceAll("###content###", content);
		    //图片数据
		    String htmlImg="";
		    for (ImgBean img : pib.getImgList()) {
				htmlImg+="<li class='jcarousel-item jcarousel-item-horizontal jcarousel-item-1 jcarousel-item-1-horizontal' style='float: left; list-style: none;'>"+
				"<div class='clip'>"+
				"<img class='icon' src='"+img.getImgT()+"' srcs='"+img.getImgS()+"' style='display: inline; width: 100%; '>"+
				"</div>"+
				"</li>";
			}
		    htmlCode=htmlCode.replaceAll("###imgList###", htmlImg);
		    
		    //数据表格内容
		    String htmlTable="";
		    int tableLine=1;
		    for (TableBean testBean : pib.getTableList()) {
				if(tableLine%2==1){
					htmlTable+="<tr style='background: #8AE5F1'>"+
					"<td width='25%' align='center'>"+testBean.getTableName()+"</td>"+
					"<td width='75%' align='center' class='erCode'>"+testBean.getTableValue()+"</td>"+
				"</tr>";
				}else{
					htmlTable+="<tr style='background: wheat'>"+
					"<td width='25%' align='center'>"+testBean.getTableName()+"</td>"+
					"<td width='75%' align='center' class='erCode'>"+testBean.getTableValue()+"</td>"+
				"</tr>";
				}
				tableLine++;
			}
		    htmlCode=htmlCode.replaceAll("###infoTable###", htmlTable);
		    
		    htmlCode=htmlCode.replaceAll("###content###", content);
			/*System.out.println("html代码:\n"+htmlCode);*/
			//生成html
			byte tag_bytes[] = htmlCode.getBytes("utf-8");
		    fileoutputstream.write(tag_bytes);
		    fileoutputstream.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"没有找到");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"读取错误");
		}
	}
	
	public static void test_to_html_scanner(String content,PageInfoBean pib,String pageName,String pageID){
		String pname=pib.getResType();
		if(pib.getResType().equals("pic")){
			if(!(pib.getDingwei()!=null&&pib.getDingwei().equals(""))){
				pname+="_nomap";
			}
		}
		//模板文件路径
		String Modelpath=GetProjectPath.getRootPath()+"/page/html/123index_"+pib.getResType()+".html";
		//输出文件路径
		String OutputpathDir=GetProjectPath.getRootPath()+"/page/scanner/"+pageID+"/";
		String Outputpath=OutputpathDir+pageName+".html";
		File dirFile=new File(OutputpathDir);
		if(!dirFile.exists()){
			dirFile.mkdirs();
		}
		
		//html代码
		String htmlCode="";
		/*System.out.println("content:"+content);
		System.out.println(Outputpath);*/
		
		//开始静态化
		FileInputStream fileinputstream;
		try {
			fileinputstream = new FileInputStream(Modelpath);
			FileOutputStream fileoutputstream = new FileOutputStream(Outputpath);// 建立文件输出流
			// 读取模板文件
		    int lenght = fileinputstream.available();
		    byte bytes[] = new byte[lenght];
		    fileinputstream.read(bytes);
		    fileinputstream.close();
		    htmlCode = new String(bytes);
		    htmlCode=new String(htmlCode.getBytes(), "utf-8");
		    
		    htmlCode=htmlCode.replaceAll("###name###", pib.getName());
		    String palyBtn="";
		    if(pib.getAudioPath()!=null){
		    	htmlCode=htmlCode.replaceAll("###audio###", pib.getAudioPath());
		    	if(!pib.getAudioPath().equals("")){
		    		palyBtn="<a href='javascript:void();' onclick='music();' id='audioplay' ><img src='page/html/34/play.png' class='icon' width='33' height='33' style='position: relative;top: 3px;left: 30px' border='0' alt=''></a>";
		    	}
		    }
		    htmlCode=htmlCode.replaceAll("###audioBtn###", palyBtn);

		    if(pib.getDingwei()!=null){
		    	htmlCode=htmlCode.replaceAll("###dingwei###", pib.getDingwei());
		    }else{
		    	htmlCode=htmlCode.replaceAll("###dingwei###", "");
		    }
		    	
		    //链接列表
		    String htmlLink="";
		    for (String page : pib.getPageList()) {
		    	htmlLink+="<td>"+
				"<img pid='"+pageID+"' pname='"+page+"' class='pbtn' src='page/html/34/"+page+".png' style='margin-left:10px;'  width='64' height='89' border='0' alt=''>"+
				"</td>";
			}
		    
		    htmlCode=htmlCode.replaceAll("###pageList###", htmlLink);
		    String htmlImg="";
		    //图片数据
		    if(pib.getResType().equals("pic")){
			    for (ImgBean img : pib.getImgScannerList()) {
					htmlImg+="<li class='jcarousel-item jcarousel-item-horizontal jcarousel-item-1 jcarousel-item-1-horizontal' style='float: left; list-style: none;'>"+
					"<div class='clip'>"+
					"<img class='icon' src='"+img.getImgT()+"' srcs='"+img.getImgS()+"' style='display: inline; width: 100%; '>"+
					"</div>"+
					"</li>";
				}
			    htmlCode=htmlCode.replaceAll("###imgList###", htmlImg);
		    }
		    
		    //视频
		    if(pib.getResType().equals("video")){
		    	htmlCode=htmlCode.replaceAll("###video###", pib.getVideoPath());
		    }
		    
		    
		    //实验
		    if(pib.getResType().equals("shiyan")){
		    	if(pib.getShiyanList()!=null&&pib.getShiyanList().size()>0){
			    	ShiyanBean shiyan=pib.getShiyanList().get(0);
			    	htmlCode=htmlCode.replaceAll("###shiyan###", shiyan.getShiyanPath());
			    }
		    }
		    
		    
		    //多維
		    if(pib.getResType().equals("duowei")){
		    	if(pib.getDuoweiList()!=null&&pib.getDuoweiList().size()>0){
			    	DuoweiBean duowei=pib.getDuoweiList().get(0);
			    	htmlCode=htmlCode.replaceAll("###model###", duowei.getMode());
			    	htmlCode=htmlCode.replaceAll("###filePath###", duowei.getFilePath());
			    	htmlCode=htmlCode.replaceAll("###info###", duowei.getInfo());
			    }
		    }
		    
		    
		  //文档
		    if(pib.getResType().equals("wendang")){
		    	 htmlImg="";
				    if(pib.getWendangList()!=null&&pib.getWendangList().size()>0){
				    	WendangBean wbNow=pib.getWendangList().get(0);
				    	for(int i=1;i<=wbNow.getFileLength();i++){
				    		htmlImg+="<li class='jcarousel-item jcarousel-item-horizontal jcarousel-item-1 jcarousel-item-1-horizontal' style='float: left; list-style: none;'>"+
							"<div class='clip'>"+
							"<img class='icon' src='"+wbNow.getFilePath()+i+".jpg' srcs='"+wbNow.getFilePath()+i+".jpg' style='display: inline; height: 100%; '>"+
							"</div>"+
							"</li>";
				    	}
				    }
				    htmlCode=htmlCode.replaceAll("###wendangImgList###", htmlImg);
		    }
		   
		    
		    //数据表格内容
		    String htmlTable="";
		    int tableLine=1;
		    for (TableBean testBean : pib.getTableList()) {
				if(tableLine%2==1){
					htmlTable+="<tr style='background: #8AE5F1'>"+
					"<td width='25%' align='center'>"+testBean.getTableName()+"</td>"+
					"<td width='75%' align='center' class='erCode'>"+testBean.getTableValue()+"</td>"+
				"</tr>";
				}else{
					htmlTable+="<tr style='background: wheat'>"+
					"<td width='25%' align='center'>"+testBean.getTableName()+"</td>"+
					"<td width='75%' align='center' class='erCode'>"+testBean.getTableValue()+"</td>"+
				"</tr>";
				}
				tableLine++;
			}
		    htmlCode=htmlCode.replaceAll("###infoTable###", htmlTable);
		    
		    //content=java.net.URLDecoder.decode(content, "utf-8");
		    
		    htmlCode=htmlCode.replaceAll("###content###", content);
			//System.out.println("html代码:\n"+htmlCode);
			//生成html
			byte tag_bytes[] = htmlCode.getBytes("utf-8");
		    fileoutputstream.write(tag_bytes);
		    fileoutputstream.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"没有找到");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"读取错误");
		}
	}
	
	public static void test_to_html_pic(PageInfoBean pib,String pageName,String pageID){
		//模板文件路径
		String Modelpath=GetProjectPath.getRootPath()+"/page/html/123pic.html";
		//输出文件路径
		String OutputpathDir=GetProjectPath.getRootPath()+"/page/scanner/"+pageID+"/";
		String Outputpath=OutputpathDir+pageName+".html";
		File dirFile=new File(OutputpathDir);
		if(!dirFile.exists()){
			dirFile.mkdirs();
		}
		
		//html代码
		String htmlCode="";
		//System.out.println(Outputpath);
		
		//开始静态化
		FileInputStream fileinputstream;
		try {
			fileinputstream = new FileInputStream(Modelpath);
			FileOutputStream fileoutputstream = new FileOutputStream(Outputpath);// 建立文件输出流
			// 读取模板文件
		    int lenght = fileinputstream.available();
		    byte bytes[] = new byte[lenght];
		    fileinputstream.read(bytes);
		    fileinputstream.close();
		    htmlCode = new String(bytes);
		    htmlCode=new String(htmlCode.getBytes(), "utf-8");
		    
		    htmlCode=htmlCode.replaceAll("###name###", pib.getName());
		    String palyBtn="";
		    if(pib.getAudioPath()!=null){
		    	htmlCode=htmlCode.replaceAll("###audio###", pib.getAudioPath());
		    	if(!pib.getAudioPath().equals("")){
		    		palyBtn="<a href='javascript:void();' onclick='music();' id='audioplay' ><img src='page/html/34/play.png' class='icon' width='33' height='33' style='position: relative;top: 3px;left: 30px' border='0' alt=''></a>";
		    	}
		    }
		    htmlCode=htmlCode.replaceAll("###audioBtn###", palyBtn);
		    if(pib.getDingwei()!=null){
		    	htmlCode=htmlCode.replaceAll("###dingwei###", pib.getDingwei());
		    }else{
		    	htmlCode=htmlCode.replaceAll("###dingwei###", "");
		    }
		    	
		    //链接列表
		    String htmlLink="";
		    for (String page : pib.getPageList()) {
		    	htmlLink+="<td>"+
				"<img pid='"+pageID+"' pname='"+page+"' class='pbtn' src='page/html/34/"+page+".png' style='margin-left:10px;'  width='64' height='89' border='0' alt=''>"+
				"</td>";
			}
		    
		    htmlCode=htmlCode.replaceAll("###pageList###", htmlLink);
		    //图片数据
		    String htmlImg="";
		    for (ImgBean img : pib.getImgList()) {
				htmlImg+="<li class='jcarousel-item jcarousel-item-horizontal jcarousel-item-1 jcarousel-item-1-horizontal' style='float: left; list-style: none;'>"+
				"<div class='clip'>"+
				"<img class='icon' src='"+img.getImgT()+"' srcs='"+img.getImgS()+"' style='display: inline; width: 100%; '>"+
				"</div>"+
				"</li>";
			}
		    htmlCode=htmlCode.replaceAll("###imgList###", htmlImg);
		    
		    
		    //数据表格内容
		    String htmlTable="";
		    int tableLine=1;
		    for (TableBean testBean : pib.getTableList()) {
				if(tableLine%2==1){
					htmlTable+="<tr style='background: #8AE5F1'>"+
					"<td width='25%' align='center'>"+testBean.getTableName()+"</td>"+
					"<td width='75%' align='center' class='erCode'>"+testBean.getTableValue()+"</td>"+
				"</tr>";
				}else{
					htmlTable+="<tr style='background: wheat'>"+
					"<td width='25%' align='center'>"+testBean.getTableName()+"</td>"+
					"<td width='75%' align='center' class='erCode'>"+testBean.getTableValue()+"</td>"+
				"</tr>";
				}
				tableLine++;
			}
		    htmlCode=htmlCode.replaceAll("###infoTable###", htmlTable);
		    
			/*System.out.println("html代码:\n"+htmlCode);*/
			//生成html
			byte tag_bytes[] = htmlCode.getBytes("utf-8");
		    fileoutputstream.write(tag_bytes);
		    fileoutputstream.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"没有找到");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"读取错误");
		}
	}
	
	public static void test_to_html_video(PageInfoBean pib,String pageName,String pageID){
		//模板文件路径
		String Modelpath=GetProjectPath.getRootPath()+"/page/html/123shipin.html";
		//输出文件路径
		String OutputpathDir=GetProjectPath.getRootPath()+"/page/scanner/"+pageID+"/";
		String Outputpath=OutputpathDir+pageName+".html";
		File dirFile=new File(OutputpathDir);
		if(!dirFile.exists()){
			dirFile.mkdirs();
		}
		//html代码
		String htmlCode="";
		/*System.out.println(Outputpath);*/
		
		//开始静态化
		FileInputStream fileinputstream;
		try {
			fileinputstream = new FileInputStream(Modelpath);
			FileOutputStream fileoutputstream = new FileOutputStream(Outputpath);// 建立文件输出流
			// 读取模板文件
		    int lenght = fileinputstream.available();
		    byte bytes[] = new byte[lenght];
		    fileinputstream.read(bytes);
		    fileinputstream.close();
		    htmlCode = new String(bytes);
		    htmlCode=new String(htmlCode.getBytes(), "utf-8");
		    
		    htmlCode=htmlCode.replaceAll("###name###", pib.getName());
		    
		    //链接列表
		    String htmlLink="";
		    for (String page : pib.getPageList()) {
		    	htmlLink+="<td>"+
				"<img pid='"+pageID+"' pname='"+page+"' class='pbtn' src='page/html/34/"+page+".png' style='margin-left:10px;'  width='64' height='89' border='0' alt=''>"+
				"</td>";
			}
		    
		    htmlCode=htmlCode.replaceAll("###pageList###", htmlLink);
		    //图片数据
		    String htmlImg="";
		    for (ImgBean img : pib.getImgList()) {
				htmlImg+="<li class='jcarousel-item jcarousel-item-horizontal jcarousel-item-1 jcarousel-item-1-horizontal' style='float: left; list-style: none;'>"+
				"<div class='clip'>"+
				"<img class='icon' src='"+img.getImgT()+"' srcs='"+img.getImgS()+"' style='display: inline; width: 100%; '>"+
				"</div>"+
				"</li>";
			}
		    htmlCode=htmlCode.replaceAll("###imgList###", htmlImg);
		    
		    //视频数据
		    htmlCode=htmlCode.replaceAll("###video###", pib.getVideoPath());
		    String htmlVideo="";
		    for (VideoBean video : pib.getVideoList()) {
		    	htmlVideo+="<li style='text-align: center;' vp='"+video.getVideoPath()+"'>"+
				"<img class='icon vp' src='"+video.getVideoImg()+"' srcs='"+video.getVideoPath()+"'  width='152' height='100' border='0' alt=''>"+
				"<br/>"+
				"<span>"+video.getVideoName()+"</span>"+
				"<li>";
			}
		    htmlCode=htmlCode.replaceAll("###videoList###", htmlVideo);
		    //数据表格内容
		    String htmlTable="";
		    int tableLine=1;
		    for (TableBean testBean : pib.getTableList()) {
				if(tableLine%2==1){
					htmlTable+="<tr style='background: #8AE5F1'>"+
					"<td width='25%' align='center'>"+testBean.getTableName()+"</td>"+
					"<td width='75%' align='center' class='erCode'>"+testBean.getTableValue()+"</td>"+
				"</tr>";
				}else{
					htmlTable+="<tr style='background: wheat'>"+
					"<td width='25%' align='center'>"+testBean.getTableName()+"</td>"+
					"<td width='75%' align='center' class='erCode'>"+testBean.getTableValue()+"</td>"+
				"</tr>";
				}
				tableLine++;
			}
		    htmlCode=htmlCode.replaceAll("###infoTable###", htmlTable);
		    
			/*System.out.println("html代码:\n"+htmlCode);*/
			//生成html
			byte tag_bytes[] = htmlCode.getBytes("utf-8");
		    fileoutputstream.write(tag_bytes);
		    fileoutputstream.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"没有找到");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"读取错误");
		}
		
	}
	
	public static void test_to_html_shiyan(PageInfoBean pib,String pageName,String pageID){
		//模板文件路径
		String Modelpath=GetProjectPath.getRootPath()+"/page/html/123shiyan.html";
		//输出文件路径
		String OutputpathDir=GetProjectPath.getRootPath()+"/page/scanner/"+pageID+"/";
		String Outputpath=OutputpathDir+pageName+".html";
		File dirFile=new File(OutputpathDir);
		if(!dirFile.exists()){
			dirFile.mkdirs();
		}
		//html代码
		String htmlCode="";
		/*System.out.println(Outputpath);*/
		
		//开始静态化
		FileInputStream fileinputstream;
		try {
			fileinputstream = new FileInputStream(Modelpath);
			FileOutputStream fileoutputstream = new FileOutputStream(Outputpath);// 建立文件输出流
			// 读取模板文件
		    int lenght = fileinputstream.available();
		    byte bytes[] = new byte[lenght];
		    fileinputstream.read(bytes);
		    fileinputstream.close();
		    htmlCode = new String(bytes);
		    htmlCode=new String(htmlCode.getBytes(), "utf-8");
		    
		    htmlCode=htmlCode.replaceAll("###name###", pib.getName());
		    
		    //链接列表
		    String htmlLink="";
		    for (String page : pib.getPageList()) {
		    	htmlLink+="<td>"+
				"<img pid='"+pageID+"' pname='"+page+"' class='pbtn' src='page/html/34/"+page+".png' style='margin-left:10px;'  width='64' height='89' border='0' alt=''>"+
				"</td>";
			}
		    
		    htmlCode=htmlCode.replaceAll("###pageList###", htmlLink);
		    //实验
		    if(pib.getShiyanList().size()>0){
		    	ShiyanBean shiyan=pib.getShiyanList().get(0);
		    	htmlCode=htmlCode.replaceAll("###shiyan###", shiyan.getShiyanPath());
		    }
		    //实验列表
		    String htmlVideo="";
		    for (ShiyanBean shiyan : pib.getShiyanList()) {
		    	htmlVideo+="<li style='text-align: center;' >"+
				"<img class='icon vp' src='34/xuni.png' fpath='"+shiyan.getShiyanPath()+"'  width='152' height='100' border='0' alt=''>"+
				"<br/>"+
				"<span>"+shiyan.getShiyanName()+"</span>"+
				"<li>";
			}
		    htmlCode=htmlCode.replaceAll("###shiyanList###", htmlVideo);
		    
			/*System.out.println("html代码:\n"+htmlCode);*/
			//生成html
			byte tag_bytes[] = htmlCode.getBytes("utf-8");
		    fileoutputstream.write(tag_bytes);
		    fileoutputstream.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"没有找到");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"读取错误");
		}
		
	}
	
	public static void test_to_html_duowei(PageInfoBean pib,String pageName,String pageID){
		//模板文件路径
		String Modelpath=GetProjectPath.getRootPath()+"/page/html/123duowei.html";
		//输出文件路径
		String OutputpathDir=GetProjectPath.getRootPath()+"/page/scanner/"+pageID+"/";
		String Outputpath=OutputpathDir+pageName+".html";
		File dirFile=new File(OutputpathDir);
		if(!dirFile.exists()){
			dirFile.mkdirs();
		}
		//html代码
		String htmlCode="";
		/*System.out.println(Outputpath);*/
		
		//开始静态化
		FileInputStream fileinputstream;
		try {
			fileinputstream = new FileInputStream(Modelpath);
			FileOutputStream fileoutputstream = new FileOutputStream(Outputpath);// 建立文件输出流
			// 读取模板文件
		    int lenght = fileinputstream.available();
		    byte bytes[] = new byte[lenght];
		    fileinputstream.read(bytes);
		    fileinputstream.close();
		    htmlCode = new String(bytes);
		    htmlCode=new String(htmlCode.getBytes(), "utf-8");
		    
		    
		    htmlCode=htmlCode.replaceAll("###name###", pib.getName());
		    
		    //链接列表
		    String htmlLink="";
		    for (String page : pib.getPageList()) {
		    	htmlLink+="<td>"+
				"<img pid='"+pageID+"' pname='"+page+"' class='pbtn' src='page/html/34/"+page+".png' style='margin-left:10px;'  width='64' height='89' border='0' alt=''>"+
				"</td>";
			}
		    
		    htmlCode=htmlCode.replaceAll("###pageList###", htmlLink);
		    //多維
		    if(pib.getDuoweiList().size()>0){
		    	DuoweiBean duowei=pib.getDuoweiList().get(0);
		    	htmlCode=htmlCode.replaceAll("###model###", duowei.getMode());
		    	htmlCode=htmlCode.replaceAll("###filePath###", duowei.getFilePath());
		    	htmlCode=htmlCode.replaceAll("###info###", duowei.getInfo());
		    }
		    //多維列表
		    String htmlVideo="";
		    for (DuoweiBean duowei : pib.getDuoweiList()) {
		    	htmlVideo+="<li style='text-align: center;' >"+
				"<img class='icon vp' src='"+duowei.getImg()+"' fpath='"+duowei.getFilePath()+"'  fmode='"+duowei.getMode()+"'  finfo='"+duowei.getInfo()+"' width='152' height='100' border='0' alt=''>"+
				"<br/>"+
				"<span>"+duowei.getName()+"</span>"+
				"<li>";
			}
		    htmlCode=htmlCode.replaceAll("###duoweiList###", htmlVideo);
		    
			/*System.out.println("html代码:\n"+htmlCode);*/
			//生成html
			byte tag_bytes[] = htmlCode.getBytes("utf-8");
		    fileoutputstream.write(tag_bytes);
		    fileoutputstream.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"没有找到");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"读取错误");
		}
		
	}
	
	public static void test_to_html_wendang(PageInfoBean pib,String pageName,String pageID){
		//模板文件路径
		String Modelpath=GetProjectPath.getRootPath()+"/page/html/123wendang.html";
		//输出文件路径
		String OutputpathDir=GetProjectPath.getRootPath()+"/page/scanner/"+pageID+"/";
		String Outputpath=OutputpathDir+pageName+".html";
		File dirFile=new File(OutputpathDir);
		if(!dirFile.exists()){
			dirFile.mkdirs();
		}
		//html代码
		String htmlCode="";
		/*System.out.println(Outputpath);*/
		
		//开始静态化
		FileInputStream fileinputstream;
		try {
			fileinputstream = new FileInputStream(Modelpath);
			FileOutputStream fileoutputstream = new FileOutputStream(Outputpath);// 建立文件输出流
			// 读取模板文件
		    int lenght = fileinputstream.available();
		    byte bytes[] = new byte[lenght];
		    fileinputstream.read(bytes);
		    fileinputstream.close();
		    htmlCode = new String(bytes);
		    htmlCode=new String(htmlCode.getBytes(), "utf-8");
		    
		    
		    htmlCode=htmlCode.replaceAll("###name###", pib.getName());
		    
		    //链接列表
		    String htmlLink="";
		    for (String page : pib.getPageList()) {
		    	htmlLink+="<td>"+
				"<img pid='"+pageID+"' pname='"+page+"' class='pbtn' src='page/html/34/"+page+".png' style='margin-left:10px;'  width='64' height='89' border='0' alt=''>"+
				"</td>";
			}
		    
		    htmlCode=htmlCode.replaceAll("###pageList###", htmlLink);
		    //图片展示
		    String htmlImg="";
		    if(pib.getWendangList().size()>0){
		    	WendangBean wbNow=pib.getWendangList().get(0);
		    	for(int i=1;i<=wbNow.getFileLength();i++){
		    		htmlImg+="<li class='jcarousel-item jcarousel-item-horizontal jcarousel-item-1 jcarousel-item-1-horizontal' style='float: left; list-style: none;'>"+
					"<div class='clip'>"+
					"<img class='icon' src='"+wbNow.getFilePath()+i+".jpg' srcs='"+wbNow.getFilePath()+i+".jpg' style='display: inline; height: 100%; '>"+
					"</div>"+
					"</li>";
		    	}
		    }
		    htmlCode=htmlCode.replaceAll("###wendangImgList###", htmlImg);
		    
		    //文档列表
		    String htmlVideo="";
		    for (WendangBean wendang : pib.getWendangList()) {
		    	htmlVideo+="<li style='text-align: center;' >"+
				"<img class='icon vp' src='page/html/34/"+pib.getListIcon()+".png' fpath='"+wendang.getFilePath()+"' flength='"+wendang.getFileLength()+"'  width='152' height='100' border='0' alt=''>"+
				"<br/>"+
				"<span>"+wendang.getFileName()+"</span>"+
				"<li>";
			}
		    htmlCode=htmlCode.replaceAll("###wendangList###", htmlVideo);
		    //数据表格内容
		    String htmlTable="";
		    int tableLine=1;
		    for (TableBean testBean : pib.getTableList()) {
				if(tableLine%2==1){
					htmlTable+="<tr style='background: #8AE5F1'>"+
					"<td width='25%' align='center'>"+testBean.getTableName()+"</td>"+
					"<td width='75%' align='center' class='erCode'>"+testBean.getTableValue()+"</td>"+
				"</tr>";
				}else{
					htmlTable+="<tr style='background: wheat'>"+
					"<td width='25%' align='center'>"+testBean.getTableName()+"</td>"+
					"<td width='75%' align='center' class='erCode'>"+testBean.getTableValue()+"</td>"+
				"</tr>";
				}
				tableLine++;
			}
		    htmlCode=htmlCode.replaceAll("###infoTable###", htmlTable);
		    
			/*System.out.println("html代码:\n"+htmlCode);*/
			//生成html
			byte tag_bytes[] = htmlCode.getBytes("utf-8");
		    fileoutputstream.write(tag_bytes);
		    fileoutputstream.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"没有找到");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err.println("模板文件"+Modelpath+"读取错误");
		}
		
	}
	
	public static void create_to_html(String directory,String pageName,String url){
		String directoryPath=GetProjectPath.getRootPath()+"/page/"+directory+"/";
		String pagePath=GetProjectPath.getRootPath()+"/page/"+directory+"/"+pageName;
		File dirFile=new File(directoryPath);
		if(!dirFile.exists()){
			dirFile.mkdirs();
		}
		MakeHtml.writeHtml(pagePath, MakeHtml.getHtmlCode(url), false);
		
	}
	
	public static boolean hasPage(String directory,String pageName){
		String pagePath=GetProjectPath.getRootPath()+"/page/"+directory+"/"+pageName;
		File pageFile=new File(pagePath);
		return pageFile.exists();
	}
}
