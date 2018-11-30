package com.ow.framework.data.po;

import java.util.List;

public class ResultData {
	
	/**整数返回值 登录中 1 成功，0 失败*/
    private int intResult = 0;
    /**列表返回值*/
    private List list;
    /**单条返回值*/
    private Object one;    
    private String content;
    /**分页参数对象*/
    private PaginatedData paginatedData;
    /**树形列表根起始点值*/
    private int treeNodeStartValue = -1;
    public ResultData()
    {
    	
    }
    
	public int getIntResult() {
		return intResult;
	}
	public void setIntResult(int intResult) {
		this.intResult = intResult;
	}
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}

	public Object getOne() {
		return one;
	}

	public void setOne(Object one) {
		this.one = one;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public PaginatedData getPaginatedData() {
		return paginatedData;
	}

	public void setPaginatedData(PaginatedData paginatedData) {
		this.paginatedData = paginatedData;
	}

	public int getTreeNodeStartValue() {
		return treeNodeStartValue;
	}

	public void setTreeNodeStartValue(int treeNodeStartValue) {
		this.treeNodeStartValue = treeNodeStartValue;
	}
	
}
