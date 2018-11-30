package com.ow.framework.data.po;

/**
 * 所有页面元素处理，数据库结果集处理类
 * 只要有页面传参处理和数据库结果集处理
 * 必须继承实现此基类,并在配置文件里配置制定类名称（包括路径）
 * @author allen
 *
 */

public abstract class AbstractBean {
	
	/**
	 * 数据类型
	 * dataType=0 代表是页面传过来的数据
	 * dataType=1 代表是数据库查询结果数据
	 */
	private String dataType;

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}


	
}
