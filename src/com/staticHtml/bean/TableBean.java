package com.staticHtml.bean;

public class TableBean {

	String tableName;
	String tableValue;
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getTableValue() {
		return tableValue;
	}
	public void setTableValue(String tableValue) {
		this.tableValue = tableValue;
	}
	public TableBean(String tableName, String tableValue) {
		super();
		this.tableName = tableName;
		this.tableValue = tableValue;
	}
	
	
	
	
}
