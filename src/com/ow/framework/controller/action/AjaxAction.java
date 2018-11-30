package com.ow.framework.controller.action;

import java.util.ArrayList;
import java.util.List;

import com.ow.framework.data.handler.config.PermissionConfig;
import com.ow.framework.data.po.PaginatedData;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.ExecutorResult;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class AjaxAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4643555457909937907L;
	private List data;
	private Object singleData;//这个变量用来传非list的值
	private PaginatedData paginatedData;
	private int success = 0;
	private ResultData resultData;
	//程序设置树形列表根起点值
	private int treeNodeStartValue = -1;
	
	public String subExecute() throws Exception {
		try {
			ExecutorResult er = this.eventExecutor.generalEventExecutor();
			this.data = er.getResultData(0) == null?new ArrayList():er.getResultData(0).getList();
			this.resultData =  er.getResultData(0);
			this.success = er.getResultData(0) == null?0:er.getResultData(0).getIntResult();
			this.singleData = er.getResultData(0) == null?new ArrayList():er.getResultData(0).getOne();
			this.paginatedData = er.getResultData(0)==null?new PaginatedData():er.getResultData(0).getPaginatedData();
			this.treeNodeStartValue = er.getResultData(0) == null?0:er.getResultData(0).getTreeNodeStartValue();
			return IAction.SUCCESS;
		} catch (Exception e) {
			String error = DetailException.expDetail(e, PermissionConfig.class);
			log.error(error);
			return IAction.FAIL;
		}		
	}


	public List getData() {
		return data;
	}


	public void setData(List data) {
		this.data = data;
	}


	public PaginatedData getPaginatedData() {
		return paginatedData;
	}


	public void setPaginatedData(PaginatedData paginatedData) {
		this.paginatedData = paginatedData;
	}


	public Object getSingleData() {
		return singleData;
	}


	public void setSingleData(Object singleData) {
		this.singleData = singleData;
	}


	public int getSuccess() {
		return success;
	}


	public void setSuccess(int success) {
		this.success = success;
	}


	public int getTreeNodeStartValue() {
		return treeNodeStartValue;
	}


	public void setTreeNodeStartValue(int treeNodeStartValue) {
		this.treeNodeStartValue = treeNodeStartValue;
	}


	public ResultData getResultData() {
		return resultData;
	}


	public void setResultData(ResultData resultData) {
		this.resultData = resultData;
	}
	
}
