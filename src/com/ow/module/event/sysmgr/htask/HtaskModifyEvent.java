package com.ow.module.event.sysmgr.htask;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class HtaskModifyEvent implements EventListener {
	static Logger log = Logger.getLogger("FRAMEWORK");
	static int gradedefault = 1;
	private ResultData resultData;

	public HtaskModifyEvent() {
		this.resultData = new ResultData(); 
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			/*String update = eventExecutor.getSqlidByIndex(0);
			int rvalue = eventExecutor.getSqlSession().update(update, paramMap);*/

			String htaskIssplit = (String) paramMap.get("htaskIssplit") == null ? "0" : (String) paramMap.get("htaskIssplit");
			paramMap.put("htaskIssplit", htaskIssplit);
			String htaskManyWealthval = (String) paramMap.get("htaskManyWealthval") == null ? "" : (String) paramMap.get("htaskManyWealthval");
			String htaskManyWealthvals[] = htaskManyWealthval.split(",");
			String htaskManyTitle = "",htaskManyContent = "";String htaskManyTitleA[] = null,htaskManyContentA[] = null;
			
			String updateWealth = eventExecutor.getSqlidByIndex(1);
			String nowWealth=(String)paramMap.get("nowWealth")==null||(String)paramMap.get("nowWealth") == "" ? "0" : (String)paramMap.get("nowWealth");
	    	String usedWealth=((String)paramMap.get("usedWealth")==null||(String)paramMap.get("usedWealth") == "") ? "0" : (String)paramMap.get("usedWealth");
	    	String userID=(String)paramMap.get("s_userID") == null ? "" : (String)paramMap.get("s_userID");
			paramMap.put("newWealth", Integer.parseInt(nowWealth)-Integer.parseInt(usedWealth));
	    	paramMap.put("userID", userID);
			eventExecutor.getSqlSession().update(updateWealth,paramMap);
			if (!htaskIssplit.equals("0")) {
				htaskManyTitle = (String) paramMap.get("htaskManyTitle") == null ? "" : (String) paramMap.get("htaskManyTitle");
				htaskManyTitleA = htaskManyTitle.split(",");
				
				htaskManyContent = (String)paramMap.get("htaskManyContent") == null ? "" : (String)paramMap.get("htaskManyContent");
	    		htaskManyContentA = htaskManyContent.split(",");
				
				paramMap.put("htaskUserCreate", paramMap.get("s_userID"));
				eventExecutor.getSqlSession().update("histask.update", paramMap);
				paramMap.put("htaskSplitID", paramMap.get("htaskID"));
			} else {
				paramMap.put("htaskIssplit", "0");
				paramMap.put("htaskSplitID", null);

				int a = 0, b = 0,c=0;
				Object objdefauWealth = paramMap.get("defauWealth");
				Object objhtaskWealthval = paramMap.get("htaskWealthval");
				Object beforeobjhtaskWealthval = paramMap.get("htaskWealthvalatu");
				if (objdefauWealth != null && objhtaskWealthval != null) {
					a = Integer.parseInt((String) objdefauWealth);
					b = Integer.parseInt((String) objhtaskWealthval);
					c = Integer.parseInt((String) beforeobjhtaskWealthval);
				}

				paramMap.put("htaskWealthval", a + b+c);
				paramMap.put("htaskUserCreate", paramMap.get("s_userID"));
				eventExecutor.getSqlSession().update("histask.update", paramMap);
			}

			if (htaskManyTitleA != null) {
				eventExecutor.getSqlSession().update("histask.delete_splitid", paramMap);
				for (int a = 0; a < htaskManyTitleA.length; a++) {
					paramMap.put("htaskTitle", htaskManyTitleA[a].trim());
	        		paramMap.put("htaskContent", htaskManyContentA[a].trim());
	        		paramMap.put("htaskWealthval", htaskManyWealthvals[a]);
	        		paramMap.put("htaskIssplit", "0");
	        		paramMap.put("htaskSplitIndex", (a+1));
	        		paramMap.put("htaskUserCreate", paramMap.get("s_userID"));
	        		paramMap.remove("htaskKeywords");
					eventExecutor.getSqlSession().insert("histask.insert", paramMap);
				}
			}

			this.resultData.setIntResult(1);

			return this.resultData;
		} catch (Exception e) {
			this.resultData.setIntResult(0);
			String error = DetailException.expDetail(e, HtaskModifyEvent.class);
			log.error(error);
		}
		return this.resultData;
	}
}