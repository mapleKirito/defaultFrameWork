/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ow.framework.controller.action;

import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.struts2.ServletActionContext;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.listener.event.ExecutorResult;


/**
 * 
 * @author Administrator
 */
public class DownloadAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3320504748360944068L;
	private String inputPath;
	private String report;
	private String downloadFileName;
	
	public String subExecute() {
		ExecutorResult executorResult = this.eventExecutor.generalEventExecutor();
		if (executorResult.getResult() != null && executorResult.getResult().equals("1")) {
			return IAction.SUCCESS;
		} else {
			return INPUT;
		}
	}
	public String getInputPath() {
		return inputPath;
	}
	public void setInputPath(String inputPath) {
		this.inputPath = inputPath;
	}
	public String getReport() {
		return report;
	}
	public void setReport(String report) {
		this.report = report;
	}
	public String getDownloadFileName() {
		return downloadFileName;
	}
	public void setDownloadFileName(String downloadFileName) {
		this.downloadFileName = downloadFileName;
	}
    public InputStream getTargetFile2() throws Exception 
	{
    	InputStream  ins = null;
    	try{
    		ins = ServletActionContext.getServletContext().getResourceAsStream(inputPath);
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    	}
        return ins;
    }
    
    public InputStream getTargetFile() throws Exception 
	{
    	InputStream  ins = null;
    	try{
    		ins = ServletActionContext.getServletContext().getResourceAsStream(inputPath);
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    	}
    	try{
			if (ins == null){
	    	 	String rpath = ServletActionContext.getServletContext().getRealPath("/");
	    	 		  // rpath = DBUtil.TogeUpload(rpath) + "/";
	    	 		 rpath = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "");
	    	 	
	    	 	if (rpath == null )
	    	 		rpath = ServletActionContext.getServletContext().getResource("/").toString();
	    	 	if (inputPath.startsWith("\\") || inputPath.startsWith("/")){
	    	 		inputPath = inputPath.substring(1,inputPath.length());
	    	 	}
	    	 	rpath = rpath + "/" + inputPath;
				ins = new FileInputStream(rpath);
			}
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    	}		
        return ins;
    }
}
