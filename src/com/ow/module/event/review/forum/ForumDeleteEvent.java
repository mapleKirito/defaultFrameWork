package com.ow.module.event.review.forum;

import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ForumDeleteEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ForumDeleteEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			HttpServletResponse resp = ServletActionContext.getResponse();
			PrintWriter out = resp.getWriter();
			JSONObject json = new JSONObject(); 
			String s_userType=eventExecutor.getBaseAction().session.get("s_userType")==null?"":eventExecutor.getBaseAction().session.get("s_userType").toString();
			if(s_userType.equals("3")||s_userType.equals("5")){
				HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
				String sql = eventExecutor.getSqlidByIndex(0);
				eventExecutor.getSqlSession().delete(sql, paramMap);
				json.put("ans", 1);
			}else{
				json.put("ans", 0);
			}
			out.println(json);
			out.flush();
			out.close();
			resultData.setIntResult(1);
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ForumDeleteEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
