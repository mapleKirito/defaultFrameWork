package com.ow.module.event.sysmgr.exhibition;

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

public class ExhibitionModifyEvent  implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	static int gradedefault = 001; 
	private ResultData resultData;
	
	private static String fileSplit = "/";

	public ExhibitionModifyEvent() {
		resultData = new ResultData();
	}
	
	@SuppressWarnings({ "unchecked", "unused", "rawtypes" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String update = eventExecutor.getSqlidByIndex(0);
				if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
				//处理资源和缩略图
				resultData = DBUtil.uploadRes(eventExecutor, "exhibition", "", true) ;
				if(resultData.getIntResult() > -1) {
					paramMap = eventExecutor.getBaseAction().getParamMap();
				}else {
					return resultData ;
				}
				
				String grGrades = paramMap.get("grGrades") == null ? "" : (String)paramMap.get("grGrades") ;
				String grJingsais = paramMap.get("grJingsai") == null ? "" : (String)paramMap.get("grJingsai") ;
				paramMap.put("erContest", grJingsais);
				
				if (!"".equals(update)) {	
					int index=-1,index1=-1,index2=-1;
					paramMap.put("erGrade", grGrades);
					
					if("".equals(((String)paramMap.get("erGangID"))) || null == (((String)paramMap.get("erGangID")))){
						paramMap.put("erGangID", paramMap.get("erChorID")) ;
						if("".equals(((String)paramMap.get("erChorID"))) || null == (((String)paramMap.get("erChorID")))){
							paramMap.put("erGangID", paramMap.get("erJieID")) ;
							if("".equals(((String)paramMap.get("erJieID"))) ||  null == (((String)paramMap.get("erJieID")))){
								paramMap.put("erGangID", paramMap.get("erTotalID")) ;
							}
						}
					}
					
					String olderRecommen = paramMap.get("erRecommen") == null ? "" : (String)paramMap.get("erRecommen") ;
					String Recommensize = paramMap.get("Recommensize") == null ? "" : (String)paramMap.get("Recommensize") ;
					String erRecommen = "0";
					if(!olderRecommen.equals("0") && !Recommensize.equals("0")){
						erRecommen = olderRecommen+","+Recommensize;
					}
					String re = Arrays.toString(DBUtil.dictinctArray(erRecommen.split(","))).replace("[", "").replace("]", "").replace(" ", "").trim();
					paramMap.put("erRecommen",  re.equals("") ? "0" : re) ;
					
					String erThumbnail = paramMap.get("erThumbnail") == null ? "" : (String)paramMap.get("erThumbnail") ;
					String erInThum = paramMap.get("erInThum") == null ? "" : (String)paramMap.get("erInThum") ;
					
					String erContent = paramMap.get("erContent") == null ? "" : ((String)paramMap.get("erContent")).replace("\r\n", "");
					paramMap.put("erContent",  erContent) ;
					
					String erKeywords = paramMap.get("erKeywords") == null ? "" : ((String)paramMap.get("erKeywords")).replace("\r\n", "");
					if(!"".equals(erKeywords)){
						paramMap.put("erKeywords","、" + erKeywords+"、") ;
						
					}
					int rvalue = eventExecutor.getSqlSession().update(update,paramMap);
					resultData.setIntResult(1);
					
					//处理地区是否显示
					DBUtil.handleArea(eventExecutor) ;
					
					String erLoLa = paramMap.get("erLoLa") == null ? "" : ((String)paramMap.get("erLoLa"));
					paramMap.put("areaDistriResID", paramMap.get("erID")) ;
					int upval = eventExecutor.getSqlSession().update("areaDistri.delete",paramMap);
					if(!erLoLa.equals("")){
						String erLoLas[] = erLoLa.split("\\|");
						for(int i = 0;i < erLoLas.length;i++){
							paramMap.put("areaDistriLongitude",  erLoLas[i].split(",")[0]) ;
							paramMap.put("areaDistriLatitude",  erLoLas[i].split(",")[1]) ;
							int lolaval = eventExecutor.getSqlSession().insert("areaDistri.insert",paramMap);
						}
					}
					
					HashMap category = new HashMap();
					String modifycateJieID = paramMap.get("modifycateJieID") == null ? "" : ((String)paramMap.get("modifycateJieID"));
					category.put("modifycateJieID", modifycateJieID);
					String modifycateChorID = paramMap.get("modifycateChorID") == null ? "" : ((String)paramMap.get("modifycateChorID"));
					category.put("modifycateChorID", modifycateChorID);
					String modifycateGangID = paramMap.get("modifycateGangID") == null ? "" : ((String)paramMap.get("modifycateGangID"));
					category.put("modifycateGangID", modifycateGangID);
					String modifycateOrderID = paramMap.get("modifycateOrderID") == null ? "" : ((String)paramMap.get("modifycateOrderID"));
					category.put("modifycateOrderID", modifycateOrderID);
					String modifycateforyID = paramMap.get("modifycateforyID") == null ? "" : ((String)paramMap.get("modifycateforyID"));
					category.put("modifycateforyID", modifycateforyID);
					DBUtil.resModifyCategoryStatus(eventExecutor, category, "exhibition");
					
					Object one = eventExecutor.getSqlSession().selectOne("exhibition.select_by_id",paramMap);
					DBUtil.modifyCategoryStatus(eventExecutor, one, "exhibition");
					
					HashMap param = new HashMap() ;
					if(erThumbnail.equals("")){
						String res_erThumbnail = paramMap.get("res_erThumbnail") == null ? "" : (String)paramMap.get("res_erThumbnail") ;
						erThumbnail = res_erThumbnail;
					}
				
					/******************将上传的文件放到年级表中********************/
					HashMap paramgrade = new HashMap() ;
					String greadDeleteByRes = "grade.delete_res";
					String greadUpdate = "grade.insert";	
					paramgrade.put("grResourceType", "exhibition") ;
					paramgrade.put("grResourceID", paramMap.get("erID")) ;
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
					paramcontest.put("grResourceID", paramMap.get("erID")) ;
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
					/******************推荐表信息********************/
						param = new HashMap() ;
						param.put("reRecommendType", "exhibition") ;
						param.put("reRecommendID", paramMap.get("erID")) ;
						if(erRecommen.indexOf("1") >= 0 ){
							String resUpdate = "recom.update"; 
							
							if(eventExecutor.getSqlSession().selectList("recom.select_by_id",param).size()<=0){
								resUpdate = "recom.insert"; 
							}
							
							param.put("reThumbnail", erThumbnail) ;
							param.put("reInThum", paramMap.get("erInThum")) ;
							param.put("reName", paramMap.get("erName")) ;
							param.put("reUpload", paramMap.get("erUpload")) ;
							param.put("reType", paramMap.get("erType")) ;
							param.put("reSize", paramMap.get("Recommensize")) ;
							param.put("reID", paramMap.get("erID")) ;
							param.put("reRecoFileUP", paramMap.get("erRecommenFile")) ;
							eventExecutor.getSqlSession().update(resUpdate,param);						
						}else{
							eventExecutor.getSqlSession().delete("recom.delete_by_resid",param);
						}
					/******************推荐表信息********************/
					/******************同步资源信息********************/
					String resUpdate = eventExecutor.getSqlidByIndex(4); 
					HashMap paramres = new HashMap() ;
					paramres.put("rrResourceType", "exhibition") ;
					paramres.put("rrResourceID", paramMap.get("erID")) ;
					paramres.put("rrThumbnail", erThumbnail) ;
					paramres.put("rrInThum", paramMap.get("erInThum")) ;
					paramres.put("rrName", paramMap.get("erName")) ;
					paramres.put("rrUpload", paramMap.get("erUpload")) ;
					paramres.put("rrType", paramMap.get("erType")) ;
					paramres.put("rrIsShare", paramMap.get("erIsShare")) ;
					paramres.put("s_userID", paramMap.get("s_userID")) ;
					paramres.put("s_userLoginAccount", paramMap.get("s_userLoginAccount")) ;
					eventExecutor.getSqlSession().update(resUpdate,paramres);
					/******************同步资源信息********************/
					
					//初始化二维码扫描静态页
					String val = "",areanames = "";
					HashMap paramresscanner = new HashMap() ;
					paramresscanner.put("areaDistriResID", paramMap.get("erID"));
					List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList("areaDistri.select_lola", paramresscanner);
					for(HashMap<String, Object> res : list1) {
						 String areaDistriLongitude = res.get("areaDistriLongitude").toString() ;
						 String areaDistriLatitude = res.get("areaDistriLatitude").toString() ;
						 val += "/" + areaDistriLongitude+","+areaDistriLatitude;
						 
						 if(res.get("areaDistriName")!=null){
							 String areaDistriname = res.get("areaDistriName").toString() ;
							 areanames += "/" + areaDistriname;
						 }
						 
					}
					val = val.replaceFirst("/", "").replace("/", "|");
					
					HashMap<String, String> tmp=new HashMap<String, String>();
					tmp.put("code", paramMap.get("thecode").toString());
					HashMap<String, Object> paramMapScanner=(HashMap<String, Object>)eventExecutor.getSqlSession().selectOne("exhibition"+".select_by_code", tmp);
					paramMapScanner.put("erLoLa", val);
					PageInfoBean pib=StaticTableFactory.getPageInfoBeanExhibition(paramMapScanner);
					String content=paramMapScanner.get("erContent")==null?"":paramMapScanner.get("erContent").toString();
					System.out.println(paramMapScanner.get("erName"));
					InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMapScanner.get("erName").toString(),content,pib,paramMapScanner.get("erCode").toString());
					
					Thread temp_t=new Thread(ish);
					temp_t.start();
				}	
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExhibitionModifyEvent.class);
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
