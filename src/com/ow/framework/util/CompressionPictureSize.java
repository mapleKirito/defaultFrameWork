package com.ow.framework.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;

import javax.imageio.ImageIO;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class CompressionPictureSize {
	public CompressionPictureSize() {

	}
	public static void CutImae_(int width_,int height_,String fullname) throws Exception {
		File _file = new File(fullname); // 读入文件
		Image src = javax.imageio.ImageIO.read(_file); // 构造Image对象
		BufferedImage tag = new BufferedImage(width_, height_, BufferedImage.TYPE_INT_RGB);
		tag.getGraphics().drawImage(src, 0, 0, width_, height_, null); // 绘制缩小后的图
		FileOutputStream out = new FileOutputStream(fullname); // 输出到文件流
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		encoder.encode(tag); // 近JPEG编码
		out.flush();
		out.close();
	}
	
	public static String getSmallJPG(String fullname,String path) throws Exception {
		File _file = new File(fullname); // 读入文件
		Image src = javax.imageio.ImageIO.read(_file); // 构造Image对象
		int wideth = src.getWidth(null); // 得到源图宽
		int height = src.getHeight(null); // 得到源图长
		BufferedImage tag = new BufferedImage(153, 125, BufferedImage.TYPE_INT_RGB);
		tag.getGraphics().drawImage(src, 0, 0, 153, 125, null); // 绘制缩小后的图
		String _filename = _file.getName();
		//System.out.println(_file.getParent());
		String s = path + "T_" + _filename;
		FileOutputStream out = new FileOutputStream(s); // 输出到文件流
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		encoder.encode(tag); // 近JPEG编码
		// System.out.print(wideth+ "* "+height);
		out.close();
		return s;
	}
	public static String getartworkJPG(String fullname,String path) throws Exception {		
		File file = new File(fullname);
		/** 对服务器上的临时文件进行处理 */
		Image srcFile = ImageIO.read(file);
		// 为等比缩放计算输出的图片宽度及高度
		double rate1 = ((double) srcFile.getWidth(null)) / 1068+0.1;
		double rate2 = ((double) srcFile.getHeight(null)) / 920+0.1;
		double rate = rate1 > rate2 ? rate1 : rate2;
		int new_w = (int) (((double) srcFile.getWidth(null)) / rate);
		int new_h = (int) (((double) srcFile.getHeight(null)) / rate);
		/** 宽,高设定 */
		BufferedImage tag = new BufferedImage(new_w, new_h, BufferedImage.TYPE_INT_RGB);
		tag.getGraphics().drawImage(srcFile, 0, 0, new_w, new_h, null);
		/** 压缩之后临时存放位置 */
		String _filename = file.getName();
		String s = path + "I_" + _filename;
		FileOutputStream out = new FileOutputStream(s);
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		encoder.encode(tag); // 近JPEG编码
		out.close();
		return s;
	}
	
	public static String getRecomJPG(String fullname,String path,String recomType) throws Exception {		
		File _file = new File(fullname); // 读入文件
		Image src = javax.imageio.ImageIO.read(_file); // 构造Image对象
		int wideth = src.getWidth(null); // 得到源图宽
		int height = src.getHeight(null); // 得到源图长
		int new_w = 305;
		int new_h = 145;
		if(recomType.equals("22")){
			new_w = 145;
			new_h = 145;
		}else{
			new_w = 305;
			new_h = 145;
		}
		/** 宽,高设定 */
		BufferedImage tag = new BufferedImage(new_w, new_h, BufferedImage.TYPE_INT_RGB);
		tag.getGraphics().drawImage(src, 0, 0, new_w, new_h, null);
		/** 压缩之后临时存放位置 */
		String _filename = _file.getName();
		//System.out.println(_file.getParent());
		String s = path + "R_" + _filename;
		FileOutputStream out = new FileOutputStream(s); // 输出到文件流
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		encoder.encode(tag); // 近JPEG编码
		// System.out.print(wideth+ "* "+height);
		out.close();
		return s;
	}
	/*
	public static void main(String[] args) {
		try {

			Change j = new Change();
			j.getSmallJPG("C:\\Documents and Settings\\Administrator\\桌面\\新建文件夹 (2)\\首页、登陆页面\\xtzc.png");
		} catch (Exception e) {
			System.out.println(e);
		}
	}*/
}
