package com.ow.module.event.student;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class StudentMyUnfinishedInfoEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public StudentMyUnfinishedInfoEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String selectSqlId = eventExecutor.getSqlidByIndex(0);
			String selectCountSqlId = eventExecutor.getSqlidByIndex(1);
			String selectTaskQuoteSqlId = eventExecutor.getSqlidByIndex(2);
			String selectTaskInfoQuoteSqlId = eventExecutor.getSqlidByIndex(3);
			paramMap.put("tiType", "1");
			List list = eventExecutor.getSqlSession().selectList(selectSqlId, paramMap);
			Object obj = eventExecutor.getSqlSession().selectOne(selectCountSqlId, paramMap);
			//当前页
			int invitationCurrentPage = 1;
			String icpage = paramMap.get("invitationCurrentPage") == null ? "1" : paramMap.get("invitationCurrentPage").toString();
			try{
				invitationCurrentPage = Integer.parseInt(icpage);
			}
			catch (Exception e){
			}			
			int count = 0;
			if (obj != null){
				if (obj instanceof Integer){
					count = (Integer)obj;
				}
			}
			//每页显示记录数
			int pageSize=8;
			String psize = eventExecutor.getBaseAction().getPageSize();;
			try{
				pageSize = Integer.parseInt(psize);
			}
			catch (Exception e){
			}
			int pageCount = (int)Math.ceil(count/(double) pageSize);
			PaginatedData paginatedData =  new PaginatedData();
			paginatedData.setCurrentPage(invitationCurrentPage);
			paginatedData.setPageCount(pageCount);
			paginatedData.setPageSize(pageSize);
			paginatedData.setSelfPageName("paramMap.invitationCurrentPage");
			paginatedData.setContextName("invitationPaginated");
			paginatedData.htmlPage("code="+eventExecutor.getBaseAction().getCode());
			if (list != null){
				for (int i=0; i<list.size(); i++){
					String quoteIds = null;
					if (list.get(i) instanceof HashMap){
						quoteIds = ((HashMap)list.get(i)).get("tiQuotePath") == null ? null:((HashMap)list.get(i)).get("tiQuotePath").toString();
						if (quoteIds != null){
							String tiContent = ((HashMap)list.get(i)).get("tiContent") == null ? null:((HashMap)list.get(i)).get("tiContent").toString();
							String userAccount = ((HashMap)list.get(i)).get("userAccount") == null ? null:((HashMap)list.get(i)).get("userAccount").toString();
							String tiQuoteOfName = ((HashMap)list.get(i)).get("tiQuoteOfName") == null ? null:((HashMap)list.get(i)).get("tiQuoteOfName").toString();
							String qarr [] = quoteIds.split(",");
							String htmlContent = null;
							String templete1 = "<table border='0' width='100%' height='%100' cellpadding='5' style='background:#F7F7FF;border: 1px solid #6BD3EF; border-collapse: collapse;'>"
											+ "<tr>"
											+ "<td width='100%'>"
											+ "QuoteOfName 的回复："
											+ "</td>"
											+ "<td width='5' valign='top' align='right'>"
											+ "replaceLevel"
											+ "</td>"												
											+ "</tr>"								
											+ "<tr>"
											+ "<td colspan='2'>"
											+ "replaceContent"
											+ "</td>"
											+ "</tr>"
											+ "</table>";
							String templete2 = "<table border='0' width='100%' height='%100' cellpadding='5' style='background:#F7F7FF;border: 1px solid #6BD3EF; border-collapse: collapse;'>"
								+ "<tr>"
								+ "<td colspan='2'>"
								+ "replaceContentUp"
								+ "</td>"
								+ "</tr>"
								+ "<tr>"
								+ "<td width='100%'>"
								+ "QuoteOfName 的回复："
								+ "</td>"
								+ "<td width='5' valign='top' align='right'>"
								+ "replaceLevel"
								+ "</td>"								
								+ "</tr>"								
								+ "<tr>"
								+ "<td colspan='2'>"
								+ "replaceContentDown"
								+ "</td>"
								+ "</tr>"								
								+ "</table>";	
							String templete3 = "<table border='0' width='100%' height='%100' cellpadding='5'>"
								+ "<tr>"
								+ "<td colspan='2'>"
								+ "replaceContentUp"
								+ "</td>"
								+ "</tr>"
								//+ "<tr>"
								//+ "<td width='100%'>"
								//+ userAccount + " 的回复："
								//+ "</td>"
								//+ "<td width='5' valign='top' align='right'>"
								//+ "replaceLevel"
								//+ "</td>"								
								+ "</tr>"									
								+ "<tr>"
								+ "<td colspan='2'>"
								+ "replaceContentDown"
								+ "</td>"
								+ "</tr>"								
								+ "</table>";								
							int index = 0;
							for (int q=0; q<qarr.length; q++){
								if (qarr[q] != null && !qarr[q].equals("")){
									int indx = qarr[q].indexOf("_");
									if (indx >= 0){
										String prefix = qarr[q].substring(0,indx);
										String id = qarr[q].substring(indx + 1,qarr[q].length());
										Object qobj = null;
										if (prefix.equals("t")){
											paramMap.put("tId", id);
											qobj = eventExecutor.getSqlSession().selectOne(selectTaskQuoteSqlId, paramMap);
										}
										else{
											paramMap.put("tiId", id);
											qobj = eventExecutor.getSqlSession().selectOne(selectTaskInfoQuoteSqlId, paramMap);
										}
										if (qobj instanceof HashMap){
											String content = null;
											String QuoteOfName=null;
											if (prefix.equals("t")){
												content = ((HashMap)qobj).get("content") == null ? null:((HashMap)qobj).get("content").toString();
											}
											else{
												content = ((HashMap)qobj).get("tiContent") == null ? null:((HashMap)qobj).get("tiContent").toString();
												QuoteOfName = ((HashMap)qobj).get("tiUserAccount") == null ? null:((HashMap)qobj).get("tiUserAccount").toString();
											}
											if (index == 0){
												htmlContent = templete1.replaceAll("replaceContent", content);
												htmlContent = htmlContent.replaceAll("replaceLevel", "1");
												htmlContent = htmlContent.replaceAll("QuoteOfName", QuoteOfName);
											}
											else{
												htmlContent = templete2.replaceAll("replaceContentUp", htmlContent);
												htmlContent = htmlContent.replaceAll("replaceContentDown", content);
												htmlContent = htmlContent.replaceAll("QuoteOfName", QuoteOfName);
												htmlContent = htmlContent.replaceAll("replaceLevel", String.valueOf(index+1));
											}
											index++;
										}										
									}
								}
							}
							htmlContent = templete3.replaceAll("replaceContentUp", htmlContent);
							htmlContent = htmlContent.replaceAll("replaceContentDown", tiContent);
							htmlContent = htmlContent.replaceAll("replaceLevel", String.valueOf(index+1));
							((HashMap)list.get(i)).put("tiContent",htmlContent);
						}
						String tiGoodScore = ((HashMap)list.get(i)).get("tiGoodScore") == null ? "0":((HashMap)list.get(i)).get("tiGoodScore").toString();
						String tiMediumScore = ((HashMap)list.get(i)).get("tiMediumScore") == null ? "0":((HashMap)list.get(i)).get("tiMediumScore").toString();
						String tiDifferentialScore = ((HashMap)list.get(i)).get("tiDifferentialScore") == null ? "0":((HashMap)list.get(i)).get("tiDifferentialScore").toString();
						int good = 0,medium = 0,differential=0;
						try{
							good = Integer.parseInt(tiGoodScore);
						}
						catch (Exception e){
							
						}
						try{
							medium = Integer.parseInt(tiMediumScore);
						}
						catch (Exception e){
							
						}
						try{
							differential = Integer.parseInt(tiDifferentialScore);
						}
						catch (Exception e){
							
						}	
						int counts = good + medium + differential;
						if (counts == 0){
							((HashMap)list.get(i)).put("tiGoodScorePercent",0);
							((HashMap)list.get(i)).put("tiMediumScorePercent",0);
							((HashMap)list.get(i)).put("tiDifferentialScorePercent",0);
						}
						else{
							int gp =  (good * 100) / counts;
							int mp =  (medium * 100) / counts;
							int dp =  (differential * 100) / counts;
							((HashMap)list.get(i)).put("tiGoodScorePercent",gp);
							((HashMap)list.get(i)).put("tiMediumScorePercent",mp);
							((HashMap)list.get(i)).put("tiDifferentialScorePercent",dp);
						}
					}
				}
			}
			resultData.setList(list);
			resultData.setPaginatedData(paginatedData);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, StudentMyUnfinishedInfoEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
