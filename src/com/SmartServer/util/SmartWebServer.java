/**************************************
 * 
 * 类名: SmartServer
 * 
 * 说明: 此类是单例模式设计,保证程序运行中只实例化一个类减少系统开销.getInstance()函数为全局访问点,用于获取引用.
 * 		 关键字synchronized用于限制多线程情况下对类和其中方法的并发访问
 * 
 **************************************/
package com.SmartServer.util;

import com.SmartServer.Biz.biz;
import com.ow.framework.listener.event.impl.GetpcInfo;
import com.ow.framework.util.Encrypt;
import com.sun.jna.Library;
import com.sun.jna.Native;

public class SmartWebServer {
	private static SmartWebServer dog = null;
	private String AppID = "MyApplication";
	  private int password1 = 31098670;
	  private int password2 = -1424684640;
	  private int password3 = -1329093357;
	  private int password4 = -1209178022;
	
	//
	private SmartWebServer() {}
	private SmartWebServer(String AppID, int password1, int password2, int password3, int password4){
		this.AppID = AppID;
		this.password1 = password1;
		this.password2 = password2;
		this.password3 = password3;
		this.password4 = password4;
	}

	/*********************************************************
	 * 接口: CLibrary
	 * 说明: 通过Jna声明dll接口中的函数,"SmartServer.x64"为接
	 * 		口文件名称,文件必须放在系统目录才能正确调用,如自定义
	 * 		接口文件名在下面也要统一
	 *********************************************************/
	private interface CLibrary extends Library {
		
		CLibrary INSTANCE = (CLibrary)Native.loadLibrary("SmartServer.win32",CLibrary.class);

		int SmartServerGetLastError();		//获取错误码
		int SmartServerFind(String AppID);	//查找加密锁
		int SmartServerGetUid(byte[] UID);			//获取硬件ID
		int SmartServerOpen(int password1, int password2, int password3, int password4);	//打开加密锁
		int SmartServerSHA1WithSeed(String Pwd, byte[] SHA1Val);		//计算SHA1值
		int SmartServerReadStorage(int nStartAddr, int nLen, byte[] pBuffer);	//读存储区
		int SmartServerWriteStorage(int nStartAddr, int nLen, byte[] pBuffer);		//写存储区
		int SmartServerTriDesEncryptBase64(String encrypt, byte[] encryptBase64);		//3DES加密
		int SmartServerTriDesBase64Decrypt(String decryptBase64, byte[] decrypt);		//3DES解密
		int SmartServerGetUserNumber(int[] nUserNumer);		//读取锁中记录的用户数
		int SmartServerGetModuleState(int nModuleId, byte[] State);		//获取模块状态
		int SmartServerGetAllModuleStates(byte[] nState);		//获取所有模块状态
		int SmartServerChangeRequest(byte[] request);	//生成远程修改请求
		int SmartServerChange(String response);		//执行修改		
		int SmartServerClose();						//关闭加密锁
    }

	
	//获取错误码函数
	public synchronized int GetLastError(){
		return CLibrary.INSTANCE.SmartServerGetLastError();
	}
	
	
	//查找并打开加密锁
	public synchronized int open(){

		int rtn = CLibrary.INSTANCE.SmartServerFind(AppID);
		
		if(0==rtn){
			
			rtn = CLibrary.INSTANCE.SmartServerOpen(password1, password2, password3, password4);
			if (0==rtn) {
				return 0;
			}else {
				return CLibrary.INSTANCE.SmartServerGetLastError();
			}
		}else {
			return CLibrary.INSTANCE.SmartServerGetLastError();
		}
	}
	

	//获取加密锁所有模块状态
	public synchronized int GetAllModuleStates(byte[] License){
		int rtn = CLibrary.INSTANCE.SmartServerGetAllModuleStates(License);
		if (0==rtn) {
			return 0;
		}else {
			return CLibrary.INSTANCE.SmartServerGetLastError();
		}

	}
	
	
	//获取指定模块状态
	public synchronized int getModuleStates(int nModuleId, byte[] License){
		int rtn = CLibrary.INSTANCE.SmartServerGetModuleState(nModuleId, License);
		if (0==rtn) {
			return 0;
		}else {
			return CLibrary.INSTANCE.SmartServerGetLastError();
		}
	}
	
	
	//计算SHA1值
	public synchronized int SHA1WithSeed(String Pwd, byte[] SHA1Val){
		int rtn = CLibrary.INSTANCE.SmartServerSHA1WithSeed(Pwd, SHA1Val);
		if (0==rtn) {
			return 0;
		}else {
			return CLibrary.INSTANCE.SmartServerGetLastError();
		}
	}

	
	//获取用户数
	public synchronized int getUserNumber(int[] nUserNumer){
		int rtn = CLibrary.INSTANCE.SmartServerGetUserNumber(nUserNumer);
		if (0==rtn) {
			return 0;
		}else {
			return CLibrary.INSTANCE.SmartServerGetLastError();
		}
	}
	
	
	//生成远程修改请求
	public synchronized String ChangeRequest() {
		byte[] request = new byte[1024];
		int rtn = CLibrary.INSTANCE.SmartServerChangeRequest(request);
		if (0==rtn) {
			return b2s(request);
		}else {
			return "生成请求失败, 错误码:"+CLibrary.INSTANCE.SmartServerGetLastError();
		}
	}
	
	
	//根据数据修改加密锁
	public synchronized int Change(String response){
		int rtn = CLibrary.INSTANCE.SmartServerChange(response);
		if (0==rtn) {
			return 0;
		}else {
			return CLibrary.INSTANCE.SmartServerGetLastError();
		}
	}
	
	
	//读存储区
	public synchronized int readStorage(int nStartAddr, int nLen, byte[] data){
		int rtn = CLibrary.INSTANCE.SmartServerReadStorage(nStartAddr, nLen, data);
		if (0==rtn) {
			return 0;
		}else {
			return CLibrary.INSTANCE.SmartServerGetLastError();
		}
	}
	

	//写存储区
	public synchronized int WriteStorage(int nStartAddr, int nLen, byte[] data) {
		int rtn = CLibrary.INSTANCE.SmartServerWriteStorage(nStartAddr, nLen, data);
		if (0==rtn) {
			return 0;
		}else {
			return CLibrary.INSTANCE.SmartServerGetLastError();
		}
	}
	
	
	//3DES加密
	public synchronized int TriDesEncryptBase64(String encrypt, byte[] encryptBase64){
		int rtn = CLibrary.INSTANCE.SmartServerTriDesEncryptBase64(encrypt, encryptBase64);
		if (0==rtn) {
			return 0;
		}else {
			return CLibrary.INSTANCE.SmartServerGetLastError();
		}
	}
	

	//3DES解密
	public synchronized int TriDesBase64Decrypt(String decryptBase64, byte[] decrypt){
		int rtn = CLibrary.INSTANCE.SmartServerTriDesBase64Decrypt(decryptBase64, decrypt);

		if (0==rtn) {
			return 0;
		}else {
			System.out.println(CLibrary.INSTANCE.SmartServerGetLastError());
			return CLibrary.INSTANCE.SmartServerGetLastError();
		}
	}

	
	//关闭加密锁
	public synchronized int  Close() {
		int rtn = CLibrary.INSTANCE.SmartServerClose();
		if (0==rtn) {
			return 0;
		}else {
			return CLibrary.INSTANCE.SmartServerGetLastError();
		}
	}

	 
	//不带参实例化  ,  参数为默认
	public synchronized static SmartWebServer getInstance(){
		if (null==dog) {
			dog = new SmartWebServer();
		}
		return dog;
	}
	//带参实例化
	public synchronized static SmartWebServer getInstance(String AppID, int password1, int password2, int password3, int password4){
		if (null==dog) {
			dog = new SmartWebServer(AppID, password1, password2, password3, password4);
		}
		return dog;
	}

	//处理byte[]数组
	public synchronized static String b2s(byte b[]) {
	    // Converts C string to Java String
		int len = 0;
	    while (b[len] != 0){
	    	++len;
	    	if (b.length == len) {
	    		break;
			}
	    }
		return new String(b, 0, len);
	}
	
	public static int getInstancegodTime(){
		/*biz b = new biz();
		
		String read_s = b.StoreRead(4,19).trim();
		System.out.println(new StringBuilder(read_s).reverse());
		
		boolean flag = true;
		try{
			Long.parseLong(read_s);
		}catch (Exception e) {
			flag = false;
		}
		
		if(!read_s.trim().equals("") && flag) {
			long read_time_one = Long.parseLong(read_s);
			
			String read_time_total_ = b.StoreRead(1,3);
			long read_time_total = Long.parseLong(read_time_total_);
			
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String read_time_now_ = sdf.format(date);
			long read_time_now  = Long.parseLong(read_time_now_); 
			
			SimpleDateFormat sdf_ = new SimpleDateFormat("yyyyMMddHHmmss");
			Date todayDate;
			long afterDate = 0l;
			
			try {
				todayDate = sdf_.parse(read_s);
				long afterTime=(todayDate.getTime()/1000)+60*60*24*read_time_total;
				todayDate.setTime(afterTime*1000); 
				afterDate = Long.parseLong(sdf_.format(todayDate));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			if(read_time_now > afterDate){
				return 0;
			}else if(read_time_now < read_time_one){
				return 2;
			}
		}*/
		
		return 1;
	}
	
	public static String writerootvalue(){
		String up = GetpcInfo.getCPUSerial()+GetpcInfo.getMotherboardSN();
	 	return Encrypt.getMD5(up);
	}
	
	public static void writeroot(){
		String write_s = new biz().StoreWrite(0, writerootvalue().getBytes());
	}
}
