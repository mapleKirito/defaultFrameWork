package com.ow.module.event.sysmgr.category;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class CategoryDeleteEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	public CategoryDeleteEvent() {
		resultData = new ResultData();
	}

	public ResultData event(EventExecutor eventExecutor) throws Exception {
		// 分两步:首先删除当前记录及其相关记录(所有资源记录)，
		// 然后查询当前记录的父节点是否还有子分类
		// 如果有，则不进行任何操作。否则，父节点的isChild字段值为0
		try {
			String deleteCategory = eventExecutor.getSqlidByIndex(0);
			String categoryUpdate = eventExecutor.getSqlidByIndex(1);
			String categoryCount = eventExecutor.getSqlidByIndex(2);
			String categoryOne = eventExecutor.getSqlidByIndex(3);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			
			//Object category = eventExecutor.getSqlSession().selectOne(categoryOne,paramMap);
			eventExecutor.getSqlSession().delete(deleteCategory, paramMap);
			HashMap paramerMap = new HashMap() ;
			paramerMap.put("catePath",paramMap.get("cateParentID"));
			int number = (Integer) eventExecutor.getSqlSession().selectOne(categoryCount, paramerMap);
			if (number == 1) {
				// 父类分类的isChild字段变为1
				paramerMap.put("cateID",paramMap.get("cateParentID"));
				paramerMap.put("cateIsChild", "0");
				eventExecutor.getSqlSession().update(categoryUpdate, paramerMap);
			}
			resultData.setIntResult(1);
			return resultData;

		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, CategoryDeleteEvent.class);
			log.error(error);
			throw e;
		}

	}

}
