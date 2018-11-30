package com.ow.module.event.space;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.SelectListEvent;

public class SpaceAttentionAjaxEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SpaceAttentionAjaxEvent()
	{
		resultData = new ResultData();
	}	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			HttpServletResponse resp = ServletActionContext.getResponse();
			PrintWriter out = resp.getWriter();
			JSONObject json = new JSONObject(); 
			
			String sqlIns = eventExecutor.getSqlidByIndex(0);
			String sqlDel = eventExecutor.getSqlidByIndex(1);
			String sid="";
			String userId=eventExecutor.getBaseAction().session.get("s_userID")==null?"":eventExecutor.getBaseAction().session.get("s_userID").toString();
			if(userId==null||userId==""){
				System.out.println("没有用户session信息");
				return resultData;
			}
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			map.put("userID", userId);
			String attentionType=map.get("attentionType").toString();
			int ans=0;
			if(attentionType.equals("add")){
				sid=sqlIns;
				ans=eventExecutor.getSqlSession().insert(sid, map);
			}else if(attentionType.equals("remove")){
				sid=sqlDel;
				ans=eventExecutor.getSqlSession().delete(sid, map);
			}
			String userID=map.get("userID")==null?"":map.get("userID").toString();
			resultData.setIntResult(1);
			json.put("flag", ans);
			out.println(json);
			out.flush();
			out.close();
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SelectListEvent.class);
			log.error(error);
			throw e;
		}
	}
}
