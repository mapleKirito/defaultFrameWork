package com.ow.framework.data.handler.config;



import java.util.HashMap;
import java.util.List;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.dao.SessionFactory;
import com.ow.framework.data.handler.IHandlerCriteria;
import com.ow.framework.exception.DetailException;
import com.ow.framework.util.Encrypt;

public class SystemDataInit implements IHandlerCriteria
{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private SqlSession sqlSession;
	/**数据源名称*/
	private String dsname;
	
	public SystemDataInit(String dsname)
	{
		this.dsname = dsname;
	}
	
	@SuppressWarnings("rawtypes")
	public void appInit()
	{
		try
		{
			System.out.println("系统机构、用户、角色信息初始化，请稍后……");
	    	try {
				this.sqlSession = SessionFactory.getInstance().getSQLSession(this.dsname,ExecutorType.SIMPLE,false);
			} catch (Exception e) {
				String debug = DetailException.expDetail(e, SystemDataInit.class);
				log.debug(debug);
				throw e;
			}			
			HashMap<String,Object> om = Constant.ORG_MAP;
			Object objOrg  = sqlSession.selectOne("org.select_by_code", om);
			if (objOrg == null){
				sqlSession.insert("org.insert", om);
				String orgid = om.get("generatedKey") == null?"":om.get("generatedKey").toString();
				om.put("orgRelation",","+orgid+",");
				sqlSession.update("org.update_relation",om);
			}
			else{
				sqlSession.update("org.update",om);
			}
			//初始化超级管理员用户
			/*HashMap<String,Object> um = Constant.USER_MAP;
			String pwd = Constant.USER_MAP.get("userPassword") == null? "administrator" : Constant.USER_MAP.get("userPassword").toString();
			Object objUser  = sqlSession.selectOne("user.select_by_account", Constant.USER_MAP);
			if (objUser == null){
				um.put("userPassword", Encrypt.getMD5(pwd));				
				sqlSession.insert("user.init_insert", um);
			}
			else{
				sqlSession.update("user.init_update", um);
			}*/
			HashMap<String,Object> um = Constant.USER_MAP;
			String pwd = Constant.USER_MAP.get("userPassword") == null? "administrator" : Constant.USER_MAP.get("userPassword").toString();
			Object objUser  = sqlSession.selectOne("user.select_by_account", Constant.USER_MAP);
			String userID2 = null;
			if (objUser == null){
				um.put("userPassword", Encrypt.getMD5(pwd));				
				sqlSession.insert("user.init_insert", um);
				userID2 = ((HashMap)um).get("generatedKey") == null ?null:((HashMap)um).get("generatedKey").toString();
				um.put("userID", userID2);				
			}
			else{
				if (objUser instanceof HashMap){
					userID2 = ((HashMap)objUser).get("userID") == null ?null:((HashMap)objUser).get("userID").toString();
					um.put("userID", userID2);
				}			
				um.remove("userPassword");
				sqlSession.update("user.init_update", um);
			}
			
			//查询角色，判断角色是否存在若存在就修改，不存在就插入
			Object objRoledf = sqlSession.selectOne("role.select_by_name", Constant.USER_MAP);
			String dfroleID = null;
			if (objRoledf == null){
				sqlSession.insert("role.insert_default", um);
			}
			else{
				if (objRoledf instanceof HashMap){
					dfroleID = ((HashMap)objRoledf).get("roleID") == null ?null:((HashMap)objRoledf).get("roleID").toString();
					um.put("roleID", dfroleID);
				}
				sqlSession.update("role.update_default", um);
			}
			//删除用户角色关系
			sqlSession.delete("userRole.delete", um);
			//插入用户角色关系
			sqlSession.insert("userRole.inti_insert", um);
			//删除角色权限关系
			sqlSession.delete("rolepms.delete", um);
			//插入角色权限关系
			String acode3 = Constant.USER_MAP.get("roleAuth") == null?"":Constant.USER_MAP.get("roleAuth").toString();
			String acodeArr3 [] = acode3.split(",");
			for (int i=0; i<acodeArr3.length; i++){
				if (acodeArr3[i] != null && !acodeArr3[i].equals("")){
					um.put("acode", acodeArr3[i]);
				
					//插入角色权限关系
					sqlSession.insert("rolepms.insert_default",um);	
				}
			}
			System.out.println("超级管理员角色初始化成功！");
			//初始化学校管理员用户
			HashMap<String,Object> hashMap = Constant.SCHOOL_USER_MAP;
			String pwd2 = Constant.SCHOOL_USER_MAP.get("userPassword") == null? "admin" : Constant.SCHOOL_USER_MAP.get("userPassword").toString();
			Object objUser2  = sqlSession.selectOne("user.select_by_account", Constant.SCHOOL_USER_MAP);
			String userID = null;
			if (objUser2 == null){
				hashMap.put("userPassword", Encrypt.getMD5(pwd2));				
				sqlSession.insert("user.init_insert", hashMap);
				userID = ((HashMap)hashMap).get("generatedKey") == null ?null:((HashMap)hashMap).get("generatedKey").toString();
				hashMap.put("userID", userID);				
			}
			else{
				if (objUser2 instanceof HashMap){
					userID = ((HashMap)objUser2).get("userID") == null ?null:((HashMap)objUser2).get("userID").toString();
					hashMap.put("userID", userID);
				}			
				hashMap.remove("userPassword");
				sqlSession.update("user.init_update", hashMap);
			}
			//查询角色，判断角色是否存在若存在就修改，不存在就插入
			Object objRole = sqlSession.selectOne("role.select_by_name", Constant.SCHOOL_USER_MAP);
			String roleID = null;
			if (objRole == null){
				sqlSession.insert("role.insert_default", hashMap);
			}
			else{
				if (objRole instanceof HashMap){
					roleID = ((HashMap)objRole).get("roleID") == null ?null:((HashMap)objRole).get("roleID").toString();
					hashMap.put("roleID", roleID);
				}
				sqlSession.update("role.update_default", hashMap);
			}
			//删除用户角色关系
			sqlSession.delete("userRole.delete", hashMap);
			//插入用户角色关系
			sqlSession.insert("userRole.inti_insert", hashMap);
			//删除角色权限关系
			sqlSession.delete("rolepms.delete", hashMap);
			//插入角色权限关系
			String acode = Constant.SCHOOL_USER_MAP.get("roleAuth") == null?"":Constant.SCHOOL_USER_MAP.get("roleAuth").toString();
			String acodeArr [] = acode.split(",");
			for (int i=0; i<acodeArr.length; i++){
				if (acodeArr[i] != null && !acodeArr[i].equals("")){
					hashMap.put("acode", acodeArr[i]);
					
					//插入角色权限关系
					sqlSession.insert("rolepms.insert_default",hashMap);	
				}
			}
			
			System.out.println("系统机构、用户、角色初始化成功！");
//			System.out.println("系统地区信息初始化，请稍后……");
//			HashMap nhashMap = new HashMap();
//			List list = sqlSession.selectList("area.select");
//			for (int i=0; i<list.size();i++){
//				String pid = ((HashMap)list.get(i)).get("areaID").toString();
//				String name = ((HashMap)list.get(i)).get("areaName").toString();
//				int ii = name.indexOf("1");
//				if (ii >= 0){
//					name = name.substring(0,ii);
//				}
//				nhashMap.put("areaName", name);
//				nhashMap.put("areaSign", converterToSpell(name));
//				nhashMap.put("areaID", pid);
//				sqlSession.update("area.update_name",nhashMap);
//			}
//			try {
//				// 打开上传的表格
//				InputStream is = new FileInputStream("D:\\area.xls");
//				// 得到工作表里的内容
//				jxl.Workbook rwb = Workbook.getWorkbook(is);
//				// 读取第一个工作表的数据
//				jxl.Sheet rs = rwb.getSheet(0);
//				// 这里涉及到内容的回显,以及数据库字段的映射所以这里只取第一行
//				int num = rs.getRows();
//				HashMap nhashMap = new HashMap();
//				<if test="areaParentID!=null">,AREA_ParentID</if>
//				<if test="areaName!=null">,AREA_Name</if>
//				<if test="areaPath!=null">,AREA_Path</if>
//				<if test="areaSign!=null">,AREA_Sign</if>
//				<if test="areaLevel!=null">,AREA_Level</if>
//				<if test="areaIsChild!=null">,AREA_IsChild</if>
//				<if test="s_userID!=null">,AREA_UserID</if>
//				<if test="s_userLoginAccount!=null">,AREA_UserAccount</if>
//				,AREA_OperateTime
//				,AREA_CreateTime
//				<if test="s_userLoginAccount!=null">,AREA_Creator</if>
//				update_name
//				int index = 0;
//				for (int j=0; j<num; j++){
//					// 得到第i行的数据..返回cell数组
//					Cell[] cell = rs.getRow(j);
//					String g = cell[0].getContents().trim();
//					String p = cell[1].getContents().trim();
//					String c = cell[2].getContents().trim();
//					String x = cell[3].getContents().trim();
//					System.out.println("g:" + g+"--p:" + p +"--c:" + c + "--x:" +x);
//					if (!p.equals("")){
//						nhashMap.put("areaName", c);
//						Object gobj = sqlSession.selectOne("area.select_one_by_name", nhashMap);
//						String pid = ((HashMap)gobj).get("areaID").toString();
//						String path = ((HashMap)gobj).get("areaPath").toString();
//						nhashMap.put("areaName", x);
//						Object cobj = sqlSession.selectOne("area.select_one_by_name", nhashMap);
//						if (cobj == null){
//							index++;
//							nhashMap.put("areaID", index);
//							nhashMap.put("areaName", x);
//							nhashMap.put("areaParentID", pid);
//							nhashMap.put("areaSign", converterToSpell(x));
//							nhashMap.put("areaLevel", "1");
//							nhashMap.put("areaPath", ",0,");
//							nhashMap.put("areaIsChild", "1");
//							nhashMap.put("s_userLoginAccount", "admin");
//							sqlSession.insert("area.insert",nhashMap);
//							String aid = nhashMap.get("generatedKey").toString();
//							nhashMap.put("areaID", aid);
//							nhashMap.put("areaPath", path+aid + ",");
//							sqlSession.update("area.update_relation",nhashMap);
//						}
//					}
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			System.out.println("系统地区信息初始化完成");
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SystemDataInit.class);
			log.error(error);
			System.out.println("系统机构、用户、角色初始化失败！");
			System.exit(0);
		}
		finally{
			/**提交事物*/
			if (sqlSession != null)
			{
				sqlSession.commit();
				sqlSession.close();
			}	
		}
	}
	
    public static String converterToSpell(String chines){              
        String pinyinName = "";      
        char[] nameChar = chines.toCharArray();      
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();      
        defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);      
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);      
        for (int i = 0; i < nameChar.length; i++) {      
            if (nameChar[i] > 128) {      
                try {      
                    pinyinName += PinyinHelper.toHanyuPinyinStringArray(nameChar[i], defaultFormat)[0];      
                } catch (BadHanyuPinyinOutputFormatCombination e) {      
                    e.printStackTrace();      
                }      
            }else{      
                pinyinName += nameChar[i];      
            }      
        }      
        return pinyinName;      
    } 	
}
