package com.ow.module.event.sysmgr.observation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.UploadDataAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DBUtil;
import com.ow.framework.util.StringUtil;
import com.staticHtml.bean.PageInfoBean;
import com.staticHtml.util.InitStaticHtml;
import com.staticHtml.util.StaticTableFactory;
import com.unitecount.ResourceCount;

public class ObservationCreateEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	private static String fileSplit = "/";

	public ObservationCreateEvent() {
		resultData = new ResultData();
	}

	@SuppressWarnings({ "unchecked", "unused", "rawtypes" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String insert = eventExecutor.getSqlidByIndex(0);
			boolean isUploadFile = true ;	//资源文件是否也上传了
			if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
				String grGrades = paramMap.get("grGrades") == null ? "" : (String)paramMap.get("grGrades") ;
				String grJingsai = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;

				String resFolder = StringUtil.reResTypeThum("observation") ;
				String s_userType = paramMap.get("s_userType") == null ? "0" : (String)paramMap.get("s_userType") ; //用户类型 管理员录入数据： 0 ，老师录入数据： 1
				String expentNum = StringUtil.resExpentNum("observation") ;	//未来扩展值
				String snNO = StringUtil.intToSN(DBUtil.findSN(eventExecutor, "observation"), 8, "0") ; //编号

				String resNO = resFolder + s_userType + expentNum + snNO ;	//资源编号

				String content = paramMap.get("contentHelp") == null ? "" : ((String)paramMap.get("contentHelp"));
				if(content.equals("1")){
					paramMap.put("orStoryState", 4);
				}else{
					paramMap.put("orStoryState", " -- ");
				}

				paramMap.put("orNO", resNO) ;
				resultData = DBUtil.uploadRes(eventExecutor, "observation", resNO, true) ;
				if(resultData.getIntResult() > -1) {
					paramMap = eventExecutor.getBaseAction().getParamMap();
				}else {
					return resultData ;
				}


				//maple
				String orType = paramMap.get("orType") == null ? "" : (String)paramMap.get("orType");
				if(orType.equals("1084")){
					paramMap.put("orState", 4);
				}
				if(orType.equals("2033")){
					paramMap.put("orState", 4);
				}
				if(orType.equals("2041")){
					paramMap.put("orState", 4);
				}
		
				/*if(orType.equals("1011")){
					paramMap.put("orState", 4);
				}*/
				//音频文件
				if(orType.equals("1073")){
					paramMap.put("orAudio", (String)paramMap.get("orUpload"));
				}
				//压缩包文件
				if(orType.equals("4033")){
					paramMap.put("orInThum", "images/resImage/file_type_12.jpg");
					paramMap.put("orThumbnail", "images/resImage/file_type_12.jpg");
				}
				
				if (!"".equals(insert)) {	
					paramMap.put("orIsGrade", 1) ;
					paramMap.put("orGrade", grGrades) ;
					paramMap.put("orContest", grJingsai);

					if("".equals(((String)paramMap.get("orCateTwLevel")))){
						paramMap.put("orCateTwLevel", paramMap.get("orCategory")) ;
					}
					
					String olderRecommen = paramMap.get("orRecommen") == null ? "" : (String)paramMap.get("orRecommen") ;
					String Recommensize = paramMap.get("Recommensize") == null ? "" : (String)paramMap.get("Recommensize") ;
					String orRecommen = "0";
					if(!olderRecommen.equals("0") && !Recommensize.equals("0")){
						orRecommen = olderRecommen+","+Recommensize;
					}
					paramMap.put("orRecommen", orRecommen) ;
					
					
					
					String orThumbnail = paramMap.get("orThumbnail") == null ? "" : (String)paramMap.get("orThumbnail") ;
					String orInThum = paramMap.get("orInThum") == null ? "" : (String)paramMap.get("orInThum") ;
					
					String grJingsais = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;
					paramMap.put("orContest", grJingsais);
					
					String orContent = paramMap.get("orContent") == null ? "" : ((String)paramMap.get("orContent")).replace("\r\n", "");
					paramMap.put("orContent",  orContent) ;
					
					String orKeywords = paramMap.get("orKeywords") == null ? "" : ((String)paramMap.get("orKeywords")).replace("\r\n", "");
					if(!"".equals(orKeywords)){
						paramMap.put("orKeywords","、" + orKeywords+"、") ;
						
					}
					
					
					String orRelation = paramMap.get("orRelation") == null ? "" : ((String)paramMap.get("orRelation")).replace("\r\n", "");
					paramMap.put("orRelation",  orRelation) ;
					String swffile=(String) paramMap.get("orFileSwf");
					//System.out.println("取到的swf"+swffile);
					if ("".equals(swffile)||swffile==null){
						String orUpload=(String)paramMap.get("orUpload");
						swffile=orUpload.substring(0,18)+orUpload.substring(orUpload.length()-8,orUpload.length()-4)+"/mainfile";
					    paramMap.put("orFileSwf", swffile);	
					//System.out.println(swffile);
					}
					int rvalue = eventExecutor.getSqlSession().insert(insert,paramMap);
					//System.out.println("写入数据库时间为："+new java.text.SimpleDateFormat("yy-MM-dd HH:mm:ss").format(new java.util.Date()));
					resultData.setIntResult(1);

					if(isUploadFile) {
						if(null != eventExecutor.getBaseAction().getParamMap().get("generatedKey")) {
							/******************将上传的文件放到年级表中********************/
							HashMap paramgrade = new HashMap() ;
							String greadDeleteByRes = "grade.delete_res";
							String greadUpdate = "grade.insert";	
							paramgrade.put("grResourceType", "observation") ;
							paramgrade.put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							eventExecutor.getSqlSession().delete(greadDeleteByRes, paramgrade) ;
							String[] grGrade = grGrades.split(",") ;
							for(int i = 0; i < grGrade.length; i ++) {
								if(!grGrade[i].trim().equals("")){	
									paramgrade.put("grGrade", grGrade[i]) ;
									paramgrade.put("grThumbnail", orThumbnail) ;
									paramgrade.put("grInThum", orInThum) ;
									paramgrade.put("grName", paramMap.get("orName")) ;
									paramgrade.put("grUpload", paramMap.get("orUpload")) ;
									paramgrade.put("grType", paramMap.get("orType")) ;
									paramgrade.put("grIsShare", paramMap.get("orIsShare")) ;
									paramgrade.put("s_userID", paramMap.get("s_userID")) ;
									paramgrade.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
									eventExecutor.getSqlSession().insert(greadUpdate, paramgrade) ;
								}
							}
							String[] jingsai = grJingsais.split(",") ;
							HashMap paramcontest = new HashMap() ;
							paramcontest.put("grResourceType", "observation") ;
							paramcontest.put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							for(int h=0;h<jingsai.length;h++){
								if(!jingsai[h].trim().equals("")){	
									paramcontest.put("grGrade", "324") ;
									paramcontest.put("grJieIDSelf", jingsai[h]) ;
									paramcontest.put("grThumbnail", orThumbnail) ;
									paramcontest.put("grInThum", orInThum) ;
									paramcontest.put("grName", paramMap.get("orName")) ;
									paramcontest.put("grUpload", paramMap.get("orUpload")) ;
									paramcontest.put("grType", paramMap.get("orType")) ;
									paramcontest.put("grIsShare", paramMap.get("orIsShare")) ;
									paramcontest.put("s_userID", paramMap.get("s_userID")) ;
									paramcontest.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
									eventExecutor.getSqlSession().insert(greadUpdate, paramcontest) ;
								}
							}
							
							/******************将上传的文件放到年级表中********************/
							/******************将上传的文件放到推荐表中******************/
								String resInsert = "recom.insert";
								paramMap.put("reRecommendID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
								paramMap.put("reRecommendType", "observation") ;
								paramMap.put("reUpload", paramMap.get("orUpload")) ;
								paramMap.put("reName", paramMap.get("orName")) ;
								paramMap.put("reThumbnail", paramMap.get("orThumbnail")) ;
								paramMap.put("reType", paramMap.get("orType")) ;
								paramMap.put("reInThum", paramMap.get("orInThum")) ;
								paramMap.put("reSize", paramMap.get("Recommensize")) ;
								paramMap.put("reRecoFileUP", paramMap.get("orRecommenFile")) ;
								eventExecutor.getSqlSession().insert(resInsert, paramMap) ;
							/******************将上传的文件放到推荐表中******************/
							/******************同步资源信息********************/
							String resinsert = "res.insert";
							HashMap paramres = new HashMap() ;
							paramres.put("rrResourceType", "observation") ;
							paramres.put("rrResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							paramres.put("rrThumbnail", orThumbnail) ;
							paramres.put("rrInThum", paramMap.get("orInThum")) ;
							paramres.put("rrName", paramMap.get("orName")) ;
							paramres.put("rrUpload", paramMap.get("orUpload")) ;
							paramres.put("rrType", paramMap.get("orType")) ;
							paramres.put("rrIsShare", paramMap.get("orIsShare")) ;
							paramres.put("rrAudio", paramMap.get("orAudio")) ;
							paramres.put("s_userID", paramMap.get("s_userID")) ;
							paramres.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
							eventExecutor.getSqlSession().insert(resinsert,paramres);
							/******************同步资源信息********************/	
									
							//初始化二维码扫描静态页
							PageInfoBean pib=StaticTableFactory.getPageInfoBeanObservation(paramMap);
							InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("orName").toString(),paramMap.get("orContent").toString(),pib,paramMap.get("orNO").toString());
							Thread temp_t=new Thread(ish);
							temp_t.start();
						}
					}
					//修改分类状态
					String orCategory = paramMap.get("orCategory") == null ? "":paramMap.get("orCategory").toString();
					if (!orCategory.equals("")){
						paramMap.put("cateID", orCategory);
						Object obj = eventExecutor.getSqlSession().selectOne("category.select_by_id", paramMap);
						if (obj != null){
							if (obj instanceof HashMap){
								String path = ((HashMap)obj).get("catePath") == null?"":((HashMap)obj).get("catePath").toString();
								String pathArr [] = path.split(",");
								for (int i=0; i<pathArr.length; i++){
									if (pathArr[i] != null && !pathArr[i].equals("")){
										paramMap.put("cateID", pathArr[i]);
										eventExecutor.getSqlSession().update("category.update_status", paramMap);
									}
								}
							}
						}
					}					
				}	
			}
			//配合统计模块进行上传统计
			if(ConstantI.ISCOUNT_KEY.equals("1")){
			String type=(String)paramMap.get("orType");
			ResourceCount.sendMsg(type,"UPLOAD");
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ObservationCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}

	/** 对多文件上传的路径处理方法 */
	@SuppressWarnings("unused")
	private List<String> getTempPath(String str, int length) {
		List<String> returnList = new ArrayList<String>();
		/** 当隐藏域没有配置 */
		if (str == null) {
			for (int i = 0; i < length; i++) {
				returnList.add(fileSplit);
			}
			return returnList;
		} else {
			/** 当上传多文件的时候两种情况 */
			String strs[] = str.split("&");
			if (strs.length > 0 && strs.length < length) {
				for (int i = 0; i < strs.length; i++) {
					returnList.add(strs[i] + fileSplit);
				}
				for (int j = 0; j < length - strs.length; j++) {
					returnList.add(fileSplit);
				}
				return returnList;
			} else {
				returnList.add(str);
				for (int i = 0; i < length - 1; i++) {
					returnList.add(fileSplit);
				}
				return returnList;
			}
		}
	}
}
