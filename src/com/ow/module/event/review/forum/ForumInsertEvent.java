package com.ow.module.event.review.forum;

import java.io.PrintWriter;
import java.net.URLDecoder;
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
import com.ow.framework.util.FileHelper;
import com.ow.framework.util.StringUtil;

public class ForumInsertEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ForumInsertEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			HttpServletResponse resp = ServletActionContext.getResponse();
			PrintWriter out = resp.getWriter();
			JSONObject json = new JSONObject(); 
			String code = (String) eventExecutor.getBaseAction().session.get("rand");
			
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String dCode = paramMap.get("code")==null?"":paramMap.get("code").toString();
			String de = paramMap.get("de")==null?"":paramMap.get("de").toString();
			
			String pname_ = paramMap.get("resURL") == null? "" : paramMap.get("resURL").toString();

			String param_[] = {"code","path","paramMap.roomtype","paramMap.st","paramMap.name","paramMap.rfResType","pid"};
			String url = "";
			String pname[] = pname_.split("\\|");
			String url_ = ""; 
					
			for(int i=0;i<pname.length;i++){
				if(pname[i]!=null && !pname[i].equals("")){
					
					if(FileHelper.isMessyCode(pname[i])){
						pname[i] = new String(pname[i].toString().getBytes("ISO-8859-1"),"utf-8");
					}
					
					if(param_[i].equals("pid"))
						url_+="&"+"paramMap."+StringUtil.reResAbbreviated(pname[2])+"ID"+"="+pname[i];
					else
						url_+="&"+param_[i]+"="+pname[i];
					
				}
			}
			url += url_.replaceFirst("&", "").trim()+"&";
			paramMap.put("srResUrl", url);
			
			if(de.equals("1")){
				if(dCode.equals(code)){	
					String txtAreaObj=paramMap.get("srContent")==null?"":paramMap.get("srContent").toString();
					txtAreaObj = URLDecoder.decode(txtAreaObj, "UTF-8"); 
					paramMap.put("srContent", txtAreaObj);
					String sql = eventExecutor.getSqlidByIndex(0);
					eventExecutor.getSqlSession().insert(sql, paramMap);
					int tmp=(Integer)paramMap.get("generatedKey");
					resultData.setIntResult(1);
					json.put("ans", 1);
				}else{
					json.put("ans", 2);
				}
			}else{
				String txtAreaObj=paramMap.get("srContent")==null?"":paramMap.get("srContent").toString();
				txtAreaObj = URLDecoder.decode(txtAreaObj, "UTF-8"); 
				paramMap.put("srContent", txtAreaObj);
				String sql = eventExecutor.getSqlidByIndex(0);
				eventExecutor.getSqlSession().insert(sql, paramMap);
				int tmp=(Integer)paramMap.get("generatedKey");
				resultData.setIntResult(1);
				json.put("ans", 1);
			}
			
			
			
			
			out.println(json);
			out.flush();
			out.close();
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ForumInsertEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
