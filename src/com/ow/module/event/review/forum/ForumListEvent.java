package com.ow.module.event.review.forum;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import java_cup.internal_error;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class ForumListEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ForumListEvent() {
		resultData = new ResultData();
	}
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			HttpServletResponse resp = ServletActionContext.getResponse();
			PrintWriter out = resp.getWriter();
			JSONObject json = new JSONObject(); 
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String sql1 = eventExecutor.getSqlidByIndex(0);
			String sql2 = eventExecutor.getSqlidByIndex(1);
			String sql3 = eventExecutor.getSqlidByIndex(2);
			String sql4 = eventExecutor.getSqlidByIndex(3);
			
			int start_num=0;
			String sql=sql1;
			String tag=paramMap.get("tag")==null?"":paramMap.get("tag").toString();
			String pagesize=paramMap.get("pagesize")==null?"":paramMap.get("pagesize").toString();
			if(tag.equals("last")){
				sql=sql2;
			}
			if(tag.equals("page")){
				sql=sql3;
				if(pagesize!=""){
					start_num+=(Integer.parseInt(pagesize)-1)*10;
				}
				paramMap.put("start_num", start_num);
				paramMap.put("offset_num", 10);
			}
			Object count=eventExecutor.getSqlSession().selectOne(sql4,paramMap);
			if(count!=null){
				json.put("count", (Integer)count);
				json.put("pages", (Integer)count/10==0?(Integer)count/10:(Integer)count/10+1);
			}
			List list=eventExecutor.getSqlSession().selectList(sql, paramMap);
			for (Object map1 : list) {
				
				((HashMap)map1).put("time", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(((HashMap)map1).get("srTime")).toString());
				if(((HashMap)map1).get("srSpaceImg")!=null){
					((HashMap)map1).put("srSpaceImg", ((HashMap)map1).get("srSpaceImg"));
				}else{
					if(((HashMap)map1).get("userType").toString().equals("1")){
						((HashMap)map1).put("srSpaceImg", "images/index/teacher.png");
					}
					else if(((HashMap)map1).get("userType").toString().equals("2")){
						((HashMap)map1).put("srSpaceImg", "images/index/student.png");
					}
					else if(((HashMap)map1).get("userType").toString().equals("4")){
						((HashMap)map1).put("srSpaceImg", "images/index/group.png");
					}
					else{
						((HashMap)map1).put("space_img", "images/index/manager.png");
					}
				}
			}
			json.put("data", list);
			resultData.setIntResult(1);
			out.println(json);
			out.flush();
			out.close();
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ForumListEvent.class);
			log.error(error);
		}
		return resultData;
	}

}
