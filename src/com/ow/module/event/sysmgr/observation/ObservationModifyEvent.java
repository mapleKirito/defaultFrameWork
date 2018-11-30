package com.ow.module.event.sysmgr.observation;

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

public class ObservationModifyEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	static int gradedefault = 001; 
	private ResultData resultData;
	
	private static String fileSplit = "/";

	public ObservationModifyEvent() {
		resultData = new ResultData();
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String update = eventExecutor.getSqlidByIndex(0);
			if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
				Object gra = eventExecutor.getSqlSession().selectOne("observation.select_by_id",paramMap);
	
				//处理资源和缩略图
				resultData = DBUtil.uploadRes(eventExecutor, "observation", "", true) ;
				if(resultData.getIntResult() > -1) {
					paramMap = eventExecutor.getBaseAction().getParamMap();
				}else {
					return resultData ;
				}
				
				String orThumbnail = paramMap.get("orThumbnail") == null ? "" : (String)paramMap.get("orThumbnail") ;
				String orInThum = paramMap.get("orInThum") == null ? "" : (String)paramMap.get("orInThum") ;
				
				String grGrades = paramMap.get("grGrades") == null ? "" : (String)paramMap.get("grGrades") ;
				paramMap.put("orGrade", grGrades);
				
				String grJingsais = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;
				paramMap.put("orContest", grJingsais);
				
				String orContent = paramMap.get("orContent") == null ? "" : ((String)paramMap.get("orContent")).replace("\r\n", "");
				paramMap.put("orContent",  orContent) ;
				
				if (!"".equals(update)) {	
					if("".equals(((String)paramMap.get("orCateTwLevel")))){
						paramMap.put("orCateTwLevel", paramMap.get("orCategory")) ;
					}
					String olderRecommen = paramMap.get("orRecommen") == null ? "" : (String)paramMap.get("orRecommen") ;
					String Recommensize = paramMap.get("Recommensize") == null ? "" : (String)paramMap.get("Recommensize") ;
					String orRecommen = "0";
					if(!olderRecommen.equals("0") && !Recommensize.equals("0")){
						orRecommen = olderRecommen+","+Recommensize;
					}
					String re = Arrays.toString(DBUtil.dictinctArray(orRecommen.split(","))).replace("[", "").replace("]", "").replace(" ", "").trim();
					paramMap.put("orRecommen",  re.equals("") ? "0" : re) ;
					
					
					String orKeywords = paramMap.get("orKeywords") == null ? "" : ((String)paramMap.get("orKeywords")).replace("\r\n", "");
					if(!"".equals(orKeywords)){
						paramMap.put("orKeywords","、" + orKeywords+"、") ;
						
					}
					String swffile=(String) paramMap.get("orFileSwf");
					//System.out.println("取到的swf"+swffile);
					if ("".equals(swffile)||swffile==null){
						String orUpload=(String)paramMap.get("orUpload");
						swffile=orUpload.substring(0,18)+orUpload.substring(orUpload.length()-8,orUpload.length()-4)+"/mainfile";
					    paramMap.put("orFileSwf", swffile);	
					//System.out.println(swffile);
					}
					int rvalue = eventExecutor.getSqlSession().update(update,paramMap);
					resultData.setIntResult(1);
					
					HashMap category = new HashMap();
					String modifycateerorCategory = paramMap.get("modifycateerorCategory") == null ? "" : ((String)paramMap.get("modifycateerorCategory"));
					category.put("modifycateerorCategory", modifycateerorCategory);
					String modifycateerorCateTwLevel = paramMap.get("modifycateerorCateTwLevel") == null ? "" : ((String)paramMap.get("modifycateerorCateTwLevel"));
					category.put("modifycateerorCateTwLevel", modifycateerorCateTwLevel);
					DBUtil.resModifyCategoryStatus(eventExecutor, category, "observation");
					
					Object one = eventExecutor.getSqlSession().selectOne("observation.select_by_id",paramMap);
					DBUtil.modifyCategoryStatus(eventExecutor, one, "observation");
					
					/******************将上传的文件放到年级表中********************/
					HashMap paramgrade = new HashMap() ;
					String greadDeleteByRes = "grade.delete_res";
					String greadUpdate = "grade.insert";	
					paramgrade.put("grResourceType", "observation") ;
					paramgrade.put("grResourceID", paramMap.get("orID")) ;
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
					paramcontest.put("grResourceID", paramMap.get("orID")) ;
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
					/******************将上传的文件放到推荐表中********************/
					HashMap param = new HashMap() ;
					param.put("reRecommendType", "observation") ;
					param.put("reRecommendID", paramMap.get("orID")) ;
					if(orRecommen.indexOf("1") >= 0 ){
						String resUpdate = "recom.update"; 
						
						if(eventExecutor.getSqlSession().selectList("recom.select_by_id",param).size()<=0){
							resUpdate = "recom.insert"; 
						}
						
						param.put("reThumbnail", orThumbnail) ;
						param.put("reInThum", paramMap.get("orInThum")) ;
						param.put("reName", paramMap.get("orName")) ;
						param.put("reUpload", paramMap.get("orUpload")) ;
						param.put("reType", paramMap.get("orType")) ;
						param.put("reSize", paramMap.get("Recommensize")) ;
						param.put("reID", paramMap.get("orID")) ;
						param.put("reRecoFileUP", paramMap.get("orRecommenFile")) ;
						eventExecutor.getSqlSession().update(resUpdate,param);						
					}else{
						eventExecutor.getSqlSession().delete("recom.delete_by_resid",param);
					}
					/******************将上传的文件放到推荐表中********************/
					/******************同步资源信息********************/
					String resUpdate = eventExecutor.getSqlidByIndex(2); 
					HashMap paramres = new HashMap() ;
					paramres.put("rrResourceType", "observation") ;
					paramres.put("rrResourceID", paramMap.get("orID")) ;
					paramres.put("rrThumbnail", orThumbnail) ;
					paramres.put("rrInThum", paramMap.get("orInThum")) ;
					paramres.put("rrName", paramMap.get("orName")) ;
					paramres.put("rrUpload", paramMap.get("orUpload")) ;
					paramres.put("rrType", paramMap.get("orType")) ;
					paramres.put("rrIsShare", paramMap.get("orIsShare")) ;
					paramres.put("rrAudio", paramMap.get("orAudio")) ;
					paramres.put("s_userID", paramMap.get("s_userID")) ;
					paramres.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
					eventExecutor.getSqlSession().update(resUpdate,paramres);
					/******************同步资源信息********************/
					
					//初始化二维码扫描静态页
					HashMap<String, String> tmp=new HashMap<String, String>();
					tmp.put("code", paramMap.get("thecode").toString());
					HashMap<String, Object> paramMapScanner=(HashMap<String, Object>)eventExecutor.getSqlSession().selectOne("observation"+".select_by_code", tmp);
					PageInfoBean pib=StaticTableFactory.getPageInfoBeanObservation(paramMapScanner);
					String content=paramMapScanner.get("orContent")==null?"":paramMapScanner.get("orContent").toString();
					System.out.println(paramMapScanner.get("orName"));
					InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMapScanner.get("orName").toString(),content,pib,paramMapScanner.get("orNO").toString());
					
					Thread temp_t=new Thread(ish);
					temp_t.start();
				}	
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ObservationModifyEvent.class);
			log.error(error);
		}
		return resultData;
	}
	
	/** 对多文件上传的路径处理方法 */
	@SuppressWarnings("unused")
	private List<String> getTempPath(String str, int length) {
		List<String> returnList = new ArrayList<String>();
		//System.out.println(fileSplit);
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
