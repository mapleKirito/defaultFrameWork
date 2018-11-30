package com.ow.framework.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Constant {

	/**
	 * 系统log4j日志类型
	 */
	public static final String FRAMEWORK = "FRAMEWORK";
	public static String DATA_SOURCE = "ORACLE_datasource";
	
	/**
	 * 权限配置文件初始化结构存储容器
	 */
	public static List<HashMap> PERMISSION_GLOBAL_LIST = new ArrayList();
	
	
	/**数据库类型*/
	public static String PERMISSION_START_CODE = "0";	
	
	/**常用数据类型*/
	public static String DATASOURCE_TYPE [] = {"MYSQL","ORACLE","SQLSERVER","DB2","SYBASE","INFORMIX","POSTGRES"};
	
	/**数据库类型*/
	public static String DATASOURCE_MYSQL = "MYSQL";
	public static String DATASOURCE_ORACLE = "ORACLE";
	public static String DATASOURCE_SQLSERVER = "SQLSERVER";
	public static String DATASOURCE_DB2 = "DB2";
	public static String DATASOURCE_SYBASE = "SYBASE";
	public static String DATASOURCE_INFORMIX = "INFORMIX";
	public static String DATASOURCE_POSTGRES = "POSTGRES";
	
	/**分页变量*/
	public static String PAGE_START = "start";
	public static String PAGE_OFFSET = "offset";
	
	/**记录日志的字段名称*/
	public static final String LOG_COLUMN = "logColumn";
	/**登录用户权限存放对象名*/
	public static final String S_LOGINC_PERMISSION = "s_loginPermission";
	/**登录用户ID存放对象名*/
	public static final String IS_INTERCEPTOR = "isInterceptor";	
	/**登录用户ID存放对象名*/
	public static final String S_USER_ID = "s_userID";
	/**登录用户所在机构存放对象名*/
	public static final String S_USER_ORG_ID = "s_userOrgID";	
	/**登录用户所在机构的上级机构id存放对象名*/
	public static final String S_USER_ORG_PARENT_ID = "s_userOrgParentID";		
	/**登录用户所在机构存放对象名*/
	public static final String S_USER_ORG_CODE = "s_userOrgCode";
	/**登录用户访问IP存放对象名*/
	public static final String S_USER_LOGIN_IP = "s_userLoginIP"; 
	/**登录用户性别存放对象名*/
	public static final String S_USER_GENDER = "s_userGender"; 
	/**登录用户性别存放对象名*/
	public static final String S_USER_ORG_MAPPER = "s_userOrgMapper";
	/**登录用户班级存放对象名*/
	public static final String S_Have_USER_ORG = "haveOrg";
	/**登录用户登录时间存放对象名*/
	public static final String S_LOGIN_TIME = "s_loginTime";
	/**登录用户类型存放对象名*/
	public static final String S_USER_TYPE = "s_userType";
	/**登录用户账号存放对象名*/
	public static final String S_USER_LOGIN_ACCOUNT = "s_userLoginAccount";	
	/**登录用户姓名存放对象名*/
	public static final String S_USER_LOGIN_NAME = "s_userLoginName";
	/**登录用户邮件存放对象名*/
	public static final String S_USER_EMAIL = "s_userMail" ;
	/**登录用户栏目信息存放对象名*/
	public static final String S_NODE ="s_node";
    public static int BATCH_NUM  ;
    /**导入文件类型验证*/
    public static String IMPORTFILETYPE=".xls";
    /**系统根目录*/
    public static String ROOT = null;
    /**CTI返回数据查询结果数据结构
     * 192.168.14.19_xxx_xxx_129_20100603133742.mp3,9527,013526669933,,2010-06-03 13:37:42,2010-06-03 13:37:50 
     * */
    public static String RETURNDATASTYLE= "fileName,userExtPhone,callNumber,caller_number,bgnDate,endDate";
	public static final String CERT_CODE="certCode";
	
	//配置发布系统相关参数的配置文件
	public static final String CMS_SYS_CONFIG="cms_sys_config";
	//邮件发送相关配置
	public static String sendMailSmtp = "";
	public static String sendMailSmtpPort = "";
	public static String sendMailAccount = "";
	public static String sendMailPwd = "";
	public static String mailAuthor = "";
	public static String sendMailSender = "";
	public static String sendMail_ssl_flag = "";
	public static String sendMailReplyMail = "";
	
	//机构初始化数据存放对象
	public static HashMap<String,Object> ORG_MAP = null;
	//用户初始化数据存放对象
	public static HashMap<String,Object> USER_MAP = null;
	//用户初始化数据存放对象
	public static HashMap<String,Object> SCHOOL_USER_MAP = null;	
	//用户初始化数据存放对象
	public static HashMap<String,Object> SCHOOL_TEACHER_USER_MAP = null;	
	//用户初始化数据存放对象
	public static HashMap<String,Object> SCHOOL_STUDENT_USER_MAP = null;	
	//角色初始化数据存放对象
	public static HashMap<String,Object> ROLE_MAP = null;
	
	//文件格式
	public static String imageFormat = ".jpg,.png" ;
	public static String videoFormat = ".mp4" ;
	public static String audioFormat = ".mp3" ;
	public static String wordFormat = ".doc" ;
	public static String pptFormat = ".ppt" ;
	public static String pdfFormat = ".pdf" ;
	public static String officeFormat = ".doc" ;
	public static String flashFormat = ".swf" ;
	public static String rarFormat = ".rar,.zip" ;
	
	//资源导出,资源类别表、地区表、文物博览室、教学研究室、专题研读室、影像资料室、自主探究室、资源表、课表表
	public static String exportTable = "res_category,sys_area,res_exhibition_room,res_laboratory_room,res_observation_room,res_projection_room,res_expand_room,res_resource,res_grade_relationship" ;
	
	//导出资源文件目录
	public static String exprotFilePath = "exportDB/" ;
	public static String exportFileType = "exp" ;
	public static String downloadPath = "upload/" ;
	public static String fileSplit = "/";
	
	//数据库表设置主键起始值
	public static int initSnNO = 1 ;
}
