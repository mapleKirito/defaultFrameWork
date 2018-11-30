package com.ow.framework.listener.event.impl;

import com.SmartServer.Biz.biz;
import com.SmartServer.util.SmartWebServer;
import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.util.Encrypt;

public class GODEvent {
	public static String getInstance(SmartWebServer dog,String password){
		dog = SmartWebServer.getInstance();	//获取加密锁引用
		byte[] SHA1Val = new byte[64];
		int i = dog.SHA1WithSeed(password, SHA1Val);	//将用户密码转换成SHA1值
		if(ConstantI.ISGOD_KEY.equals("1")){
			if (0==i) {
				password = SmartWebServer.b2s(SHA1Val);	//将SHA1值转换成字符串类型
			}
		}else{
			if (!"".equals(password) && password != null)
				password = Encrypt.getMD5(password.trim());
		}
		return password;
	}
	
	public static String setKeyWords(String key){
		try {
			return Encrypt.encrypt(key);
		} catch (Exception e) {
			return "";
		}
	}
	
	public static String getKeyWords(String key){
		try {
			return Encrypt.decrypt(key);
		} catch (Exception e) {
			return "";
		}
	}
	
	public static boolean getgetInstanceTF(){
		/*int[] Key = (int[]) KeyTransition.decode();
		boolean SmartTF = false; 
		biz b = new biz();
		for (int j = 0; j < Key.length; j++) {
			if(b.getModuleStates(Key[j]) == 2){
				SmartTF = true;
			}else{
				SmartTF = false;
				break;
			}	
		}
		return SmartTF;*/
		return true;
	}
	
	public static boolean getInstancegod(){
		/*SmartWebServer dog = SmartWebServer.getInstance();
		int rtn = dog.open();
		if(0==rtn){
			return true;
		}
		return false;*/
		return true;
	}
	
}