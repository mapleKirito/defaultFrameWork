package com.ow.module.event.sysmgr.expand;

import java.io.File;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ambow.base.grm.common.ConstantI;
import com.ambow.base.grm.onlineread.web.OnlineReadEntrance;
import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.UploadDataAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DBUtil;
import com.ow.framework.util.DateUtil;
import com.ow.framework.util.FileHelper;
import com.ow.framework.util.StringUtil;
import com.ow.module.event.sysmgr.ResourceUtil;
import com.staticHtml.bean.PageInfoBean;
import com.staticHtml.util.InitStaticHtml;
import com.staticHtml.util.StaticTableFactory;

public class ExpandCreateEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	private static String fileSplit = "/";

	public ExpandCreateEvent() {
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
			
				String resFolder = StringUtil.reResTypeThum("expand") ;
				String s_userType = paramMap.get("s_userType") == null ? "0" : (String)paramMap.get("s_userType") ; //用户类型 管理员录入数据： 0 ，老师录入数据： 1
				String expentNum = StringUtil.resExpentNum("expand") ;	//未来扩展值
				String snNO = StringUtil.intToSN(DBUtil.findSN(eventExecutor, "expand"), 8, "0") ; //编号

				String resNO = resFolder + s_userType + expentNum + snNO ;	//资源编号
				paramMap.put("erNO", resNO) ;
				
				//maple
				String erType = paramMap.get("erType") == null ? "" : (String)paramMap.get("erType");
				if(erType.equals("1084")||erType.equals("2033")||erType.equals("2041")||erType.equals("2055")){
					paramMap.put("erState", 4);
				}
				
				String content = paramMap.get("contentHelp") == null ? "" : ((String)paramMap.get("contentHelp"));
				if(content.equals("1")){
					paramMap.put("erStoryState", 4);
				}else{
					paramMap.put("erStoryState", " -- ");
				}
				
				resultData = DBUtil.uploadRes(eventExecutor, "expand", resNO, true) ;
				if(resultData.getIntResult() > -1) {
					paramMap = eventExecutor.getBaseAction().getParamMap();
				}else {
					return resultData ;
				}

				if (!"".equals(insert)) {	
					paramMap.put("erIsGrade", 1) ;
					paramMap.put("erGrade", grGrades) ;
					paramMap.put("erContest", grJingsai);
					
					paramMap.put("GCorWB","ER2200") ;
					
					if("".equals(((String)paramMap.get("erCateTwLevel")))){
						paramMap.put("erCateTwLevel", paramMap.get("erResType")) ;
					}
					
					String olderRecommen = paramMap.get("erRecommen") == null ? "" : (String)paramMap.get("erRecommen") ;
					String Recommensize = paramMap.get("Recommensize") == null ? "" : (String)paramMap.get("Recommensize") ;
					String erRecommen = "0";
					if(!olderRecommen.equals("0") && !Recommensize.equals("0")){
						erRecommen = olderRecommen+","+Recommensize;
					}
					paramMap.put("erRecommen", erRecommen) ;
					
					String erThumbnail = paramMap.get("erThumbnail") == null ? "" : (String)paramMap.get("erThumbnail") ;
					String erInThum = paramMap.get("erInThum") == null ? "" : (String)paramMap.get("erInThum") ;
					
					String grJingsais = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;
					paramMap.put("erContest", grJingsais);
					
					String erContent = paramMap.get("erContent") == null ? "" : ((String)paramMap.get("erContent")).replace("\r\n", "");
					paramMap.put("erContent",  erContent) ;
					
					if(erType.equals("2033") || erType.equals("2041") || erType.equals("2055")){
						String erUpload = paramMap.get("erUpload") == null ? "" : (String)paramMap.get("erUpload") ;
						String erFileSwf = 	erUpload.substring(0,erUpload.lastIndexOf("/"))+"/"+resNO.substring(resNO.length()-4)+"/mainfile";
						paramMap.put("erFileSwf",  erFileSwf) ;
					}
					
					int rvalue = eventExecutor.getSqlSession().insert(insert,paramMap);
					resultData.setIntResult(1);

					if(isUploadFile) {	//如果上传了资源文件，更新资源文件表和适用学段、年级表
						if(null != eventExecutor.getBaseAction().getParamMap().get("generatedKey")) {
							/******************将上传的文件放到年级表中********************/
							HashMap paramgrade = new HashMap() ;
							String greadDeleteByRes = "grade.delete_res";
							String greadUpdate = "grade.insert";	
							paramgrade.put("grResourceType", "expand") ;
							paramgrade.put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							eventExecutor.getSqlSession().delete(greadDeleteByRes, paramgrade) ;
							String[] grGrade = grGrades.split(",") ;
							for(int i = 0; i < grGrade.length; i ++) {
								if(!grGrade[i].trim().equals("")){	
									paramgrade.put("grGrade", grGrade[i]) ;
									paramgrade.put("grThumbnail", erThumbnail) ;
									paramgrade.put("grInThum", erInThum) ;
									paramgrade.put("grName", paramMap.get("erName")) ;
									paramgrade.put("grUpload", paramMap.get("erUpload")) ;
									paramgrade.put("grType", paramMap.get("erType")) ;
									paramgrade.put("s_userID", paramMap.get("s_userID")) ;
									paramgrade.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
									eventExecutor.getSqlSession().insert(greadUpdate, paramgrade) ;
								}
							}
							String[] jingsai = grJingsais.split(",") ;
							HashMap paramcontest = new HashMap() ;
							paramcontest.put("grResourceType", "expand") ;
							paramcontest.put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							for(int h=0;h<jingsai.length;h++){
								if(!jingsai[h].trim().equals("")){	
									paramcontest.put("grGrade", "324") ;
									paramcontest.put("grJieIDSelf", jingsai[h]) ;
									paramcontest.put("grThumbnail", erThumbnail) ;
									paramcontest.put("grInThum", erInThum) ;
									paramcontest.put("grName", paramMap.get("erName")) ;
									paramcontest.put("grUpload", paramMap.get("erUpload")) ;
									paramcontest.put("grType", paramMap.get("erType")) ;
									paramcontest.put("s_userID", paramMap.get("s_userID")) ;
									paramcontest.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
									eventExecutor.getSqlSession().insert(greadUpdate, paramcontest) ;
								}
							}
							/******************将上传的文件放到年级表中********************/
							/******************同步资源信息********************/
							String resinsert = "res.insert";
							HashMap paramres = new HashMap() ;
							paramres.put("rrResourceType", "expand") ;
							paramres.put("rrResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							paramres.put("rrThumbnail", erThumbnail) ;
							paramres.put("rrInThum", paramMap.get("erInThum")) ;
							paramres.put("rrName", paramMap.get("erName")) ;
							paramres.put("rrUpload", paramMap.get("erUpload")) ;
							paramres.put("rrType", paramMap.get("erType")) ;
							paramres.put("s_userID", paramMap.get("s_userID")) ;
							paramres.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
							eventExecutor.getSqlSession().insert(resinsert,paramres);
							/******************同步资源信息********************/	
							
							//初始化二维码扫描静态页
							PageInfoBean pib=StaticTableFactory.getPageInfoBeanLovely(paramMap);
							InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("erName").toString(),paramMap.get("erContent").toString(),pib,paramMap.get("erNO").toString());
							Thread temp_t=new Thread(ish);
							temp_t.start();
							
							/******************将上传的文件放到推荐表中******************/
							String resInsert = "recom.insert";
							if(!erRecommen.equals("0")){
								paramMap.put("reRecommendID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
								paramMap.put("reRecommendType", "expand") ;
								paramMap.put("reUpload", paramMap.get("erUpload")) ;
								paramMap.put("reName", paramMap.get("erName")) ;
								paramMap.put("reThumbnail", paramMap.get("erThumbnail")) ;
								paramMap.put("reType", paramMap.get("erType")) ;
								paramMap.put("reInThum", paramMap.get("erInThum")) ;
								paramMap.put("reSize", paramMap.get("Recommensize")) ;
								paramMap.put("reRecoFileUP", paramMap.get("erRecommenFile")) ;
								eventExecutor.getSqlSession().insert(resInsert, paramMap) ;
							}
							/******************将上传的文件放到推荐表中******************/	

							//String erReferType = paramMap.get("erReferType") == null ? "" : (String)paramMap.get("erReferType") ;
							String erHelpReferType = paramMap.get("erHelpReferType") == null ? "" : (String)paramMap.get("erHelpReferType") ;
							String erReferLocation = paramMap.get("erReferLocation") == null ? "" : (String)paramMap.get("erReferLocation") ;
							String erReferRealLocation = paramMap.get("erReferRealLocation") == null ? "" : (String)paramMap.get("erReferRealLocation") ;
							String erReferRealLocationSwfPath = paramMap.get("erReferRealLocationSwfPath") == null ? "" : (String)paramMap.get("erReferRealLocationSwfPath") ;
							
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
									map.put("referName", paramMap.get("erName")) ;
									map.put("referReferType","expand") ;
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
					String category = paramMap.get("erResType") == null ? "":paramMap.get("erResType").toString();
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
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExpandCreateEvent.class);
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
