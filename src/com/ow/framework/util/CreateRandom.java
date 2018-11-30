package com.ow.framework.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

public class CreateRandom {

    private static Random random = new java.util.Random();
    private static final int ID_BYTES = 10;
    public CreateRandom()
    {
    }

    /**
     * 随机数
     */
    public static String generateRandom()
    {
        StringBuffer result = new StringBuffer();
        result = result.append(System.currentTimeMillis());
        for (int i = 0; i < ID_BYTES; i++) {
            result = result.append(random.nextInt(10));
        }
        return result.toString();
    }
    
    /**
     * 随机数
     */
    public static String generateRandom(int digit)
    {
        StringBuffer result = new StringBuffer();
        for (int i = 0; i < digit; i++) {
            result = result.append(random.nextInt(10));
        }
        return result.toString();
    }

    public static String getRandomString(int size) {
        char[] c = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'q', 'w',
                   'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f',
                   'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm'};
        Random random = new Random(); //初始化随机数产生器
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < size; i++) {
            sb.append(c[Math.abs(random.nextInt()) % c.length]);
        }
        return sb.toString();
    }
    /**
     * 通过当前毫秒数与随机数相加返回指定位数的随机数
     * @param timeLengthStart 毫秒数截取起始位置，结束位置为末位。
     * @param randomLength    被加随机数的位数。
     * @param rtnLength       返回字符串的位数。
     * @return  
     */
    public static String getRandomStringWithTime(int timeLengthStart,int randomLength,int rtnLength){
        Calendar calendar = Calendar.getInstance();
        //创建指定位数的字符串。
        String randomNum = CreateRandom.generateRandom(randomLength);
        //获得当前毫秒数。
        String timeStr = String.valueOf(calendar.getTimeInMillis());
        //截取毫秒字符串。
        String strAfterSubString = timeStr.substring(timeLengthStart,timeStr.length());
        //两数连接
        String addResult = String.valueOf(Long.parseLong(randomNum)+Long.parseLong(strAfterSubString));
        if(addResult.length() > rtnLength){
        	return addResult.substring(addResult.length()-rtnLength,addResult.length());
        }else{
        	return addResult.concat(CreateRandom.generateRandom(rtnLength - addResult.length()));
        }
    }
    public static void main(String[] args) {
//     Calendar calendar = Calendar.getInstance();
//     String randomNum = CreateRandom.generateRandom(6);
//     String str = String.valueOf(calendar.getTimeInMillis());
//     //str.substring(beginIndex, endIndex)
//    	for(int i = 0 ; i < 10 ; i++){
//    		System.out.println(CreateRandom.getRandomStringWithTime(5, 6, 6));
//    	}
		System.out.println(CreateRandom.getRandomString(15));
   }
}
