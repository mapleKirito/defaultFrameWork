package com.ow.module.event.sysmgr.projection.mod;

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

public class SmallProjectionMod {
	public static Object SmallEx(String erID,String Url){
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
			rs = (ResultSet) stat.executeQuery("select projection.PR_ID, projection.PR_Upload, projection.PR_Name, projection.PR_Category,projection.PR_FileSwf,projection.PR_Outline, projection.PR_Thumbnail, projection.PR_UserID,projection.PR_Type,projection.PR_UserAccount, projection.PR_OperateTime,projection.PR_JieProID,projection.PR_JieProName,projection.PR_Category_Name,projection.PR_CreateTime, projection.PR_Creator  ,projection.PR_Grade ,case when c.CATE_Name is null or c.CATE_Name = '' then '顶级分类' else c.CATE_Name end as PR_Category_Name,(select c.CATE_Path from res_category c where projection.PR_CateTwLevel=c.CATE_ID ) as  PR_Path from res_projection_room projection left join res_category c on c.CATE_ID = projection.PR_Category where projection.PR_ID =" + erID );
			if (rs.next()) {
				json.put("PR_ID",rs.getString("PR_ID")); 
				json.put("PR_Upload",rs.getString("PR_Upload")); 
				json.put("PR_Name",rs.getString("PR_Name"));
				json.put("PR_Category",rs.getString("PR_Category"));
				json.put("PR_FileSwf",rs.getString("PR_FileSwf"));
				json.put("PR_Outline",rs.getString("PR_Outline"));
				json.put("PR_Thumbnail",rs.getString("PR_Thumbnail")); 
				json.put("PR_UserID",rs.getString("PR_UserID"));
				json.put("PR_Path",rs.getString("PR_Path"));
				json.put("PR_Type",rs.getString("PR_Type"));
				json.put("PR_UserAccount",rs.getString("PR_UserAccount")); 
				json.put("PR_OperateTime",rs.getString("PR_OperateTime"));
				json.put("PR_JieProID",rs.getString("PR_JieProID"));
				json.put("PR_JieProName",rs.getString("PR_JieProName"));
				json.put("PR_Category_Name",rs.getString("PR_Category_Name"));
				json.put("PR_CreateTime",rs.getString("PR_CreateTime"));
				json.put("PR_Creator",rs.getString("PR_Creator"));
				json.put("PR_Grade",rs.getString("PR_Grade"));
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
