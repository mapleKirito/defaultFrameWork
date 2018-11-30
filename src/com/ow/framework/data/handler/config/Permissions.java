package com.ow.framework.data.handler.config;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.exception.DetailException;
import com.thoughtworks.xstream.XStream;

public class Permissions implements java.io.Serializable
{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private static final long serialVersionUID = -3376083579273281122L;
	private ArrayList<Permission> permissionList;

	public Permissions()
	{
	}

	public static Permissions getInstance(String fileName)
	{
		try
		{
	        InputStream in = new FileInputStream(new File(fileName));
	        InputStreamReader reader = new InputStreamReader(in, Charset.forName("UTF-8"));
			return (Permissions) makeStream().fromXML(reader);
		}
		catch ( Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	public String toString()
	{
		return makeStream().toXML(this);
	}

	/**
	 * xStream：Java和xml之间的转换器，转化过程是双向的,xml到Java的方法:fromXml();Java到xml的方法:toxml();
	 * @return
	 */
	private static XStream makeStream()
	{
		XStream stream = new XStream();
		try
		{
			stream.alias("permissions", Permissions.class);
			stream.alias("permission", Permission.class);
			stream.addImplicitCollection(Permissions.class, "permissionList");
		}
		catch (Exception e)
		{
			log.debug(DetailException.expDetail(e, Permissions.class));
		}
		return stream;
	}

	/**
	 * @return the permissionList
	 */
	public ArrayList<Permission> getPermissionList()
	{
		return permissionList;
	}

	/**
	 * @param permissionList the permissionList to set
	 */
	public void setPermissionList(ArrayList<Permission> permissionList)
	{
		this.permissionList = permissionList;
	}
}
