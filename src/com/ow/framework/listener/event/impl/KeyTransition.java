package com.ow.framework.listener.event.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

import com.util.Application;

public class KeyTransition {
	private static final char[] FlashFXP_Key = "yA36zA48dEhfrvghGRg57h5UlDv3".toCharArray();
	@SuppressWarnings("unchecked")
	public static int[] decode() {
		String patch = (KeyTransition.class.getResource("")+"KeyNum.class").replaceAll("%20", " ");
		int[] KeyMR = {};
		String Key = null;
		Document document = null;
		try {
			document = new SAXReader().read(patch).getDocument();
		} catch (DocumentException e1) {
			e1.printStackTrace();
		}
		for(Element Start : (List<Element>)document.getRootElement().elements()){
			Key = Start.element("StringKey").getText();//读取加密锁密匙
		}
		try{
			if (Key.equals("")||Key==null) return KeyMR;
			StringBuffer result = new StringBuffer();
			char[] inputArr = Key.toCharArray();
			for (int i = 0; i < inputArr.length - 2; i = i + 2) {
				String source = "" + inputArr[i + 2] + inputArr[i + 3];
				String key = "" + Integer.toHexString((byte) (FlashFXP_Key[i / 2 % 28]));
				String magic_number = "" + inputArr[i] + inputArr[i + 1];
				int chr = (Integer.parseInt(source, 16) ^ Integer.parseInt(key, 16)) - Integer.parseInt(magic_number, 16);
				if (chr < 0) {
					chr = chr + 255;
				}
				result.append((char) chr);
			}	
			String a[] = result.toString().split(":");
			int[] number =new int[a.length];
				for(int i=0;i<a.length;i++){
					number[i] = Integer.parseInt(a[i]) ;
				}
			return number;
		}catch(Exception e){
			return KeyMR;
		}
	}
	
	public static int getDemoState(){
		//标志-1文件丢失(正式)  0 第一次	1过期	2修改日期
		int ans=10;
		String result = KeyTransition.class.getResource("").toString(); 
		int index = result.indexOf("WEB-INF"); 
		if(index == -1){ 
		index = result.indexOf("bin"); 
		} 
		//result = result.substring(0,index); 
		if(result.startsWith("jar")){ 
		// 当class文件在jar文件中时，返回"jar:file:/F:/ ..."样的路径 
		result = result.substring(10); 
		}else if(result.startsWith("file")){ 
		// 当class文件在class文件中时，返回"file:/F:/ ..."样的路径 
		result = result.substring(6); 
		} 
		String patch = (result+"regDate").replaceAll("%20", " ");
		File f=new File(patch);
		if(f.exists()){
			String FirstTime = null;
			String LastTime=null;
			Document document = null;
			try {
				document = new SAXReader().read(f).getDocument();
			} catch (DocumentException e1) {
				e1.printStackTrace();
			}
			for(Element Start : (List<Element>)document.getRootElement().elements()){
				FirstTime = Start.element("FirstTime").getText();//读取加密锁密匙
				LastTime = Start.element("LastTime").getText();//读取加密锁密匙
			}
			if(FirstTime.equals("")){
				ans=0;
			}else{
				//上一次日期
				long read_time_one = Long.parseLong(LastTime);
				
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				//当前日期
				String read_time_now_ = sdf.format(date);
				long read_time_now  = Long.parseLong(read_time_now_); 
				
				SimpleDateFormat sdf_ = new SimpleDateFormat("yyyyMMddHHmmss");
				Date todayDate;
				//过期日期
				long afterDate = 0l;
				
				try {
					todayDate = sdf_.parse(FirstTime);
					long useTime=30;//30天
					long afterTime=(todayDate.getTime()/1000)+60*60*24*useTime;
					todayDate.setTime(afterTime*1000); 
					afterDate = Long.parseLong(sdf_.format(todayDate));
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				
				if(read_time_now > afterDate){
					//过期
					ans=1;
				}else if(read_time_now < read_time_one){
					//修改时间
					ans=2;
				}
				
				for(Element Start : (List<Element>)document.getRootElement().elements()){
					Start.element("LastTime").setText(read_time_now_);//设置最后一次日期
				}
				
				XMLWriter writer;
				try {
					writer = new XMLWriter(new FileOutputStream(f));
					writer.write(document);
					writer.close();
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			
		}else{
			ans=-1;
		}
		
		
		return ans;
	}
	
	public static void regTime(){
		
		String result = KeyTransition.class.getResource("").toString(); 
		int index = result.indexOf("WEB-INF"); 
		if(index == -1){ 
		index = result.indexOf("bin"); 
		} 
		//result = result.substring(0,index); 
		if(result.startsWith("jar")){ 
		// 当class文件在jar文件中时，返回"jar:file:/F:/ ..."样的路径 
		result = result.substring(10); 
		}else if(result.startsWith("file")){ 
		// 当class文件在class文件中时，返回"file:/F:/ ..."样的路径 
		result = result.substring(6); 
		} 
		String patch = (result+"regDate").replaceAll("%20", " ");
		File f=new File(patch);
		Document document = null;
		try {
			document = new SAXReader().read(f).getDocument();
		} catch (DocumentException e1) {
			e1.printStackTrace();
		}
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		//当前日期
		String read_time_now_ = sdf.format(date);
		for(Element Start : (List<Element>)document.getRootElement().elements()){
			Start.element("FirstTime").setText(read_time_now_);//读取加密锁密匙
			Start.element("LastTime").setText(read_time_now_);//读取加密锁密匙
		}
		
		XMLWriter writer;
		try {
			writer = new XMLWriter(new FileOutputStream(f));
			writer.write(document);
			writer.close();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		
	}
}
