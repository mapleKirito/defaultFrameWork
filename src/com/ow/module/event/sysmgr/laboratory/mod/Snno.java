package com.ow.module.event.sysmgr.laboratory.mod;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ResultSet;
import com.mysql.jdbc.Statement;

public class Snno {
	public static String getSnno(String name,String Url){
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		Properties props = new Properties();		
		InputStream in = null;
		
		String snno = "";
		
		try {
			in = new BufferedInputStream(new FileInputStream(Url));
			props.load(in);
			String driverClassName = props.getProperty("driverClassName");
			String url = props.getProperty("url");
			String username = props.getProperty("username");
			String password = props.getProperty("password");
			Class.forName(driverClassName);
			conn = (Connection) DriverManager.getConnection(url, username, password);
			stat = (Statement) conn.createStatement();
			rs = (ResultSet) stat.executeQuery("select serial.SN_ID, serial.SN_Name, serial.SN_CNName, serial.SN_NO, serial.SN_UserID, serial.SN_UserAccount, serial.SN_OperateTime, serial.SN_CreateTime, serial.SN_Creator from sys_serial_number serial where serial.SN_Name ='" + name +"'" );
			
			while(rs.next()){
				snno = rs.getString("SN_NO");
			}
			
		
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				rs = null;
			}
			if (stat != null) {
				try {
					stat.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				stat = null;
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				conn = null;
			}
		}
		return snno;
	}
}
