package com.ow.module.event.sysmgr.gagellery;

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

public class GagelleryDeleteEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public GagelleryDeleteEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			HttpServletResponse resp = ServletActionContext.getResponse();
			PrintWriter out = resp.getWriter();
			JSONObject json = new JSONObject(); 
			String deletegallery = eventExecutor.getSqlidArr()[0];	//查询当前资源ID
			HashMap parmap = eventExecutor.getBaseAction().getParamMap();
			int rvalue = eventExecutor.getSqlSession().delete(deletegallery, parmap);
			resultData.setIntResult(1);
			json.put("flag", rvalue);
			out.println(json);
			out.flush();
			out.close();
			
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, GagelleryDeleteEvent.class);
			log.error(error);
			throw e;
		}
		return resultData;
	}
}