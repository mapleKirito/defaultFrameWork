package com.ow.module.event.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class AjaxAddCategoryByCode implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	public AjaxAddCategoryByCode() {
		resultData = new ResultData();
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try {
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String cateName=new String(paramMap.get("cateName").toString().getBytes("ISO-8859-1"),"utf-8");
			paramMap.put("cateName", cateName);
			Object count=eventExecutor.getSqlSession().selectOne("category.select_has_sameCate", paramMap);
			List rlistback =null;
			if(((Integer)count)>0){
				rlistback=new ArrayList<String>();
			}else{
				String path = (String) paramMap.get("npath");
				eventExecutor.getSqlSession().insert("category.insert",paramMap);
				paramMap.put("cateID", eventExecutor.getBaseAction().getParamMap().get("generatedKey"));
				paramMap.put("catePath", path+""+paramMap.get("cateID")+",");
				eventExecutor.getSqlSession().update("category.update_status",paramMap);
				eventExecutor.getSqlSession().update("category.update_catePath",paramMap);
				paramMap.put("y_cateParentID", paramMap.get("cateParentID"));
				eventExecutor.getSqlSession().update("category.update_ischild_y",paramMap);
				rlistback = eventExecutor.getSqlSession().selectList("category.select_by_id", paramMap);
			}	
			resultData.setList(rlistback);
			return this.resultData;
		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e,
					AjaxAddCategoryByCode.class);
			log.error(error);
		}
		return resultData;
	}
}
