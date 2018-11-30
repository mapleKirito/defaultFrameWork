package com.ow.framework.util;

import java.security.Key;
import java.security.MessageDigest;
import java.security.Security;

import javax.crypto.Cipher;

public class Encrypt {
	private static Cipher encryptCipher = null,decryptCipher = null;
	public static byte [] key = {-42, 1, 25, 25, -57, 84, 67, 32};
	
	public static final String getMD5(String text) {
		MessageDigest md5 = null;
		try{
			md5 = MessageDigest.getInstance("MD5");
		}catch (Exception e){
			System.out.println(e.toString());
			e.printStackTrace();
			return "";
		}
		char[] charArray = text.toCharArray();
		byte[] byteArray = new byte[charArray.length];

		for (int i = 0; i < charArray.length; i++)
			byteArray[i] = (byte) charArray[i];
		byte[] md5Bytes = md5.digest(byteArray);
		StringBuffer hexValue = new StringBuffer();
		for (int i = 0; i < md5Bytes.length; i++){
			int val = ((int) md5Bytes[i]) & 0xff;
			if (val < 16)
				hexValue.append("0");
			hexValue.append(Integer.toHexString(val));
		}
		return hexValue.toString();
	}
	
	public static String convertMD5(String inStr){
		char[] a = inStr.toCharArray();
		for (int i = 0; i < a.length; i++){
			a[i] = (char) (a[i] ^ 't');
		}
		String s = new String(a);
		return s;
	}
	
	private static Key getKey(byte[] arrBTmp) throws Exception {
	    byte[] arrB = new byte[8];
	    for (int i = 0; i < arrBTmp.length && i < arrB.length; i++) {
	    	arrB[i] = arrBTmp[i];
	    }
	    Key key = new javax.crypto.spec.SecretKeySpec(arrB, "DES");
	    return key;
    }
	
	public static String byteArr2HexStr(byte[] arrB) throws Exception {
		int iLen = arrB.length;
		StringBuffer sb = new StringBuffer(iLen * 2);
		for (int i = 0; i < iLen; i++) {
			int intTmp = arrB[i];
			while (intTmp < 0) {
				intTmp = intTmp + 256;
			}
			if (intTmp < 16) {
				sb.append("0");
			}
			sb.append(Integer.toString(intTmp, 16));
		}
		return sb.toString();
	}
	
	public static byte[] hexStr2ByteArr(String strIn) throws Exception {
		byte[] arrB = strIn.getBytes();
		int iLen = arrB.length;
		byte[] arrOut = new byte[iLen / 2];
		for (int i = 0; i < iLen; i = i + 2) {
			String strTmp = new String(arrB, i, 2);
			arrOut[i / 2] = (byte) Integer.parseInt(strTmp, 16);
		}
		return arrOut;
	}
    
	public static byte[] encrypt(byte[] arrB) throws Exception {
		return encryptCipher.doFinal(arrB);
	}

	public static String encrypt(String strIn){
		try {
			EncryptModify();
			return byteArr2HexStr(encrypt(strIn.getBytes()));
		} catch (Exception e) {
			return "";
		}				
	}

	public static byte[] decrypt(byte[] arrB) throws Exception {
		return decryptCipher.doFinal(arrB);
	}

	public static String decrypt(String strIn) throws Exception {
		EncryptModify();
		return new String(decrypt(hexStr2ByteArr(strIn)));
	}

	public static void EncryptModify(){
		String strKey = "!@#$%^&*()(*&^%@ERTYUIOP(*ERTYU";
		Security.addProvider(new com.sun.crypto.provider.SunJCE());
		Key key;
		try {
			key = getKey(strKey.getBytes());
			encryptCipher = Cipher.getInstance("DES");
			encryptCipher.init(Cipher.ENCRYPT_MODE, key);
			decryptCipher = Cipher.getInstance("DES");
			decryptCipher.init(Cipher.DECRYPT_MODE, key);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) throws Exception {
		String test = "lk10yd:lk01yd";
		System.out.println("加密后的字符：" + encrypt(test));
		System.out.println("解密后的字符：" + decrypt(encrypt(test)));		
	}
	
}