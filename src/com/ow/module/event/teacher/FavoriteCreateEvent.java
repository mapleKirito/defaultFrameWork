package com.ow.module.event.teacher;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class FavoriteCreateEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public FavoriteCreateEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String iid = eventExecutor.getSqlidByIndex(0);
			String uid = eventExecutor.getSqlidByIndex(1);
			String upid = eventExecutor.getSqlidByIndex(2);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			if (!"".equals(iid))
			{
				paramMap.put("rfType", 0);
				String rfParentId = paramMap.get("rfParentId") == null?"0":paramMap.get("rfParentId").toString();
				if (rfParentId != null && rfParentId.equals("0")){
					String rpSelectVal = paramMap.get("rfSelectName") == null?"":paramMap.get("rfSelectName").toString();
					String rpSelectText = paramMap.get("selectText") == null?"":paramMap.get("selectText").toString();
					eventExecutor.getBaseAction().getParamMap().put("rfName", rpSelectText);
					eventExecutor.getBaseAction().getParamMap().put("rfSort", rpSelectVal);
					eventExecutor.getBaseAction().getParamMap().put("rfIsChild", "0");
					eventExecutor.getSqlSession().insert(iid, paramMap);
					if (paramMap.get("generatedKey") != null){
						paramMap.put("rfId", paramMap.get("generatedKey").toString());
						paramMap.put("rfPath", ",0," +  paramMap.get("generatedKey").toString() + ",");
					}
					//更新path和ischild
					eventExecutor.getSqlSession().update(uid, paramMap);
				}
				else{
					String path = paramMap.get("rfPath") == null? "":paramMap.get("rfPath").toString();
					String level = paramMap.get("rfLevel") == null? "":paramMap.get("rfLevel").toString();
					paramMap.put("rfIsPath", "1");
					paramMap.put("rfIsChild", "0");
					paramMap.put("rfLevel", Integer.parseInt(level) + 1);
					eventExecutor.getSqlSession().insert(iid, paramMap);
					if (paramMap.get("generatedKey") != null){
						paramMap.put("rfId", paramMap.get("generatedKey").toString());
						paramMap.put("rfPath", path +  paramMap.get("generatedKey").toString() + ",");
					}
					//更新path和ischild
					eventExecutor.getSqlSession().update(uid, paramMap);
					paramMap.put("rfIsChild", "1");
					//修改上级ischild为1
					eventExecutor.getSqlSession().update(upid, paramMap);
				}
				resultData.setIntResult(1);
			}				
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, FavoriteCreateEvent.class);
			log.error(error);
			throw e;
		}
		return resultData;
	}

}
