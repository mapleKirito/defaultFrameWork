package com.ow.framework.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.Properties;

public class GetProperty {
	// 读取全部信息
	public static String readProperties(String filePath) {
		Properties props = new Properties();
		String value = "";
		try {
			InputStream ips = new BufferedInputStream(new FileInputStream(filePath));
			props.load(ips);
			Enumeration enums = props.propertyNames();
			while (enums.hasMoreElements()) {
				String key = (String) enums.nextElement();
				value = props.getProperty(key);
				//System.out.println(key + "=" + value);
				value = value.substring(value.lastIndexOf("=")+1);
				//System.out.println(value);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return value;
	}
	
	 /* public static void main(String[] args) { GetProperty.readProperties(
	  "D:\\workspace36\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\dm\\WEB-INF\\classes\\CompressionPictureSize.properties"
	  );
	  
	  }*/
	 
}