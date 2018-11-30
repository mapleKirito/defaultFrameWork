package com.ow.module.event.sysmgr.history;

import org.apache.log4j.Logger;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DBUtil;
import com.ow.framework.util.StringUtil;

public class SelectHistoryNumEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	
	private ResultData resultData;
	public SelectHistoryNumEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String s_userType = eventExecutor.getBaseAction().getParamMap().get("s_userType") == null ? "0" : (String)eventExecutor.getBaseAction().getParamMap().get("s_userType");
			String snNO = StringUtil.intToSN(DBUtil.findSNTo(eventExecutor, "todayonhistory"), 8, "0") ;
			String resNO = "History" + s_userType + "0000" + snNO ;	
			eventExecutor.getBaseAction().getParamMap().put("hitoryNum_", resNO);
			resultData.setIntResult(1);
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, SelectHistoryNumEvent.class);
			log.error(error);
		}
		return resultData;
	}
}