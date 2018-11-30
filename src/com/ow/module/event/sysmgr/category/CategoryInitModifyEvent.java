package com.ow.module.event.sysmgr.category;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;




public class CategoryInitModifyEvent implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public CategoryInitModifyEvent()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String sid = eventExecutor.getSqlidByIndex(0);
			String spid = eventExecutor.getSqlidByIndex(1);
			if (!"".equals(sid))
			{
				Object one = eventExecutor.getSqlSession().selectOne(sid, eventExecutor.getBaseAction().getParamMap());
				Object pobj = eventExecutor.getSqlSession().selectOne(spid, eventExecutor.getBaseAction().getParamMap());
				if (one instanceof HashMap){
					String name = null;
					if (pobj instanceof HashMap){
						name = ((HashMap)pobj).get("cateName") == null? "设为顶级分类" : ((HashMap)pobj).get("cateName").toString();
					}
					else{
						name = "设为顶级分类";
					}
					((HashMap)one).put("cateParentName", name);
				}
				resultData.setOne(one);
			}				
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, CategoryInitModifyEvent.class);
			log.error(error);
			throw e;
		}
		return resultData;
	}

}
