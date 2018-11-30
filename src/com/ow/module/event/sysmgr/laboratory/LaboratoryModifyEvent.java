package com.ow.module.event.sysmgr.laboratory;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;

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

public class LaboratoryModifyEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	static int gradedefault = 001; 
	private ResultData resultData;
	
	private static String fileSplit = "/";

	public LaboratoryModifyEvent() {
		resultData = new ResultData();
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			
			String update = eventExecutor.getSqlidByIndex(0);
			if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
			
				//处理资源和缩略图
		    	resultData = DBUtil.uploadRes(eventExecutor, "laboratory", "", true) ;
				
				if(resultData.getIntResult() > -1) {
					paramMap = eventExecutor.getBaseAction().getParamMap();
				}else {
					return resultData ;
				}
				
				String lrThumbnail = paramMap.get("lrThumbnail") == null ? "" : (String)paramMap.get("lrThumbnail") ;
				String lrInThum = paramMap.get("lrInThum") == null ? "" : (String)paramMap.get("lrInThum") ;
				String grGrades = paramMap.get("grGrades") == null ? "" : (String)paramMap.get("grGrades") ;
				paramMap.put("lrGrade", grGrades);
				
				String grJingsais = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;
				paramMap.put("lrContest", grJingsais);
				
				if (!"".equals(update)) {	
					int index=-1,index1=-1,index2=-1;
					paramMap.put("GCorWB","LR2200") ;
					
					if("".equals(((String)paramMap.get("lrCateTwLevel")))){
						paramMap.put("lrCateTwLevel", paramMap.get("lrCategory")) ;
					}
					
					String olderRecommen = paramMap.get("lrRecommen") == null ? "" : (String)paramMap.get("lrRecommen") ;
					String Recommensize = paramMap.get("Recommensize") == null ? "" : (String)paramMap.get("Recommensize") ;
					String lrRecommen = "0";
					if(!olderRecommen.equals("0") && !Recommensize.equals("0")){
						lrRecommen = olderRecommen+","+Recommensize;
					}
					String re = Arrays.toString(DBUtil.dictinctArray(lrRecommen.split(","))).replace("[", "").replace("]", "").replace(" ", "").trim();
					paramMap.put("lrRecommen",  re.equals("") ? "0" : re) ;
					
					String lrKeywords = paramMap.get("lrKeywords") == null ? "" : ((String)paramMap.get("lrKeywords")).replace("\r\n", "");
					if(!"".equals(lrKeywords)){
						paramMap.put("lrKeywords","、" + lrKeywords+"、") ;
						
					}
					
					String lrContent = paramMap.get("lrContent") == null ? "" : ((String)paramMap.get("lrContent")).replace("\r\n", "");
					paramMap.put("lrContent",  lrContent) ;
					
					int rvalue = eventExecutor.getSqlSession().update(update,paramMap);
					resultData.setIntResult(1);

					
					HashMap category = new HashMap();
					String modifycateerlrCategory = paramMap.get("modifycateerlrCategory") == null ? "" : ((String)paramMap.get("modifycateerlrCategory"));
					category.put("modifycateerlrCategory", modifycateerlrCategory);
					String modifycateerlrCateTwLevel = paramMap.get("modifycateerlrCateTwLevel") == null ? "" : ((String)paramMap.get("modifycateerlrCateTwLevel"));
					category.put("modifycateerlrCateTwLevel", modifycateerlrCateTwLevel);
					DBUtil.resModifyCategoryStatus(eventExecutor, category, "laboratory");
					
					Object one = eventExecutor.getSqlSession().selectOne("laboratory.select_by_id",paramMap);
					DBUtil.modifyCategoryStatus(eventExecutor, one, "laboratory");
					
					
					
					/******************将上传的文件放到年级表中********************/
					HashMap paramgrade = new HashMap() ;
					String greadDeleteByRes = "grade.delete_res";
					String greadUpdate = "grade.insert";	
					paramgrade.put("grResourceType", "laboratory") ;
					paramgrade.put("grResourceID", paramMap.get("lrID")) ;
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
					paramcontest.put("grResourceID", paramMap.get("lrID")) ;
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
					
					
					
					/******************将上传的文件放到推荐表中********************/
					HashMap param = new HashMap() ;
					param = new HashMap() ;
					param.put("reRecommendType", "laboratory") ;
					param.put("reRecommendID", paramMap.get("lrID")) ;
					if(lrRecommen.indexOf("1") >= 0 ){
						String resUpdate = "recom.update"; 
						
						if(eventExecutor.getSqlSession().selectList("recom.select_by_id",param).size()<=0){
							resUpdate = "recom.insert"; 
						}
						
						param.put("reThumbnail", lrThumbnail) ;
						param.put("reInThum", paramMap.get("lrInThum")) ;
						param.put("reName", paramMap.get("lrName")) ;
						param.put("reUpload", paramMap.get("lrUpload")) ;
						param.put("reType", paramMap.get("lrType")) ;
						param.put("reSize", paramMap.get("Recommensize")) ;
						param.put("reID", paramMap.get("lrID")) ;
						param.put("reRecoFileUP", paramMap.get("lrRecommenFile")) ;
						eventExecutor.getSqlSession().update(resUpdate,param);						
					}else{
						eventExecutor.getSqlSession().delete("recom.delete_by_resid",param);
					}
					/******************将上传的文件放到推荐表中********************/
					/******************同步资源信息********************/
					String resUpdate = eventExecutor.getSqlidByIndex(2); 
					HashMap paramres = new HashMap() ;
					paramres.put("rrResourceType", "laboratory") ;
					paramres.put("rrResourceID", paramMap.get("lrID")) ;
					paramres.put("rrThumbnail", lrThumbnail) ;
					paramres.put("rrInThum", paramMap.get("lrInThum")) ;
					paramres.put("rrName", paramMap.get("lrName")) ;
					paramres.put("rrUpload", paramMap.get("lrUpload")) ;
					paramres.put("rrType", paramMap.get("lrType")) ;
					paramres.put("rrIsShare", paramMap.get("lrIsShare")) ;
					paramres.put("rrFileSwfPath", paramMap.get("lrFileSwfPath")) ;
					paramres.put("rrFileSwf", paramMap.get("lrFileSwf")) ;
					paramres.put("s_userID", paramMap.get("s_userID")) ;
					paramres.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
					eventExecutor.getSqlSession().update(resUpdate,paramres);
					/******************同步资源信息********************/
					
					//初始化二维码扫描静态页
					HashMap<String, String> tmp=new HashMap<String, String>();
					tmp.put("code", paramMap.get("thecode").toString());
					HashMap<String, Object> paramMapScanner=(HashMap<String, Object>)eventExecutor.getSqlSession().selectOne("laboratory"+".select_by_code", tmp);
					PageInfoBean pib=StaticTableFactory.getPageInfoBeanLaboratory(paramMapScanner);
					String content=paramMapScanner.get("lrContent")==null?"":paramMapScanner.get("lrContent").toString();
					System.out.println(paramMapScanner.get("lrName"));
					InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMapScanner.get("lrName").toString(),content,pib,paramMapScanner.get("lrNO").toString());
					
					Thread temp_t=new Thread(ish);
					temp_t.start();
					
					/******************将上传的文件放到参考资源中********************/
					HashMap map = new HashMap();
					map.put("referReferType", "laboratory") ;
					map.put("referReferID", paramMap.get("lrID")) ;
					String DiffReferUpload = paramMap.get("DiffReferUpload") == null ? "" : (String)paramMap.get("DiffReferUpload");	
					if(!DiffReferUpload.equals("")){
						String diff[] = DiffReferUpload.split(",");
						for(int i=0;i<diff.length;i++){
							HashMap diffMap = new HashMap();
							diffMap.put("referUpload", diff[i]) ;
							Object obj = eventExecutor.getSqlSession().selectOne("refer.select_by_upload",diffMap);
							String beforefiel = ((HashMap)obj).get("referID").toString();
							diffMap.put("referID", beforefiel) ;
							diffMap.put("referReferType", "laboratory") ;
							int va = eventExecutor.getSqlSession().delete("refer.delete",diffMap);
						}
					}
					
					String referafter = paramMap.get("referafter") == null ? "0" : (String)paramMap.get("referafter");	
					if(!referafter.equals("0") && !referafter.equals("")){
						String referafterValue = paramMap.get("referafterValue") == null ? "0" : (String)paramMap.get("referafterValue");	
						String referafterFileSwfValue = paramMap.get("referafterFileSwfValue") == null ? "0" : (String)paramMap.get("referafterFileSwfValue");	
						String referafterFileType = paramMap.get("referafterFileType") == null ? "0" : (String)paramMap.get("referafterFileType");	
						String referafterFileSwfPath = paramMap.get("referafterFileSwfPath") == null ? "0" : (String)paramMap.get("referafterFileSwfPath");	
						
						if(!referafterValue.equals("") && !referafterFileSwfValue.equals("") && !referafterFileType.equals("")){
							String referV[] = referafterValue.split(",");
							String referFileswfV[] = referafterFileSwfValue.split(",");
							String referFileType[] = referafterFileType.split(",");
							String referFileSwfPathV[] = referafterFileSwfPath.split(",");
							
							if(referV.length == referFileswfV.length && referFileswfV.length == referFileType.length){
								
								for(int h = 0;h<referV.length;h++){
									HashMap refermodi = new HashMap();
									String referupload = referV[h].trim();
									refermodi.put("referReferID", paramMap.get("lrID")) ;
									refermodi.put("referName", paramMap.get("lrName")) ;
									refermodi.put("referReferType","laboratory") ;
									refermodi.put("referThumbnail", StringUtil.reResReferThumbnail(referFileType[h])) ;
									refermodi.put("referUpload", referupload) ;
									refermodi.put("referFileSwf", referFileswfV[h].trim()) ;
									refermodi.put("referFileSwfPath", referFileSwfPathV[h].trim().replace("\\", "/")) ;
									refermodi.put("referType", referupload.substring(referupload.lastIndexOf(".")).replace(".", "")) ;
									eventExecutor.getSqlSession().insert("refer.insert", refermodi) ;
								}	
							}
						}
					}
					
					String referResTotalLen = paramMap.get("referResTotalLen") == null ? "0" : (String)paramMap.get("referResTotalLen") ;
					if(referResTotalLen.equals("0")){
						eventExecutor.getSqlSession().delete("refer.delete_by_resid",map);
					}
					
					
					List refrtypelist = eventExecutor.getSqlSession().selectList("refer.select_refertype_count",map);
					if(refrtypelist.size() > 0){
						String typere = refrtypelist.toString().replace("[", "").replace("]", "").replace("}", "").replace(" ", "").trim();
					    String type = "";
					    HashMap mmap = null;
						for(Object o : refrtypelist){
							mmap = (HashMap<String, String>)o;
							type += (String)mmap.get("referType") + ",";
					    }
						
						map.put("lrReferType", type.substring(0,type.lastIndexOf(","))) ;
						map.put("lrID", paramMap.get("lrID")) ;
						map.put("lrIsRefer", "1") ;
					}else{
						map.put("lrReferType", "") ;
						map.put("lrID", paramMap.get("lrID")) ;
						map.put("lrIsRefer", "0") ;
					}
					int ralue = eventExecutor.getSqlSession().update("laboratory.update_refertype",map);
					/******************将上传的文件放到参考资源中********************/
					
					
					
				}	
			}
			 
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, LaboratoryModifyEvent.class);
			/*log.error(error);*/
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
