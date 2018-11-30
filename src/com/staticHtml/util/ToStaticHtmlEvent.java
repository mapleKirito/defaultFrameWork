package com.staticHtml.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.staticHtml.bean.PageInfoBean;

public class ToStaticHtmlEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

		public ToStaticHtmlEvent() {
		resultData = new ResultData();
	}

	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			String sql=".select_by_code";
			String res_codes=map.get("code")==null?"":map.get("code").toString();
			String[] res_code=res_codes.split(",");
			Worker worker=new Worker();
			List<InitStaticHtml> initList=new ArrayList<InitStaticHtml>();
			
			for (String  rcode : res_code) {
				HashMap<String, String> tmp=new HashMap<String, String>();
				tmp.put("code", rcode);
				if(rcode.contains("BLS")){
					HashMap<String, Object> paramMap=(HashMap<String, Object>)eventExecutor.getSqlSession().selectOne("exhibition"+sql, tmp);
					
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
					paramMap.put("erLoLa", val);
					
					PageInfoBean pib=StaticTableFactory.getPageInfoBeanExhibition(paramMap);
					String content=paramMap.get("erContent")==null?"":paramMap.get("erContent").toString();
					System.out.println(paramMap.get("erName"));
					InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("erName").toString(),content,pib,paramMap.get("erCode").toString());
					initList.add(ish);
				}
				else if(rcode.contains("YDS")){
					HashMap<String, Object> paramMap=(HashMap<String, Object>)eventExecutor.getSqlSession().selectOne("observation"+sql, tmp);
					PageInfoBean pib=StaticTableFactory.getPageInfoBeanObservation(paramMap);
					String content=paramMap.get("orContent")==null?"":paramMap.get("orContent").toString();
					System.out.println(paramMap.get("orName"));
					InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("orName").toString(),content,pib,paramMap.get("orNO").toString());
					initList.add(ish);
				}
				else if(rcode.contains("YJS")){
					HashMap<String, Object> paramMap=(HashMap<String, Object>)eventExecutor.getSqlSession().selectOne("laboratory"+sql, tmp);
					PageInfoBean pib=StaticTableFactory.getPageInfoBeanLaboratory(paramMap);
					String content=paramMap.get("lrContent")==null?"":paramMap.get("lrContent").toString();
					System.out.println(paramMap.get("lrName"));
					InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("lrName").toString(),content,pib,paramMap.get("lrNO").toString());
					initList.add(ish);
				}
				else if(rcode.contains("ZLS")){
					HashMap<String, Object> paramMap=(HashMap<String, Object>)eventExecutor.getSqlSession().selectOne("projection"+sql, tmp);
					PageInfoBean pib=StaticTableFactory.getPageInfoBeanProjection(paramMap);
					String content=paramMap.get("prContent")==null?"":paramMap.get("prContent").toString();
					System.out.println(paramMap.get("prName"));
					InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("prName").toString(),content,pib,paramMap.get("prNO").toString());
					initList.add(ish);
				}
				else if(rcode.contains("TJS")){
					HashMap<String, Object> paramMap=(HashMap<String, Object>)eventExecutor.getSqlSession().selectOne("expand"+sql, tmp);
					PageInfoBean pib=StaticTableFactory.getPageInfoBeanLovely(paramMap);
					String content=paramMap.get("erContent")==null?"":paramMap.get("erContent").toString();
					System.out.println(paramMap.get("erName"));
					InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("erName").toString(),content,pib,paramMap.get("erNo").toString());
					initList.add(ish);
				}
			}
			
			worker.setWorkList(initList);
			worker.start();
			resultData.setIntResult(1);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ToStaticHtmlEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
