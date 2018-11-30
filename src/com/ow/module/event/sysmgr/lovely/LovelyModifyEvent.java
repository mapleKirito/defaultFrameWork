package com.ow.module.event.sysmgr.lovely;

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
import com.ow.framework.util.StringUtil;
import com.staticHtml.bean.PageInfoBean;
import com.staticHtml.util.InitStaticHtml;
import com.staticHtml.util.StaticTableFactory;

public class LovelyModifyEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	static int gradedefault = 001; 
	private ResultData resultData;
	
	private static String fileSplit = "/";

	public LovelyModifyEvent() {
		resultData = new ResultData();
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String update = eventExecutor.getSqlidByIndex(0);
			if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
				
				resultData = DBUtil.uploadRes(eventExecutor, "lovely", "", true) ;
				if(resultData.getIntResult() > -1) {
					paramMap = eventExecutor.getBaseAction().getParamMap();
				}else {
					return resultData ;
				}
				String erThumbnail = paramMap.get("crThumbnail") == null ? "" : (String)paramMap.get("crThumbnail") ;
				String erInThum = paramMap.get("crInThum") == null ? "" : (String)paramMap.get("crInThum") ;
				
				String grGrades = paramMap.get("grGrades") == null ? "" : (String)paramMap.get("grGrades") ;
				paramMap.put("crGrade", grGrades);
				
				String grJingsais = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;
				paramMap.put("crContest", grJingsais);
				
				
				if (!"".equals(update)) {
					
					if("".equals(((String)paramMap.get("crCateTwLevel")))){
						paramMap.put("crCateTwLevel", paramMap.get("crResType")) ;
					}
					
					String olderRecommen = paramMap.get("crRecommen") == null ? "" : (String)paramMap.get("crRecommen") ;
					String Recommensize = paramMap.get("Recommensize") == null ? "" : (String)paramMap.get("Recommensize") ;
					String erRecommen = "0";
					if(!olderRecommen.equals("0") && !Recommensize.equals("0")){
						erRecommen = olderRecommen+","+Recommensize;
					}
					String re = Arrays.toString(DBUtil.dictinctArray(erRecommen.split(","))).replace("[", "").replace("]", "").replace(" ", "").trim();
					paramMap.put("crRecommen",  re.equals("") ? "0" : re) ;
					
					String crContent = paramMap.get("crContent") == null ? "" : ((String)paramMap.get("crContent")).replace("\r\n", "");
					paramMap.put("crContent",  crContent) ;
					
					int rvalue = eventExecutor.getSqlSession().update(update,paramMap);
					resultData.setIntResult(1);
					
					HashMap category = new HashMap();
					String modifycateerResType = paramMap.get("modifycateerResType") == null ? "" : ((String)paramMap.get("modifycateerResType"));
					category.put("modifycateerResType", modifycateerResType);
					String modifycateerCateTwLevel = paramMap.get("modifycateerCateTwLevel") == null ? "" : ((String)paramMap.get("modifycateerCateTwLevel"));
					category.put("modifycateerCateTwLevel", modifycateerCateTwLevel);
					DBUtil.resModifyCategoryStatus(eventExecutor, category, "lovely");
					
					Object one = eventExecutor.getSqlSession().selectOne("lovely.select_by_id",paramMap);
					DBUtil.modifyCategoryStatus(eventExecutor, one, "lovely");
					
					
					HashMap param = new HashMap() ;
					
					/******************将上传的文件放到年级表中********************/
					HashMap paramgrade = new HashMap() ;
					String greadDeleteByRes = "grade.delete_res";
					String greadUpdate = "grade.insert";	
					paramgrade.put("grResourceType", "lovely") ;
					paramgrade.put("grResourceID", paramMap.get("crID")) ;
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
					paramcontest.put("grResourceID", paramMap.get("crID")) ;
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
					/******************将上传的文件放到推荐表中********************/
					param = new HashMap() ;
					param.put("reRecommendType", "lovely") ;
					String aa = eventExecutor.getBaseAction().getParamMap().get("generatedKey");
					param.put("reRecommendID", paramMap.get("crID")) ;
					if(!erRecommen.equals("0")){
						String resUpdate = "recom.update"; 
						if(eventExecutor.getSqlSession().selectList("recom.select_by_id",param).size()<=0){
							resUpdate = "recom.insert"; 
						}
						param.put("reThumbnail", erThumbnail) ;
						param.put("reInThum", paramMap.get("crInThum")) ;
						param.put("reName", paramMap.get("crName")) ;
						param.put("reUpload", paramMap.get("crUpload")) ;
						param.put("reType", paramMap.get("crType")) ;
						param.put("reSize", paramMap.get("Recommensize")) ;
						param.put("reID", paramMap.get("crID")) ;
						param.put("reRecoFileUP", paramMap.get("crRecommenFile")) ;
						eventExecutor.getSqlSession().update(resUpdate,param);						
					}else{
						eventExecutor.getSqlSession().delete("recom.delete_by_resid",param);
					}
					/******************将上传的文件放到推荐表中********************/
					/******************同步资源信息********************/
					String resUpdate = eventExecutor.getSqlidByIndex(2); 
					HashMap paramres = new HashMap() ;
					paramres.put("rrResourceType", "lovely") ;
					paramres.put("rrResourceID", paramMap.get("crID")) ;
					paramres.put("rrThumbnail", erThumbnail) ;
					paramres.put("rrInThum", paramMap.get("crInThum")) ;
					paramres.put("rrName", paramMap.get("crName")) ;
					paramres.put("rrUpload", paramMap.get("crUpload")) ;
					paramres.put("rrType", paramMap.get("crType")) ;
					paramres.put("rrIsShare", paramMap.get("crIsShare")) ;
					paramres.put("s_userID", paramMap.get("s_userID")) ;
					paramres.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
					eventExecutor.getSqlSession().update(resUpdate,paramres);
					/******************同步资源信息********************/
					
					//初始化二维码扫描静态页
					HashMap<String, String> tmp=new HashMap<String, String>();
					tmp.put("code", paramMap.get("thecode").toString());
					HashMap<String, Object> paramMapScanner=(HashMap<String, Object>)eventExecutor.getSqlSession().selectOne("lovely"+".select_by_code", tmp);
					PageInfoBean pib=StaticTableFactory.getPageInfoBeanLovely(paramMapScanner);
					String content=paramMapScanner.get("crContent")==null?"":paramMapScanner.get("crContent").toString();
					System.out.println(paramMapScanner.get("crName"));
					InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMapScanner.get("crName").toString(),content,pib,paramMapScanner.get("crNo").toString());
					
					Thread temp_t=new Thread(ish);
					temp_t.start();
					
					/******************将上传的文件放到参考资源中********************/
					HashMap map = new HashMap();
					map.put("referReferType", "lovely") ;
					map.put("referReferID", paramMap.get("crID")) ;
					String DiffReferUpload = paramMap.get("DiffReferUpload") == null ? "" : (String)paramMap.get("DiffReferUpload");	
					if(!DiffReferUpload.equals("")){
						String diff[] = DiffReferUpload.split(",");
						for(int i=0;i<diff.length;i++){
							HashMap diffMap = new HashMap();
							diffMap.put("referUpload", diff[i]) ; 
							Object obj = eventExecutor.getSqlSession().selectOne("refer.select_by_upload",diffMap);
							String beforefiel = ((HashMap)obj).get("referID").toString();
							diffMap.put("referID", beforefiel) ;
							diffMap.put("referReferType", "lovely") ;
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
									refermodi.put("referReferID", paramMap.get("crID")) ;
									refermodi.put("referName", paramMap.get("crName")) ;
									refermodi.put("referReferType","lovely") ;
									refermodi.put("referThumbnail", StringUtil.reResReferThumbnail(referFileType[h])) ;
									refermodi.put("referUpload", referupload) ;
									refermodi.put("referFileSwf", referFileswfV[h].trim()) ;
									refermodi.put("referFileSwfPath", referFileSwfPathV[h].trim()) ;
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
						
						map.put("crReferType", type.substring(0,type.lastIndexOf(","))) ;
						map.put("crID", paramMap.get("crID")) ;
						map.put("crIsRefer", "1") ;
					}else{
						map.put("crReferType", "") ;
						map.put("crID", paramMap.get("crID")) ;
						map.put("crIsRefer", "0") ;
					}
					int ralue = eventExecutor.getSqlSession().update("lovely.update_refertype",map);
					/******************将上传的文件放到参考资源中********************/
					
					
				}	
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, LovelyModifyEvent.class);
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
