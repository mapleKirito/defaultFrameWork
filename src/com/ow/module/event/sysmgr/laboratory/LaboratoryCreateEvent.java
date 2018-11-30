package com.ow.module.event.sysmgr.laboratory;

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

public class LaboratoryCreateEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	private static String fileSplit = "/";

	public LaboratoryCreateEvent() {
		resultData = new ResultData();
	}

	@SuppressWarnings({ "unchecked", "unused", "rawtypes" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			//System.out.println(paramMap.get("lrIsRefer"));
			String insert = eventExecutor.getSqlidByIndex(0);
			boolean isUploadFile = true ;	//资源文件是否也上传了
			if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
				
				String resFolder = StringUtil.reResTypeThum("laboratory") ;
				String s_userType = paramMap.get("s_userType") == null ? "0" : (String)paramMap.get("s_userType") ; //用户类型 管理员录入数据： 0 ，老师录入数据： 1
				String expentNum = StringUtil.resExpentNum("laboratory") ;	//未来扩展值
				String snNO = StringUtil.intToSN(DBUtil.findSN(eventExecutor, "laboratory"), 8, "0") ; //编号

				String resNO = resFolder + s_userType + expentNum + snNO ;	//资源编号
				paramMap.put("lrNO", resNO) ;
				
				String content = paramMap.get("contentHelp") == null ? "" : ((String)paramMap.get("contentHelp"));
				if(content.equals("1")){
					paramMap.put("lrStoryState", 4);
				}else{
					paramMap.put("lrStoryState", " -- ");
				}
				
				String lrType = paramMap.get("lrType") == null ? "" : (String)paramMap.get("lrType");
				if(lrType.equals("1084")||lrType.equals("2033")||lrType.equals("2041")){
					paramMap.put("lrState", 4);
				}
				//音频文件
				if(lrType.equals("1073")){
					paramMap.put("lrAudio", (String)paramMap.get("lrUpload"));
				}
				//压缩包文件
				if(lrType.equals("4033")){
					paramMap.put("lrInThum", "images/resImage/file_type_12.jpg");
					paramMap.put("lrThumbnail", "images/resImage/file_type_12.jpg");
				}
				resultData = DBUtil.uploadRes(eventExecutor, "laboratory", resNO, true) ;
				if(resultData.getIntResult() > -1) {
					paramMap = eventExecutor.getBaseAction().getParamMap();
				}else {
					return resultData ;
				}

				if (!"".equals(insert)) {	

					if("".equals(((String)paramMap.get("lrCateTwLevel")))){
						paramMap.put("lrCateTwLevel", paramMap.get("lrCategory")) ;
					}
					
					String olderRecommen = paramMap.get("lrRecommen") == null ? "" : (String)paramMap.get("lrRecommen") ;
					String Recommensize = paramMap.get("Recommensize") == null ? "" : (String)paramMap.get("Recommensize") ;
					String lrRecommen = "0";
					if(!olderRecommen.equals("0") && !Recommensize.equals("0")){
						lrRecommen = olderRecommen+","+Recommensize;
					}
					paramMap.put("lrRecommen", lrRecommen) ;
					paramMap.put("lrIsGrade", 1) ;
					
					String lrKeywords = paramMap.get("lrKeywords") == null ? "" : ((String)paramMap.get("lrKeywords")).replace("\r\n", "");
					if(!"".equals(lrKeywords)){
						paramMap.put("lrKeywords","、" + lrKeywords+"、") ;
						
					}
					
					
					String grGrades = paramMap.get("grGrades") == null ? "" : (String)paramMap.get("grGrades") ;
					String grJingsai = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;
					paramMap.put("lrGrade", grGrades) ;
					paramMap.put("lrContest", grJingsai);
					
					String lrThumbnail = paramMap.get("lrThumbnail") == null ? "" : (String)paramMap.get("lrThumbnail") ;
					String lrInThum = paramMap.get("lrInThum") == null ? "" : (String)paramMap.get("lrInThum") ;
					
					String grJingsais = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;
					paramMap.put("lrContest", grJingsais);
					
					String lrContent = paramMap.get("lrContent") == null ? "" : ((String)paramMap.get("lrContent")).replace("\r\n", "");
					paramMap.put("lrContent",  lrContent) ;
					
					
					String lrRelation = paramMap.get("lrRelation") == null ? "" : ((String)paramMap.get("lrRelation")).replace("\r\n", "");
					paramMap.put("lrRelation", lrRelation) ;
					
					if(lrType.equals("2033") || lrType.equals("2041") || lrType.equals("2055")){
						String lrUpload = paramMap.get("lrUpload") == null ? "" : (String)paramMap.get("lrUpload") ;
						String lrFileSwf = 	lrUpload.substring(0,lrUpload.lastIndexOf("/"))+"/"+resNO.substring(resNO.length()-4)+"/mainfile";
						paramMap.put("lrFileSwf",  lrFileSwf) ;
					}
					
					int rvalue = eventExecutor.getSqlSession().insert(insert,paramMap);
					resultData.setIntResult(1);

					//maple
					//DBUtil.updatSN(eventExecutor, "laboratory") ;
					if(isUploadFile) {	//如果上传了资源文件，更新资源文件表和适用学段、年级表
						if(null != eventExecutor.getBaseAction().getParamMap().get("generatedKey")) {
							/******************将上传的文件放到年级表中********************/
							HashMap paramgrade = new HashMap() ;
							String greadDeleteByRes = "grade.delete_res";
							String greadUpdate = "grade.insert";	
							paramgrade.put("grResourceType", "laboratory") ;
							paramgrade.put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							eventExecutor.getSqlSession().delete(greadDeleteByRes, paramgrade) ;
							String[] grGrade = grGrades.split(",") ;
							for(int i = 0; i < grGrade.length; i ++) {
								if(!grGrade[i].trim().equals("")){	
									paramgrade.put("grGrade", grGrade[i]) ;
									paramgrade.put("grThumbnail", lrThumbnail) ;
									paramgrade.put("grInThum", lrInThum) ;
									paramgrade.put("grName", paramMap.get("lrName")) ;
									paramgrade.put("grUpload", paramMap.get("lrUpload")) ;
									paramgrade.put("grType", paramMap.get("lrType")) ;
									paramgrade.put("grIsShare", paramMap.get("lrIsShare")) ;
									paramgrade.put("s_userID", paramMap.get("s_userID")) ;
									paramgrade.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
									eventExecutor.getSqlSession().insert(greadUpdate, paramgrade) ;
								}
							}
							String[] jingsai = grJingsais.split(",") ;
							HashMap paramcontest = new HashMap() ;
							paramcontest.put("grResourceType", "laboratory") ;
							paramcontest.put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							for(int h=0;h<jingsai.length;h++){
								if(!jingsai[h].trim().equals("")){	
									paramcontest.put("grGrade", "324") ;
									paramcontest.put("grJieIDSelf", jingsai[h]) ;
									paramcontest.put("grThumbnail", lrThumbnail) ;
									paramcontest.put("grInThum", lrInThum) ;
									paramcontest.put("grName", paramMap.get("lrName")) ;
									paramcontest.put("grUpload", paramMap.get("lrUpload")) ;
									paramcontest.put("grType", paramMap.get("lrType")) ;
									paramcontest.put("grIsShare", paramMap.get("lrIsShare")) ;
									paramcontest.put("s_userID", paramMap.get("s_userID")) ;
									paramcontest.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
									eventExecutor.getSqlSession().insert(greadUpdate, paramcontest) ;
								}
							}
							
							/******************将上传的文件放到年级表中********************/
							/******************将上传的文件放到推荐表中******************/
								String resInsert = "recom.insert";
								paramMap.put("reRecommendID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
								paramMap.put("reRecommendType", "laboratory") ;
								paramMap.put("reUpload", paramMap.get("lrUpload")) ;
								paramMap.put("reName", paramMap.get("lrName")) ;
								paramMap.put("reThumbnail", paramMap.get("lrThumbnail")) ;
								paramMap.put("reType", paramMap.get("lrType")) ;
								paramMap.put("reInThum", paramMap.get("lrInThum")) ;
								paramMap.put("reSize", paramMap.get("Recommensize")) ;
								paramMap.put("reRecoFileUP", paramMap.get("lrRecommenFile")) ;
								eventExecutor.getSqlSession().insert(resInsert, paramMap) ;
							/******************将上传的文件放到推荐表中******************/
							/******************同步资源信息********************/
							String resinsert = "res.insert";
							HashMap paramres = new HashMap() ;
							paramres.put("rrResourceType", "laboratory") ;
							paramres.put("rrResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							paramres.put("rrThumbnail", lrThumbnail) ;
							paramres.put("rrInThum", paramMap.get("lrInThum")) ;
							paramres.put("rrName", paramMap.get("lrName")) ;
							paramres.put("rrUpload", paramMap.get("lrUpload")) ;
							paramres.put("rrType", paramMap.get("lrType")) ;
							paramres.put("rrIsShare", paramMap.get("lrIsShare")) ;
							paramres.put("s_userID", paramMap.get("s_userID")) ;
							paramres.put("rrFileSwfPath", paramMap.get("lrFileSwfPath")) ;
							paramres.put("rrFileSwf", paramMap.get("lrFileSwf")) ;
							paramres.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
							eventExecutor.getSqlSession().insert(resinsert,paramres);
							/******************同步资源信息********************/	
							
							//初始化二维码扫描静态页
							PageInfoBean pib=StaticTableFactory.getPageInfoBeanLaboratory(paramMap);
							InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("lrName").toString(),paramMap.get("lrContent").toString(),pib,paramMap.get("lrNO").toString());
							Thread temp_t=new Thread(ish);
							temp_t.start();
						}							
						
						//String lrReferType = paramMap.get("lrReferType") == null ? "" : (String)paramMap.get("lrReferType") ;
						String lrHelpReferType = paramMap.get("lrHelpReferType") == null ? "" : (String)paramMap.get("lrHelpReferType") ;
						String lrReferLocation = paramMap.get("lrReferLocation") == null ? "" : (String)paramMap.get("lrReferLocation") ;
						String lrReferRealLocation = paramMap.get("lrReferRealLocation") == null ? "" : (String)paramMap.get("lrReferRealLocation") ;
						String lrReferRealLocationSwfPath = paramMap.get("lrReferRealLocationSwfPath") == null ? "" : (String)paramMap.get("lrReferRealLocationSwfPath") ;
						
						if(!lrReferLocation.equals(""))
							lrReferLocation = lrReferLocation.substring(0,lrReferLocation.lastIndexOf(","));							
						
						//String ReferType[] = lrReferType.split(",");
						String HelpReferType[] = lrHelpReferType.split(",");
						String ReferLocation[] = lrReferLocation.split(",");
						String ReferRealLocation[] = lrReferRealLocation.split(",");
						String ReferRealLocationSwfPath[] = lrReferRealLocationSwfPath.split(",");
						
						String referResLen = paramMap.get("referResLen") == null ? "0" : (String)paramMap.get("referResLen") ;
						if(!referResLen.equals("0") && !referResLen.equals("")){
							HashMap map = new HashMap();
							String referinsert = "refer.insert";
							for(int h = 0;h<ReferLocation.length;h++){
								String referUpload = ReferRealLocation[h].trim();
								map.put("referReferID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
								map.put("referName", paramMap.get("lrName")) ;
								map.put("referReferType","laboratory") ;
								map.put("referThumbnail", StringUtil.reResReferThumbnail(HelpReferType[h])) ;
								map.put("referUpload", ReferRealLocationSwfPath[h].trim()) ;
								map.put("referFileSwf", ReferLocation[h].trim()) ;
								map.put("referFileSwfPath", (ReferRealLocationSwfPath[h].trim().substring(0,ReferRealLocationSwfPath[h].trim().lastIndexOf("."))+".swf").replace("\\", "/")) ;
								map.put("referType", referUpload.substring(referUpload.lastIndexOf(".")).replace(".", "")) ;
								eventExecutor.getSqlSession().insert(referinsert, map) ;
							}
						}
					}
					//修改分类状态
					String lrCategory = paramMap.get("lrCategory") == null ? "":paramMap.get("lrCategory").toString();
					if (!lrCategory.equals("")){
						paramMap.put("cateID", lrCategory);
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
			String type=(String)paramMap.get("lrType");
			ResourceCount.sendMsg(type,"UPLOAD");
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, LaboratoryCreateEvent.class);
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
