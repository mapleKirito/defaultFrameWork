package com.ow.framework.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

public class KeyHelper{
	
	private static final long MASK = 160866563754082L;	//6个字节的掩码，随机产生的一个15位的十进制数
	//将时间信息和随机数穿插的规则
	private static int[][] combRule = {{1, 8, 10, 12, 14, 20, 26, 27, 28, 31, 40, 43, 44, 45, 46, 47 },
		{29, 18, 37, 30, 22, 23, 32, 15, 11, 0, 5, 21, 34, 19, 7, 2, 3, 4, 25, 42, 9, 16, 17, 24, 41, 35, 13, 36, 33, 6, 38, 39 }};		
	private static long seed = 0;
	
    public synchronized static String getKey(){
    	if (seed > 1000000)
    		seed = 0;
        return String.valueOf(System.currentTimeMillis()+(seed++)+randomNum10Bytes());
    }

	/**
	 * 2009年1月1日至今的小时数，其后2个字节有用（且不重复），其余不考虑
	 * @return 2009年1月1日至今的小时数
	 */
	
	private static long hourNum2Bytes() {
		Calendar early = Calendar.getInstance();
		Calendar now = Calendar.getInstance();
		early.set(2009, 0, 1);
		long ms = (long)((now.getTimeInMillis() - early.getTimeInMillis())/ (1000 * 60 * 60));
		return ms;
	}
	
	/**
	 * 获得当前时间如(200808080808)+3位随即数字的字符串
	 */
	public static String getTimeRandom(){
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmssSSSS");
		Date date = new Date();
		return formatter.format(date);
	}
	
	
	private static long randomNum10Bytes(){
		Random random = new java.util.Random();
		StringBuilder sb = new StringBuilder();
		for(int i =0 ;i<10;i++){
			String stmp = random.nextInt(10)+"";
			sb.append(stmp);
			 
		}
		
		return Long.parseLong(sb.toString());
	}
	
	/**
	 * 生成随机数，其后面4个字节（32位）有用，其余字节不考虑
	 * @return long类型的随机数
	 */
	
	
	private static long randomNum4Bytes() {
		Random random = new java.util.Random();
		return Math.abs(random.nextLong());	//再思考
	}
	
	/**
	 * 产生一个15位的由数字组成的字符串
	 * @return 一个15位的由数字组成的字符串
	 */
	public static String getSerialNo () {
		//将hourNum的后两个字节和randomNum的后四个字节以位（bit）为单位进行穿插组合
		char[] combChar = new char[combRule[0].length + combRule[1].length];
		long hourNum	= hourNum2Bytes();
		long randomNum = randomNum4Bytes();

		for(int i = 0; i < combRule[0].length; i++) {
			combChar[combRule[0][i]] = (char) ((hourNum >> i) % 2 + 48);
		}
		for(int i = 0; i < combRule[1].length; i++) {
			combChar[combRule[1][i]] = (char) ((randomNum >> i) % 2 + 48);
		}
		long combNum = Long.valueOf(new String(combChar), 2);
		
		//将combNum与掩码MASK进行XOR异或运算，并取后6个字节构成的数字
		long result = (long) ((combNum ^ MASK) % java.lang.Math.pow(2, 8 * 6));
		
		String sResult = result + "";
		while(sResult.length() < 15) {	//6个字节未用足15位数字，在数字后加零补足15位数字恒定
			sResult += "0";
		}
		
		return sResult;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		KeyHelper kh = new KeyHelper();
		
		for(int i =0 ; i < 10 ;i++){
			System.out.println(getKey());
		}
	}
}