package com.expansion.bean;

import java.io.Serializable;

public class VersionBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2362339966090264400L;
	
	private String version;
	private String updateURL;
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getUpdateURL() {
		return updateURL;
	}
	public void setUpdateURL(String updateURL) {
		this.updateURL = updateURL;
	}
	
	

}
