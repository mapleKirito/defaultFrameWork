package com.ow.module.event.teacher;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.listener.event.impl.SelectOneEvent;



/**
 * 分页方法 
 * rlist 返回结果集
 * obj   对应结果集数量
 * @author sunny
 *
 */
public class UserResLike implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public UserResLike()
	{
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			String sidCount = eventExecutor.getSqlidByIndex(1);
			HashMap map = eventExecutor.getBaseAction().getParamMap();
			String s_userID=eventExecutor.getBaseAction().session.get("s_userID")==null?"":eventExecutor.getBaseAction().session.get("s_userID").toString();
			
			if (!"".equals(sid) && !"".equals(sidCount))
			{
				map.put("ruserid", s_userID);
				map.put("userID", s_userID);
				String tmp_sql="user_info.select_by_userid";
				HashMap tmp_map=(HashMap)eventExecutor.getSqlSession().selectOne(tmp_sql, map);
				
				String str=tmp_map.get("resLike").toString();
				String[] str_=str.split(",");
				String values="";
				for (String string : str_) {
					values+="or rt.rname like '%"+string+"%' ";
				}
				values="and ("+values.substring(values.indexOf("rt"))+")";
				map.put("values", values);
				
				List rlist = eventExecutor.getSqlSession().selectList(sid, map);
				Object obj = eventExecutor.getSqlSession().selectOne(sidCount,eventExecutor.getBaseAction().getParamMap());
				resultData.setList(rlist);
				int cnt = 0;
				if (obj instanceof Integer)
					cnt = ((Integer)obj).intValue();
				eventExecutor.getPaginatedData().setRecordCount(cnt);
				resultData.setPaginatedData(eventExecutor.getPaginatedData());
			}				
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SelectOneEvent.class);
			log.error(error);
			throw e;
		}
	}

}
