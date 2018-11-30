package com.ow.module.event.sysmgr;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.PromptInfo;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class UserRetrieveQuestionEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private PromptInfo promptInfo;
	
	public UserRetrieveQuestionEvent()
	{
		resultData = new ResultData();
		promptInfo = new PromptInfo();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap pmap = eventExecutor.getBaseAction().getParamMap();
			String quesTemp = pmap.get("userDicType") == null ? "" : pmap.get("userDicType").toString();
			String ansTemp = pmap.get("userAnswer") == null ? "" : pmap.get("userAnswer").toString();
			String sid = eventExecutor.getSqlidByIndex(0);
			String proinfo = null;
			if (!"".equals(sid))
			{
				List list = eventExecutor.getSqlSession().selectList(sid,pmap);
				if (list != null && list.size() > 0){
					if (list.get(0) instanceof HashMap){
						HashMap vmap = (HashMap)list.get(0);
						String ques = vmap.get("userDicType") == null ? "" : vmap.get("userDicType").toString();
						String ans = vmap.get("userAnswer") == null ? "" : vmap.get("userAnswer").toString();
						if (ques.equals(quesTemp) && !quesTemp.equals("") && !ques.equals("")){
							resultData.setIntResult(1);
						}
						else{
							proinfo = eventExecutor.getPromptInfo(eventExecutor.getBaseAction().getCode(), pmap, eventExecutor.getBaseAction(), "_question");
							promptInfo.setResultDescInfo(proinfo);
							eventExecutor.getBaseAction().setPromptInfo(promptInfo);
							resultData.setIntResult(0);
							return resultData;
						}
						if (ans.equals(ansTemp) && !ansTemp.equals("") && !ans.equals("")){
							resultData.setIntResult(1);
						}
						else{
							proinfo = eventExecutor.getPromptInfo(eventExecutor.getBaseAction().getCode(), pmap, eventExecutor.getBaseAction(), "_answer");							
							promptInfo.setResultDescInfo(proinfo);
							eventExecutor.getBaseAction().setPromptInfo(promptInfo);
							resultData.setIntResult(0);
							return resultData;
						}	
						resultData.setIntResult(1);
					}
				}
				else{
					proinfo = eventExecutor.getPromptInfo(eventExecutor.getBaseAction().getCode(), pmap, eventExecutor.getBaseAction(), "_account");
					promptInfo.setResultDescInfo(proinfo);
					eventExecutor.getBaseAction().setPromptInfo(promptInfo);
					resultData.setIntResult(0);
				}
			}				
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, UserRetrieveQuestionEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
