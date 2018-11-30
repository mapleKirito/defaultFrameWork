package com.ow.module.event.sysmgr.lovely.mod;

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

public class SmallLovelyMod {
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
			System.out.println("select lovely.CR_ID,lovely.CR_ResTypeName,lovely.CR_CateTwLevel_Name, lovely.CR_Name, lovely.CR_Content, lovely.CR_UserID, lovely.CR_ResType, lovely.CR_ConType,lovely.CR_UserAccount, lovely.CR_OperateTime, lovely.CR_CreateTime, lovely.CR_Grade, lovely.CR_TaskId,lovely.CR_Thumbnail ,lovely.CR_Creator , lovely.CR_Upload, lovely.CR_FileSwf, lovely.CR_Type,(select c.CATE_Path from res_category c where lovely.CR_ResType=c.CATE_ID ) as  CR_Path from res_lovecountry_room lovely where lovely.CR_ID = " + ID);

			rs = (ResultSet) stat.executeQuery("select lovely.CR_ID,lovely.CR_ResTypeName,lovely.CR_CateTwLevel_Name, lovely.CR_Name, lovely.CR_Content, lovely.CR_UserID, lovely.CR_ResType, lovely.CR_ConType,lovely.CR_UserAccount, lovely.CR_OperateTime, lovely.CR_CreateTime, lovely.CR_Grade, lovely.CR_TaskId,lovely.CR_Thumbnail ,lovely.CR_Creator , lovely.CR_Upload, lovely.CR_FileSwf, lovely.CR_Type,(select c.CATE_Path from res_category c where lovely.CR_ResType=c.CATE_ID ) as  CR_Path from res_lovecountry_room lovely where lovely.CR_ID = " + ID );
			
			if (rs.next()) {
				json.put("CR_ID",rs.getString("CR_ID")); 
				json.put("CR_Name",rs.getString("CR_Name")); 
				json.put("CR_Content",rs.getString("CR_Content"));  
				json.put("CR_UserID",rs.getString("CR_UserID"));  
				json.put("CR_ResType",rs.getString("CR_ResType"));  
				
				json.put("CR_Path",rs.getString("CR_Path"));  
				json.put("CR_ResTypeName",rs.getString("CR_ResTypeName"));  
				json.put("CR_CateTwLevel_Name",rs.getString("CR_CateTwLevel_Name"));  
				
				json.put("CR_ConType",rs.getString("CR_ConType")); 
				json.put("CR_UserAccount",rs.getString("CR_UserAccount"));  
				json.put("CR_OperateTime",rs.getString("CR_OperateTime"));  
				json.put("CR_CreateTime",rs.getString("CR_CreateTime"));  
				json.put("CR_Grade",rs.getString("CR_Grade"));  
				json.put("CR_TaskId",rs.getString("CR_TaskId")); 
				json.put("CR_Thumbnail ",rs.getString("CR_Thumbnail")); 
				json.put("CR_Creator ",rs.getString("CR_Creator"));
				json.put("CR_Upload",rs.getString("CR_Upload"));  
				json.put("CR_FileSwf",rs.getString("CR_FileSwf")); 
				json.put("CR_Type",rs.getString("CR_Type"));
		
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
