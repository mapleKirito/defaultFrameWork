package com.ow.module.event.view.Event;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.FileHelper;
import com.ow.framework.util.StringUtil;
import com.ow.module.event.view.ResSearchViewEvent;
import com.ow.upload.servlet.ComparatorToList;

public class SmallResSearchViewAllEvent2 implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SmallResSearchViewAllEvent2()
	{
		resultData = new ResultData();
	}
	@SuppressWarnings("unchecked")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			HttpServletResponse resp = ServletActionContext.getResponse();
			PrintWriter out = resp.getWriter();
			JSONObject json = new JSONObject(); 
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap() ;
			String roomtype = paramMap.get("roomtype") == null ? "" : (String)paramMap.get("roomtype") ;
			String typehead = StringUtil.reResAbbreviated(roomtype);
			String _id = paramMap.get(typehead + "ID") == null ? "" : (String)paramMap.get(typehead + "ID");
			Map mapmap = new HashMap();
			mapmap.put(typehead + "ID", _id);
			Object obj = eventExecutor.getSqlSession().selectOne(roomtype + ".select_by_id",mapmap);
			String keyword = ((HashMap)obj).get(typehead+ "Keywords") == null ? "":((HashMap)obj).get(typehead+ "Keywords").toString();
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>() ;

			if("".equals(keyword.trim()) || keyword ==null){
				
			}else{
				keyword = keyword.substring(1,keyword.length()-1 );
				if("".equals(keyword.trim()) || keyword ==null){
					
				}else{
					String[] keywords = keyword.split("、");
					String sqler = "(";
					String sqlor = "(";
					String sqllr = "(";
					String sqlpr = "(";
					for(int i = 0; i < keywords.length;i++){
						
						/*ER_Keywords*/
						sqler += "  ER_Keywords like '%、"+keywords[i]+"、%' or";
						sqlor += "  OR_Keywords like '%、"+keywords[i]+"、%' or";
						sqllr += "  LR_Keywords like '%、"+keywords[i]+"、%' or";
						sqlpr += "  PR_Keywords like '%、"+keywords[i]+"、%' or";
						
						
					}
					sqler = sqler.substring(0,sqler.length()-2);
					sqler += ")";
					
					sqlor = sqlor.substring(0,sqlor.length()-2);
					sqlor += ")";
					
					sqllr = sqllr.substring(0,sqllr.length()-2);
					sqllr += ")";
					
					sqlpr = sqlpr.substring(0,sqlpr.length()-2);
					sqlpr += ")";
					
					HashMap<String, Object> map = new HashMap<String, Object>() ;
					map.put("sqlParamer",  sqler);
					map.put("sqlParamor",  sqlor);
					map.put("sqlParamlr",  sqllr);
					map.put("sqlParampr",  sqlpr);
					map.put("notInID", _id);
					
					List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList("exhibition.select_page_keywords", map);//文物博览室
					for(HashMap<String, Object> res : list1) {
						HashMap<String, Object> map1 = new HashMap<String, Object>() ;
						map1.put("name", res.get("erName")) ;
						map1.put("id", res.get("erID")) ;
						map1.put("code",res.get("erCode")) ;
						map1.put("upload", res.get("erUpload")) ;
						map1.put("thumbnail", res.get("erThumbnail")) ;
						map1.put("inThum", res.get("erInThum")) ;
						map1.put("description", res.get("erDescription")) ;
						map1.put("path", res.get("erPath")) ;
						map1.put("gangID", res.get("erGangID")) ;
						map1.put("fileType", res.get("erType")) ;
						map1.put("resType", "exhibition") ;
						map1.put("creator", res.get("erCreator")) ;
						map1.put("createTime", res.get("erCreateTime")) ;
						map1.put("audio", res.get("erAudio"));
						map1.put("Remarks", res.get("erRemarks")) ;
						map1.put("room", "1");
						list.add(map1);
					}
					List<HashMap<String, Object>> list2 = eventExecutor.getSqlSession().selectList("observation.select_page_keywords", map);//文物博览室
					for(HashMap<String, Object> res : list2) {
						HashMap<String, Object> map2 = new HashMap<String, Object>() ;
						map2.put("name", res.get("orName")) ;
						map2.put("id", res.get("orID")) ;
						map2.put("code",res.get("orNo")) ;
						map2.put("upload", res.get("orUpload")) ;
						map2.put("thumbnail", res.get("orThumbnail")) ;
						map2.put("inThum", res.get("orInThum")) ;
						map2.put("description", res.get("orDescription")) ;
						map2.put("path", res.get("orPath")) ;
						map2.put("gangID", res.get("orGangID")) ;
						map2.put("fileType", res.get("orType")) ;
						map2.put("resType", "observation") ;
						map2.put("creator", res.get("orCreator")) ;
						map2.put("createTime", res.get("orCreateTime")) ;
						map2.put("audio", res.get("orAudio"));
						map2.put("Remarks", res.get("orRemarks")) ;
						map2.put("room", "2");
						list.add(map2);
					}
					
					List<HashMap<String, Object>> list3 = eventExecutor.getSqlSession().selectList("laboratory.select_page_keywords", map);//文物博览室
					for(HashMap<String, Object> res : list3) {
						HashMap<String, Object> map3 = new HashMap<String, Object>() ;
						map3.put("name", res.get("lrName")) ;
						map3.put("id", res.get("lrID")) ;
						map3.put("code",res.get("lrNo")) ;
						map3.put("upload", res.get("lrUpload")) ;
						map3.put("thumbnail", res.get("lrThumbnail")) ;
						map3.put("inThum", res.get("lrInThum")) ;
						map3.put("description", res.get("lrDescription")) ;
						map3.put("path", res.get("lrPath")) ;
						map3.put("gangID", res.get("lrGangID")) ;
						map3.put("fileType", res.get("lrType")) ;
						map3.put("resType", "laboratory") ;
						map3.put("creator", res.get("lrCreator")) ;
						map3.put("createTime", res.get("lrCreateTime")) ;
						map3.put("audio", res.get("lrAudio"));
						map3.put("Remarks", res.get("lrRemarks")) ;
						map3.put("room", "3");
						list.add(map3);
					}
					List<HashMap<String, Object>> list4 = eventExecutor.getSqlSession().selectList("projection.select_page_keywords", map);//文物博览室
					for(HashMap<String, Object> res : list4) {
						HashMap<String, Object> map4 = new HashMap<String, Object>() ;
						map4.put("name", res.get("prName")) ;
						map4.put("id", res.get("prID")) ;
						map4.put("code",res.get("prNo")) ;
						map4.put("upload", res.get("prUpload")) ;
						map4.put("thumbnail", res.get("prThumbnail")) ;
						map4.put("inThum", res.get("prInThum")) ;
						map4.put("description", res.get("prDescription")) ;
						map4.put("path", res.get("prPath")) ;
						map4.put("gangID", res.get("prGangID")) ;
						map4.put("fileType", res.get("prType")) ;
						map4.put("resType", "projection") ;
						map4.put("creator", res.get("prCreator")) ;
						map4.put("createTime", res.get("prCreateTime")) ;
						map4.put("audio", res.get("prAudio"));
						map4.put("Remarks", res.get("prRemarks")) ;
						map4.put("room", "4");
						list.add(map4);
					}
					
				}
				
			}
			if(list.size()>30){
				 list = list.subList(0,30);
			 }
			
			//手动数据关联查询  数据查询格式  科室-ID   ：exhibition-12
			String  relation = ((HashMap)obj).get(typehead+ "Relation") == null ? "":((HashMap)obj).get(typehead+ "Relation").toString();
			
			if("".equals(((HashMap)obj).get(typehead+ "Relation"))|| ((HashMap)obj).get(typehead+ "Relation") == null){
			
			}else{
				String[] relations = relation.split(",");
				String exhibitionIDs = "";
				String observationIDs = "";
				String laboratoryIDs = "";
				String projectionIDs = "";
				String lovelyIDs = "";
				
				for(int i = 0; i<relations.length; i++){
					
					if(relations[i].split("-")[0].equals("exhibition"))
						exhibitionIDs += relations[i].split("-")[1]+",";
					if(relations[i].split("-")[0].equals("observation"))
						observationIDs += relations[i].split("-")[1]+",";
					if(relations[i].split("-")[0].equals("laboratory"))
						laboratoryIDs += relations[i].split("-")[1]+",";
					if(relations[i].split("-")[0].equals("projection"))
						projectionIDs += relations[i].split("-")[1]+",";
					if(relations[i].split("-")[0].equals("lovely"))
						lovelyIDs += relations[i].split("-")[1]+",";
					
				}

				HashMap<String, Object> mapRealtion = new HashMap<String, Object>() ;
				if(!"".equals(exhibitionIDs)){
					mapRealtion.put("erID", exhibitionIDs.substring(0, exhibitionIDs.length()-1));
					List<HashMap<String, Object>> listRe = eventExecutor.getSqlSession().selectList("exhibition.select_by_ids", mapRealtion);//文物博览室
					for(HashMap<String, Object> res : listRe) {
						HashMap<String, Object> map1 = new HashMap<String, Object>() ;
						map1.put("name", res.get("erName")) ;
						map1.put("id", res.get("erID")) ;
						map1.put("code",res.get("erCode")) ;
						map1.put("upload", res.get("erUpload")) ;
						map1.put("thumbnail", res.get("erThumbnail")) ;
						map1.put("inThum", res.get("erInThum")) ;
						map1.put("description", res.get("erDescription")) ;
						map1.put("path", res.get("erPath")) ;
						map1.put("gangID", res.get("erGangID")) ;
						map1.put("fileType", res.get("erType")) ;
						map1.put("resType", "exhibition") ;
						map1.put("creator", res.get("erCreator")) ;
						map1.put("createTime", res.get("erCreateTime")) ;
						map1.put("audio", res.get("erAudio"));
						map1.put("Remarks", res.get("erRemarks")) ;
						map1.put("room", "1");
						list.add(map1);
					}
				}
				if(!"".equals(observationIDs)){
					mapRealtion.put("orID", observationIDs.substring(0, observationIDs.length()-1));
					List<HashMap<String, Object>> listRo = eventExecutor.getSqlSession().selectList("observation.select_by_ids", mapRealtion);//专题研读室
					for(HashMap<String, Object> res : listRo) {
						HashMap<String, Object> map2 = new HashMap<String, Object>() ;
						map2.put("name", res.get("orName")) ;
						map2.put("id", res.get("orID")) ;
						map2.put("code",res.get("orNo")) ;
						map2.put("upload", res.get("orUpload")) ;
						map2.put("thumbnail", res.get("orThumbnail")) ;
						map2.put("inThum", res.get("orInThum")) ;
						map2.put("description", res.get("orDescription")) ;
						map2.put("path", res.get("orPath")) ;
						map2.put("gangID", res.get("orGangID")) ;
						map2.put("fileType", res.get("orType")) ;
						map2.put("resType", "observation") ;
						map2.put("creator", res.get("orCreator")) ;
						map2.put("createTime", res.get("orCreateTime")) ;
						map2.put("audio", res.get("orAudio"));
						map2.put("Remarks", res.get("orRemarks")) ;
						map2.put("room", "2");
						list.add(map2);
					}
				}
				if(!"".equals(laboratoryIDs)){
					mapRealtion.put("lrID", laboratoryIDs.substring(0, laboratoryIDs.length()-1));
					List<HashMap<String, Object>> listRl = eventExecutor.getSqlSession().selectList("laboratory.select_by_ids", mapRealtion);//教学研究室
					for(HashMap<String, Object> res : listRl) {
						HashMap<String, Object> map3 = new HashMap<String, Object>() ;
						map3.put("name", res.get("lrName")) ;
						map3.put("id", res.get("lrID")) ;
						map3.put("code",res.get("lrNo")) ;
						map3.put("upload", res.get("lrUpload")) ;
						map3.put("thumbnail", res.get("lrThumbnail")) ;
						map3.put("inThum", res.get("lrInThum")) ;
						map3.put("description", res.get("lrDescription")) ;
						map3.put("path", res.get("lrPath")) ;
						map3.put("gangID", res.get("lrGangID")) ;
						map3.put("fileType", res.get("lrType")) ;
						map3.put("resType", "laboratory") ;
						map3.put("creator", res.get("lrCreator")) ;
						map3.put("createTime", res.get("lrCreateTime")) ;
						map3.put("audio", res.get("lrAudio"));
						map3.put("Remarks", res.get("lrRemarks")) ;
						map3.put("room", "3");
						list.add(map3);
					}
				}
				
				if(!"".equals(projectionIDs)){
					mapRealtion.put("prID", projectionIDs.substring(0, projectionIDs.length()-1));
					List<HashMap<String, Object>> listRp = eventExecutor.getSqlSession().selectList("projection.select_by_ids", mapRealtion);//文物博览室
					for(HashMap<String, Object> res : listRp) {
						HashMap<String, Object> map4 = new HashMap<String, Object>() ;
						map4.put("name", res.get("prName")) ;
						map4.put("id", res.get("prID")) ;
						map4.put("code",res.get("prNo")) ;
						map4.put("upload", res.get("prUpload")) ;
						map4.put("thumbnail", res.get("prThumbnail")) ;
						map4.put("inThum", res.get("prInThum")) ;
						map4.put("description", res.get("prDescription")) ;
						map4.put("path", res.get("prPath")) ;
						map4.put("gangID", res.get("prGangID")) ;
						map4.put("fileType", res.get("prType")) ;
						map4.put("resType", "projection") ;
						map4.put("creator", res.get("prCreator")) ;
						map4.put("createTime", res.get("prCreateTime")) ;
						map4.put("audio", res.get("prAudio"));
						map4.put("Remarks", res.get("prRemarks")) ;
						map4.put("room", "4");
						list.add(map4);
					}
				}
				
				if(!"".equals(lovelyIDs)){
					mapRealtion.put("crID", lovelyIDs.substring(0, lovelyIDs.length()-1));
					List<HashMap<String, Object>> listRc = eventExecutor.getSqlSession().selectList("lovely.select_by_ids", mapRealtion);//文物博览室
					for(HashMap<String, Object> res : listRc) {
						HashMap<String, Object> map5 = new HashMap<String, Object>() ;
						map5.put("name", res.get("crName")) ;
						map5.put("id", res.get("crID")) ;
						map5.put("code",res.get("crNo")) ;
						map5.put("upload", res.get("crUpload")) ;
						map5.put("thumbnail", res.get("crThumbnail")) ;
						map5.put("inThum", res.get("crInThum")) ;
						map5.put("description", res.get("crDescription")) ;
						map5.put("path", res.get("crPath")) ;
						map5.put("gangID", res.get("crGangID")) ;
						map5.put("fileType", res.get("crType")) ;
						map5.put("resType", "lovely") ;
						map5.put("creator", res.get("crCreator")) ;
						map5.put("createTime", res.get("crCreateTime")) ;
						map5.put("audio", res.get("crAudio"));
						map5.put("Remarks", res.get("crRemarks")) ;
						map5.put("room", "5");
						list.add(map5);
					}
				}
			}
			json.put("list", list);
			out.println(json);
			out.flush();
			out.close();
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ResSearchViewEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
