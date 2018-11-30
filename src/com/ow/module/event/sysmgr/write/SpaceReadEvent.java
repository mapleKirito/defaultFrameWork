package com.ow.module.event.sysmgr.write;
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

public class SpaceReadEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SpaceReadEvent()
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
			String sql = eventExecutor.getSqlidByIndex(0);
			HashMap map=(HashMap)eventExecutor.getSqlSession().selectOne(sql, paramMap);
			if(map!=null){
				json.put("title", map.get("aTitle")==null?"":map.get("aTitle").toString());
				json.put("content", map.get("aContent")==null?"":map.get("aContent").toString());
			}
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
