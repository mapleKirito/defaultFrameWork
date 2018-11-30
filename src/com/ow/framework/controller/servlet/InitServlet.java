package com.ow.framework.controller.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.net.MalformedURLException;
import java.util.HashMap;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.log4j.Logger;

import com.SmartServer.util.ModuleStatesUtils;
import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.common.Constant;
import com.ow.framework.data.handler.CollectionInit;
import com.ow.framework.data.handler.config.PermissionConfig;
import com.ow.framework.data.handler.config.ServerSqlConfig;
import com.ow.framework.data.handler.config.SqlSessionConfig;
import com.ow.framework.data.handler.config.SystemDataConfig;
import com.ow.framework.data.handler.config.SystemDataInit;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.impl.GODEvent;
  
public class InitServlet extends HttpServlet
{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private static final long serialVersionUID = 2994828437175265025L;
	private CollectionInit collectionInit;

	public void init(ServletConfig param) throws ServletException
	{
		if(GODEvent.getInstancegod()){
			try
			{
				String filePath = param.getServletContext().getRealPath("/");
				if(filePath == null){
					try {
						filePath = param.getServletContext().getResource("/").toString();
					} catch (MalformedURLException e) {
						e.printStackTrace();
					}
				}
				//设置系统根目录
				Constant.ROOT = filePath;
				Properties props=new Properties();
	            String configFile = filePath + File.separator + "WEB-INF" + File.separator + "classes" + File.separator + "config" + File.separator + "framework.properties";
	            props.load(new FileInputStream(configFile));
	    		String dsname = props.getProperty("framework.datasource.name") == null ? "" : props.getProperty("framework.datasource.name").trim();
	    		String pmsStartCode = props.getProperty("framework.permission.start.code") == null ? "" : props.getProperty("framework.permission.start.code").trim();
	    		Constant.PERMISSION_START_CODE = pmsStartCode;
	    		
	    		String orgName = props.getProperty("framework.org.name") == null ? "" : props.getProperty("framework.org.name").trim();
	    		String orgCode = props.getProperty("framework.org.code") == null ? "" : props.getProperty("framework.org.code").trim();
	    		String orgPhone = props.getProperty("framework.org.phone") == null ? "" : props.getProperty("framework.org.phone").trim();
	    		String orgFax = props.getProperty("framework.org.fax") == null ? "" : props.getProperty("framework.org.fax").trim();
	    		String orgPostcode = props.getProperty("framework.org.postCode") == null ? "" : props.getProperty("framework.org.postCode").trim();
	    		String orgAddress = props.getProperty("framework.org.address") == null ? "" : props.getProperty("framework.org.address").trim();
	    		HashMap<String,Object> orgMap = new HashMap<String,Object>();
	    		orgMap.put("orgName", orgName);
	    		orgMap.put("orgCode", orgCode);
	    		orgMap.put("orgRelation", ",1,");
	    		orgMap.put("orgParentID", "0");
	    		orgMap.put("orgLevel", "1");
	    		orgMap.put("orgPhone", orgPhone);
	    		orgMap.put("orgFax", orgFax);
	    		orgMap.put("orgPostcode", orgPostcode);
	    		orgMap.put("orgAddress", orgAddress);
	    		orgMap.put("orgStatus", "0");
	    		orgMap.put("orgParentName", "");
	    		orgMap.put("orgIsChild", "0");
	    		orgMap.put("orgCreator", "system");
	    		Constant.ORG_MAP = orgMap;
	    		
	    		String userAccount = props.getProperty("framework.user.account") == null ? "" : props.getProperty("framework.user.account").trim();
	    		String userName = props.getProperty("framework.user.name") == null ? "" : props.getProperty("framework.user.name").trim();
	    		String userPassword = props.getProperty("framework.user.name") == null ? "" : props.getProperty("framework.user.name").trim();
	    		String userGender = props.getProperty("framework.user.gender") == null ? "" : props.getProperty("framework.user.gender").trim();
	    		String userMobilePhone = props.getProperty("framework.user.mobilePhone") == null ? "" : props.getProperty("framework.user.mobilePhone").trim();
	    		String userOfficePhone = props.getProperty("framework.user.officePhone") == null ? "" : props.getProperty("framework.user.officePhone").trim();
	    		String userEmail = props.getProperty("framework.user.email") == null ? "" : props.getProperty("framework.user.email").trim();
	    		String defaultuseindex = props.getProperty("framework.default.role.index") == null ? "" : props.getProperty("framework.default.role.index").trim();
	    		String usname1 = props.getProperty("framework.default.role.name") == null ? "" : props.getProperty("framework.default.role.name").trim();
	    		String usdesc1 = props.getProperty("framework.default.role.desc") == null ? "" : props.getProperty("framework.default.role.desc").trim();
	    		String usauth1 = props.getProperty("framework.default.role.auth.code") == null ? "" : props.getProperty("framework.default.role.auth.code").trim();    		
	    		HashMap<String,Object> userMap = new HashMap<String,Object>();
	    		userMap.put("userAccount", userAccount);
	    		userMap.put("userName", userName);
	    		userMap.put("userPassword", userPassword);
	    		userMap.put("userType", "0");
	    		userMap.put("userGender", userGender);
	    		userMap.put("userMobilePhone", userMobilePhone);
	    		userMap.put("userOfficePhone", userOfficePhone);
	    		userMap.put("userEmail", userEmail);
	    		userMap.put("userStatus", "0");
	    		userMap.put("userCreator", "system");
	    		userMap.put("roleName", usname1);
	    		userMap.put("roleDesc", usdesc1);
	    		userMap.put("roleStatus", "0");
	    		userMap.put("roleAuth", usauth1); 
	    		userMap.put("roleIndex", defaultuseindex);
	    		Constant.USER_MAP = userMap;   
	    		
	    		//学校管理员初始化
	    		String userSchoolAccount = props.getProperty("framework.school.user.account") == null ? "" : props.getProperty("framework.school.user.account").trim();
	    		String userSchoolName = props.getProperty("framework.school.user.name") == null ? "" : props.getProperty("framework.school.user.name").trim();
	    		String userSchoolPassword = props.getProperty("framework.school.user.name") == null ? "" : props.getProperty("framework.school.user.name").trim();
	    		String userSchoolGender = props.getProperty("framework.school.user.gender") == null ? "" : props.getProperty("framework.school.user.gender").trim();
	    		String userSchoolMobilePhone = props.getProperty("framework.school.user.mobilePhone") == null ? "" : props.getProperty("framework.school.user.mobilePhone").trim();
	    		String userSchoolOfficePhone = props.getProperty("framework.school.user.officePhone") == null ? "" : props.getProperty("framework.school.user.officePhone").trim();
	    		String userSchoolEmail = props.getProperty("framework.school.user.email") == null ? "" : props.getProperty("framework.school.user.email").trim();
	    		String usname = props.getProperty("framework.school.role.name") == null ? "" : props.getProperty("framework.school.role.name").trim();
	    		String usdesc = props.getProperty("framework.school.role.desc") == null ? "" : props.getProperty("framework.school.role.desc").trim();
	    		String usauth = props.getProperty("framework.school.role.auth.code") == null ? "" : props.getProperty("framework.school.role.auth.code").trim();    		
	    		String useindex = props.getProperty("framework.school.role.index") == null ? "" : props.getProperty("framework.school.role.index").trim();
	    		HashMap<String,Object> userSchoolMap = new HashMap<String,Object>();
	    		userSchoolMap.put("userAccount", userSchoolAccount);
	    		userSchoolMap.put("userName", userSchoolName);
	    		userSchoolMap.put("userPassword", userSchoolPassword);
	    		userSchoolMap.put("userType", "3");
	    		userSchoolMap.put("userGender", userSchoolGender);
	    		userSchoolMap.put("userMobilePhone", userSchoolMobilePhone);
	    		userSchoolMap.put("userOfficePhone", userSchoolOfficePhone);
	    		userSchoolMap.put("userEmail", userSchoolEmail);
	    		userSchoolMap.put("userStatus", "0");
	    		userSchoolMap.put("userCreator", "system");
	    		userSchoolMap.put("roleName", usname);
	    		userSchoolMap.put("roleDesc", usdesc);
	    		userSchoolMap.put("roleStatus", "0");
	    		userSchoolMap.put("roleAuth", usauth); 
	    		userSchoolMap.put("roleIndex", useindex);
	    		Constant.SCHOOL_USER_MAP = userSchoolMap;       		
	    		
	    		//初始化角色信息
	    		String name = props.getProperty("framework.role.name") == null ? "" : props.getProperty("framework.role.name").trim();
	    		String desc = props.getProperty("framework.role.desc") == null ? "" : props.getProperty("framework.role.desc").trim();
	    		String auth = props.getProperty("framework.role.auth.code") == null ? "" : props.getProperty("framework.role.auth.code").trim();
	    		HashMap<String,Object> roleMap = new HashMap<String,Object>();
	    		roleMap.put("roleName", name);
	    		roleMap.put("roleDesc", desc);
	    		roleMap.put("roleStatus", "1");
	    		roleMap.put("roleAuth", auth);
	    		Constant.ROLE_MAP = roleMap;  
	    		
	    		//邮件服务器内容
	    		Constant.sendMailSmtp = props.getProperty("sendMailSmtp") == null ? "" : props.getProperty("sendMailSmtp").trim();
	    		Constant.sendMailSmtpPort = props.getProperty("sendMailSmtpPort") == null ? "" : props.getProperty("sendMailSmtpPort").trim();
	    		Constant.sendMailAccount = props.getProperty("sendMailAccount") == null ? "" : props.getProperty("sendMailAccount").trim();
	    		Constant.sendMailPwd = props.getProperty("sendMailPwd") == null ? "" : props.getProperty("sendMailPwd").trim();
	    		Constant.mailAuthor = props.getProperty("mailAuthor") == null ? "" : props.getProperty("mailAuthor").trim();
	    		Constant.sendMailSender = props.getProperty("sendMailSender") == null ? "" : props.getProperty("sendMailSender").trim();
	    		Constant.sendMail_ssl_flag = props.getProperty("sendMail_ssl_flag") == null ? "" : props.getProperty("sendMail_ssl_flag").trim();
	    		Constant.sendMailReplyMail = props.getProperty("sendMailReplyMail") == null ? "" : props.getProperty("sendMailReplyMail").trim();
				String relPath = filePath + File.separator + "WEB-INF" + File.separator + "config" + File.separator;
				String filePermission = relPath+"module";
				String fileIbtatisConfig = filePath + File.separator + "WEB-INF" + File.separator + "classes" + File.separator +"com" + File.separator + "ow" + File.separator + "framework" + File.separator + "data" + File.separator + "dao" + File.separator + "xml" + File.separator + "ibatis.config.xml";
				
				//执行数据库主键配置
				String readServerSqlFile = filePath + File.separator + "WEB-INF" + File.separator + "classes" + File.separator + "config" + File.separator + "server-sql-config.properties";
				//资源导出
				Constant.exportTable = props.getProperty("exportTable") == null ? Constant.exportTable : props.getProperty("exportTable") ;
				Constant.exprotFilePath = props.getProperty("exprotFilePath") == null ? Constant.exprotFilePath : props.getProperty("exprotFilePath") ;
				
				collectionInit = new CollectionInit();
				collectionInit.addInit(new SqlSessionConfig(fileIbtatisConfig));
				collectionInit.addInit(new PermissionConfig(filePermission,dsname));
				collectionInit.addInit(new SystemDataInit(dsname));
				collectionInit.addInit(new SystemDataConfig());
				collectionInit.addInit(new ServerSqlConfig(readServerSqlFile, dsname)) ;
				collectionInit.doInit();
				
				//文件格式配置
				Constant.imageFormat = props.getProperty("imageFormat") == null ? Constant.imageFormat : props.getProperty("imageFormat") ;
				Constant.videoFormat = props.getProperty("videoFormat") == null ? Constant.videoFormat : props.getProperty("videoFormat") ;
				Constant.audioFormat = props.getProperty("audioFormat") == null ? Constant.audioFormat : props.getProperty("audioFormat") ;
				Constant.wordFormat = props.getProperty("wordFormat") == null ? Constant.wordFormat : props.getProperty("wordFormat") ;
				Constant.pptFormat = props.getProperty("pptFormat") == null ? Constant.pptFormat : props.getProperty("pptFormat") ;
				Constant.pdfFormat = props.getProperty("pdfFormat") == null ? Constant.pdfFormat : props.getProperty("pdfFormat") ;
				Constant.officeFormat = props.getProperty("officeFormat") == null ? Constant.officeFormat : props.getProperty("officeFormat") ;
				Constant.flashFormat = props.getProperty("flashFormat") == null ? Constant.flashFormat : props.getProperty("flashFormat") ;
				Constant.rarFormat = props.getProperty("rarFormat") == null ? Constant.rarFormat : props.getProperty("rarFormat") ;
				
				//在线阅读配置
				String readORMFile = filePath + File.separator + "WEB-INF" + File.separator + "classes" + File.separator + "config" + File.separator + "orm-params.properties";
				Properties readProps=new Properties();
				readProps.load(new FileInputStream(readORMFile));
				//通过哪一种方式进行转换  1:openoffice  2:libreoffice
				ConstantI.TRANSFORTYPEFLAG_KEY = readProps.getProperty("orm.transforTypeFlag");
				//获得pdf转换jar包路径
				ConstantI.PDFJARPATH_KEY = readProps.getProperty("orm.pdfJarPath");
				//获得swf服务地址
				ConstantI.SWFTOOLSPATH_KEY = readProps.getProperty("orm.swfToolsPath");
				//获得能够转换的文件类型
				ConstantI.ONLINEREADFILETYPE_KEY = readProps.getProperty("orm.onlineReadFileType");
				//获得多维观察允许上传类型
				ConstantI.RARZIP_KEY = Constant.rarFormat;
				//获得在线阅读页面
				ConstantI.ONLINEREADPATH_KEY = readProps.getProperty("orm.onlineReadPath");
				
				ConstantI.ISGOD_KEY = readProps.getProperty("orm.onlyisgodkey");
				ConstantI.ISCOUNT_KEY = readProps.getProperty("orm.onlyiscountkey");
				//配置upload映射路径
				ConstantI.UPLOADPATH_KEY = readProps.getProperty("orm.uploadptah");
				//配置address映射路径
				ConstantI.ADDRESS_KEY = readProps.getProperty("orm.address");
				
				String states=ModuleStatesUtils.getStates();
				//配置激活状态
				ConstantI.SYSTEM_STATUS = states;
				
				
				String readORMvsersion = filePath + File.separator + "WEB-INF" + File.separator + "classes" + File.separator + "config" + File.separator + "orm-version.properties";
				Properties readPropsversion=new Properties();
				readPropsversion.load(new FileInputStream(readORMvsersion));
	
				ConstantI.VERSION_KEY = readPropsversion.getProperty("framework.version.name");
			}
			catch (Exception e)
			{
				String debug = DetailException.expDetail(e, InitServlet.class);
				log.debug(debug);
				/**异常退出系统*/
				System.exit(0);
			}
		}
	}
	public void destroy()
	{		
	}
}