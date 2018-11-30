package com.ow.framework.data.po;

import java.util.HashMap;

public class ImitationStepData {

	/**模拟步骤时的权限代码*/
	private String code;
	/**模拟步骤时的目标文件*/
	private String directFile;	
	/**模拟步骤时的参数对象*/
	private HashMap<String,String> paramMap;	
	
	public ImitationStepData()
	{
		
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDirectFile() {
		return directFile;
	}

	public void setDirectFile(String directFile) {
		this.directFile = directFile;
	}

	public HashMap<String, String> getParamMap() {
		return paramMap;
	}

	public void setParamMap(HashMap<String, String> paramMap) {
		this.paramMap = paramMap;
	}
}
