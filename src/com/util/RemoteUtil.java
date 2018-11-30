package com.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import com.ow.framework.listener.event.impl.GetpcInfo;
import com.ow.framework.util.Encrypt;

public class RemoteUtil {

	public static int getRemoteInfo(){
		int ans=2;
		String remoteName="information";
		String remoteDirPath=System.getProperties().getProperty("user.home")+"\\Digital\\DigitalMuseum\\";
		File remoteFile=new File(remoteDirPath+remoteName);
		if(!remoteFile.exists()){
			ans= -1;
		}else{
			try {
				FileReader fr=new FileReader(remoteFile);
				BufferedReader reader=new BufferedReader(fr);
				String up=reader.readLine();
				if(up.equals(writerootvalue())){
					ans= 0;
				}else{
					ans= 1;
				}
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		return ans;
	}
	
	public static void remoteSystem(){
		System.out.println(System.getProperties().getProperty("user.home"));
		String remoteName="information";
		String remoteDirPath=System.getProperties().getProperty("user.home")+"\\Digital\\DigitalMuseum\\";
		File remoteDir=new File(remoteDirPath);
		remoteDir.mkdirs();
		File remoteFile=new File(remoteDirPath+remoteName);
		if(!remoteFile.exists()){
			try {
				remoteFile.createNewFile();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				System.err.println("生成注册文件失败");
				e.printStackTrace();
			}
		}
		FileWriter fw=null;
		try {
			fw=new FileWriter(remoteFile);
			fw.write(writerootvalue());
			fw.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(fw!=null)
				try {
					fw.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
		}
		
		
	}
	
	public static String writerootvalue(){
		String up = GetpcInfo.getCPUSerial()+GetpcInfo.getMotherboardSN();
	 	return Encrypt.getMD5(up);
	}
}
