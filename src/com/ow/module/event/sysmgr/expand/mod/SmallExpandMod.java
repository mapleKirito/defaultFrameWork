package com.ow.module.event.sysmgr.expand.mod;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import net.sf.json.JSONObject;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ResultSet;
import com.mysql.jdbc.Statement;

public class SmallExpandMod {
	public static Object SmallEx(String ID,String Url){
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		Properties props = new Properties();
		JSONObject json = new JSONObject(); 
		InputStream in = null;
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
			rs = (ResultSet) stat.executeQuery("select expand.ER_ID,expand.ER_ResTypeName,expand.ER_CateTwLevel_Name, expand.ER_Name, expand.ER_Content, expand.ER_UserID, expand.ER_ResType, expand.ER_ConType,expand.ER_UserAccount, expand.ER_OperateTime, expand.ER_CreateTime, expand.ER_Grade, expand.ER_TaskId,expand.ER_Thumbnail ,expand.ER_Creator , expand.ER_Upload, expand.ER_FileSwf, expand.ER_Type,(select c.CATE_Path from res_category c where expand.ER_ResType=c.CATE_ID ) as  ER_Path from res_expand_room expand where expand.ER_ID =" + ID );
			if (rs.next()) {
				json.put("ER_ID",rs.getString("ER_ID")); 
				json.put("ER_Name",rs.getString("ER_Name")); 
				json.put("ER_Content",rs.getString("ER_Content"));  
				json.put("ER_UserID",rs.getString("ER_UserID"));  
				json.put("ER_ResType",rs.getString("ER_ResType"));  
				
				json.put("ER_Path",rs.getString("ER_Path"));  
				json.put("ER_ResTypeName",rs.getString("ER_ResTypeName"));  
				json.put("ER_CateTwLevel_Name",rs.getString("ER_CateTwLevel_Name"));  
				
				json.put("ER_ConType",rs.getString("ER_ConType")); 
				json.put("ER_UserAccount",rs.getString("ER_UserAccount"));  
				json.put("ER_OperateTime",rs.getString("ER_OperateTime"));  
				json.put("ER_CreateTime",rs.getString("ER_CreateTime"));  
				json.put("ER_Grade",rs.getString("ER_Grade"));  
				json.put("ER_TaskId",rs.getString("ER_TaskId")); 
				json.put("ER_Thumbnail ",rs.getString("ER_Thumbnail")); 
				json.put("ER_Creator ",rs.getString("ER_Creator"));
				json.put("ER_Upload",rs.getString("ER_Upload"));  
				json.put("ER_FileSwf",rs.getString("ER_FileSwf")); 
				json.put("ER_Type",rs.getString("ER_Type"));
		
			}
			return json;
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
		return json;
	}
}
