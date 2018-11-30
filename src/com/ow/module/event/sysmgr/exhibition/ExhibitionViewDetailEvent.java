package com.ow.module.event.sysmgr.exhibition;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.module.event.sysmgr.ResourceUtil;
import com.unitecount.ResourceCount;

public class ExhibitionViewDetailEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ExhibitionViewDetailEvent()
	{
		resultData = new ResultData();
	}	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			/*信息统计开始*/
			if(ConstantI.ISCOUNT_KEY.equals("1")){
			String type="1011";
			ResourceCount.sendMsg(type,"BROWSE");
			}
			/*信息统计结束*/
			Object obj = eventExecutor.getSqlSession().selectOne(selectSqlId,map);
			String path = eventExecutor.getBaseAction().getPath() == null ? "" : eventExecutor.getBaseAction().getPath();
			String nameother = "";
			
			nameother = ((HashMap)obj).get("erName").toString();
			eventExecutor.getBaseAction().session.put("nameother",nameother);
			
			map.put("path",path);
			
			String val = "",areanames = "";
			map.put("areaDistriResID", map.get("erID"));
			List<HashMap<String, Object>> list1 = eventExecutor.getSqlSession().selectList("areaDistri.select_lola", map);
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
			areanames = areanames.replaceAll("/", " ");
			map.put("erLoLa", val);
			map.put("erLoLaName", areanames);

			resultData.setOne(obj);
			//根据查询类型返回面包屑
			//查询类别 1-按功能查询 2-按区域查询 3-按适用学段、年级查询 4-按资源查询
			String st = eventExecutor.getBaseAction().getParamMap().get("st") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("st");
			if("1".equals(st)){
				String erName = "",erID = "";
				if (obj != null){
					erName = ((HashMap)obj).get("erName") == null ? "":((HashMap)obj).get("erName").toString();
					erID = ((HashMap)obj).get("erID") == null ? "":((HashMap)obj).get("erID").toString();					
				}
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnCategoryPath(eventExecutor, "erID", erName, erID));		
			}else if("2".equals(st)){
				String erName = "",erID = "";
				if (obj != null){
					erName = ((HashMap)obj).get("erName") == null ? "":((HashMap)obj).get("erName").toString();
					erID = ((HashMap)obj).get("erID") == null ? "":((HashMap)obj).get("erID").toString();
				}
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnAreaPath(eventExecutor, "erID", erName, erID));
			}else if("3".equals(st)){
				String erName = "",erID = "";
				if (obj != null){
					erName = ((HashMap)obj).get("erName") == null ? "":((HashMap)obj).get("erName").toString();
					erID = ((HashMap)obj).get("erID") == null ? "":((HashMap)obj).get("erID").toString();
				}
				String grGrade = eventExecutor.getBaseAction().getParamMap().get("grGrade") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("grGrade") ;
				eventExecutor.getBaseAction().setNavigation("") ;
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnGradePath(grGrade, "erID", erName, erID));
			}else if("4".equals(st)){
				String erName = "",erID = "";
				if (obj != null){
					erName = ((HashMap)obj).get("erName") == null ? "":((HashMap)obj).get("erName").toString();
					erID = ((HashMap)obj).get("erID") == null ? "":((HashMap)obj).get("erID").toString();
				}
				String rrType = eventExecutor.getBaseAction().getParamMap().get("rrType") == null ? "" : eventExecutor.getBaseAction().getParamMap().get("rrType") ;
				eventExecutor.getBaseAction().setNavigation("") ;
				eventExecutor.getBaseAction().setBussessNavigation(ResourceUtil.returnResourcePath(rrType, "erID", erName, erID));
			}
			return resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExhibitionViewDetailEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
