package com.ow.framework.data.handler.config;

public class Permission {
	private String index;
	private String code;
	private String parentCode;
	private String type;
	private String name;
	private String isValid;
	private String dataSource;
	private String isTransaction;
	private String initEvent;
	private String defaultEvent;
	private String extendEvent;
	private String icon;
	private String directName;
	private String imitationStep;
	private String dataHandlerBean;
	private String beforeExecuteCode;
	private String afterExecuteCode;
	private String paixu;

	public String getPaixu() {
		return paixu;
	}

	public void setPaixu(String paixu) {
		this.paixu = paixu;
	}

	public Permission() {
		super();
	}

	public String getIndex() {
		return index;
	}

	public void setIndex(String index) {
		this.index = index;
	}

	public String getBeforeExecuteCode() {
		return beforeExecuteCode;
	}

	public void setBeforeExecuteCode(String beforeExecuteCode) {
		this.beforeExecuteCode = beforeExecuteCode;
	}

	public String getAfterExecuteCode() {
		return afterExecuteCode;
	}

	public void setAfterExecuteCode(String afterExecuteCode) {
		this.afterExecuteCode = afterExecuteCode;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIsValid() {
		return isValid;
	}

	public void setIsValid(String isValid) {
		this.isValid = isValid;
	}

	public String getDataSource() {
		return dataSource;
	}

	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	public String getIsTransaction() {
		return isTransaction;
	}

	public void setIsTransaction(String isTransaction) {
		this.isTransaction = isTransaction;
	}

	public String getInitEvent() {
		return initEvent;
	}

	public void setInitEvent(String initEvent) {
		this.initEvent = initEvent;
	}

	public String getDefaultEvent() {
		return defaultEvent;
	}

	public void setDefaultEvent(String defaultEvent) {
		this.defaultEvent = defaultEvent;
	}

	public String getExtendEvent() {
		return extendEvent;
	}

	public void setExtendEvent(String extendEvent) {
		this.extendEvent = extendEvent;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getDirectName() {
		return directName;
	}

	public void setDirectName(String directName) {
		this.directName = directName;
	}

	public String getImitationStep() {
		return imitationStep;
	}

	public void setImitationStep(String imitationStep) {
		this.imitationStep = imitationStep;
	}

	public String getDataHandlerBean() {
		return dataHandlerBean;
	}

	public void setDataHandlerBean(String dataHandlerBean) {
		this.dataHandlerBean = dataHandlerBean;
	}
}
