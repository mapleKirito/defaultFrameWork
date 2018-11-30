package com.ow.framework.util;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.tools.ant.taskdefs.Sleep;

import com.ow.framework.data.dao.SessionFactory;
import com.ow.module.event.sysmgr.laboratory.LaboratoryUploadHelp;

public class ToPicUtil implements Runnable {
	private String fileRealPath;
	private String upload;
	private String savepath;
	private String resType;
	private HashMap paramMap;
	private String dsname;
	
	


	public ToPicUtil(String fileRealPath, String upload, String savepath,
			String resType, HashMap paramMap,String dsname) {
		this.fileRealPath = fileRealPath;
		this.upload = upload;
		this.savepath = savepath;
		this.resType = resType;
		this.paramMap = paramMap;
		this.dsname=dsname;
	}




	/*public static HashMap toFlv(String video,String path,String outputpath) {
		HashMap rtnMap = new HashMap();
		// 视频文件
		String videoRealPath = video;
		// 截图的路径（输出路径）
		//String imageRealPath = "d:\\"+ video.substring(video.lastIndexOf("\\"),video.lastIndexOf(".")) + ".flv";
		List<String> commend = new java.util.ArrayList<String>();
		commend.add(path);
		commend.add("-i");
		commend.add(videoRealPath);
		commend.add("-ar");
		commend.add("22050");
		commend.add("-ab");
		commend.add("56");
		commend.add("-f");
		commend.add("flv");
		commend.add("-y");
		commend.add("-s");
		commend.add("1920*1080");
		commend.add(outputpath);
		try {
			ProcessBuilder builder = new ProcessBuilder();
			builder.command(commend);
			builder.redirectErrorStream(true);
			System.out.println(" 视频转码开始 ...");
			// builder.start();
			Process process = builder.start();
			InputStream in = process.getInputStream();
			byte[] re = new byte[1024];

			System.out.print(" 正在进行转码，请稍候 ");
			while (in.read(re) != -1) {
				System.out.print(".");
			}
			System.out.println("");
			in.close();
			System.out.println(" 视频转码完成 ...");
		} catch (Exception e) {
			rtnMap.put("error", "0");
		}
		
		return rtnMap;
	}*/



	@Override
	public void run() {
	    
		String roomType=StringUtil.reResAbbreviated(resType);
		try {
			LaboratoryUploadHelp.laboratoryHandlePptDocPdf(fileRealPath, upload, savepath, resType, paramMap,"");
			String orType=(String) paramMap.get("orType");
			if("2033".equals(orType) ||"2041".equals(orType)||"2055".equals(orType)){
			Thread.sleep(3000);
			}
			paramMap.put(roomType+"State", "3");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			paramMap.put(roomType+"State", "0");
		} 
		
		try {
			//System.out.println(paramMap);
			SqlSession sqlsession=SessionFactory.getInstance().getSQLSession(dsname);
			int r=sqlsession.update(resType+".update_state", paramMap) ;
			System.out.println("转换成功与否代表数字："+r+"时间是："+new java.text.SimpleDateFormat("yy-MM-dd HH:mm:ss").format(new java.util.Date()));
			sqlsession.commit();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			//System.err.println("文档转换状态更新失败");
		}
	}

	/*public static void main(String[] args) {
		toFlv("D:\\1.wmv");
	}
*/
}
