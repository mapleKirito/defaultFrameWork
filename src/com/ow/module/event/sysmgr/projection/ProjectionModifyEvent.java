package com.ow.module.event.sysmgr.projection;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.UploadDataAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DBUtil;
import com.staticHtml.bean.PageInfoBean;
import com.staticHtml.util.InitStaticHtml;
import com.staticHtml.util.StaticTableFactory;

public class ProjectionModifyEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	static int gradedefault = 001; 
	private ResultData resultData;
	
	private static String fileSplit = "/";

	public ProjectionModifyEvent() {
		resultData = new ResultData();
	}
	
	@SuppressWarnings({ "unchecked", "unused", "rawtypes" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String update = eventExecutor.getSqlidByIndex(0);
			if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
				//处理资源和缩略图
				resultData = DBUtil.uploadRes(eventExecutor, "projection", "", true) ;
				if(resultData.getIntResult() > -1) {
					paramMap = eventExecutor.getBaseAction().getParamMap();
				}else {
					return resultData ;
				}
				String prThumbnail = paramMap.get("prThumbnail") == null ? "" : (String)paramMap.get("prThumbnail") ;
				
				Object gra = eventExecutor.getSqlSession().selectOne("projection.select_by_id",paramMap);
				String grGrades = paramMap.get("grGrades") == null ? "" : (String)paramMap.get("grGrades") ;
				paramMap.put("prGrade", grGrades);
				
				String grJingsais = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;
				paramMap.put("prContest", grJingsais);
				
				
				if (!"".equals(update)) {	
					if("".equals(((String)paramMap.get("prCateTwLevel")))){
						paramMap.put("prCateTwLevel", paramMap.get("prCategory")) ;
					}
					
					paramMap.put("GCorWB","PR2200") ;
										
					String olderRecommen = paramMap.get("prRecommen") == null ? "" : (String)paramMap.get("prRecommen") ;
					String Recommensize = paramMap.get("Recommensize") == null ? "" : (String)paramMap.get("Recommensize") ;
					String prRecommen = "0";
					if(!olderRecommen.equals("0") && !Recommensize.equals("0")){
						prRecommen = olderRecommen+","+Recommensize;
					}
					String re = Arrays.toString(DBUtil.dictinctArray(prRecommen.split(","))).replace("[", "").replace("]", "").replace(" ", "").trim();
					paramMap.put("prRecommen",  re.equals("") ? "0" : re) ;
					
					String prInThum = paramMap.get("prInThum") == null ? "" : (String)paramMap.get("orInThum") ;
					
					String prContent = paramMap.get("prContent") == null ? "" : ((String)paramMap.get("prContent")).replace("\r\n", "");
					paramMap.put("prContent",  prContent) ;
					
					String prKeywords = paramMap.get("prKeywords") == null ? "" : ((String)paramMap.get("prKeywords")).replace("\r\n", "");
					if(!"".equals(prKeywords)){
						paramMap.put("erKeywords","、" + prKeywords+"、") ;
						
					}
					
					int rvalue = eventExecutor.getSqlSession().update(update,paramMap);
					resultData.setIntResult(1);
					
					HashMap category = new HashMap();
					String modifycateerprCategory = paramMap.get("modifycateerprCategory") == null ? "" : ((String)paramMap.get("modifycateerprCategory"));
					category.put("modifycateerprCategory", modifycateerprCategory);
					String modifycateerprCateTwLevel = paramMap.get("modifycateerprCateTwLevel") == null ? "" : ((String)paramMap.get("modifycateerprCateTwLevel"));
					category.put("modifycateerprCateTwLevel", modifycateerprCateTwLevel);
					DBUtil.resModifyCategoryStatus(eventExecutor, category, "projection");
					
					Object one = eventExecutor.getSqlSession().selectOne("projection.select_by_id",paramMap);
					DBUtil.modifyCategoryStatus(eventExecutor, one, "projection");
					
					/******************将上传的文件放到年级表中********************/
					HashMap paramgrade = new HashMap() ;
					String greadDeleteByRes = "grade.delete_res";
					String greadUpdate = "grade.insert";	
					paramgrade.put("grResourceType", "projection") ;
					paramgrade.put("grResourceID", paramMap.get("prID")) ;
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
					paramcontest.put("grResourceID", paramMap.get("prID")) ;
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
					/******************将上传的文件放到推荐表中********************/
					HashMap param = new HashMap() ;
					param = new HashMap() ;
					param.put("reRecommendType", "projection") ;
					param.put("reRecommendID", paramMap.get("prID")) ;
					if(prRecommen.indexOf("1") >= 0 ){
						String resUpdate = "recom.update"; 
						
						if(eventExecutor.getSqlSession().selectList("recom.select_by_id",param).size()<=0){
							resUpdate = "recom.insert"; 
						}
						
						param.put("reThumbnail", prThumbnail) ;
						param.put("reInThum", paramMap.get("prInThum")) ;
						param.put("reName", paramMap.get("prName")) ;
						param.put("reUpload", paramMap.get("prUpload")) ;
						param.put("reType", paramMap.get("prType")) ;
						param.put("reSize", paramMap.get("Recommensize")) ;
						param.put("reID", paramMap.get("prID")) ;
						param.put("reRecoFileUP", paramMap.get("prRecommenFile")) ;
						eventExecutor.getSqlSession().update(resUpdate,param);						
					}else{
						eventExecutor.getSqlSession().delete("recom.delete_by_resid",param);
					}
					/******************将上传的文件放到推荐表中********************/
					/******************同步资源信息********************/
					String resUpdate = eventExecutor.getSqlidByIndex(2); 
					HashMap paramres = new HashMap() ;
					paramres.put("rrResourceType", "projection") ;
					paramres.put("rrResourceID", paramMap.get("prID")) ;
					paramres.put("rrThumbnail", prThumbnail) ;
					paramres.put("rrInThum", paramMap.get("prInThum")) ;
					paramres.put("rrName", paramMap.get("prName")) ;
					paramres.put("rrUpload", paramMap.get("prUpload")) ;
					paramres.put("rrType", paramMap.get("prType")) ;
					paramres.put("rrIsShare", paramMap.get("prIsShare")) ;
					paramres.put("s_userID", paramMap.get("s_userID")) ;
					paramres.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
					eventExecutor.getSqlSession().update(resUpdate,paramres);
					/******************同步资源信息********************/
					
					//初始化二维码扫描静态页
					HashMap<String, String> tmp=new HashMap<String, String>();
					tmp.put("code", paramMap.get("thecode").toString());
					HashMap<String, Object> paramMapScanner=(HashMap<String, Object>)eventExecutor.getSqlSession().selectOne("projection"+".select_by_code", tmp);
					PageInfoBean pib=StaticTableFactory.getPageInfoBeanProjection(paramMapScanner);
					String content=paramMapScanner.get("prContent")==null?"":paramMapScanner.get("prContent").toString();
					System.out.println(paramMapScanner.get("prName"));
					InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMapScanner.get("prName").toString(),content,pib,paramMapScanner.get("prNO").toString());
					
					Thread temp_t=new Thread(ish);
					temp_t.start();
				}	
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ProjectionModifyEvent.class);
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
