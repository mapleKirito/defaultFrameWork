package com.ow.module.event.teacher;

import java.io.PrintWriter;
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




public class UpdateEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public UpdateEvent()
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
			String[] sid = eventExecutor.getSqlidArr();
			int ans=0;
			for(int i = 0 ; i < sid.length; i ++){
				if (sid[i] != null && !sid[i].equals(""))
				{
					ans=eventExecutor.getSqlSession().update(sid[i], eventExecutor.getBaseAction().getParamMap());
					resultData.setIntResult(1);
				}		
			}
			json.put("flag", ans);
			resultData.setIntResult(1);
			out.println(json);
			out.flush();
			out.close();
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, UpdateEvent.class);
			log.error(error);
			throw e;
		}
	}
}
