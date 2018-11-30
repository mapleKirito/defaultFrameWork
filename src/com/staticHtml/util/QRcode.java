package com.staticHtml.util;

import java.io.File;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;

public class QRcode {

    /**
     * 
     * @param content
     * @param imgPath
     */
	public static void createQRImg(String content,String path){
		try {
		     
		     MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
		     
		     Map hints = new HashMap();
		     hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
		     BitMatrix bitMatrix = multiFormatWriter.encode(content, BarcodeFormat.QR_CODE, 400, 400,hints);
		     File file=new File(path);
		     if(!file.exists()){
		    	 file.mkdirs();
		     }
		     
		     File file1 = new File(path,"qrcode.jpg");
		     if(!file1.exists()){
		    	 file1.createNewFile();
		     }
		     //File file1 = new File(path);
		     MatrixToImageWriter.writeToFile(bitMatrix, "jpg", file1);
		     
		 } catch (Exception e) {
		     e.printStackTrace();
		 }
	}
	
	public static void createQRImg(String content,String path,OutputStream os){
		try {
		     
		     MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
		     
		     Map hints = new HashMap();
		     hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
		     BitMatrix bitMatrix = multiFormatWriter.encode(content, BarcodeFormat.QR_CODE, 400, 400,hints);
		     File file1 = new File(path,"qrcode.jpg");
		     //File file1 = new File(path);
		     MatrixToImageWriter.writeToStream(bitMatrix, "jpg", os);
		     
		 } catch (Exception e) {
		     e.printStackTrace();
		 }
	}
}
