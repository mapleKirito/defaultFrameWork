package com.ow.framework.util;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.ambow.base.grm.common.ConstantI;
import com.ambow.base.grm.onlineread.business.FileConvertBusiness;
import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.UploadDataAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.module.event.sysmgr.ResourceUtil;
import com.ow.module.event.sysmgr.laboratory.LaboratoryUploadHelp;
import com.ow.module.event.sysmgr.observation.ObservationUploadHelp;

/**
 * 此类中会操作数据库 
 */
public class DBUtil {
	private static String fileRealPath = ""; //获取tomcat路径   D://.....
	private static String s_userType = "";	//获取用户登录类型	1 ?、2 ?、3 ?、
	private static String isUpdate = "";	//是否是回显操作
	private static String oldUpload = "";   //资源路径 ,用在回显
	private static String pizeword = "";	//资源展示缩略图方式。1或0
	private static String resUpload = "";
	
	
	
	/**
	 * 获得表的字段
	 * @param conn
	 * @param tableName
	 * @return
	 */
	public static StringBuffer tableMetaData(Connection conn, String tableName) {
		StringBuffer buffer = new StringBuffer(300000) ;
		Statement st = null ;
		ResultSet rs = null ;
		ResultSetMetaData meta = null ;
		try{
			st = conn.createStatement() ;
			rs = st.executeQuery("select * from " + tableName); 
			meta = rs.getMetaData();

			buffer = insertStr(meta, rs, tableName) ;
		}catch(Exception e) {

		}finally {
			closeConn(rs, st, null) ;
		}
		return buffer ;
	}

	public static StringBuffer insertStr(ResultSetMetaData meta, ResultSet rs, String tableName) {
		StringBuffer buffer = new StringBuffer(300000) ;
		try{
			while(rs.next()) {
				buffer.append("insert into ").append(tableName).append(" ") ;
				String fields = "" ;
				String values = "" ;
				for(int i = 1; i <= meta.getColumnCount(); i++){
					String field = meta.getColumnName(i) ;
					String value = rs.getString(field) ;

					if(!rs.wasNull()){
						value = value.replaceAll("'", "\'") ;
						fields += i == 1 ? field : ", " + field ;
						values += i == 1 ? "'" + value + "'" : ",'" + value + "'" ;
					}
				}
				buffer.append("(").append(fields).append(") ");
				buffer.append("values (").append(values).append(")").append("\n");
			}
		}catch(Exception e) {
			e.printStackTrace() ;
		}

		return buffer ;
	}

	/**
	 * 关闭数据库连接等
	 * 
	 * @param rs
	 * @param stmt
	 * @param conn
	 */
	private static void closeConn(ResultSet rs, Statement stmt, Connection conn) {
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {

		}

		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (SQLException e) {

		}
		try {
			if ((conn != null) && !conn.isClosed()) {
				conn.close();
			}
		} catch (Exception e) {

		}

	}

	/**
	 * 根据序号名称，返回当前名称数据库中的序号
	 * @param eventExecutor
	 * @param snName
	 * @return
	 */
	public static int findSN(EventExecutor eventExecutor, String snName) {
		int snNO = 0 ;
		HashMap<String, String> param = new HashMap<String, String>() ;
		param.put("snName", snName) ;
		Object obj = eventExecutor.getSqlSession().selectOne("serial.select_by_name",param);

		if(obj instanceof HashMap){
			snNO = (Integer)((HashMap) obj).get("snNO") ;
			//maple
			updatSN(eventExecutor, snName);
		}else {
			addSN(eventExecutor, snName) ;
			snNO = 1 ;
		}
		return snNO ;
	}

	/**
	 * 根据序号名称，返回当前名称数据库中的序号
	 * @param eventExecutor
	 * @param snName
	 * @return
	 */
	public static int findSNTo(EventExecutor eventExecutor, String snName) {
		int snNO = 0 ;
		HashMap<String, String> param = new HashMap<String, String>() ;
		param.put("snName", snName) ;
		Object obj = eventExecutor.getSqlSession().selectOne("serial.select_by_name",param);

		if(obj instanceof HashMap){
			snNO = (Integer)((HashMap) obj).get("snNO") ;
		}else {
			snNO = 1 ;
		}
		return snNO ;
	}
	
	/**
	 * 添加序号到数据库
	 * @param eventExecutor
	 * @param snName
	 * @return
	 */
	public static int addSN(EventExecutor eventExecutor, String snName) {
		int initSnNo = Constant.initSnNO ;
		HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
		paramMap.put("snName", snName) ;
		paramMap.put("snNO", initSnNo) ;
		int rvalue = eventExecutor.getSqlSession().insert("serial.insert", paramMap) ;
		return rvalue ;
	}

	/**
	 * 增加一个序号
	 * @param eventExecutor
	 * @param snName
	 * @return
	 */
	public static int updatSN(EventExecutor eventExecutor, String snName) {
		HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
		paramMap.put("snName", snName) ;
		int rvalue = eventExecutor.getSqlSession().update("serial.update_no", paramMap) ;
		return rvalue ;
	}

	public static String TogeUpload(String filePathaa){
		filePathaa = filePathaa.substring(0,filePathaa.lastIndexOf("\\"));
		filePathaa = filePathaa.substring(0,filePathaa.lastIndexOf("\\"));
		filePathaa = filePathaa.substring(0,filePathaa.lastIndexOf("\\"));
		return filePathaa;
	}
	
	
	
	/**
	 * 处理上传资源和缩略图
	 * @param eventExecutor
	 * @param resType 资源类别
	 * @param snNO 资源编号
	 * @param isResFileToSWF 是否需要将文件转换为SWF文件
	 */
	public static ResultData uploadRes(EventExecutor eventExecutor,String resType, String snNO, boolean isResFileToSWF) {
		ResultData resultData = new ResultData();

		resultData = dealResUpload(eventExecutor, resType, snNO, isResFileToSWF) ;

		if(resultData.getIntResult() > -1) {
			resultData = dealResThumbnail(eventExecutor, resType, snNO);
		}
		return resultData ;
	}

	/**
	 * 处理上传资源
	 * @param eventExecutor
	 * @param resType
	 * @param snNO
	 * @param isResFileToSWF
	 * @return
	 */
	public static ResultData dealResUpload(EventExecutor eventExecutor,String resType, String snNO, boolean isResFileToSWF) {
		ResultData resultData = new ResultData();
		HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
		
		//上传或者修改操作时把中文名称转换为汉语拼音操作
		String nameTochar = (String)paramMap.get(StringUtil.reResAbbreviated(resType)+"Name");
		paramMap.put(StringUtil.reResAbbreviated(resType)+"Char", ConverterToChar.getNameByChine(nameTochar)); 			
		
		//tomcat获取服务器路径
		fileRealPath = ServletActionContext.getServletContext().getRealPath("/");
	
		//fileRealPath = DBUtil.TogeUpload(fileRealPath) + "/";
			fileRealPath = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "");
		
		
		String oldResUpload = paramMap.get("oldResUpload") == null ? "" : (String)paramMap.get("oldResUpload");
		
		String s_userType = paramMap.get("s_userType") == null ? "0" : (String)paramMap.get("s_userType") ; //用户类型 管理员录入数据： 0 ，老师录入数据： 1
		
		String RoomType = paramMap.get(StringUtil.reResAbbreviated(resType) + "Type") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Type");
		
		String uploadName = StringUtil.reResTypeToUploadFilename(resType) ;
		String resUpload = paramMap.get(uploadName) == null ? "" : (String)paramMap.get(uploadName) ;
		if(!oldResUpload.equals("")){ snNO = oldResUpload.substring(oldResUpload.lastIndexOf("/"),oldResUpload.lastIndexOf(".")); }
		String uploadPath = ("upload/" + StringUtil.reResTypeThum(resType) + "/" + s_userType + "/" + StringUtil.resExpentNum(resType) + "/" + snNO + "." + resUpload.substring(resUpload.lastIndexOf(".") + 1)).replace("//", "/") ;
		String refeFoldername = snNO.substring(snNO.length()-4);
		
		
		if(oldResUpload.equals(resUpload)) {	//如果原始资源文件路径与上传的资源路径相同，说明在修改时没有修改资源文件
			isResFileToSWF = false;
		}
		paramMap.put("isResFileToSWF", isResFileToSWF) ;
		
		String referResLen = paramMap.get("referResLen") == null ? "0" : (String)paramMap.get("referResLen") ;
		if(!referResLen.equals("0") && !referResLen.equals("")){
			RoomType= "4044";
			paramMap.put(StringUtil.reResAbbreviated(resType)+"IsRefer", "1") ;
		}else{
			paramMap.put(StringUtil.reResAbbreviated(resType)+"IsRefer", "0") ;
		}
		
		String referismodi = paramMap.get("referismodi") == null ? "" : (String)paramMap.get("referismodi") ;
		/***********新文件上传类型为4044时做true判断**********/
		if((RoomType.equals("4044"))){
			
			String realrefeFoldername = "upload/" + StringUtil.reResTypeThum(resType) + "/" + s_userType + "/" + StringUtil.resExpentNum(resType) + "/" + refeFoldername + "/auxilifile";
			// 获取文件夹下面的所有文件
			paramMap.put("file", fileRealPath + "/"+realrefeFoldername) ;
			paramMap.put("realrefeFoldername", realrefeFoldername) ;
			paramMap.put("snNO", snNO) ;
			if(!oldResUpload.equals(resUpload)){
				HandleDelRen(eventExecutor,resultData,resType,fileRealPath,uploadPath,resUpload,paramMap);					
			}
		}else{ 
			//oldResUpload.equals("")是上传操作。!oldResUpload.equals(resUpload)是 修改操作时，修改了“资源分类”这一行。
			if(oldResUpload.equals("") || !oldResUpload.equals(resUpload)) {
				HandleDelRen(eventExecutor,resultData,resType,fileRealPath,uploadPath,resUpload,paramMap);			
			}
			
			//olderUpAudio.equals("")是上传操作。!olderUpAudio.equals(erAudio)是 修改操作时，修改了“是否上传音频”这一行。
			String olderUpAudio = paramMap.get("olderUpAudio") == null ? "0" : (String)paramMap.get("olderUpAudio");
			String erAudio = paramMap.get(StringUtil.reResAbbreviated(resType) + "Audio") == null ? "0" : (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Audio");
			if(olderUpAudio.equals("") || !olderUpAudio.equals(erAudio)){
				HandleAudio(resType,s_userType,snNO,paramMap);
			}			
		}
		
		if(RoomType.equals("2002") || RoomType.equals("2095")){
			String AnimationFile1 = "<param name=\"movie\" value=";
			/*String AnimationFile2 = "/>";*/
			String content = paramMap.get(StringUtil.reResAbbreviated(resType) + "Content") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Content");
			if(content.indexOf(AnimationFile1) > -1){
				content = content.replace("\r\n", "");
				/*int a = content.indexOf(AnimationFile1)+AnimationFile1.length();
				int b = content.indexOf(AnimationFile1)+AnimationFile1.length();
				int c = content.indexOf(AnimationFile2, b);
				String d = content.substring(a,c).replace("\"", "").trim();
				//String h =  "upload/flash/" + StringUtil.reResTypeThum(resType) + "/" + s_userType + "/" + StringUtil.resExpentNum(resType) + "/" + snNO + "." + resUpload.substring(resUpload.lastIndexOf(".") + 1);
				//content = content.replace(d, h);
				if (!FileHelper.copyFile(fileRealPath + uploadPath,fileRealPath + d,true)) {
					resultData.setIntResult(-1); 
					return resultData;
				}*/
				//paramMap.put(StringUtil.reResAbbreviated(resType) + "Content", content) ;
			}					
		}
		return resultData ;
	}

	/***************处理上传资源文件***************/		
	public static ResultData dealResThumbnail(EventExecutor eventExecutor,String resType, String snNO) {
		ResultData resultData = new ResultData();
		HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
		//tomcat获取服务器路径
		String  fileRealPath = ServletActionContext.getServletContext().getRealPath("/");
			 //   fileRealPath = DBUtil.TogeUpload(fileRealPath) + "/";
			fileRealPath = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "");
		
		String savepath = ((UploadDataAction) eventExecutor.getBaseAction()).getSavePath();
		String realPath = fileRealPath+ "/" + savepath + "/";
		
		
		String word  = "1";
		if(word.equals("1")){			
			String resUploadPath = DateUtil.getCurrentDateString("yyyyMMdd") + "Thumbnail" + "/" ;
			String ArtworkUploadPath = DateUtil.getCurrentDateString("yyyyMMdd") +"InThum" + "/" ;

			String upload = (String) paramMap.get(StringUtil.reResAbbreviated(resType) + "Upload");
			
			String RoomType = paramMap.get(StringUtil.reResAbbreviated(resType) + "Type") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Type");
			String referResLen = paramMap.get("referResLen") == null ? "0" : (String)paramMap.get("referResLen") ;
			if(!referResLen.equals("0") && !referResLen.equals("")){
				RoomType= "4044";
			}
			String filep = paramMap.get("file") == null ? "" : (String)paramMap.get("file");
			
			String snNO1 = paramMap.get("snNO") == null ? "" : (String)paramMap.get("snNO");
			
			String realrefeFoldername = paramMap.get("realrefeFoldername") == null ? "" : (String)paramMap.get("realrefeFoldername");
			
			String oldResUpload = paramMap.get("oldResUpload") == null ? "" : (String)paramMap.get("oldResUpload");
			String uploadName = StringUtil.reResTypeToNewUploadName(resType) ;
			String resUpload = paramMap.get(uploadName) == null ? "" : (String)paramMap.get(uploadName) ;
			String resUpload1 = paramMap.get(StringUtil.reResTypeToUploadFilename(resType)) == null ? "" : (String)paramMap.get(StringUtil.reResTypeToUploadFilename(resType)) ;
			
			if((RoomType.equals("4044") )){
				
				String referOldbefor = paramMap.get("referOldbefor") == null ? "" : (String)paramMap.get("referOldbefor");
				String referbefor = paramMap.get("referbefor") == null ? "" : (String)paramMap.get("referbefor");
				if(!referOldbefor.equals("") ){
					String oldrefer[] = referOldbefor.split(",");
					String befor[] = referbefor.split(",");
					if(oldrefer.length!=befor.length || (befor[0].equals("") && !oldrefer[0].equals(""))){
						String diff[] = FileHelper.compareArrStrFindDiff(befor,oldrefer);
						for(String di : diff){
							HashMap hm = new HashMap();
							hm.put("referUpload", di);
							
							String DiffReferUpload = paramMap.get("DiffReferUpload") == null ? "" : (String)paramMap.get("DiffReferUpload") ;
							
							String dff = di + "," + DiffReferUpload + ",";
							
							if(dff.endsWith(",")){
								dff = dff.substring(0, dff.lastIndexOf(","));
								paramMap.put("DiffReferUpload",dff) ;
							}
							
							Object obj = eventExecutor.getSqlSession().selectOne("refer.select_by_upload",hm);
							String beforefiel = ((HashMap)obj).get("referFileSwf").toString();
							
							FileHelper.deleteFile(fileRealPath + di) ;
							if(di.indexOf("ppt") > -1 || di.indexOf("doc") > -1 || di.indexOf("pdf") > -1){
								di = di.substring(0,di.lastIndexOf(".")) + ".pdf";
								FileHelper.deleteFile(fileRealPath + di) ;
								String swfdel = di.substring(0,di.lastIndexOf(".")) + ".swf";
								FileHelper.deleteFile(fileRealPath + swfdel) ;
							}
							String folder = fileRealPath + beforefiel;
							FileHelper.deleteDirectory(folder);
							String fold = folder.substring(0,folder.lastIndexOf("/")); 
							int tota = FileHelper.foldNum(fold);
							if(tota == 0){
								new File(folder.substring(0,folder.lastIndexOf("/"))).delete();
								int total = FileHelper.foldNum(fold.substring(0,fold.lastIndexOf("/")));
								if(total == 0){
									new File(fold.substring(0,fold.lastIndexOf("/"))).delete();
								}
							}
						}
					}
					
					String referResTotalLen = paramMap.get("referResTotalLen") == null ? "0" : (String)paramMap.get("referResTotalLen") ;
					if(referResTotalLen.equals("0") || befor.length == 0){
						HashMap map = new HashMap();
						map.put("referReferType", "laboratory") ;
						map.put("referReferID", paramMap.get("lrID")) ;
						String delFile = fileRealPath + oldResUpload.substring(0,oldResUpload.lastIndexOf("/")) + "/" + snNO1.replace("/", "").substring(snNO1.replace("/", "").length()-4) + "/" + "auxilifile";
						FileHelper.deleteDirectory(delFile);
						eventExecutor.getSqlSession().delete("refer.delete_by_resid",map);
						paramMap.put(StringUtil.reResAbbreviated(resType)+"ReferType","");
					}
				
				}
			
				//在创建新资源 或者 在修改页面 修改上传了新的资源 时做此操作
				String referismodi = paramMap.get("referismodi") == null ? "0" : (String)paramMap.get("referismodi");	
				String HandleStatus = paramMap.get("status") == null ? "0" : (String)paramMap.get("status");	
				String referafter = paramMap.get("referafter") == null ? "0" : (String)paramMap.get("referafter");	
				
				if( (RoomType.equals("4044") && (referismodi.equals("istrue")))){
					//maple
					File fdir=new File(filep);
					File[] referList=fdir.listFiles();
					String referRealLocation="";
					if(referList!=null &&referList.length>0){
						for (File file : referList) {
							referRealLocation+=file.getName()+",";
						}
						paramMap.put(StringUtil.reResAbbreviated(resType)+"ReferRealLocation", referRealLocation);
					}
					String Len = "";
					if(HandleStatus.equals("isCreate")){
						Len = paramMap.get("referResLen") == null ? "0" : (String)paramMap.get("referResLen") ;
						if(!Len.equals("0") && !Len.equals("")){
						    LaboratoryUploadHelp.laboratoryHandleFileDocumentReference(filep, snNO1, fileRealPath, realrefeFoldername, resType, savepath, paramMap,eventExecutor.getDsname()); 
						/*	ToPicReferenceUtil toPic=new ToPicReferenceUtil(filep, snNO1, fileRealPath, realrefeFoldername, resType, savepath, paramMap,eventExecutor.getDsname());
							Thread temp_t=new Thread(toPic);
							temp_t.start();
							try {
								Thread.sleep(1000);
							} catch (InterruptedException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}*/
						}else{
							ToPicReferenceUtil2 toPic2=new ToPicReferenceUtil2(fileRealPath, upload, savepath, resType, paramMap,eventExecutor.getDsname());
							Thread temp_t=new Thread(toPic2);
							temp_t.start();
							try {
								Thread.sleep(1000);
							} catch (Exception e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							
						}
					}
				
					int index__ = 0;
					File file = new File(filep);				
					File[] files = file.listFiles();
					String s[] = null;
					if(files != null){
						s = new String[files.length];
						for (int i = 0; i < files.length; i++) {
							String f = files[i].getAbsolutePath().replace("\\", "/");
							s[i] = f.substring(f.lastIndexOf(savepath));
							if(s[i].indexOf("__") > 0){
								index__++;
							}
						}	
					}
					
					if(HandleStatus.equals("ismodify") && !referafter.equals("0") && index__!=0){
						//String refermodi[] = new String[s.length];
						for(int sarray = 0;sarray<s.length;sarray++){
							if(s[sarray].indexOf(".") > -1 && s[sarray].indexOf("__") > 0){
								System.out.println(s[sarray]);
								
								String fileType = s[sarray].substring(s[sarray].lastIndexOf(".")).replace(".", "");
								
								String f = filep + "/" + fileType;
								
								FileHelper.createFolder(f);
								
								int fileli[] = FileHelper.refreshFileList(f);
								int max = 0;
								if(fileli != null && fileli.length > 0){
									max = FileHelper.getMax_2(fileli);
								}else{
									max=999;
								}
								
								max++;
								
								f = f + "/" + max;
								
								String nameNew = "";
								File fi = new File(filep);
								File fis[] = fi.listFiles();
								for (int u=0;u<fis.length;u++) {
									if(!fis[u].isDirectory()){
										if(fis[u].getName().indexOf("pdf") > -1 || fis[u].getName().indexOf("ppt") > -1 || fis[u].getName().indexOf("doc") > -1){
											int a = fis[u].getName().lastIndexOf("_")+1;
											int b = fis[u].getName().lastIndexOf(".");
											nameNew += "," +  fis[u].getName().substring(a,b);
										}
									}
								}
								String nameNewArr[] = nameNew.replaceFirst("\\,","").split(",");
								int nameNews[] = new int[nameNewArr.length];
								for(int g = 0;g<nameNewArr.length;g++){
									nameNews[g] = Integer.parseInt(nameNewArr[g]);
								}
								int maxname = FileHelper.getMax_2(nameNews) + 1;
								
								
								String name = snNO1.replace("/", "") + "_" + maxname + "." + fileType;
								
								FileHelper.reName(filep + "/" + name,fileRealPath + s[sarray]) ;
								
								String convertPDFName = snNO1.replace("/", "") + "_" + maxname + ".pdf";
								
								String convertSWFName = snNO1.replace("/", "") + "_" + maxname + ".swf";
								
								FileHelper.createFolder(filep + "/" + fileType + "/" + max);
								
								FileConvertBusiness fCBusiness= new FileConvertBusiness();
								
								boolean convertPDFFlag = fCBusiness.docToPdf(new File(filep + "/" + name), new File(filep+File.separator+convertPDFName),ConstantI.PDFJARPATH_KEY,ConstantI.TRANSFORTYPEFLAG_KEY);
								
								
								if(fileType.toLowerCase().indexOf("pdf") > -1){
									convertPDFFlag = true;
								}
								
								
								String filePath = filep + "/" + name;
								String fileFolder = filePath.substring(0,filePath.lastIndexOf("/"));
								boolean convertSWFFlag = false;
								if(convertPDFFlag){//pdf 是否转化完成
									convertSWFFlag = fCBusiness.PdfToSwf(new File(fileFolder+File.separator+convertPDFName),new File(fileFolder+File.separator+convertSWFName), ConstantI.SWFTOOLSPATH_KEY);
									if(oldResUpload.equals("") || !oldResUpload.equals(resUpload)) {
										paramMap.put(StringUtil.reResAbbreviated(resType)+"State","3");
										paramMap.put(StringUtil.reResAbbreviated(resType)+"FileSwfPath", (fileFolder+File.separator+convertSWFName).substring((fileFolder+File.separator+convertSWFName).indexOf(savepath)).trim().replace("\\","/")) ;
									}
								}
								
								
								try {
									LaboratoryUploadHelp.laboratoryHandlepdftopicTwo(new File(filep+File.separator+convertPDFName), fileType, fileType + "/" + max, savepath, resType, paramMap);
								} catch (Exception e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}
								
								String refera = filep.substring(filep.lastIndexOf(savepath)) + "/" + name;
								String referafterValue = paramMap.get("referafterValue") == null ? "" : (String)paramMap.get("referafterValue");	
								paramMap.put("referafterValue",("," +refera + "," + referafterValue).replaceFirst("\\,","")) ;
							
								String referf = filep.substring(filep.lastIndexOf(savepath)) + "/" + fileType + "/" + max;
								String referafterFileSwfValue = paramMap.get("referafterFileSwfValue") == null ? "" : (String)paramMap.get("referafterFileSwfValue");	
								paramMap.put("referafterFileSwfValue",("," + referf + "," + referafterFileSwfValue).replaceFirst("\\,","")) ;
								
								String referafterFileType = paramMap.get("referafterFileType") == null ? "" : (String)paramMap.get("referafterFileType");
								paramMap.put("referafterFileType",("," + fileType + "," + referafterFileType).replaceFirst("\\,","")) ;
							
								String ss = (filep+File.separator+convertSWFName).substring((filep+File.separator+convertSWFName).indexOf(savepath)).trim();
								String referafterFileSwfPath = paramMap.get("referafterFileSwfPath") == null ? "" : (String)paramMap.get("referafterFileSwfPath");
								paramMap.put("referafterFileSwfPath", ("," + ss + "," + referafterFileSwfPath).replaceFirst("\\,","")) ;
								
								
							}
						}
						
					
					}
				
					
				}
				
				
			}
			
			boolean f = ((Boolean)paramMap.get("isResFileToSWF")).booleanValue();
			if(RoomType.equals("1011") && f){  
				PublicHandlePlugIn(realPath,resUploadPath,ArtworkUploadPath,upload,resType,savepath,paramMap);	
			}else if(RoomType.equals("1011") && !f){
				paramMap.put(StringUtil.reResAbbreviated(resType) + "InThum", paramMap.get("Old1011InThum"));
				paramMap.put(StringUtil.reResAbbreviated(resType) + "Thumbnail", paramMap.get("Old1011Thumbnail"));
			}
			
			resultData = PublicHandleNoPlugIn(eventExecutor,upload,realPath,resUploadPath,resType,savepath,snNO,paramMap);
			
			//修改操作取消推荐时,从硬盘上删除推荐图片
			if(((String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Recommen")).indexOf("1") < 0 ){
				
				FileHelper.deleteFile((fileRealPath.replace("\\", "/") + "/" + (String)paramMap.get("Old" + StringUtil.reResAbbreviated(resType) + "RecommenFile")).replace("//", "/")) ;
				
			}
			
			/*if(RoomType.equals("4033") && ConstantI.RARZIP_KEY.contains(upload.substring(upload.lastIndexOf(".")).replace(".", ""))){ 解压上传的压缩包到指定的路径
				
				ObservationUploadHelp.observationHandleDecom(realPath, upload, paramMap);
			
			}	*/			
			
			if(oldResUpload.equals("") || !oldResUpload.equals(resUpload)) {
				if(!upload.equals("") && ConstantI.ONLINEREADFILETYPE_KEY.contains(upload.substring(upload.lastIndexOf(".")).replace(".", ""))){	//现只要为教学研究室或自主探究室。将上传的文档格式文件转换为图片格式文件。
					//LaboratoryUploadHelp.laboratoryHandlePptDocPdf(fileRealPath, upload, savepath, resType, paramMap);
					//maple
					fileRealPath = fileRealPath.replace("\\", "/");
					
					upload = upload.replace("\\", "/"); 
					
					String filePath = fileRealPath + "/" + upload ;
					
					String fileRealName =  filePath.substring(filePath.lastIndexOf("/")+1);
					
					String fileType = fileRealName.substring(fileRealName.lastIndexOf("."));
					
					String fileTempName =  URLEncoder.encode(fileRealName.replace(fileType, ""));
					
					String fileFolder = filePath.substring(0,filePath.lastIndexOf("/"));
					
					String convertPDFName = fileTempName + ".pdf";
					
					String convertSWFName = fileTempName + ".swf";
					paramMap.put(StringUtil.reResAbbreviated(resType)+"FileSwfPath", (fileFolder+File.separator+convertSWFName).substring((fileFolder+File.separator+convertSWFName).indexOf(savepath)).trim().replace("\\","/")) ;
					ToPicUtil toPic=new ToPicUtil(fileRealPath, upload, savepath, resType, paramMap,eventExecutor.getDsname());
					Thread temp_t=new Thread(toPic);
					temp_t.start();
					try {
						Thread.sleep(1000);
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		//System.out.println("数据返回："+paramMap+new java.text.SimpleDateFormat("yy-MM-dd HH:mm:ss").format(new java.util.Date()));
		return resultData ;
	}
	
	/**
	 *@param fileRealPath 文件重命名后的名称
	 *@param uploadPath 文件重命名后的upload后名称  upload/...
	 *@param resUpload  文件重命名前的名称
	 * @return 
	 **/
	public static ResultData HandleDelRen(EventExecutor eventExecutor,ResultData resultData,String resType,String fileRealPath,String uploadPath,String resUpload,HashMap paramMap){
		FileHelper.deleteFile(fileRealPath + "/" + uploadPath) ;
		FileHelper.reName(fileRealPath + "/" + uploadPath, fileRealPath + "/" + resUpload) ;
		String resUploadName = StringUtil.reResAbbreviated(resType) + "Upload" ;
		paramMap.put(resUploadName, uploadPath) ;
		
		String RoomType = paramMap.get(StringUtil.reResAbbreviated(resType) + "Type") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Type");
		if(RoomType.equals("1084")){
			String tomp4 = (fileRealPath + uploadPath).substring(0,(fileRealPath + uploadPath).lastIndexOf("."));
			String  fileRealPath_videoexe = ServletActionContext.getServletContext().getRealPath("/");
			//create avs
			//CreateAVS.toAVS(tomp4, fileRealPath + uploadPath,fileRealPath_videoexe + "pluginIn\\tools\\watermark\\");
			//截图
			ScreenshotUtil su=new ScreenshotUtil(fileRealPath + uploadPath,fileRealPath_videoexe + "pluginIn\\tools\\",tomp4,eventExecutor.getDsname(),resType);
			su.run();
			//HD转码
			ToHDMp4Util toMp4hd=new ToHDMp4Util(fileRealPath + uploadPath,fileRealPath_videoexe + "pluginIn\\tools\\",tomp4,eventExecutor.getDsname(),resType);
			Thread temp_thd=new Thread(toMp4hd);
			temp_thd.start();
			
			
			//HashMap<String,String> rtnMap = ToFlvUtil.toFlv(fileRealPath + uploadPath,fileRealPath + "pluginIn\\tools\\toFlv.exe",toflv);
			/*String errorStr = "";
			if(rtnMap.get("error") != null && rtnMap.get("error").toString().equals("0")){
				errorStr="视频文件转换失败!";
				eventExecutor.getBaseAction().getPromptInfo().setResultDescInfo(errorStr);
				resultData.setIntResult(-1);  
				return resultData ;
			}*/
			paramMap.remove(resUploadName);
			String resPlayPath = StringUtil.reResAbbreviated(resType) + "FileSwf" ;
			String thum = StringUtil.reResAbbreviated(resType) + "Thumbnail" ;
			String resPath=fileRealPath + uploadPath;
			paramMap.put(thum, tomp4.substring(tomp4.lastIndexOf("\\")).replace("\\", "")+"_thum.jpg") ;
			paramMap.put(resUploadName, uploadPath) ;
			paramMap.put(resPlayPath, tomp4.substring(tomp4.lastIndexOf("\\")).replace("\\", "")+"_LD.mp4") ;
		}
		return resultData;
	}
	
	/**
	 *@param fileRealPath 处理音频文件
	 **/
	public static void HandleAudio(String resType,String s_userType,String snNO,HashMap paramMap){
		String resAudioUploadName = StringUtil.reResAbbreviated(resType) + "Audio" ;
		String resAudioUpload = paramMap.get(resAudioUploadName) == null ? "" : (String)paramMap.get(resAudioUploadName) ;
		if(resAudioUpload.length() > 0) {
			String uploadAudioPath = ("upload/" + StringUtil.reResTypeThum(resType) + "/" + s_userType + "/" + StringUtil.resExpentNum(resType) + "/" + snNO + "." + resAudioUpload.substring(resAudioUpload.lastIndexOf(".") + 1)).replace("//","/") ;
			paramMap.put(resAudioUploadName, uploadAudioPath) ;
			FileHelper.deleteFile(fileRealPath + "/" + uploadAudioPath) ;
			FileHelper.reName(fileRealPath + "/" + uploadAudioPath, fileRealPath + "/" + resAudioUpload) ;
		}		
	}
	
	
	public static ResultData PublicHandleNoPlugIn(EventExecutor eventExecutor,String upload,String realPath,String resUploadPath,String resType,String savepath,String snNO,HashMap paramMap){
		String pfileRealPath = ServletActionContext.getServletContext().getRealPath("/");
		
		ResultData resultData = new ResultData();
		
		File[] files = ((UploadDataAction) eventExecutor.getBaseAction()).getUpload();
		if (files != null) {
			List<String> tempPath = FileHelper.getTempPath(eventExecutor.getBaseAction().getParamMap().get("swapPath"),files.length);
			if(files.length > 0) {
				for(int i = 0; i < files.length; i ++){
					String oldFileName = ((UploadDataAction) eventExecutor.getBaseAction()).getUploadFileName()[i];
					String FileTitle= ((UploadDataAction) eventExecutor.getBaseAction()).getTitle();
					
					if(FileTitle!=null){
						String filetitle[] = FileTitle.split(",");

						/*if(filetitle[i].trim().equals("")){
							if(!resType.equals("exhibition")){
								filetitle[i] = filetitle[i+2];
							}else{
								filetitle[i] = filetitle[i+1];
							}
						}*/
						
						filetitle = FileHelper.emptyArray(filetitle);
						
						String smallUpload = "",zhongupload = "",ziprarUpload="",referenceUpload="",pwp="";
						String RoomType = paramMap.get(StringUtil.reResAbbreviated(resType) + "Type") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Type");
						String referResLen = paramMap.get("referResLen") == null ? "0" : (String)paramMap.get("referResLen") ;
						if(!referResLen.equals("0") && !referResLen.equals("")){
							RoomType= "4044";
						}
						String referismodi = paramMap.get("referismodi") == null ? "" : (String)paramMap.get("referismodi") ;
						String IsRefer = paramMap.get(StringUtil.reResAbbreviated(resType) + "IsRefer") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "IsRefer");
						
						String fileDateName = DateUtil.sDateFormat() ;
						String fileType = oldFileName.substring(oldFileName.lastIndexOf(".")) ;
						String fileName = fileDateName + fileType;
						
						String pfoldpath = realPath  + "/" + StringUtil.reResTypeThum(resType) + "/" + (String)paramMap.get("s_userType") + "/" + StringUtil.resExpentNum(resType)+"/" + resUploadPath + "/" ;
						String ppath = (pfoldpath + fileName).replace("///", "//").replace("//","/");
						String puppath = ppath.substring(ppath.lastIndexOf(savepath),ppath.lastIndexOf("/"));
						
						/*如果存在，则处理缩略图文件*/
						if(filetitle[i].trim().equals("titleuploadThumFile")){
							
							String oldResUpload = paramMap.get("oldResUpload") == null ? "" : (String)paramMap.get("oldResUpload");
							String uploadName = StringUtil.reResTypeToUploadFilename(resType) ;
							String resUpload = paramMap.get(uploadName) == null ? "" : (String)paramMap.get(uploadName) ;
							
							String olduploadThumFile = paramMap.get("olduploadThumFile") == null ? "" : (String)paramMap.get("olduploadThumFile");
							String uploadThumFile = paramMap.get("uploadThumFile") == null ? "" : (String)paramMap.get("uploadThumFile");
							
							/*if(RoomType.equals("4033") && (uploadThumFile.equals("1")) && ConstantI.RARZIP_KEY.contains(upload.substring(upload.lastIndexOf(".")).replace(".", ""))){ 处理专题研读室压缩包格式文件
								ziprarUpload = upload;
								upload = ObservationUploadHelp.observationHandleZipRar(pfoldpath,ppath,files,i,upload,oldFileName,pfileRealPath,puppath);
							}*/
							
							
							/*if(!olduploadThumFile.equals("") && uploadThumFile.equals("1") && RoomType.equals("4033") && ConstantI.RARZIP_KEY.contains(upload.substring(upload.lastIndexOf(".")).replace(".", ""))){ 处理专题研读室压缩包格式文件
								ObservationUploadHelp.observationHandleZipRar(pfoldpath, ppath, files, i, olduploadThumFile, oldFileName, pfileRealPath, puppath);
							}*/
							
							
							if(!upload.equals("") && ConstantI.ONLINEREADFILETYPE_KEY.contains(upload.substring(upload.lastIndexOf(".")).replace(".", ""))){
								pwp = upload;
								FileHelper.createFolder(pfoldpath);
								if (!FileHelper.writeFile(new File(ppath), files[i])) {
									resultData.setIntResult(-1);
									return resultData;
								}
								String up = upload.substring(upload.lastIndexOf("/")+1,upload.lastIndexOf(".")) + oldFileName.substring(oldFileName.lastIndexOf("."));
								FileHelper.deleteFile(pfileRealPath + puppath + "/" + up) ;
								FileHelper.reName(pfileRealPath + puppath + "/" + up,ppath) ;
								upload = puppath + "/" + up;	
							}  
							
							if(RoomType.equals("1084")){
								//修改时过。创建是snNO为"",获取并添加文件名。
								if(!oldResUpload.equals("")){
									snNO = oldResUpload.substring(oldResUpload.lastIndexOf("/"),oldResUpload.lastIndexOf(".")).replace("/", "");									
								}
								upload = puppath + "/" + snNO + fileType;
								upload = LaboratoryUploadHelp.laboratoryHandleReference(pfoldpath,ppath,files,i,upload,oldFileName,pfileRealPath,puppath);
							}
							
							if(RoomType.equals("2002") || RoomType.equals("2095")){
								FileHelper.createFolder(pfoldpath);
								if (!FileHelper.writeFile(new File(ppath), files[i])) {
									resultData.setIntResult(-1);
									return resultData;
								}
								
								if(uploadThumFile.equals("1")){
									snNO = oldResUpload.substring(oldResUpload.lastIndexOf("/"),oldResUpload.lastIndexOf(".")).replace("/", "");
								}
								
								FileHelper.deleteFile(pfileRealPath + puppath + "/" + snNO + fileType) ;
								FileHelper.reName(pfileRealPath + puppath + "/" + snNO + fileType,ppath) ;
								upload = puppath + "/" + snNO + fileType;
							}
							
							/*if(IsRefer.equals("1")){
								FileHelper.createFolder(pfoldpath);
								if (!FileHelper.writeFile(new File(ppath), files[i])) {
									resultData.setIntResult(-1);
									return resultData;
								}
								FileHelper.deleteFile(pfileRealPath + puppath + "/" + snNO + fileType) ;
								FileHelper.reName(pfileRealPath + puppath + "/" + snNO + fileType,ppath) ;
								upload = puppath + "/" + snNO + fileType;
							}*/
							
							if(RoomType.equals("1073")){
								FileHelper.createFolder(pfoldpath);
								if (!FileHelper.writeFile(new File(ppath), files[i])) {
									resultData.setIntResult(-1);
									return resultData;
								}
								//修改时过。创建是snNO为"",获取并添加文件名。
								if(!oldResUpload.equals("")){
									snNO = oldResUpload.substring(oldResUpload.lastIndexOf("/"),oldResUpload.lastIndexOf("."));									
								}
								FileHelper.deleteFile(pfileRealPath + puppath + "/" + snNO + fileType) ;
								FileHelper.reName(pfileRealPath + puppath + "/" + snNO + fileType,ppath) ;
								upload = puppath + "/" + snNO + fileType;
							}
							
							if(RoomType.equals("1022")){
								FileHelper.createFolder(pfoldpath);
								if (!FileHelper.writeFile(new File(ppath), files[i])) {
									resultData.setIntResult(-1);
									return resultData;
								}
								//修改时过。创建是snNO为"",获取并添加文件名。
								if(!oldResUpload.equals("")){
									snNO = oldResUpload.substring(oldResUpload.lastIndexOf("/"),oldResUpload.lastIndexOf("."));									
								}
								FileHelper.deleteFile(pfileRealPath + puppath + "/" + snNO + fileType) ;
								FileHelper.reName(pfileRealPath + puppath + "/" + snNO + fileType,ppath) ;
								upload = puppath + "/" + snNO + fileType;
							}
							smallUpload = getSmallUpload(pfileRealPath, upload, realPath, resUploadPath, resType, paramMap);
							zhongupload = getartworkUpload(pfileRealPath, upload, realPath, resUploadPath, resType, paramMap);
							
							/*if(RoomType.equals("4033") && (uploadThumFile.equals("1")) && ConstantI.RARZIP_KEY.contains(ziprarUpload.substring(ziprarUpload.lastIndexOf(".")).replace(".", ""))){ 存放专题研读室压缩包格式文件路径
								ObservationUploadHelp.observationHandlePut(ziprarUpload, resType, smallUpload, zhongupload, savepath, paramMap);
							}*/
							
							if(!pwp.equals("") && ConstantI.ONLINEREADFILETYPE_KEY.contains(pwp.substring(pwp.lastIndexOf(".")).replace(".", ""))){
								paramMap.put(StringUtil.reResAbbreviated(resType) + "Thumbnail", smallUpload.substring(smallUpload.lastIndexOf(savepath))) ;
								paramMap.put(StringUtil.reResAbbreviated(resType) + "InThum", zhongupload.substring(zhongupload.lastIndexOf(savepath))) ;
							}  
							
							if(RoomType.equals("1084") ){
								paramMap.put(StringUtil.reResAbbreviated(resType) + "Thumbnail", smallUpload.substring(smallUpload.lastIndexOf(savepath))) ;
								paramMap.put(StringUtil.reResAbbreviated(resType) + "InThum", zhongupload.substring(zhongupload.lastIndexOf(savepath))) ;
							}
							
							if(RoomType.equals("2002") || RoomType.equals("2095")){
								paramMap.put(StringUtil.reResAbbreviated(resType) + "Thumbnail", smallUpload.substring(smallUpload.lastIndexOf(savepath))) ;
								paramMap.put(StringUtil.reResAbbreviated(resType) + "InThum", zhongupload.substring(zhongupload.lastIndexOf(savepath))) ;
							}
							
							/*if(IsRefer.equals("1")){
								paramMap.put(StringUtil.reResAbbreviated(resType) + "Thumbnail", smallUpload.substring(smallUpload.lastIndexOf(savepath))) ;
							}*/
							
							if(RoomType.equals("1073")){
								paramMap.put(StringUtil.reResAbbreviated(resType) + "Thumbnail", smallUpload.substring(smallUpload.lastIndexOf(savepath))) ;
								paramMap.put(StringUtil.reResAbbreviated(resType) + "InThum", zhongupload.substring(zhongupload.lastIndexOf(savepath))) ;
							}
							
							if(RoomType.equals("1022")){
								paramMap.put(StringUtil.reResAbbreviated(resType) + "Thumbnail", smallUpload.substring(smallUpload.lastIndexOf(savepath))) ;
								paramMap.put(StringUtil.reResAbbreviated(resType) + "InThum", zhongupload.substring(zhongupload.lastIndexOf(savepath))) ;
							}
						} 
						
						/*如果存在，则处理推荐文件*/
						if(filetitle[i].trim().equals("titleuploadRecommenFile")){
							
							File fi = new File(ppath);
							try {
								FileUtils.forceMkdir(fi.getParentFile());
							} catch (IOException e) {
								e.printStackTrace();
							} 
							if (!FileHelper.writeFile(fi, files[i])) {
								resultData.setIntResult(-1);
								return resultData;
							}
							
							if((RoomType.equals("4044") )){
								upload = "/" + (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "NO") + fileType;
							}
							
							String namebeforepath = ppath.substring(0,ppath.lastIndexOf("/")) + "/R_" + upload.substring(upload.lastIndexOf("/")+1);
							
							//操作的资源类型为4033时，换一下扩展名。
							/*if(RoomType.equals("4033") || RoomType.equals("1022") || RoomType.equals("1084") || RoomType.equals("2002") || RoomType.equals("2095") || ConstantI.ONLINEREADFILETYPE_KEY.contains(upload.substring(upload.lastIndexOf(".")).replace(".", ""))){
								namebeforepath = namebeforepath.substring(0,namebeforepath.lastIndexOf(".")) + ppath.substring(ppath.lastIndexOf("."));
							}*/
							FileHelper.deleteFile(namebeforepath) ;
							//FileHelper.reName(namebeforepath,ppath) ;
							try {
								String tmp = CompressionPictureSize.getRecomJPG(fileRealPath + "/" + upload,realPath  + "/" + StringUtil.reResTypeThum(resType) + "/" + (String)paramMap.get("s_userType") + "/" + StringUtil.resExpentNum(resType)+"/" + resUploadPath + "/",paramMap.get("Recommensize").toString());
							} catch (Exception e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							String recomm = namebeforepath.substring(namebeforepath.lastIndexOf(savepath));
							paramMap.put(StringUtil.reResAbbreviated(resType) + "RecommenFile", recomm) ;
							
						}
						
						/*如果存在，则处理推荐文件*/
						if(filetitle[i].trim().equals("titlecontentfileFile")){
							String coddpath = upload.substring(upload.lastIndexOf("/")+1,upload.lastIndexOf("."));
							
							ppath = realPath  + "/" + StringUtil.reResTypeThum(resType) + "/" + (String)paramMap.get("s_userType") + "/" + StringUtil.resExpentNum(resType)+"/" + "story/"+coddpath.substring(coddpath.length()-4)+"/"+fileName;
							ppath = ppath.replace("///", "//").replace("//","/");
							File fi = new File(ppath);
							try {
								FileUtils.forceMkdir(fi.getParentFile());
							} catch (IOException e) {
								e.printStackTrace();
							} 
							if (!FileHelper.writeFile(fi, files[i])) {
								resultData.setIntResult(-1);
								return resultData;
							}
							
							if((RoomType.equals("4044") )){
								upload = "/" + (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "NO") + fileType;
							}
							
							String namebeforepath = ppath.substring(0,ppath.lastIndexOf("/")) + "/story_" + coddpath + fileType;
							FileHelper.deleteFile(namebeforepath) ;
							
							if(namebeforepath.indexOf("ppt") > -1 || namebeforepath.indexOf("doc") > -1 || namebeforepath.indexOf("pdf") > -1){
								String pdfdel = namebeforepath.substring(0,namebeforepath.lastIndexOf(".")) + ".pdf";
								FileHelper.deleteFile(pdfdel) ;
								String swfdel = namebeforepath.substring(0,namebeforepath.lastIndexOf(".")) + ".swf";
								FileHelper.deleteFile(swfdel) ;
							}
							
							String beforefiel = namebeforepath.substring(0,namebeforepath.lastIndexOf("/"))+"/"+coddpath.substring(coddpath.length()-4)+"/mainfile";
							
							String folder = beforefiel;
							FileHelper.deleteDirectory(folder);
							String fold = folder.substring(0,folder.lastIndexOf("/")); 
							int tota = FileHelper.foldNum(fold);
							if(tota == 0){
								new File(folder.substring(0,folder.lastIndexOf("/"))).delete();
								/*int total = FileHelper.foldNum(fold.substring(0,fold.lastIndexOf("/")));
								if(total == 0){
									new File(fold.substring(0,fold.lastIndexOf("/"))).delete();
								}*/
							}
							
							FileHelper.reName(namebeforepath,ppath) ;
							String recomm = namebeforepath.substring(namebeforepath.lastIndexOf(savepath));
							
							ToPicReferenceUtil3 toPic3=new ToPicReferenceUtil3(fileRealPath, recomm, "isstory" ,savepath, resType, paramMap,eventExecutor.getDsname());
							Thread temp_t=new Thread(toPic3);
							temp_t.start();
							try {
								Thread.sleep(1000);
							} catch (Exception e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						
							paramMap.put(StringUtil.reResAbbreviated(resType) + "Content", recomm.substring(0,recomm.lastIndexOf("/")) + "/story_" + coddpath+".swf") ;
							paramMap.put(StringUtil.reResAbbreviated(resType) + "ContentPath", recomm.substring(0,recomm.lastIndexOf("/")) + "/"+coddpath.substring(coddpath.length()-4) + "/mainfile") ;
							
						}
						
						/*相关链接*/
						if(filetitle[i].trim().equals("relatedlinksfileFile")){
							String coddpath = upload.substring(upload.lastIndexOf("/")+1,upload.lastIndexOf("."));
							
							ppath = realPath  + "/" + StringUtil.reResTypeThum(resType) + "/" + (String)paramMap.get("s_userType") + "/" + StringUtil.resExpentNum(resType)+"/" + "rellinks/"+coddpath.substring(coddpath.length()-4)+"/"+fileName;
							ppath = ppath.replace("///", "//").replace("//","/");
							File fi = new File(ppath);
							try {
								FileUtils.forceMkdir(fi.getParentFile());
							} catch (IOException e) {
								e.printStackTrace();
							} 
							if (!FileHelper.writeFile(fi, files[i])) {
								resultData.setIntResult(-1);
								return resultData;
							}
							
							if((RoomType.equals("4044") )){
								upload = "/" + (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "NO") + fileType;
							}
							
							String namebeforepath = ppath.substring(0,ppath.lastIndexOf("/")) + "/rellinks_" + coddpath + fileType;
							FileHelper.deleteFile(namebeforepath) ;
							
							if(namebeforepath.indexOf("ppt") > -1 || namebeforepath.indexOf("doc") > -1 || namebeforepath.indexOf("pdf") > -1){
								String pdfdel = namebeforepath.substring(0,namebeforepath.lastIndexOf(".")) + ".pdf";
								FileHelper.deleteFile(pdfdel) ;
								String swfdel = namebeforepath.substring(0,namebeforepath.lastIndexOf(".")) + ".swf";
								FileHelper.deleteFile(swfdel) ;
							}
							
							String beforefiel = namebeforepath.substring(0,namebeforepath.lastIndexOf("/"))+"/"+coddpath.substring(coddpath.length()-4)+"/mainfile";
							
							String folder = beforefiel;
							FileHelper.deleteDirectory(folder);
							String fold = folder.substring(0,folder.lastIndexOf("/")); 
							int tota = FileHelper.foldNum(fold);
							if(tota == 0){
								new File(folder.substring(0,folder.lastIndexOf("/"))).delete();
								/*int total = FileHelper.foldNum(fold.substring(0,fold.lastIndexOf("/")));
								if(total == 0){
									new File(fold.substring(0,fold.lastIndexOf("/"))).delete();
								}*/
							}
							
							FileHelper.reName(namebeforepath,ppath) ;
							String recomm = namebeforepath.substring(namebeforepath.lastIndexOf(savepath));
							
							ToPicReferenceUtil4 toPic4=new ToPicReferenceUtil4(fileRealPath, recomm, "isrellinks" ,savepath, resType, paramMap,eventExecutor.getDsname());
							Thread temp_t=new Thread(toPic4);
							temp_t.start();
							try {
								Thread.sleep(1000);
							} catch (Exception e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						
							paramMap.put(StringUtil.reResAbbreviated(resType) + "RelatedLinks", recomm.substring(0,recomm.lastIndexOf("/")) + "/rellinks_" + coddpath+".swf") ;
							paramMap.put(StringUtil.reResAbbreviated(resType) + "RelatedLinksPath", recomm.substring(0,recomm.lastIndexOf("/")) + "/"+coddpath.substring(coddpath.length()-4) + "/mainfile") ;
							
						}
					}
				
				}
			}
		}
		
		if(null == paramMap.get(StringUtil.reResAbbreviated(resType) + "Thumbnail")){
			//01-图片 02-3D图片 03-word文档 04-PPT 05-PDF 06-office文件 07-音频 08-视频 09-flash文件 10-压缩文件 00-其他文件
			String type1 = paramMap.get(StringUtil.reResAbbreviated(resType) + "Type") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Type") ;
			if(type1.equals("4033")&&false){
				type1 = "11";
			}else{
				type1 = "".equals(type1) ? "00" : type1.substring(1, 3) ;	
			}
			eventExecutor.getBaseAction().getParamMap().put(StringUtil.reResAbbreviated(resType) + "Thumbnail", "images/resImage/file_type_" + type1 + ".jpg");
		}
		
		if(null == paramMap.get(StringUtil.reResAbbreviated(resType) + "InThum")){
			String type1 = paramMap.get(StringUtil.reResAbbreviated(resType) + "Type") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Type") ;
			if(type1.equals("4033")&&false){
				type1 = "11";
			}else{
				type1 = "".equals(type1) ? "00" : type1.substring(1, 3) ;	
			}
			eventExecutor.getBaseAction().getParamMap().put(StringUtil.reResAbbreviated(resType) + "InThum", "images/resImage/file_type_" + type1 + ".jpg");
		}
		
		
		
		return resultData ;
	}
	
	public static String getSmallUpload(String pfileRealPath, String upload, String realPath, String resUploadPath, String resType, HashMap paramMap){
		String RoomType = paramMap.get(StringUtil.reResAbbreviated(resType) + "Type") == null ? "" : (String)paramMap.get(StringUtil.reResAbbreviated(resType) + "Type");
		String smallUpload = "",zhong="";
		zhong = StringUtil.reResTypeThum(resType) + "/" + (String)paramMap.get("s_userType") + "/" + StringUtil.resExpentNum(resType)+"/"+resUploadPath + "/";
		try {
			smallUpload = (CompressionPictureSize.getSmallJPG(pfileRealPath + upload,realPath + zhong)).replace("///","//").replace("//","/");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return smallUpload;
	}
	
	public static String getartworkUpload(String pfileRealPath, String upload, String realPath, String resUploadPath, String resType, HashMap paramMap){
		String upload_ = "" ,zhong = "";
		zhong = StringUtil.reResTypeThum(resType) + "/" + (String)paramMap.get("s_userType") + "/" + StringUtil.resExpentNum(resType)+"/"+resUploadPath + "/";
		try {
			upload_ = (CompressionPictureSize.getartworkJPG(pfileRealPath + upload,realPath  + zhong)).replace("///","//").replace("//","/");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return upload_;
	}
	
	
	/**
	 * 处理上传的资源文件辅助
	 * 
	 * @param realPath文件真实路径
	 * @param resType科室英文名称
	 * @param savepath 值为upload
	 * @param paramMap页面参数集合
	 * */
	public static void PublicHandlePlugIn(String realPath,String resUploadPath,String ArtworkUploadPath,String upload, String resType,String savepath,HashMap paramMap){

		FileHelper.createFolder(realPath  + "/" + StringUtil.reResTypeThum(resType) + "/" + (String)paramMap.get("s_userType") + "/" + StringUtil.resExpentNum(resType)+"/" + resUploadPath + "/") ;
		FileHelper.createFolder(realPath  + "/" + StringUtil.reResTypeThum(resType) + "/" + (String)paramMap.get("s_userType") + "/" + StringUtil.resExpentNum(resType)+"/" + ArtworkUploadPath + "/");
		
		String smallUpload = "",artworkUpload = "";
		
		try {
			smallUpload = CompressionPictureSize.getSmallJPG(fileRealPath + "/" + upload,realPath  + "/" + StringUtil.reResTypeThum(resType) + "/" + (String)paramMap.get("s_userType") + "/" + StringUtil.resExpentNum(resType)+"/" + resUploadPath + "/");
			artworkUpload = CompressionPictureSize.getartworkJPG(fileRealPath + "/" + upload,realPath  + "/" + StringUtil.reResTypeThum(resType) + "/" + (String)paramMap.get("s_userType") + "/" + StringUtil.resExpentNum(resType)+"/" + ArtworkUploadPath + "/");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		smallUpload = smallUpload.substring(smallUpload.lastIndexOf(savepath)).replace("//", "/");
		artworkUpload = artworkUpload.substring(artworkUpload.lastIndexOf(savepath)).replace("//", "/");
		
		paramMap.put(StringUtil.reResAbbreviated(resType) + "Thumbnail", smallUpload);
		paramMap.put(StringUtil.reResAbbreviated(resType) + "InThum", artworkUpload);
		paramMap.put("orState", 3);
	
	}
	
	
	public static String[] removeArraynull(String[] str){
		
		for(int s = 0;s<str.length;s++){ if(str[s] == null){ str[s] = ""; } }
		
		String s = Arrays.toString(str).replace(" ,", "").trim();
		
		int a = s.lastIndexOf(", ]");
		
		String[] newStr = str;
		
		if(a > -1){
			String b = s.substring(a);
			
			s = s.replace(b, "]");
				
			newStr= s.split(",");
		}
			
        return 	newStr;

	}
	
	
	public static String[] dictinctArray(String array[]){
	

		Set<String> set = new HashSet<String>(); 
        
		for (int i=0; i<array.length; i++) { 
			
			if(array[i] != null){
				
				set.add(array[i]); 
				
			}
        
        
		} 
	    
        String[] Str =  set.toArray(new String[1]); 
		
        if(Str[0]==null){
        	
        	Str[0] = "";
        	
        }
        
        return Str;
	}
	
	public static ResultData resModifyCategoryStatus(EventExecutor eventExecutor,HashMap one,String resType) {
		ResultData resultData = new ResultData();
		int count = 0 ;
		String resCateID = "",resCate = "" ;
		try{
			if("exhibition".equals(resType)) {
				String selectCount = "exhibition.select_count_by_category"	;
				String jieID = (String)(one.get("modifycateJieID")) ;
				HashMap map = new HashMap() ;
				if(jieID != null) {
					map.put("erJieID", jieID) ;
					Integer jieCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(jieCount == 0) {
						resCateID += "," + jieID ;
					}else{
						resCate += "," + jieID ;
					}
				}
				
				String erChorID = (String)(one.get("modifycateChorID")) ;
				map = new HashMap() ;
				if(erChorID != null) {
					map.put("erChorID", erChorID) ;
					Integer jieCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(jieCount == 0) {
						resCateID += "," + erChorID ;
					}else{
						resCate += "," + erChorID ;
					}
				}

				String erGangID = (String)(one.get("modifycateGangID")) ;
				map = new HashMap() ;
				if(erGangID != null) {
					map.put("erGangID", erGangID) ;
					Integer jieCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(jieCount == 0) {
						resCateID += "," + erGangID ;
					}else{
						resCate += "," + erGangID ;
					}
				}

				String erOrderID = (String)(one.get("modifycateOrderID")) ;
				map = new HashMap() ;
				if(erOrderID != null) {
					map.put("erOrderID", erOrderID) ;
					Integer jieCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(jieCount == 0) {
						resCateID += "," + erOrderID ;
					}else{
						resCate += "," + erOrderID ;
					}
				}

				String erCategory = (String)(one.get("modifycateforyID")) ;
				map = new HashMap() ;
				if(erOrderID != null) {
					map.put("erCategory", erCategory) ;
					Integer jieCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(jieCount == 0) {
						resCateID += "," + erCategory ;
					}else{
						resCate += "," + erCategory ;
					}
				}
			}else if("observation".equals(resType)) {
				String selectCount = "observation.select_count_by_category"	;
				HashMap map = new HashMap() ;
								
				String orCategory = (String)(one.get("modifycateerorCategory")) ;
				map = new HashMap() ;
				if(orCategory != null) {
					map.put("orCategory", orCategory) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + orCategory ;
					}else{
						resCate += "," + orCategory ;
					}
				}
				
				String orCateTwLevel = (String)(one.get("modifycateerorCateTwLevel")) ;
				map = new HashMap() ;
				if(orCateTwLevel != null) {
					map.put("orCateTwLevel", orCateTwLevel) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + orCateTwLevel ;
					}else{
						resCate += "," + orCateTwLevel ;
					}
				}				
			}else if("laboratory".equals(resType)) {
				String selectCount = "laboratory.select_count_by_category"	;
				String lrCategory = (String)(one.get("modifycateerlrCategory")) ;
				HashMap map = new HashMap() ;
				if(lrCategory != null) {
					map.put("lrCategory", lrCategory) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + lrCategory ;
					}else{
						resCate += "," + lrCategory ;
					}
				}
				
				String lrCateTwLevel = (String)(one.get("modifycateerlrCateTwLevel")) ;
				map = new HashMap() ;
				if(lrCateTwLevel != null) {
					map.put("lrCateTwLevel", lrCateTwLevel) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + lrCateTwLevel ;
					}else{
						resCate += "," + lrCateTwLevel ;
					}
				}
			}else if("projection".equals(resType)) {
				String selectCount = "projection.select_count_by_category"	;
				String prCategory = (String)(one.get("modifycateerprCategory")) ;
				HashMap map = new HashMap() ;
				if(prCategory != null) {
					map.put("prCategory", prCategory) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + prCategory ;
					}else{
						resCate += "," + prCategory ;
					}
				}
				
				String prCateTwLevel = (String)(one.get("modifycateerprCateTwLevel")) ;
				map = new HashMap() ;
				if(prCateTwLevel != null) {
					map.put("prCateTwLevel", prCateTwLevel) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + prCateTwLevel ;
					}else{
						resCate += "," + prCateTwLevel ;
					}
				}	
				
			}else if("lovely".equals(resType)) {
				String selectCount = "lovely.select_count_by_category"	;
				String erResType = (String)(one.get("modifycateerResType")) ;
				HashMap map = new HashMap() ;
				if(erResType != null) {
					map.put("crResType", erResType) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + erResType ;
					}else{
						resCate += "," + erResType ;
					}
				}
				
				String erCateTwLevel = (String)(one.get("modifycateerCateTwLevel")) ;
				map = new HashMap() ;
				if(erCateTwLevel != null) {
					map.put("crCateTwLevel", erCateTwLevel) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + erCateTwLevel ;
					}else{
						resCate += "," + erCateTwLevel ;
					}
				}
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		String[] cateID = resCateID.split(",") ;
		for(int i = 0; i < cateID.length; i ++) {
			resultData = handleCategory(eventExecutor, cateID[i]) ;
		}
		
		String[] rescateID = resCate.split(",") ;
		for(int i = 0; i < rescateID.length; i ++) {
			resultData = handleCategoryShow(eventExecutor, rescateID[i]) ;
		}

		return resultData ;
	}
	
	public static ResultData modifyCategoryStatus(EventExecutor eventExecutor,Object one,String resType) {
		ResultData resultData = new ResultData();
		HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
		int count = 0 ;
		String resCateID = "" ,resID = "";
		try{
			if("exhibition".equals(resType)) {
				String selectCount = "exhibition.select_count_by_category"	;
				BigDecimal jieID = (BigDecimal)((HashMap)one).get("erJieID") ;
				HashMap map = new HashMap() ;
				if(jieID != null) {
					map.put("erJieID", jieID) ;
					Integer jieCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(jieCount == 0) {
						resCateID += "," + jieID ;
					}else{
						resID += "," + jieID ;
					}
				}
				
				BigDecimal erChorID = (BigDecimal)((HashMap)one).get("erChorID") ;
				map = new HashMap() ;
				if(erChorID != null) {
					map.put("erChorID", erChorID) ;
					Integer jieCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(jieCount == 0) {
						resCateID += "," + erChorID ;
					}else{
						resID += "," + erChorID ;
					}
				}

				BigDecimal erGangID = (BigDecimal)((HashMap)one).get("erGangID") ;
				map = new HashMap() ;
				if(erGangID != null) {
					map.put("erGangID", erGangID) ;
					Integer jieCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(jieCount == 0) {
						resCateID += "," + erGangID ;
					}else{
						resID += "," + erGangID ;
					}
				}

				BigDecimal erOrderID = (BigDecimal)((HashMap)one).get("erOrderID") ;
				map = new HashMap() ;
				if(erOrderID != null) {
					map.put("erOrderID", erOrderID) ;
					Integer jieCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(jieCount == 0) {
						resCateID += "," + erOrderID ;
					}else{
						resID += "," + erOrderID ;
					}
				}

				BigDecimal erCategory = (BigDecimal)((HashMap)one).get("erCategory") ;
				map = new HashMap() ;
				if(erOrderID != null) {
					map.put("erCategory", erCategory) ;
					Integer jieCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(jieCount == 0) {
						resCateID += "," + erCategory ;
					}else{
						resID += "," + erCategory ;
					}
				}
			}else if("observation".equals(resType)) {
				String selectCount = "observation.select_count_by_category"	;
				HashMap map = new HashMap() ;
								
				BigDecimal orCategory = (BigDecimal)((HashMap)one).get("orCategory") ;
				map = new HashMap() ;
				if(orCategory != null) {
					map.put("orCategory", orCategory) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + orCategory ;
					}else{
						resID += "," + orCategory ;
					}
				}
				
				BigDecimal orCateTwLevel = (BigDecimal)((HashMap)one).get("orCateTwLevel") ;
				map = new HashMap() ;
				if(orCateTwLevel != null) {
					map.put("orCateTwLevel", orCateTwLevel) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + orCateTwLevel ;
					}else{
						resID += "," + orCateTwLevel ;
					}
				}				
			}else if("laboratory".equals(resType)) {
				String selectCount = "laboratory.select_count_by_category"	;
				BigDecimal lrCategory = (BigDecimal)((HashMap)one).get("lrCategory") ;
				HashMap map = new HashMap() ;
				if(lrCategory != null) {
					map.put("lrCategory", lrCategory) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + lrCategory ;
					}else{
						resID += "," + lrCategory ;
					}
				}
				
				BigDecimal lrCateTwLevel = (BigDecimal)((HashMap)one).get("lrCateTwLevel") ;
				map = new HashMap() ;
				if(lrCateTwLevel != null) {
					map.put("lrCateTwLevel", lrCateTwLevel) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + lrCateTwLevel ;
					}else{
						resID += "," + lrCateTwLevel ;
					}
				}
			}else if("projection".equals(resType)) {
				String selectCount = "projection.select_count_by_category"	;
				BigDecimal prCategory = (BigDecimal)((HashMap)one).get("prCategory") ;
				HashMap map = new HashMap() ;
				if(prCategory != null) {
					map.put("prCategory", prCategory) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + prCategory ;
					}else{
						resID += "," + prCategory ;
					}
				}
				
				BigDecimal prCateTwLevel = (BigDecimal)((HashMap)one).get("prCateTwLevel") ;
				map = new HashMap() ;
				if(prCateTwLevel != null) {
					map.put("prCateTwLevel", prCateTwLevel) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + prCateTwLevel ;
					}else{
						resID += "," + prCateTwLevel ;
					}
				}	
				
			}else if("lovely".equals(resType)) {
				String selectCount = "lovely.select_count_by_category"	;
				Integer erResType = (Integer)((HashMap)one).get("crResType") ;
				HashMap map = new HashMap() ;
				if(erResType != null) {
					map.put("crResType", erResType) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + erResType ;
					}else{
						resID += "," + erResType ;
					}
				}
				
				BigDecimal erCateTwLevel = (BigDecimal)((HashMap)one).get("crCateTwLevel") ;
				map = new HashMap() ;
				if(erCateTwLevel != null) {
					map.put("crCateTwLevel", erCateTwLevel) ;
					Integer resCount = (Integer)eventExecutor.getSqlSession().selectOne(selectCount, map) ;
					if(resCount == 0) {
						resCateID += "," + erCateTwLevel ;
					}else{
						resID += "," + erCateTwLevel ;
					}
				}
				
			}
		}catch(Exception e) {

		}
		String[] cateID = resCateID.split(",") ;
		for(int i = 0; i < cateID.length; i ++) {
			resultData = handleCategory(eventExecutor, cateID[i]) ;
		}

		String[] rescateID = resID.split(",") ;
		for(int i = 0; i < rescateID.length; i ++) {
			resultData = handleCategoryShow(eventExecutor, rescateID[i]) ;
		}
		return resultData ;
	}

	public static ResultData handleCategory(EventExecutor eventExecutor, String cateID) {
		ResultData resultData = new ResultData();
		if(cateID != null && !"".equals(cateID)) {
			HashMap map = new HashMap() ;
			map.put("cateStatus", "0") ;
			map.put("cateID", cateID) ;
			int up = eventExecutor.getSqlSession().update("category.update_res_status", map) ;
			resultData.setIntResult(1);
		}
		return resultData; 
	}
	
	public static ResultData handleCategoryShow(EventExecutor eventExecutor, String cateID) {
		ResultData resultData = new ResultData();
		if(cateID != null && !"".equals(cateID)) {
			HashMap map = new HashMap() ;
			map.put("cateStatus", "1") ;
			map.put("cateID", cateID) ;
			int up = eventExecutor.getSqlSession().update("category.update_res_status", map) ;
			resultData.setIntResult(1);
		}
		return resultData; 
	}

	public static void handleArea(EventExecutor eventExecutor) {
		HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
		String erCountry = paramMap.get("erCountry") == null ? "" : (String)paramMap.get("erCountry");
		String erProvince = paramMap.get("erProvince") == null ? "" : (String)paramMap.get("erProvince");
		String erCity = paramMap.get("erCity") == null ? "" : (String)paramMap.get("erCity");
		String erArea = paramMap.get("erArea") == null ? "" : (String)paramMap.get("erArea");

		if(findResByAreaCount(eventExecutor, "erArea", erArea) == 0) {
			updateAreaIsShow(eventExecutor, erArea, 0) ;
		}else {
			updateAreaIsShow(eventExecutor, erArea, 1) ;
		}

		if(findResByAreaCount(eventExecutor, "erCity", erCity) == 0) {
			updateAreaIsShow(eventExecutor, erCity, 0) ;
		}else {
			updateAreaIsShow(eventExecutor, erCity, 1) ;
		}

		if(findResByAreaCount(eventExecutor, "erProvince", erProvince) == 0) {
			updateAreaIsShow(eventExecutor, erProvince, 0) ;
		}else {
			updateAreaIsShow(eventExecutor, erProvince, 1) ;
		}

		if(findResByAreaCount(eventExecutor, "erCountry", erCountry) == 0) {
			updateAreaIsShow(eventExecutor, erCountry, 0) ;
		}else {
			updateAreaIsShow(eventExecutor, erCountry, 1) ;
		}
	}

	public static int findResByAreaCount(EventExecutor eventExecutor, String fieldName, String areaID) {
		HashMap map = new HashMap() ;
		int count = 0 ;
		if(areaID!= null && !"".equals(areaID)){
			map.put(fieldName, areaID) ;
			Object obj = eventExecutor.getSqlSession().selectOne("exhibition.select_res_area_count", map) ;

			if (obj instanceof Integer)
				count = ((Integer)obj).intValue();
		}
		return count ;
	}

	public static ResultData updateAreaIsShow(EventExecutor eventExecutor, String areaID, int areaIsShow) {
		ResultData resultData = new ResultData();
		if(areaID != null && !"".equals(areaID)) {
			HashMap map = new HashMap() ;
			map.put("areaIsShow", areaIsShow) ;
			map.put("areaID", areaID) ;
			int up = eventExecutor.getSqlSession().update("area.update_area_show", map) ;
			resultData.setIntResult(1);
		}
		return resultData; 
	}
}