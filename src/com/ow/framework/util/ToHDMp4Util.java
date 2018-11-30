package com.ow.framework.util;

import java.io.File;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import java_cup.internal_error;

import org.apache.ibatis.session.SqlSession;

import com.ow.framework.data.dao.SessionFactory;
import com.ow.framework.listener.event.EventExecutor;

public class ToHDMp4Util implements Runnable {
	private String video;
	private String path;
	private String outputpath;
	private String dsname;
	private String resType;
	public ToHDMp4Util(String video,String path,String outputpath,String dsname,String resType){
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

	@Override
	public void run() {
		// TODO Auto-generated method stub
		String videoRealPath = this.video;
		//String videoRealPath = this.outputpath+".avs";
		String output_tmp = this.outputpath+"_tmp.mp4";
		String output_HD = this.outputpath+".mp4";
		String output_LD = this.outputpath+"_LD.mp4";
		// 截图的路径（输出路径）
		//String imageRealPath = "d:\\"+ video.substring(video.lastIndexOf("\\"),video.lastIndexOf(".")) + ".flv";
		
		List<String> commend = new java.util.ArrayList<String>();
		//commend.add(this.path);
		commend.add(this.path+"toHD_mp4.bat");
		commend.add(videoRealPath);
		commend.add(output_tmp);
		commend.add(output_HD);
		
		HashMap paramMap = new HashMap<Object, Object>();
		String roomType=StringUtil.reResAbbreviated(resType);
		int state=0;
			//HD
			ProcessBuilder builder = new ProcessBuilder();
			builder.command(commend);
			builder.redirectErrorStream(true);
			System.out.println("视频源:"+this.video);
			System.out.println(" 视频转码开始 ...");
			// builder.start();
			
			try{
				//HD
				Process process= builder.start();
				InputStream in = process.getInputStream();
				byte[] re = new byte[1024];
				System.out.println(" 正在进行转码高清视频，请稍候 ");
				while (in.read(re) != -1) {
					System.out.print(".");
				}
				System.out.println("");
				if(null!=in)
					in.close();
				
				System.err.println(" 高清视频转码完成 ...");
				//ScreenshotUtil ss=new ScreenshotUtil(output_HD,this.path,this.outputpath,this.dsname,this.resType);
				state+=1;
			} catch (Exception e) {
				System.err.println("高清视频转码失败");
			}finally{
				File fi=new File(output_tmp);
				if(fi.exists())
					fi.delete();
			}
			
		try {
			paramMap.put(roomType+"Upload", video.substring(video.lastIndexOf("upload"))) ;
			paramMap.put(roomType+"FileSwf", this.outputpath.substring(this.outputpath.lastIndexOf("\\")+1)+"_LD.mp4") ;
			paramMap.put(roomType+"State", state);
			SqlSession sqlsession=SessionFactory.getInstance().getSQLSession(dsname);
			int st=(Integer)sqlsession.selectOne(resType+".select_state", paramMap);
			System.out.println(st);
			if(st!=4){
				paramMap.put(roomType+"State", state+st);
			}
			int r=sqlsession.update(resType+".update_state", paramMap) ;
			//System.out.println(r);
			sqlsession.commit();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			//System.err.println("视频转换状态更新失败");
		}
		//int rvalue = DBUtil.updatState(eventExecutor, paramMap);
		//LD转码
		ToLDMp4Util toMp4ld=new ToLDMp4Util(this.video,this.path,this.outputpath,this.dsname,this.resType,state);
		Thread temp_tld=new Thread(toMp4ld);
		temp_tld.start();
	}

	/*public static void main(String[] args) {
		toFlv("D:\\1.wmv");
	}
*/
}
