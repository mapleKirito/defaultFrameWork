/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ow.framework.data.po;

import com.ow.framework.common.Constant;



/**
 *
 * @author Administrator
 */
public class PaginatedData extends AbstractBean{	

    /**总记录数*/
    private int recordCount = 0;
	/**当前页*/
	private int currentPage = 0;
	/**当前页*/
	private int pageSize = 10;
	/**分页开始值*/
	private int start = 0;
	/**偏移量*/
	private int offset = 0;
	/**总页数*/
	private int pageCount = 0;
	
	/**左右方块数 限制最多*/
	private int pageDiv = 1;
	/**页面内容**/
	private String pageContent;
	/**自定义当前页参数名**/
	private String selfPageName;
	/**上下文名称**/
	private String contextName;	
	
	public PaginatedData()
	{
		
	}
	
	public PaginatedData(String datasourceName,int pageSize,int currentPage)
	{
		if (currentPage == 0)
			currentPage = 1;
		datasourceName = datasourceName == null ? "" : datasourceName;
		int idx = datasourceName.indexOf("_");
		if (idx > -1){
			String dsname = datasourceName.substring(0,idx);
			if (dsname.equals(Constant.DATASOURCE_MYSQL)){
				this.start = (currentPage - 1) * pageSize;
				this.offset = pageSize;
			}
			else if (dsname.equals(Constant.DATASOURCE_ORACLE)){ 
				this.start = (currentPage - 1) * pageSize + 1;
				this.offset = currentPage * pageSize;				
			}
			else if (dsname.equals(Constant.DATASOURCE_SQLSERVER)){ 
				this.start = (currentPage - 1) * pageSize;
				this.offset = currentPage * pageSize + 1;
			}
			else if (dsname.equals(Constant.DATASOURCE_DB2)){ 
				//以后待补
			}
			else if (dsname.equals(Constant.DATASOURCE_SYBASE)){ 
				//以后待补
			}
			else if (dsname.equals(Constant.DATASOURCE_INFORMIX)){ 
				//以后待补
			}	
			else if (dsname.equals(Constant.DATASOURCE_POSTGRES)){ 
				//以后待补
			}			
		}
		this.pageSize = pageSize;
		this.currentPage = currentPage;
	}

	public void htmlPage(String param){ 
		String htmlPage = "";
		if (this.pageCount > 0){
			if (this.currentPage > 1){
				htmlPage = "<input type=\"button\" name=\"pageBack\" id=\"pageBack\" class=\"pageBack\" value=\"上一页\"/>";
				htmlPage += "<input type=\"hidden\" value=\""
					+ "decorateForwardAction.action?pageSize=" + this.pageSize
					+ "&currentPage="+(this.currentPage-1);
				if (this.selfPageName != null){
					htmlPage += "&" + this.selfPageName + "=" + (this.currentPage-1);
				}
				htmlPage += "&" + param + "\" name=\"pageBackParam\" id=\"pageBackParam\"/>";
			}
			if (this.currentPage - pageDiv <= 2){
				for (int i=1; i<=this.currentPage; i++){
					if (i == this.currentPage){
						htmlPage += "<span class=\"thisPage\">"+this.currentPage+"</span>";
					}
					else{
						String hidePage = "<input type=\"hidden\" value=\""
							+ "decorateForwardAction.action?pageSize=" + this.pageSize
							+ "&currentPage="+i;
						if (this.selfPageName != null){
							hidePage += "&" + this.selfPageName + "=" + i;
						}
						hidePage += "&" + param + "\" name=\"page"+i+"\" id=\"page"+i+"\"/>";
						htmlPage += "<span>"+hidePage+"<a href=\"javascript:void(0)\">"+i+"</a></span>";
					}
				}				
			}
			else if(this.currentPage - pageDiv == 3){
				for (int i=1; i<=this.currentPage; i++){
					if (i == 2){
						htmlPage += "<span class=\"waitspan\">...</span>";
					}
					if (i == this.currentPage){
						htmlPage += "<span class=\"thisPage\">"+this.currentPage+"</span>";
					}
					else{
						String hidePage = "<input type=\"hidden\" value=\""
							+ "decorateForwardAction.action?pageSize=" + this.pageSize
							+ "&currentPage="+i;
						if (this.selfPageName != null){
							hidePage += "&" + this.selfPageName + "=" + i;
						}
						hidePage += "&" + param + "\" name=\"page"+i+"\" id=\"page"+i+"\"/>";						
						htmlPage += "<span>"+hidePage+"<a href=\"javascript:void(0)\">"+i+"</a></span>";
					}
				}				
			}
			else if(this.currentPage - pageDiv > 3){
				String hidePage1 = "<input type=\"hidden\" value=\""
					+ "decorateForwardAction.action?pageSize=" + this.pageSize
					+ "&currentPage=1";
				if (this.selfPageName != null){
					hidePage1 += "&" + this.selfPageName + "=1";
				}
				hidePage1 += "&" + param + "\" name=\"page1\" id=\"page1\"/>";	
				htmlPage += "<span>"+hidePage1+"<a href=\"javascript:void();\">1</a></span>";
				htmlPage += "<span class=\"waitspan\">...</span>";
				for (int i=(this.currentPage-pageDiv); i<=this.currentPage; i++){
					if (i == this.currentPage){
						htmlPage += "<span class=\"thisPage\">"+this.currentPage+"</span>";
					}
					else{
						String hidePage = "<input type=\"hidden\" value=\""
							+ "decorateForwardAction.action?pageSize=" + this.pageSize
							+ "&currentPage="+i;
						if (this.selfPageName != null){
							hidePage += "&" + this.selfPageName + "=" + i;
						}
						hidePage += "&" + param + "\" name=\"page"+i+"\" id=\"page"+i+"\"/>";		
						htmlPage += "<span>"+hidePage+"<a href=\"javascript:void(0)\">"+i+"</a></span>";
					}
				}				
			}
			for (int i=this.currentPage+1; i<=(this.currentPage + pageDiv); i++){
				if (i <= this.pageCount){
					if (i == this.currentPage){
						htmlPage += "<span class=\"thisPage\">"+this.currentPage+"</span>";
					}
					else{
						String hidePage = "<input type=\"hidden\" value=\""
							+ "decorateForwardAction.action?pageSize=" + this.pageSize
							+ "&currentPage="+i;
						if (this.selfPageName != null){
							hidePage += "&" + this.selfPageName + "=" + i;
						}
						hidePage += "&" + param + "\" name=\"page"+i+"\" id=\"page"+i+"\"/>";							
						htmlPage += "<span>"+hidePage+"<a href=\"javascript:void(0)\">"+i+"</a></span>";
					}
					if (this.pageCount - (this.currentPage + pageDiv) >= 1 && (this.currentPage + pageDiv) == i){
						String hidePage = "<input type=\"hidden\" value=\""
							+ "decorateForwardAction.action?pageSize=" + this.pageSize
							+ "&currentPage="+this.pageCount;
						if (this.selfPageName != null){
							hidePage += "&" + this.selfPageName + "=" + this.pageCount;
						}
						hidePage += "&" + param + "\" name=\"page"+this.pageCount+"\" id=\"page"+this.pageCount+"\"/>";	
						htmlPage += "<span class=\"waitspan\">...</span>";
						htmlPage += "<span>"+hidePage+"<a href=\"javascript:void(0)\">"+this.pageCount+"</a></span>";	
					}
				}
			}
			if (this.currentPage < this.pageCount){
				htmlPage += "<input type=\"button\" name=\"pageNext\" id=\"pageNext\" class=\"pageNext\"  value=\"下一页\"/>";
				htmlPage +=  "<input type=\"hidden\" value=\""
					+ "decorateForwardAction.action?pageSize=" + this.pageSize
					+ "&currentPage="+(this.currentPage+1);
				if (this.selfPageName != null){
					htmlPage += "&" + this.selfPageName + "=" + (this.currentPage+1);
				}
				htmlPage += "&" + param + "\" name=\"pageNextParam\" id=\"pageNextParam\"/>";
			}
			htmlPage += "<input type=\"text\" name=\"goPage\" onkeydown='main()' id=\"goPage\" style=\"width:40px;height:27px;line-height:27px;\" value=\""+this.currentPage+"\"  />";
			htmlPage += "<input type=\"button\" name=\"goPageBtn\" id=\"goPageBtn\" value=\"跳转到\"  style=\"height:30px\"  />";
			htmlPage += "<input type=\"hidden\" name=\"pageCount\" id=\"pageCount\" value=\""+this.pageCount+"\"/>";
			htmlPage += "<input type=\"hidden\" name=\"pageCountParam\" id=\"pageCountParam\"  value=\""
					 +  "decorateForwardAction.action?pageSize=" + this.pageSize + "&" + param;
			if (this.selfPageName != null){
				htmlPage += "&" + this.selfPageName + "=";
			}
			htmlPage += "\" />";
			this.pageContent = htmlPage;
		}
		else{
			this.pageContent = htmlPage;
		}
	}
	
	public int getRecordCount() {
		return recordCount;
	}

	public void setRecordCount(int recordCount) {
		this.recordCount = recordCount;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public String getPageContent() {
		return pageContent;
	}

	public void setPageContent(String pageContent) {
		this.pageContent = pageContent;
	}

	public String getContextName() {
		return contextName;
	}

	public void setContextName(String contextName) {
		this.contextName = contextName;
	}

	public String getSelfPageName() {
		return selfPageName;
	}

	public void setSelfPageName(String selfPageName) {
		this.selfPageName = selfPageName;
	}
	
	
}
