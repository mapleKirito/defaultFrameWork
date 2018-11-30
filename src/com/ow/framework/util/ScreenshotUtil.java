package com.ow.framework.util;

import java.io.File;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import java_cup.internal_error;

import org.apache.ibatis.session.SqlSession;

import com.ow.framework.data.dao.SessionFactory;
import com.ow.framework.listener.event.EventExecutor;

public class ScreenshotUtil {
	private String video;
	private String path;
	private String outputpath;
	private String dsname;
	private String resType;
	public ScreenshotUtil(String video,String path,String outputpath,String dsname,String resType){
		this.video=video;
		this.path=path;
		this.outputpath=outputpath;
		this.dsname=dsname;
		this.resType=resType;
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

	public void run() {
		// TODO Auto-generated method stub
		// 截图的路径（输出路径）
		//String imageRealPath = "d:\\"+ video.substring(video.lastIndexOf("\\"),video.lastIndexOf(".")) + ".flv";
		
		List<String> commend = new java.util.ArrayList<String>();
		commend.add("ffmpeg.exe");
		commend.add("-i");
		commend.add(this.video);
		commend.add("-y");
		commend.add("-f");
		commend.add("image2");
		commend.add("-ss");
		commend.add("00:00:09");
		commend.add("-vframes");
		commend.add("1");
		commend.add("-s");
		commend.add("380*250");
		commend.add(outputpath+"_thum.jpg");
		
		HashMap paramMap = new HashMap<Object, Object>();
		String roomType=StringUtil.reResAbbreviated(resType);
			//HD
			ProcessBuilder builder = new ProcessBuilder();
			builder.command(commend);
			builder.redirectErrorStream(true);
			System.out.println("视频源:"+this.video);
			System.out.println(" 视频截图开始 ...");
			// builder.start();
			
			try{
				//HD
				Process process= builder.start();
				InputStream in = process.getInputStream();
				byte[] re = new byte[1024];
				System.out.println(" 正在生成截图，请稍候 ");
				while (in.read(re) != -1) {
					System.out.print(".");
				}
				System.out.println("");
				if(null!=in)
					in.close();
				
				System.err.println(" 截图完成 ...");
			} catch (Exception e) {
				e.printStackTrace();
				System.err.println("截图失败");
			}
			
		//int rvalue = DBUtil.updatState(eventExecutor, paramMap);
	}

	/*public static void main(String[] args) {
		toFlv("D:\\1.wmv");
	}
*/
}
