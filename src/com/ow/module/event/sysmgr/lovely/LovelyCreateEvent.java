package com.ow.module.event.sysmgr.lovely;

import java.util.HashMap;

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

public class LovelyCreateEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	private static String fileSplit = "/";

	public LovelyCreateEvent() {
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
			
				String resFolder = StringUtil.reResTypeThum("lovely") ;
				String s_userType = paramMap.get("s_userType") == null ? "0" : (String)paramMap.get("s_userType") ; //用户类型 管理员录入数据： 0 ，老师录入数据： 1
				String expentNum = StringUtil.resExpentNum("lovely") ;	//未来扩展值
				String snNO = StringUtil.intToSN(DBUtil.findSN(eventExecutor, "lovely"), 8, "0") ; //编号

				String resNO = resFolder + s_userType + expentNum + snNO ;	//资源编号
				paramMap.put("crNO", resNO) ;
				
				//maple
				String erType = paramMap.get("crType") == null ? "" : (String)paramMap.get("crType");
				if(erType.equals("1084")||erType.equals("2033")||erType.equals("2041")){
					paramMap.put("crState", 4);
				}
				
				String content = paramMap.get("contentHelp") == null ? "" : ((String)paramMap.get("contentHelp"));
				if(content.equals("1")){
					paramMap.put("crStoryState", 4);
				}else{
					paramMap.put("crStoryState", " -- ");
				}
				
				resultData = DBUtil.uploadRes(eventExecutor, "lovely", resNO, true) ;
				if(resultData.getIntResult() > -1) {
					paramMap = eventExecutor.getBaseAction().getParamMap();
				}else {
					return resultData ;
				}

				if (!"".equals(insert)) {	
					paramMap.put("crIsGrade", 1) ;
					paramMap.put("crGrade", grGrades) ;
					paramMap.put("crContest", grJingsai);
					
					if("".equals(((String)paramMap.get("crCateTwLevel")))){
						paramMap.put("crCateTwLevel", paramMap.get("crResType")) ;
					}
					
					String olderRecommen = paramMap.get("crRecommen") == null ? "" : (String)paramMap.get("crRecommen") ;
					String Recommensize = paramMap.get("Recommensize") == null ? "" : (String)paramMap.get("Recommensize") ;
					String erRecommen = "0";
					if(!olderRecommen.equals("0") && !Recommensize.equals("0")){
						erRecommen = olderRecommen+","+Recommensize;
					}
					paramMap.put("crRecommen", erRecommen) ;
					
					String erThumbnail = paramMap.get("crThumbnail") == null ? "" : (String)paramMap.get("crThumbnail") ;
					String erInThum = paramMap.get("crInThum") == null ? "" : (String)paramMap.get("crInThum") ;
					
					String grJingsais = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;
					paramMap.put("crContest", grJingsais);
					
					String erRelation = paramMap.get("crRelation") == null ? "" : ((String)paramMap.get("crRelation")).replace("\r\n", "");
					paramMap.put("crRelation",  erRelation) ;
					
					String erContent = paramMap.get("crContent") == null ? "" : ((String)paramMap.get("crContent")).replace("\r\n", "");
					paramMap.put("crContent",  erContent) ;
					
					if(erType.equals("2033") || erType.equals("2041") || erType.equals("2055")){
						String erUpload = paramMap.get("crUpload") == null ? "" : (String)paramMap.get("crUpload") ;
						String erFileSwf = 	erUpload.substring(0,erUpload.lastIndexOf("/"))+"/"+resNO.substring(resNO.length()-4)+"/mainfile";
						paramMap.put("crFileSwf",  erFileSwf) ;
					}
					//压缩包文件
					if(erType.equals("4033")){
						paramMap.put("crInThum", "images/resImage/file_type_12.jpg");
						paramMap.put("crThumbnail", "images/resImage/file_type_12.jpg");
					}
					int rvalue = eventExecutor.getSqlSession().insert(insert,paramMap);
					resultData.setIntResult(1);

					if(isUploadFile) {	//如果上传了资源文件，更新资源文件表和适用学段、年级表
						if(null != eventExecutor.getBaseAction().getParamMap().get("generatedKey")) {
							/******************将上传的文件放到年级表中********************/
							HashMap paramgrade = new HashMap() ;
							String greadDeleteByRes = "grade.delete_res";
							String greadUpdate = "grade.insert";	
							paramgrade.put("grResourceType", "lovely") ;
							paramgrade.put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							eventExecutor.getSqlSession().delete(greadDeleteByRes, paramgrade) ;
							String[] grGrade = grGrades.split(",") ;
							for(int i = 0; i < grGrade.length; i ++) {
								if(!grGrade[i].trim().equals("")){	
									paramgrade.put("grGrade", grGrade[i]) ;
									paramgrade.put("grThumbnail", erThumbnail) ;
									paramgrade.put("grInThum", erInThum) ;
									paramgrade.put("grName", paramMap.get("crName")) ;
									paramgrade.put("grUpload", paramMap.get("crUpload")) ;
									paramgrade.put("grType", paramMap.get("crType")) ;
									paramgrade.put("grIsShare", paramMap.get("crIsShare")) ;
									paramgrade.put("s_userID", paramMap.get("s_userID")) ;
									paramgrade.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
									eventExecutor.getSqlSession().insert(greadUpdate, paramgrade) ;
								}
							}
							String[] jingsai = grJingsais.split(",") ;
							HashMap paramcontest = new HashMap() ;
							paramcontest.put("grResourceType", "lovely") ;
							paramcontest.put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							for(int h=0;h<jingsai.length;h++){
								if(!jingsai[h].trim().equals("")){	
									paramcontest.put("grGrade", "324") ;
									paramcontest.put("grJieIDSelf", jingsai[h]) ;
									paramcontest.put("grThumbnail", erThumbnail) ;
									paramcontest.put("grInThum", erInThum) ;
									paramcontest.put("grName", paramMap.get("crName")) ;
									paramcontest.put("grUpload", paramMap.get("crUpload")) ;
									paramcontest.put("grType", paramMap.get("crType")) ;
									paramcontest.put("grIsShare", paramMap.get("crIsShare")) ;
									paramcontest.put("s_userID", paramMap.get("s_userID")) ;
									paramcontest.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
									eventExecutor.getSqlSession().insert(greadUpdate, paramcontest) ;
								}
							}
							/******************将上传的文件放到年级表中********************/
							/******************同步资源信息********************/
							String resinsert = "res.insert";
							HashMap paramres = new HashMap() ;
							paramres.put("rrResourceType", "lovely") ;
							paramres.put("rrResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							paramres.put("rrThumbnail", erThumbnail) ;
							paramres.put("rrInThum", paramMap.get("crInThum")) ;
							paramres.put("rrName", paramMap.get("crName")) ;
							paramres.put("rrUpload", paramMap.get("crUpload")) ;
							paramres.put("rrType", paramMap.get("crType")) ;
							paramres.put("rrIsShare", paramMap.get("crIsShare")) ;
							paramres.put("s_userID", paramMap.get("s_userID")) ;
							paramres.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
							eventExecutor.getSqlSession().insert(resinsert,paramres);
							/******************同步资源信息********************/	
							
							//初始化二维码扫描静态页
							PageInfoBean pib=StaticTableFactory.getPageInfoBeanLovely(paramMap);
							InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("crName").toString(),paramMap.get("crContent").toString(),pib,paramMap.get("crNO").toString());
							Thread temp_t=new Thread(ish);
							temp_t.start();
							
							/******************将上传的文件放到推荐表中******************/
							String resInsert = "recom.insert";
							if(!erRecommen.equals("0")){
								paramMap.put("reRecommendID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
								paramMap.put("reRecommendType", "lovely") ;
								paramMap.put("reUpload", paramMap.get("crUpload")) ;
								paramMap.put("reName", paramMap.get("crName")) ;
								paramMap.put("reThumbnail", paramMap.get("crThumbnail")) ;
								paramMap.put("reType", paramMap.get("crType")) ;
								paramMap.put("rrIsShare", paramMap.get("crIsShare")) ;
								paramMap.put("reInThum", paramMap.get("crInThum")) ;
								paramMap.put("reSize", paramMap.get("Recommensize")) ;
								paramMap.put("reRecoFileUP", paramMap.get("crRecommenFile")) ;
								eventExecutor.getSqlSession().insert(resInsert, paramMap) ;
							}
							/******************将上传的文件放到推荐表中******************/	

							//String erReferType = paramMap.get("crReferType") == null ? "" : (String)paramMap.get("crReferType") ;
							String erHelpReferType = paramMap.get("crHelpReferType") == null ? "" : (String)paramMap.get("crHelpReferType") ;
							String erReferLocation = paramMap.get("crReferLocation") == null ? "" : (String)paramMap.get("crReferLocation") ;
							String erReferRealLocation = paramMap.get("crReferRealLocation") == null ? "" : (String)paramMap.get("crReferRealLocation") ;
							String erReferRealLocationSwfPath = paramMap.get("crReferRealLocationSwfPath") == null ? "" : (String)paramMap.get("crReferRealLocationSwfPath") ;
							
							if(!erReferLocation.equals(""))
								erReferLocation = erReferLocation.substring(0,erReferLocation.lastIndexOf(","));							
							
							//String ReferType[] = erReferType.split(",");
							String HelpReferType[] = erHelpReferType.split(",");
							String ReferLocation[] = erReferLocation.split(",");
							String ReferRealLocation[] = erReferRealLocation.split(",");
							String ReferRealLocationSwfPath[] = erReferRealLocationSwfPath.split(",");
							
							String referResLen = paramMap.get("referResLen") == null ? "0" : (String)paramMap.get("referResLen") ;
							if(!referResLen.equals("0") && !referResLen.equals("")){
								HashMap map = new HashMap();
								String referinsert = "refer.insert";
								for(int h = 0;h<ReferLocation.length;h++){
									String referUpload = ReferRealLocation[h].trim();
									map.put("referReferID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
									map.put("referName", paramMap.get("crName")) ;
									map.put("referReferType","lovely") ;
									map.put("referThumbnail", StringUtil.reResReferThumbnail(HelpReferType[h])) ;
									map.put("referUpload", ReferRealLocationSwfPath[h].trim()) ;
									map.put("referFileSwf", ReferLocation[h].trim()) ;
									map.put("referFileSwfPath", (ReferRealLocationSwfPath[h].trim().substring(0,ReferRealLocationSwfPath[h].trim().lastIndexOf("."))+".swf").replace("\\", "/")) ;
									map.put("referType", referUpload.substring(referUpload.lastIndexOf(".")).replace(".", "")) ;
									eventExecutor.getSqlSession().insert(referinsert, map) ;
								}
							}							
							
						}	
					}
					//修改分类状态
					String category = paramMap.get("crResType") == null ? "":paramMap.get("crResType").toString();
					if (!category.equals("")){
						paramMap.put("cateID", category);
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
			String type=(String)paramMap.get("crType");
			ResourceCount.sendMsg(type,"UPLOAD");
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, LovelyCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
