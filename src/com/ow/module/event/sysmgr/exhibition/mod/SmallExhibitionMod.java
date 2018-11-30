package com.ow.module.event.sysmgr.exhibition.mod;

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

public class SmallExhibitionMod {
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
			rs = (ResultSet) stat.executeQuery("select "+
			" exhibition.ER_ID,exhibition.ER_CountLike,exhibition.ER_RelLinksState,exhibition.ER_RelatedLinks,exhibition.ER_ContentPath,exhibition.ER_StoryState, exhibition.ER_Content,  exhibition.ER_Recommen, exhibition.ER_ChorID, exhibition.ER_Chor, exhibition.ER_Code, exhibition.ER_Upload, exhibition.ER_Name, exhibition.ER_TotalID,exhibition.ER_Total,"+
			" exhibition.ER_Type, exhibition.ER_Category, exhibition.ER_Order, exhibition.ER_Audio," +
			" exhibition.ER_Genus, exhibition.ER_LatinName,exhibition.ER_Contest," +
			" exhibition.ER_OrderID, exhibition.ER_GenusID, exhibition.ER_LatinNameID,exhibition.ER_City," +
			" exhibition.ER_BiologicalReserve, exhibition.ER_Hunters," +
			" exhibition.ER_SpecimensNo, exhibition.ER_SpecimensDate, exhibition.ER_Keywords," +
			" exhibition.ER_Country, exhibition.ER_Province, exhibition.ER_About,exhibition.ER_Relation," +
			" exhibition.ER_PlaceName, exhibition.ER_Longitude," +
			" exhibition.ER_Latitude, exhibition.ER_Habitat," +
			" exhibition.ER_Characteristics, exhibition.ER_Description," +
			" exhibition.ER_Elevation, exhibition.ER_Identifier,exhibition.ER_Grade," +
			" exhibition.ER_IdentifierDate, exhibition.ER_Use," +
			" exhibition.ER_Remarks, exhibition.ER_Thumbnail, exhibition.ER_UserID,exhibition.ER_InThum," +
			" exhibition.ER_UserAccount, DATE_FORMAT(exhibition.ER_OperateTime,'%Y-%m-%d %H:%i:%s') ER_OperateTime," +
			" DATE_FORMAT(exhibition.ER_CreateTime,'%Y-%m-%d')  ER_CreateTime, exhibition.ER_Creator ," +
			" exhibition.ER_CategoryName ,exhibition.ER_IsShare ," +
			" exhibition.ER_JieID, exhibition.ER_Jie, exhibition.ER_GangID, exhibition.ER_Gang,  exhibition.ER_Custom," +
			" a_co.AREA_Name as ER_Country_Name," +
			" a_p.AREA_Name as ER_Province_Name,a_ci.AREA_Name as erCityName," +
			" (select c.CATE_Path from res_category c where exhibition.ER_GangID=c.CATE_ID ) as  er_Path" +
			" from" +
			" res_exhibition_room exhibition" +
			" left join sys_area a_co on a_co.AREA_ID = exhibition.ER_Country" +
			" left join sys_area a_p on a_p.AREA_ID = exhibition.ER_Province" +
			" left join sys_area a_ci on a_ci.AREA_ID = exhibition.ER_City" +
			" where" +
			" exhibition.ER_ID = " +erID);
			if (rs.next()) {
				json.put("ER_ID",rs.getString("ER_ID"));
				json.put("ER_Code",rs.getString("ER_Code"));
				json.put("ER_Recommen",rs.getString("ER_Recommen"));
				json.put("ER_Type",rs.getString("ER_Type"));
				json.put("ER_Upload",rs.getString("ER_Upload"));
				json.put("ER_Audio",rs.getString("ER_Audio"));
				json.put("ER_InThum",rs.getString("ER_InThum"));
				json.put("ER_Thumbnail",rs.getString("ER_Thumbnail"));
				
				json.put("ER_Name",rs.getString("ER_Name"));
				json.put("ER_Path",rs.getString("ER_Path"));
				
				json.put("ER_TotalID",rs.getString("ER_TotalID"));
				json.put("ER_Total",rs.getString("ER_Total"));
				json.put("ER_JieID",rs.getString("ER_JieID"));
				json.put("ER_Jie",rs.getString("ER_Jie"));
				json.put("ER_ChorID",rs.getString("ER_ChorID"));
				json.put("ER_Chor",rs.getString("ER_Chor"));
				json.put("ER_GangID",rs.getString("ER_GangID"));
				json.put("ER_Gang",rs.getString("ER_Gang"));
				json.put("ER_OrderID",rs.getString("ER_OrderID"));
				json.put("ER_Order",rs.getString("ER_Order"));
				json.put("ER_Category",rs.getString("ER_Category"));
				json.put("ER_CategoryName",rs.getString("ER_CategoryName"));
				json.put("ER_GenusID",rs.getString("ER_GenusID"));
				json.put("ER_Genus",rs.getString("ER_Genus"));
			
				json.put("ER_Custom",rs.getString("ER_Custom"));
				json.put("ER_LatinNameID",rs.getString("ER_LatinNameID"));
				json.put("ER_LatinName",rs.getString("ER_LatinName"));
				json.put("ER_BiologicalReserve",rs.getString("ER_BiologicalReserve"));
				json.put("ER_Hunters",rs.getString("ER_Hunters"));
				json.put("ER_SpecimensNo",rs.getString("ER_SpecimensNo"));
				json.put("ER_SpecimensDate",rs.getString("ER_SpecimensDate"));
				
				json.put("ER_Country",rs.getString("ER_Country"));
				json.put("ER_Country_Name",rs.getString("ER_Country_Name"));
				json.put("ER_Province",rs.getString("ER_Province"));
				json.put("ER_Province_Name",rs.getString("ER_Province_Name"));
				json.put("ER_PlaceName",rs.getString("ER_PlaceName"));
				
				json.put("ER_Longitude",rs.getString("ER_Longitude"));
				json.put("ER_Latitude",rs.getString("ER_Latitude"));
				json.put("ER_Habitat",rs.getString("ER_Habitat"));
				
				json.put("ER_Description",rs.getString("ER_Description"));
				json.put("ER_Elevation",rs.getString("ER_Elevation"));
				json.put("ER_Characteristics",rs.getString("ER_Characteristics"));
				json.put("ER_Identifier",rs.getString("ER_Identifier"));
				json.put("ER_IdentifierDate",rs.getString("ER_IdentifierDate"));
			
				json.put("ER_Use",rs.getString("ER_Use"));
				json.put("ER_Remarks",rs.getString("ER_Remarks"));
				json.put("ER_Content",rs.getString("ER_Content"));
				
				json.put("ER_Grade",rs.getString("ER_Grade"));
				json.put("ER_Contest",rs.getString("ER_Contest"));
				json.put("ER_UserID",rs.getString("ER_UserID"));
				json.put("ER_Longitude",rs.getString("ER_Longitude"));
				json.put("ER_Latitude",rs.getString("ER_Latitude"));

				json.put("ER_CreateTime",rs.getString("ER_CreateTime"));
				json.put("ER_Creator",rs.getString("ER_Creator"));
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
