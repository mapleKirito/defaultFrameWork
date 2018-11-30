package com.ow.module.event.sysmgr.observation.mod;

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

public class SmallObservationMod {
	public static Object SmallEx(String ID,String Url){
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		Properties props = new Properties();
		JSONObject json = new JSONObject(); 
		InputStream in = null;
		int index = 0;
		try {
			index++;
			in = new BufferedInputStream(new FileInputStream(Url));
			props.load(in);
			String driverClassName = props.getProperty("driverClassName");
			String url = props.getProperty("url");
			String username = props.getProperty("username");
			String password = props.getProperty("password");
			Class.forName(driverClassName);
			conn = (Connection) DriverManager.getConnection(url, username, password);
			stat = (Statement) conn.createStatement();
			rs = (ResultSet) stat.executeQuery("select observation.OR_ID, observation.OR_CateTwLevel_Name, observation.OR_CateTwLevel, observation.OR_Type,observation.OR_Content,observation.OR_InThum, observation.OR_Recommen, observation.OR_NO, observation.OR_Upload, observation.OR_Name,observation.OR_FileSwf, observation.OR_LatinName, observation.OR_LatinNameID,observation.OR_Contest, observation.OR_Description, observation.OR_Identifier, observation.OR_Remarks, observation.OR_Thumbnail, observation.OR_UserID, observation.OR_UserAccount, observation.OR_OperateTime, observation.OR_CreateTime, observation.OR_Creator ,observation.OR_Grade , observation.OR_Category, observation.OR_CategoryName ,  observation.OR_Custom ,(select c.CATE_Path from res_category c where observation.OR_Category=c.CATE_ID ) as OR_Path from res_observation_room observation where observation.OR_ID =  " + ID );
			if (rs.next()) {
				json.put("OR_ID",rs.getString("OR_ID"));
				json.put("OR_NO",rs.getString("OR_NO"));
				json.put("OR_Name",rs.getString("OR_Name"));
				json.put("OR_Recommen",rs.getString("OR_Recommen"));				
				json.put("OR_Type",rs.getString("OR_Type"));
				json.put("OR_Upload",rs.getString("OR_Upload"));
				json.put("OR_FileSwf",rs.getString("OR_FileSwf"));				
				json.put("OR_Thumbnail",rs.getString("OR_Thumbnail"));	
				json.put("OR_InThum",rs.getString("OR_InThum"));	
				
				json.put("OR_Path",rs.getString("OR_Path"));
				json.put("OR_Category",rs.getString("OR_Category"));
				json.put("OR_CategoryName",rs.getString("OR_CategoryName"));
				
				json.put("OR_CateTwLevel",rs.getString("OR_CateTwLevel"));
				json.put("OR_CateTwLevel_Name",rs.getString("OR_CateTwLevel_Name"));
			
				json.put("OR_Grade",rs.getString("OR_Grade"));
				json.put("OR_Contest",rs.getString("OR_Contest"));
				
				json.put("OR_Custom",rs.getString("OR_Custom"));	
				json.put("OR_LatinNameID",rs.getString("OR_LatinNameID"));		
				json.put("OR_LatinName",rs.getString("OR_LatinName"));	
				
				json.put("OR_Description",rs.getString("OR_Description"));
				json.put("OR_Identifier",rs.getString("OR_Identifier"));		
				json.put("OR_Remarks",rs.getString("OR_Remarks"));
				
				
				json.put("OR_Content",rs.getString("OR_Content"));
				
				
				json.put("OR_UserID",rs.getString("OR_UserID"));
				json.put("OR_UserAccount",rs.getString("OR_UserAccount"));		
				json.put("OR_OperateTime",rs.getString("OR_OperateTime"));
				json.put("OR_CreateTime",rs.getString("OR_CreateTime"));			
				json.put("OR_Creator",rs.getString("OR_Creator"));
				
			
			   
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
