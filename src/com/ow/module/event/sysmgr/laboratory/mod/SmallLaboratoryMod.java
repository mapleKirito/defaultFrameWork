package com.ow.module.event.sysmgr.laboratory.mod;

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

public class SmallLaboratoryMod {
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
			rs = (ResultSet) stat.executeQuery("select laboratory.LR_ID,laboratory.LR_Content,laboratory.LR_CateTwLevel_Name,laboratory.LR_CateTwLevel, laboratory.LR_NO, laboratory.LR_Upload,laboratory.LR_Name,laboratory.LR_FileSwf,laboratory.LR_Category, laboratory.LR_ExperimentSupplies,laboratory.LR_Type, laboratory.LR_Thumbnail, laboratory.LR_UserID,laboratory.LR_UserAccount, laboratory.LR_OperateTime,laboratory.LR_CreateTime, laboratory.LR_Creator ,laboratory.LR_Grade ,case when c.CATE_Name is null or c.CATE_Name = '' then '顶级分类' else c.CATE_Name end as LR_CategoryName,(select c.CATE_Path from res_category c where laboratory.LR_Category=c.CATE_ID ) as  LR_Path from res_laboratory_room laboratory left join res_category c on c.CATE_ID = laboratory.LR_Category where laboratory.LR_ID =" + ID );			
			if (rs.next()) {
				json.put("LR_ID" ,rs.getString("LR_ID"));
				json.put("LR_NO" ,rs.getString("LR_NO"));
				json.put("LR_Upload" ,rs.getString("LR_Upload"));
				json.put("LR_Type",rs.getString("LR_Type"));
				json.put("LR_Name" ,rs.getString("LR_Name"));
				json.put("LR_FileSwf",rs.getString("LR_FileSwf"));
				json.put("LR_Category" ,rs.getString("LR_Category"));
				json.put("LR_CategoryName",rs.getString("LR_CategoryName"));
				
				json.put("LR_Path",rs.getString("LR_Path"));
				json.put("LR_CateTwLevel" ,rs.getString("LR_CateTwLevel"));
				json.put("LR_CateTwLevel_Name",rs.getString("LR_CateTwLevel_Name"));
				
				json.put("LR_ExperimentSupplies",rs.getString("LR_ExperimentSupplies"));
				json.put("LR_Content",rs.getString("LR_Content"));
				json.put("LR_Thumbnail",rs.getString("LR_Thumbnail"));
				json.put("LR_UserID",rs.getString("LR_UserID"));
				json.put("LR_UserAccount",rs.getString("LR_UserAccount"));
				json.put("LR_OperateTime",rs.getString("LR_OperateTime"));
				json.put("LR_CreateTime",rs.getString("LR_CreateTime"));
				json.put("LR_Creator",rs.getString("LR_Creator"));
				json.put("LR_Grade",rs.getString("LR_Grade"));
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
