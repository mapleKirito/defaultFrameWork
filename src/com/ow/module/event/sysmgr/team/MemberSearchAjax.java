package com.ow.module.event.sysmgr.team;
import java.io.PrintWriter;
import java.net.URLDecoder;
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

public class MemberSearchAjax implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public MemberSearchAjax()
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
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String name=paramMap.get("name")==null?"":(String)(paramMap.get("name"));
			name=URLDecoder.decode(name, "UTF-8");
			paramMap.put("name", name);
			String sql = eventExecutor.getSqlidByIndex(0);
			List list=eventExecutor.getSqlSession().selectList(sql, paramMap);
			json.put("list", list);
			resultData.setIntResult(1);
			out.println(json);
			out.flush();
			out.close();
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SelectListEvent.class);
			log.error(error);
			throw e;
		}
		return resultData;
	}
}
