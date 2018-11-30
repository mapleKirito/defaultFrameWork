package com.SmartServer.util;

import com.SmartServer.Biz.biz;
import com.ow.framework.listener.event.impl.GODEvent;
import com.ow.framework.listener.event.impl.KeyTransition;
import com.util.RemoteUtil;

public class ModuleStatesUtils {
	public static String getStates(){
		String ans="";
		int[] indexKey = KeyTransition.decode();
		biz b = new biz();
		int key = indexKey[indexKey.length-1];
		String s = Integer.toString((b.getModuleStates(key)));
		if(GODEvent.getInstancegod()){
			//演示版状态 -1非演示版
			int DemoState=KeyTransition.getDemoState();
			if(DemoState==-1){
				/*String read_s = b.StoreRead(0,32).trim();
				String value = SmartWebServer.writerootvalue();*/
				/*老版本绑定机器到加密狗*/
				/*if(s.equals("1") || !read_s.equals(value)){*/
				//新版本绑定注册机器
				if(s.equals("1") ||RemoteUtil.getRemoteInfo()==-1){
					ans="1";
					/*
					Date t = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
					byte[] pBuffer = sdf.format(t).getBytes();
					String write_s = b.StoreWrite(4, pBuffer);//写入第一次登录时间
	*/				
				}else if(RemoteUtil.getRemoteInfo()==1){
					ans="6";
					
				}else{
					if(SmartWebServer.getInstancegodTime()==0){
						ans="3";
					}else if(SmartWebServer.getInstancegodTime()==2){
						ans="4";
					}
				}
				
			}else{
				if(DemoState==0){
					ans="demo0";
				}else if(DemoState==1){
					ans="demo1";
				}else if(DemoState==2){
					ans="demo2";
				}
				
			}
			
			
		}else{
			ans="5";
		}

		return ans;
		
	}
}
