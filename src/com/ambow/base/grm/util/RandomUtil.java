package com.ambow.base.grm.util;

import java.util.*;

public class RandomUtil {

    private static Random random = new java.util.Random();
    private static final int ID_BYTES = 10;
    public RandomUtil()
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
	
}
