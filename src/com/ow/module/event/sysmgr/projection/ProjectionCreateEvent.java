package com.ow.module.event.sysmgr.projection;

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

public class ProjectionCreateEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	private static String fileSplit = "/";

	public ProjectionCreateEvent() {
		resultData = new ResultData();
	}

	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String insert = eventExecutor.getSqlidByIndex(0);
			boolean isUploadFile = true ;	//资源文件是否也上传了
			if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
				String grGrades = paramMap.get("grGrades") == null ? "" : (String)paramMap.get("grGrades") ;
				String grJingsai = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;

				String resFolder = StringUtil.reResTypeThum("projection") ;
				String s_userType = paramMap.get("s_userType") == null ? "0" : (String)paramMap.get("s_userType") ; //用户类型 管理员录入数据： 0 ，老师录入数据： 1
				String expentNum = StringUtil.resExpentNum("projection") ;	//未来扩展值
				String snNO = StringUtil.intToSN(DBUtil.findSN(eventExecutor, "projection"), 8, "0") ; //编号

				String resNO = resFolder + s_userType + expentNum + snNO ;	//资源编号
				paramMap.put("prNO", resNO) ;
				
				//maple
				String prType = paramMap.get("prType") == null ? "" : (String)paramMap.get("prType");
				if(prType.equals("1084")){
					paramMap.put("prState", 4);
				}
				
				
				String content = paramMap.get("contentHelp") == null ? "" : ((String)paramMap.get("contentHelp"));
				if(content.equals("1")){
					paramMap.put("prStoryState", 4);
				}else{
					paramMap.put("prStoryState", " -- ");
				}
				
				resultData = DBUtil.uploadRes(eventExecutor, "projection", resNO, true) ;
				if(resultData.getIntResult() > -1) {
					paramMap = eventExecutor.getBaseAction().getParamMap();
				}else {
					return resultData ;
				}

				if (!"".equals(insert)) {	
					paramMap.put("prIsGrade", 1) ;
					if("".equals(((String)paramMap.get("prCateTwLevel")))){
						paramMap.put("prCateTwLevel", paramMap.get("prCategory")) ;
					}
					paramMap.put("prGrade", grGrades) ;
					paramMap.put("prContest", grJingsai);
					
					paramMap.put("GCorWB","PR2200") ;
					
					String olderRecommen = paramMap.get("prRecommen") == null ? "" : (String)paramMap.get("prRecommen") ;
					String Recommensize = paramMap.get("Recommensize") == null ? "" : (String)paramMap.get("Recommensize") ;
					String prRecommen = "0";
					if(!olderRecommen.equals("0") && !Recommensize.equals("0")){
						prRecommen = olderRecommen+","+Recommensize;
					}
					
					String prThumbnail = paramMap.get("prThumbnail") == null ? "" : (String)paramMap.get("prThumbnail") ;
					String prInThum = paramMap.get("prInThum") == null ? "" : (String)paramMap.get("prInThum") ;
					
					String grJingsais = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;
					paramMap.put("prContest", grJingsais);
					
					String prKeywords = paramMap.get("prKeywords") == null ? "" : ((String)paramMap.get("prKeywords")).replace("\r\n", "");
					if(!"".equals(prKeywords)){
						paramMap.put("prKeywords","、" + prKeywords+"、") ;
						
					}
					
					
					String prContent = paramMap.get("prContent") == null ? "" : ((String)paramMap.get("prContent")).replace("\r\n", "");
					paramMap.put("prContent",  prContent) ;
					
					String prRelation = paramMap.get("prRelation") == null ? "" : ((String)paramMap.get("prRelation")).replace("\r\n", "");
					paramMap.put("prRelation",  prRelation) ;
					
					paramMap.put("prRecommen", prRecommen) ;
					
					int rvalue = eventExecutor.getSqlSession().insert(insert,paramMap);
					resultData.setIntResult(1);

					if(isUploadFile) {	//如果上传了资源文件，更新资源文件表和适用学段、年级表
						if(null != eventExecutor.getBaseAction().getParamMap().get("generatedKey")) {
							/******************将上传的文件放到年级表中********************/
							HashMap paramgrade = new HashMap() ;
							String greadDeleteByRes = "grade.delete_res";
							String greadUpdate = "grade.insert";	
							paramgrade.put("grResourceType", "projection") ;
							paramgrade.put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							eventExecutor.getSqlSession().delete(greadDeleteByRes, paramgrade) ;
							String[] grGrade = grGrades.split(",") ;
							for(int i = 0; i < grGrade.length; i ++) {
								if(!grGrade[i].trim().equals("")){	
									paramgrade.put("grGrade", grGrade[i]) ;
									paramgrade.put("grThumbnail", prThumbnail) ;
									paramgrade.put("grInThum", prInThum) ;
									paramgrade.put("grName", paramMap.get("prName")) ;
									paramgrade.put("grUpload", paramMap.get("prUpload")) ;
									paramgrade.put("grType", paramMap.get("prType")) ;
									paramgrade.put("grIsShare", paramMap.get("prIsShare")) ;
									paramgrade.put("s_userID", paramMap.get("s_userID")) ;
									paramgrade.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
									eventExecutor.getSqlSession().insert(greadUpdate, paramgrade) ;
								}
							}
							String[] jingsai = grJingsais.split(",") ;
							HashMap paramcontest = new HashMap() ;
							paramcontest.put("grResourceType", "projection") ;
							paramcontest.put("grResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							for(int h=0;h<jingsai.length;h++){
								if(!jingsai[h].trim().equals("")){	
									paramcontest.put("grGrade", "324") ;
									paramcontest.put("grJieIDSelf", jingsai[h]) ;
									paramcontest.put("grThumbnail", prThumbnail) ;
									paramcontest.put("grInThum", prInThum) ;
									paramcontest.put("grName", paramMap.get("prName")) ;
									paramcontest.put("grUpload", paramMap.get("prUpload")) ;
									paramcontest.put("grType", paramMap.get("prType")) ;
									paramcontest.put("grIsShare", paramMap.get("prIsShare")) ;
									paramcontest.put("s_userID", paramMap.get("s_userID")) ;
									paramcontest.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
									eventExecutor.getSqlSession().insert(greadUpdate, paramcontest) ;
								}
							}
							
							/******************将上传的文件放到年级表中********************/
							/******************将上传的文件放到推荐表中******************/
							String resInsert = "recom.insert";
							paramMap.put("reRecommendID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							paramMap.put("reRecommendType", "projection") ;
							paramMap.put("reUpload", paramMap.get("prUpload")) ;
							paramMap.put("reName", paramMap.get("prName")) ;
							paramMap.put("reThumbnail", paramMap.get("prThumbnail")) ;
							paramMap.put("reType", paramMap.get("prType")) ;
							paramMap.put("reInThum", paramMap.get("prInThum")) ;
							paramMap.put("reSize", paramMap.get("Recommensize")) ;
							paramMap.put("reRecoFileUP", paramMap.get("prRecommenFile")) ;
							eventExecutor.getSqlSession().insert(resInsert, paramMap) ;
							/******************将上传的文件放到推荐表中******************/	
							/******************同步资源信息********************/
							String resinsert = "res.insert";
							HashMap paramres = new HashMap() ;
							paramres.put("rrResourceType", "projection") ;
							paramres.put("rrResourceID", eventExecutor.getBaseAction().getParamMap().get("generatedKey")) ;
							paramres.put("rrThumbnail", prThumbnail) ;
							paramres.put("rrInThum", paramMap.get("prInThum")) ;
							paramres.put("rrName", paramMap.get("prName")) ;
							paramres.put("rrUpload", paramMap.get("prUpload")) ;
							paramres.put("rrType", paramMap.get("prType")) ;
							paramres.put("rrIsShare", paramMap.get("prIsShare")) ;
							paramres.put("rrAudio", paramMap.get("prAudio")) ;
							paramres.put("s_userID", paramMap.get("s_userID")) ;
							paramres.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
							eventExecutor.getSqlSession().insert(resinsert,paramres);
							/******************同步资源信息********************/	
							
							//初始化二维码扫描静态页
							PageInfoBean pib=StaticTableFactory.getPageInfoBeanProjection(paramMap);
							InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("prName").toString(),paramMap.get("prContent").toString(),pib,paramMap.get("prNO").toString());
							Thread temp_t=new Thread(ish);
							temp_t.start();
						}
					}
				}
				//修改分类状态
				String category = paramMap.get("prCategory") == null ? "":paramMap.get("prCategory").toString();
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
			//配合统计模块进行上传统计
			if(ConstantI.ISCOUNT_KEY.equals("1")){
			String type=(String)paramMap.get("prType");
			ResourceCount.sendMsg(type,"UPLOAD");
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ProjectionCreateEvent.class);
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
