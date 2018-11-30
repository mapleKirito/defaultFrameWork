/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ow.framework.data.po;



/**
 *
 * @author Administrator
 */
public class PromptInfo extends AbstractBean{	
	private static final long serialVersionUID = -69801047232224262L;

	private String resultDescInfo;
	private String totalDescInfo;
	private String contentDescInfo;
	private String helpDescInfo;
	
	public PromptInfo()
    {    	
    }

	public String getResultDescInfo() {
		return resultDescInfo;
	}

	public void setResultDescInfo(String resultDescInfo) {
		this.resultDescInfo = resultDescInfo;
	}

	public String getTotalDescInfo() {
		return totalDescInfo;
	}

	public void setTotalDescInfo(String totalDescInfo) {
		this.totalDescInfo = totalDescInfo;
	}

	public String getContentDescInfo() {
		return contentDescInfo;
	}

	public void setContentDescInfo(String contentDescInfo) {
		this.contentDescInfo = contentDescInfo;
	}

	public String getHelpDescInfo() {
		return helpDescInfo;
	}

	public void setHelpDescInfo(String helpDescInfo) {
		this.helpDescInfo = helpDescInfo;
	}
	
	
}
