package com.ow.module.event.sysmgr;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class ParamInsertEvent implements EventListener{

	
	/**异常处理*/
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData = new ResultData();
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {

		try
		{ 
			HashMap paramMap = new HashMap();
			String parNameArr,parValueArr,parDescArr = null;
			paramMap = eventExecutor.getBaseAction().getParamMap();
			String deletesid = eventExecutor.getSqlidByIndex(0);
			String insertsid = eventExecutor.getSqlidByIndex(1);
			/**清空表内容*/
			if (!"".equals(deletesid))
			{
				eventExecutor.getSqlSession().delete(deletesid, eventExecutor.getBaseAction().getParamMap());
			}				
			parNameArr = paramMap.get("parName")==null?"":paramMap.get("parName").toString();
			parValueArr = paramMap.get("parValue")==null?"":paramMap.get("parValue").toString();
			parDescArr = paramMap.get("parDesc")==null?"":paramMap.get("parDesc").toString();
			String[] parNameArrSplit = parNameArr.split(",");
			String[] parValueArrSplit = parValueArr.split(",");
			String[] parDescArrSplit = parDescArr.split(",");
			/**重新插入新数据*/
			if (!"".equals(insertsid)){
				for(int i = 0 ; i < parNameArrSplit.length ; i ++){
					String parName = parNameArrSplit[i] ==null?"":parNameArrSplit[i].trim();
					String parValue = parValueArrSplit[i] ==null?"":parValueArrSplit[i].trim();
					String parDesc = parDescArrSplit[i] ==null?"":parDescArrSplit[i].trim();
					if(!parName.equals("") && !parValue.equals("")){
						eventExecutor.getBaseAction().getParamMap().put("parDesc",parDescArrSplit[i].trim());						
						eventExecutor.getBaseAction().getParamMap().put("parName",parNameArrSplit[i].trim());
						eventExecutor.getBaseAction().getParamMap().put("parValue",parValueArrSplit[i].trim());
						int rvalue = eventExecutor.getSqlSession().insert(insertsid, eventExecutor.getBaseAction().getParamMap());
						resultData.setIntResult(1);
					}
				}
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			/**执行器执行失败*/
			String error = DetailException.expDetail(e, PasswordModifyEvent.class);
			log.error(error);
			throw e;
		}
	}
}
