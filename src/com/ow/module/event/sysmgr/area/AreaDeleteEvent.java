package com.ow.module.event.sysmgr.area;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;

public class AreaDeleteEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;

	public AreaDeleteEvent() {
		resultData = new ResultData();
	}

	public ResultData event(EventExecutor eventExecutor) throws Exception {
		// 分两步:首先删除当前记录及其相关记录(所有资源记录)，
		// 然后查询当前记录的父节点是否还有子地区
		// 如果有，则不进行任何操作。否则，父节点的isChild字段值为0
		try {
			String deleteCategory = eventExecutor.getSqlidByIndex(0);
			String areaUpdate = eventExecutor.getSqlidByIndex(1);
			String areaCount = eventExecutor.getSqlidByIndex(2);
			String areaOne = eventExecutor.getSqlidByIndex(3);
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			
			//Object area = eventExecutor.getSqlSession().selectOne(areaOne,paramMap);
			eventExecutor.getSqlSession().delete(deleteCategory, paramMap);
			HashMap paramerMap = new HashMap() ;
			paramerMap.put("areaPath",paramMap.get("areaParentID"));
			int number = (Integer) eventExecutor.getSqlSession().selectOne(areaCount, paramerMap);
			if (number == 1) {
				// 父类地区的isChild字段变为1
				paramerMap.put("areaID",paramMap.get("areaParentID"));
				paramerMap.put("areaIsChild", "0");
				eventExecutor.getSqlSession().update(areaUpdate, paramerMap);
			}
			resultData.setIntResult(1);
			return resultData;

		} catch (Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, AreaDeleteEvent.class);
			log.error(error);
			throw e;
		}

	}

}
