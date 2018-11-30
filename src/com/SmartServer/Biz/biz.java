package com.SmartServer.Biz;
import java.io.IOException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import org.xml.sax.SAXException;

import com.SmartServer.util.SmartIpXml;
import com.SmartServer.util.SmartWebServer;

public class biz {
	//生成解锁申请码
	public String getChangeRequest(){
		SmartWebServer dog = SmartWebServer.getInstance();
		return dog.ChangeRequest();
	}
	//远程修改
	public String setRemote(String response){
		SmartWebServer dog = SmartWebServer.getInstance();
		int i = dog.Change(response);
		if (0==i) {
			return "YES";
		}else {
			return ""+i;
		}
	}
	//获取指定模块状态
	public int getModuleStates(int b1){
		SmartWebServer dog = SmartWebServer.getInstance();
		byte[] License = new byte[1];
		int i = dog.getModuleStates(b1, License);	//函数执行成功返回0  否则返回错误码
		if(0==i){
			if(License[0]==0){	//License[0]的值为0或1
				/*return "第"+b1+"个许可证状态获取成功:关闭";	*/
				return 1;
			}else{
				/*return "第"+b1+"个许可证状态获取成功:打开";*/
				return 2;
			}

		}else {
			return 1;
		}
	}
	//设置ip
	public void setXml(String ips,String path){
		try {
			SmartIpXml.updateXml(ips, path);
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//读取ip
	public String getXml(String path){
		String xml = SmartIpXml.Xml(path);
		String ip = xml.replaceAll(".*?((\\d{0,3}\\.){3}\\d{0,3}).*","$1");
		return ip;
	}
	
	//读存储区
	public String StoreRead(int nStartAddr, int nLen){
		
		SmartWebServer dog = SmartWebServer.getInstance();		//获取加密锁引用
		
		byte[] pBuffer = new byte[nLen];
		int i = dog.readStorage(nStartAddr, nLen, pBuffer);
		if(0==i){
			return SmartWebServer.b2s(pBuffer);
		}
		return "读取失败, 错误码:"+i;
	}

	
	//写存储区
	public String StoreWrite(int nStartAddr, byte[] pBuffer){
		SmartWebServer dog = SmartWebServer.getInstance();

		int i = dog.WriteStorage(nStartAddr, pBuffer.length, pBuffer);
		if(0==i){
			return "写存储区成功";
		}
		return "写存储区失败";
	}
}