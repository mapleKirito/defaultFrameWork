package com.SmartServer.util;

import org.longmai.smartserveradm.SmartServerAdminLib;

public class Demo {
	public static void main(String[] args) {
		SmartServerAdminLib ss = SmartServerAdminLib.getInstance();
		/**
		 * 检测加密锁
		 */
		int [] keyHandles = new int[8];
		int [] keyNumber = new int[8];
		int rtn = ss.IA300ServerFindAll(keyHandles, keyNumber);
		if (rtn == 0){
			System.out.println("查找加密锁成功");
		}else{
			System.out.println("查找加密锁失败");
		}
		/**
		 * 超级用户登录
		 */
		String superPin = "admin";
		rtn = ss.IA300ServerCheckSuperPin(keyHandles[0], superPin);
		if(rtn == 0){
			System.out.println("超级用户登录成功");
		}else{
			System.out.println("超级用户登录失败");
		}
		/**
		 * 从远程解锁请求中获得相关的请求信息，包括唯一ID, 用户数， 模块状态 
		 */
		String request = "SWkiXfunFfMZmyy8ERi93O6zEYxiTYjlZo72Mql58kA4ld1Fhpun4nATZTJsup6NbwS7EKSWUc8OBQCnMmnMsnYTIQfVkBxS55GskvSfOjkqp4QIt+tNn1iY5oci0tPnHQL8L5x63RJ0Pa8pJqG43xq54mNvuPmW3LzU4Wi6cgLuk6CUBzrr/xsx3ITfCgsXGkNO3DB1KUJ07wRDXVR3tXmQxkbE3q3puRNdGLNm78Gn71yFlDECt5WxAp2BZd5RnAN4oL31Scwo0LIec9GGaA==";
		byte[] keyId = new byte[64];
		int [] userNumber = new int [1];
		byte[] moduleStates = new byte[128];
		rtn = ss.IA300ServerGetRequestInfo(keyHandles[0], request, keyId, userNumber, moduleStates);
		if(rtn == 0){
			System.out.println("从远程解锁请求中获得相关的请求信息成功");
		}else{
			System.out.println("从远程解锁请求中获得相关的请求信息失败");
		}
		/**
		 * 根据解锁请求生成相应的解锁码
		 * IA300ServerGenResponse 使用当前连接的锁的付密钥进行处理， 这种方式更方便安全，但是要求用户留一把锁作为管理使用
		 * 
		 */
		int newUserNumber = userNumber[0];
		byte[]newModuleStates = moduleStates;
		byte[]response = new byte[512];;
		rtn = ss.IA300ServerGenResponse(keyHandles[0],superPin, newUserNumber, newModuleStates, request, response);
		if(rtn == 0){
			System.out.println("根据解锁请求生成相应的解锁码成功");
		}else{
			System.out.println("根据解锁请求生成相应的解锁码失败");
		}
		/**
		 * 根据解锁请求生成相应的解锁码
		 * IA300ServerGenResponseEx 用于手工输入付密钥， 这样用户不需要另一把锁作为管理使用，但是需要保证付密钥的安全性
		 */
		String seckey = "ABCDEFGhijklmn0123456789";
		byte[]response1 = new byte[512];
		rtn = ss.IA300ServerGenResponseEx(keyHandles[0], superPin,seckey, newUserNumber, newModuleStates, request, response1);
		if( rtn ==0){
			System.out.println("根据解锁请求生成相应的解锁码成功");
		}else{
			System.out.println("根据解锁请求生成相应的解锁码失败");
		}
	}
}
