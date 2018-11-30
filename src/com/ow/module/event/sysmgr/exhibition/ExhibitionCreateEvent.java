package com.ow.module.event.sysmgr.exhibition;

import java.io.File;
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
import com.staticHtml.util.GetProjectPath;
import com.staticHtml.util.InitStaticHtml;
import com.staticHtml.util.StaticTableFactory;
import com.staticHtml.util.ToHtmlByOpenOffice;
import com.staticHtml.util.To_Html;
import com.unitecount.ResourceCount;

public class ExhibitionCreateEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	private static String fileSplit = "/";

	public ExhibitionCreateEvent() {
		resultData = new ResultData();
	}

	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String insert = eventExecutor.getSqlidByIndex(0);
		   
			boolean isUploadFile = true ;	//资源文件是否也上传了		2011/02/20 修改，默认为true
			if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
				String grGrades = paramMap.get("grGrades") == null ? "" : (String)paramMap.get("grGrades") ;
				String grJingsai = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;
				
				String resFolder = StringUtil.reResTypeThum("exhibition") ;
				String s_userType = paramMap.get("s_userType") == null ? "0" : (String)paramMap.get("s_userType") ; //用户类型 管理员录入数据： 0 ，老师录入数据： 1
				String expentNum = StringUtil.resExpentNum("exhibition") ;	//未来扩展值
				String snNO = StringUtil.intToSN(DBUtil.findSN(eventExecutor, "exhibition"), 8, "0") ; //编号

				String resNO = resFolder + s_userType + expentNum + snNO ;	//资源编号

				String content = paramMap.get("contentHelp") == null ? "" : ((String)paramMap.get("contentHelp"));
				if(content.equals("1")){
					paramMap.put("erStoryState", 4);
				}else{
					paramMap.put("erStoryState", " -- ");
				}
				
				resultData = DBUtil.uploadRes(eventExecutor, "exhibition", resNO, true) ;
				if(resultData.getIntResult() > -1) {
					paramMap = eventExecutor.getBaseAction().getParamMap();
				}else {
					return resultData ;
				}

				paramMap.put("erCode", resNO) ;
				if (!"".equals(insert)) {	
					paramMap.put("erIsGrade", 1) ;
					paramMap.put("erGrade", grGrades) ;
					paramMap.put("erContest", grJingsai);
					
					if("".equals(((String)paramMap.get("erGangID"))) || null == (((String)paramMap.get("erGangID")))){
						paramMap.put("erGangID", paramMap.get("erChorID")) ;
						if("".equals(((String)paramMap.get("erChorID"))) || null == (((String)paramMap.get("erChorID")))){
							paramMap.put("erGangID", paramMap.get("erJieID")) ;
							if("".equals(((String)paramMap.get("erJieID"))) ||  null == (((String)paramMap.get("erJieID")))){
								paramMap.put("erGangID", paramMap.get("erTotalID")) ;
							}
						}
					}
					
					if("".equals(((String)paramMap.get("erProvince")))){
						paramMap.put("erProvince", null) ;
					}
					if("".equals(((String)paramMap.get("erCity")))){
						paramMap.put("erCity", null) ;
					}
					if("".equals(((String)paramMap.get("erArea")))){
						paramMap.put("erArea", null) ;
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
					String erKeywords = paramMap.get("erKeywords") == null ? "" : ((String)paramMap.get("erKeywords")).replace("\r\n", "");
					if(!"".equals(erKeywords)){
						paramMap.put("erKeywords","、" + erKeywords+"、") ;
						
					}
					String erAbout = paramMap.get("erAbout") == null ? "" : ((String)paramMap.get("erAbout")).replace("\r\n", "");
					paramMap.put("erAbout",  erAbout) ;
					
					String erRelation = paramMap.get("erRelation") == null ? "" : ((String)paramMap.get("erRelation")).replace("\r\n", "");
					paramMap.put("erRelation",  erRelation) ;
					int rvalue = eventExecutor.getSqlSession().insert(insert,paramMap);

					//处理地区是否显示
					DBUtil.handleArea(eventExecutor) ;
					
					String erLoLa = paramMap.get("erLoLa") == null ? "" : ((String)paramMap.get("erLoLa"));
					if(!erLoLa.equals("")){
						String erLoLas[] = erLoLa.split("\\|");
						paramMap.put("areaDistriResID",  eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
						for(int i = 0;i < erLoLas.length;i++){
							paramMap.put("areaDistriLongitude",  erLoLas[i].split(",")[0]) ;
							paramMap.put("areaDistriLatitude",  erLoLas[i].split(",")[1]) ;
							int lolaval = eventExecutor.getSqlSession().insert("areaDistri.insert",paramMap);
						}
					}

					if(isUploadFile) {	//如果上传了资源文件，更新资源文件表和适用学段、年级表
						if(null != eventExecutor.getBaseAction().getParamMap().get("generatedKey")) {
							/******************将上传的文件放到年级表中********************/
							HashMap paramgrade = new HashMap() ;
							String greadDeleteByRes = "grade.delete_res";
							String greadUpdate = "grade.insert";	
							paramgrade.put("grResourceType", "exhibition") ;
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
									paramgrade.put("grIsShare", paramMap.get("erIsShare")) ;
									paramgrade.put("s_userID", paramMap.get("s_userID")) ;
									paramgrade.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
									eventExecutor.getSqlSession().insert(greadUpdate, paramgrade) ;
								}
							}
							String[] jingsai = grJingsais.split(",") ;
							HashMap paramcontest = new HashMap() ;
							paramcontest.put("grResourceType", "exhibition") ;
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
									paramcontest.put("grIsShare", paramMap.get("erIsShare")) ;
									paramcontest.put("s_userID", paramMap.get("s_userID")) ;
									paramcontest.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
									eventExecutor.getSqlSession().insert(greadUpdate, paramcontest) ;
								}
							}
							
							/******************将上传的文件放到年级表中********************/
							/******************将上传的文件放到推荐表中******************/
							if(!olderRecommen.equals("0")){
								String resInsert = "recom.insert";
								paramMap.put("reRecommendID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
								paramMap.put("reRecommendType", "exhibition") ;
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
							/******************同步资源信息********************/
							String resinsert = "res.insert";
							HashMap paramres = new HashMap() ;
							paramres.put("rrResourceType", "exhibition") ;
							paramres.put("rrResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							paramres.put("rrThumbnail", erThumbnail) ;
							paramres.put("rrInThum", paramMap.get("erInThum")) ;
							paramres.put("rrName", paramMap.get("erName")) ;
							paramres.put("rrUpload", paramMap.get("erUpload")) ;
							paramres.put("rrType", paramMap.get("erType")) ;
							paramres.put("rrIsShare", paramMap.get("erIsShare")) ;
							paramres.put("s_userID", paramMap.get("s_userID")) ;
							paramres.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
							eventExecutor.getSqlSession().insert(resinsert,paramres);
							/******************同步资源信息********************/	
							
							//初始化二维码扫描静态页
							PageInfoBean pib=StaticTableFactory.getPageInfoBeanExhibition(paramMap);
							InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("erName").toString(),paramMap.get("erContent").toString(),pib,paramMap.get("erCode").toString());
							Thread temp_t=new Thread(ish);
							temp_t.start();
							
							/*//资源相关链接处理
							String resLinkPath=paramMap.get("erRelatedLinks").toString();
							if(!resLinkPath.equals("")&&resLinkPath.lastIndexOf(".")>0){
								resLinkPath=resLinkPath.substring(0,resLinkPath.lastIndexOf("."))+".doc";
							}else{
								resLinkPath="";
							}
							String docContent="";
							ArrayList<String> klist=new ArrayList<String>();
							klist.add("测试一");
							klist.add("测试二");
							if(resLinkPath!=null&&!resLinkPath.equals("")){
								docContent=ToHtmlByOpenOffice.toHtmlString(new File(ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "")+resLinkPath), GetProjectPath.getRootPath()+"/page/scanner/"+paramMap.get("erCode").toString()+"/");
								for (String string : klist) {
									docContent=docContent.replaceAll(string, "<a class='reslink'>"+string+"</a>");
								}
								
							}
							To_Html.reslink_html(docContent, "reslink",paramMap.get("erCode").toString());*/
							
						}
					}
					//修改分类状态
					String erCategory = paramMap.get("erCategory") == null ? "":paramMap.get("erCategory").toString();
					if (!erCategory.equals("")){
						paramMap.put("cateID", erCategory);
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
					//配合统计模块进行上传统计
					if(ConstantI.ISCOUNT_KEY.equals("1")){
					String type=(String)paramMap.get("erType");
					ResourceCount.sendMsg(type,"UPLOAD");
					}
					resultData.setIntResult(1);
				}	
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExhibitionCreateEvent.class);
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
