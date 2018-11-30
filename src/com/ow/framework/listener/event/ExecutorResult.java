package com.ow.framework.listener.event;

import java.util.ArrayList;

import com.ow.framework.data.po.ResultData;

public class ExecutorResult {
	/**执行器执行后结果集存放对象*/
	private ArrayList<ResultData> arrayList;

	/**执行器执行事件后，结果
	 * 0:失败 1：成功 2：唯一约束*/
	private String result;
	public ExecutorResult()
	{
		if (arrayList == null)
		{
			arrayList = new ArrayList();
		}
	}
	
	/**
	 * 存放每个事件的执行结果
	 * @param resultData
	 */
	public void putResultData(ResultData resultData)
	{
		arrayList.add(resultData);
	}
	
	/**
	 * 根据索引获取执行结果数据
	 * @param index
	 * @return
	 */
	public ResultData getResultData(int index)
	{
		try{
			return arrayList.get(index);
		}
		catch (Exception e)
		{
			System.out.println("no result date can find");
		}
		return null;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	
	
}
