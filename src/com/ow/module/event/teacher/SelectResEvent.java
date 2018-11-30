package com.ow.module.event.teacher;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class SelectResEvent implements EventListener{
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public SelectResEvent()
	{
		resultData = new ResultData();
	}		 
	@SuppressWarnings("rawtypes")
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			
			String userId=eventExecutor.getBaseAction().session.get("s_userID")==null?"":eventExecutor.getBaseAction().session.get("s_userID").toString();
			String userName=eventExecutor.getBaseAction().session.get("s_userLoginName")==null?"":eventExecutor.getBaseAction().session.get("s_userLoginName").toString();
			if(userId==null||userId==""){
				System.out.println("没有用户session信息");
				return resultData;
			}
			
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			String s_start=map.get("s_start")==null?"0":map.get("s_start").toString();
			map.put("start", s_start);
			map.put("offset", 10);
			String tag=map.get("tag")==null?"":map.get("tag").toString();
			String tableName=map.get("tableName")==null?"":map.get("tableName").toString();
			String sid = eventExecutor.getSqlidByIndex(0);
			map.put("ruserid", userId);
			map.put("userID", userId);
					String tmp_sql="user_info.select_by_userid";
					HashMap tmp_map=(HashMap)eventExecutor.getSqlSession().selectOne(tmp_sql, map);
				
					if(!(tmp_map.get("resLike")!=null&&!tmp_map.get("resLike").toString().equals(""))){
						List<HashMap<String, Object>> list = new ArrayList();
						resultData.setList(list);
					}else{
						String str=tmp_map.get("resLike").toString();
						String[] str_=str.split(",");
						String values="";
						for (String string : str_) {
							values+="or rt.rname like '%"+string+"%' ";
						}
						values="and ("+values.substring(values.indexOf("rt"))+")";
						map.put("values", values);
						List<HashMap<String, Object>> list = eventExecutor.getSqlSession().selectList(sid, map);
						for (HashMap<String, Object> map1 : list) {
							map1.put("content", map1.get("rName"));
							map1.put("userName", map1.get("userName"));
							map1.put("time", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(((HashMap)map1).get("rCreatetime")).toString());
							map1.put("type", map1.get("rType"));
							map1.put("tableName", map1.get("rTable"));
							map1.put("rID", map1.get("Id"));
						}
						resultData.setList(list);
					}
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
