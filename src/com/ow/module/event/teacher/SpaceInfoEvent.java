package com.ow.module.event.teacher;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class SpaceInfoEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	
	public SpaceInfoEvent()
	{
		resultData = new ResultData();
	}	
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			String sql_attention="user_attention.select_by_userid";
			String s_userID=eventExecutor.getBaseAction().session.get("s_userID")==null?"":eventExecutor.getBaseAction().session.get("s_userID").toString();
			HashMap<String, String> map = eventExecutor.getBaseAction().getParamMap();
			String targetID=map.get("userID");
			if (!"".equals(sid))
			{
				Object one = eventExecutor.getSqlSession().selectOne(sid, map);
				((HashMap<String, Object>)one).put("attention", "0");
				List list=eventExecutor.getSqlSession().selectList(sql_attention, map);
				for (Object obj : list) {
					HashMap<String, Object> tmp=(HashMap<String, Object>)obj;
					if(tmp.get("userID").toString().equals(s_userID)&&tmp.get("targetID").toString().equals(targetID)){
						((HashMap<String, Object>)one).put("attention", "1");
					}
				}
				
				resultData.setOne(one);
			}				
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, SpaceInfoEvent.class);
			log.error(error);
			throw e;
		}
	}

}
