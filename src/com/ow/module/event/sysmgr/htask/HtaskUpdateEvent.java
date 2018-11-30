package com.ow.module.event.sysmgr.htask;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class HtaskUpdateEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public HtaskUpdateEvent()
	{
		resultData = new ResultData();
	}		
	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			
			Object isAccpetEnd = eventExecutor.getSqlSession().selectOne("histask.select_end_max", eventExecutor.getBaseAction().getParamMap());
			String htaskSplitIndex = eventExecutor.getBaseAction().getParamMap().get("htaskSplitIndex");
			if(isAccpetEnd!=null && !htaskSplitIndex.equals("")){
				if((Integer)isAccpetEnd == Integer.parseInt(htaskSplitIndex)){
					eventExecutor.getSqlSession().update("histask.update_isAccpet_end", eventExecutor.getBaseAction().getParamMap());
				}
			}
			
			String[] sid = eventExecutor.getSqlidArr();
			for(int i = 0 ; i < sid.length; i ++){
				if (sid[i] != null && !sid[i].equals(""))
				{
					eventExecutor.getSqlSession().update(sid[i], eventExecutor.getBaseAction().getParamMap());
					resultData.setIntResult(1);
				}		
			}
			
			String ishtaskIssplit = eventExecutor.getBaseAction().getParamMap().get("ishtaskIssplit");
			if(ishtaskIssplit!=null&&!ishtaskIssplit.equals("1")){
				eventExecutor.getSqlSession().update("histask.update_isAccpet_o", eventExecutor.getBaseAction().getParamMap());
			}
			
			String addWealht="user_info.add_wealth";
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("userID", eventExecutor.getBaseAction().getParamMap().get("ansUID"));
			map.put("newWealth", eventExecutor.getBaseAction().getParamMap().get("addWealth"));
			eventExecutor.getSqlSession().update(addWealht, map);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, HtaskUpdateEvent.class);
			log.error(error);
			throw e;
		}
	}
}
