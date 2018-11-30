package com.ow.module.event.sysmgr.exhibition;

import java.util.ArrayList;
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
import com.staticHtml.bean.TableBean;
import com.staticHtml.util.InitStaticHtml;
import com.staticHtml.util.StaticTableFactory;
import com.staticHtml.util.Worker;

public class ExhibitionCreateQrcodeEvent implements EventListener {

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	private static String fileSplit = "/";

	public ExhibitionCreateQrcodeEvent() {
		resultData = new ResultData();
	}

	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			
			Worker worker=new Worker();
			List<InitStaticHtml> initList=new ArrayList<InitStaticHtml>();
			HashMap<String, String> map = eventExecutor.getBaseAction().getParamMap();
			
			List<HashMap> list1=eventExecutor.getSqlSession().selectList("exhibition.select_all");
			for (HashMap paramMap : list1) {
				PageInfoBean pib=StaticTableFactory.getPageInfoBeanExhibition(paramMap);
				String content=paramMap.get("erContent")==null?"":paramMap.get("erContent").toString();
				System.out.println(paramMap.get("erName"));
				InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("erName").toString(),content,pib,paramMap.get("erCode").toString());
				initList.add(ish);
			}
			list1=eventExecutor.getSqlSession().selectList("observation.select_all");
			for (HashMap paramMap : list1) {
				PageInfoBean pib=StaticTableFactory.getPageInfoBeanObservation(paramMap);
				String content=paramMap.get("orContent")==null?"":paramMap.get("orContent").toString();
				System.out.println(paramMap.get("orName"));
				InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("orName").toString(),content,pib,paramMap.get("orNO").toString());
				initList.add(ish);
			}
			list1=eventExecutor.getSqlSession().selectList("laboratory.select_all");
			for (HashMap paramMap : list1) {
				PageInfoBean pib=StaticTableFactory.getPageInfoBeanLaboratory(paramMap);
				String content=paramMap.get("lrContent")==null?"":paramMap.get("lrContent").toString();
				System.out.println(paramMap.get("lrName"));
				InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("lrName").toString(),content,pib,paramMap.get("lrNO").toString());
				initList.add(ish);
			}
			list1=eventExecutor.getSqlSession().selectList("projection.select_all");
			for (HashMap paramMap : list1) {
				PageInfoBean pib=StaticTableFactory.getPageInfoBeanProjection(paramMap);
				String content=paramMap.get("prContent")==null?"":paramMap.get("prContent").toString();
				System.out.println(paramMap.get("prName"));
				InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("prName").toString(),content,pib,paramMap.get("prNO").toString());
				initList.add(ish);
			}
			list1=eventExecutor.getSqlSession().selectList("lovely.select_all");
			for (HashMap paramMap : list1) {
				PageInfoBean pib=StaticTableFactory.getPageInfoBeanLovely(paramMap);
				String content=paramMap.get("crContent")==null?"":paramMap.get("crContent").toString();
				System.out.println(paramMap.get("crName"));
				InitStaticHtml ish=new InitStaticHtml(eventExecutor.getDsname(), paramMap.get("crName").toString(),content,pib,paramMap.get("crNo").toString());
				initList.add(ish);
			}
			
			worker.setWorkList(initList);
			worker.start();
			

			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExhibitionCreateQrcodeEvent.class);
			log.error(error);
		}
		return resultData;
	}


}
