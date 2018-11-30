package com.ow.module.event.sysmgr.gagellery;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.UploadDataAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
public class GagelleryModifyEvent  implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	static int gradedefault = 001; 
	private ResultData resultData;
	public GagelleryModifyEvent() {
		resultData = new ResultData();
	}
	@SuppressWarnings({ "unused", "rawtypes" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String update = eventExecutor.getSqlidByIndex(0);
				if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
					int rvalue = eventExecutor.getSqlSession().update(update,paramMap);
					resultData.setIntResult(1);
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, GagelleryModifyEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
