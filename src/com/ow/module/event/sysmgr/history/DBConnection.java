/***************************************************
 *  源文件名:  DBConnecion.java
 *  功    能：   数据库连接类
 ****************************************************
*/
package com.ow.module.event.sysmgr.history;			//指定类所在的包
import java.sql.*;						//导入数据库操作的类
import java.util.*;
import java.io.*;

public class DBConnection					
{

    private String FileName;			//配置文件名
    private Connection conn;			//连接对象
    private String MySqlDriver;			//MYSQL Server驱动程序
    private String MySqlURL; 			//MYSQL Server连接字符串
    private String MySqlName;
    private String MySqlPassword;
    public DBConnection()
    {
    	conn = null;
    }

	public  Connection getConn()
	{
			return(getConnToMySql());
	}

	public String getPara(String ParaName) 
	{
		FileName="../../../../../../jdbc.properties";
		Properties prop= new Properties();
		try
		{
			InputStream is = getClass().getResourceAsStream(FileName);
			prop.load(is);
			if(is!=null) is.close();
		}
		catch(Exception e) {
			return "Error!";
		}
		return prop.getProperty(ParaName);
	}

    public Connection getConnToMySql()
    {
		try{
	 		MySqlDriver = getPara("driverClassName");	
	 		MySqlName = getPara("username");
	 		MySqlPassword = getPara("password");
	    	MySqlURL = getPara("url");
	    	Class.forName(MySqlDriver).newInstance();
	    	conn = DriverManager.getConnection(MySqlURL+"&user="+MySqlName+"&password="+MySqlPassword);
	    	}catch(Exception e){
	    		e.printStackTrace();
		    	//return "操作数据库出错，请仔细检查" ;
		    	System.err.println(e.getMessage());
	    	}
	    return conn;
    } 

   //关闭数据库连接
    public void Close()
    {
        try{
            conn.close(); 
        }catch(SQLException sqlexception){
            sqlexception.printStackTrace();
        }
    }
}
