package com.ow.framework.listener.event.impl;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.ow.framework.data.po.ResultData;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class PreparingCenterTop implements EventListener{
	@Override
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		HttpServletResponse resp = ServletActionContext.getResponse();
		PrintWriter out = resp.getWriter();
		JSONObject json = new JSONObject(); 
		
		HashMap<String, String> map = eventExecutor.getBaseAction().getParamMap();
		String have = map.get("istophave") == null ? "" : map.get("istophave");
		
		Object one = eventExecutor.getSqlSession().selectOne("user.select_by_session_account",map);
		String path = "";
		if(((HashMap)one).get("userCenterPath") != null){
			path = ((HashMap)one).get("userCenterPath").toString();
		}
		
		if(!have.equals("") && "".equals(path)){
			json.put("is1","yespath");
		}else if(!"".equals(path) && have.equals("")){
			openExe(path,json);
		}else{
			json.put("is1","false");
		}
		
		out.println(json);
		out.flush();
		out.close();
		
		return null;
	}
	@SuppressWarnings("unused")
	public static void openExe(String  filePath,JSONObject json) {		
		if(filePath != null){
			Runtime rn = Runtime.getRuntime();
			Process p = null;
			try {
				p = rn.exec("\""+filePath+"\"");	
			} catch (Exception e) {
				json.put("is1","startfail");
			}
		}else{
			json.put("is1","nopath");
			json.put("is2",filePath);
		}
	}
}
