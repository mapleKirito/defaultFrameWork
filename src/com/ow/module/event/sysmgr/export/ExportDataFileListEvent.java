package com.ow.module.event.sysmgr.export;

import java.io.File;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.StringUtil;

public class ExportDataFileListEvent implements EventListener  {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ExportDataFileListEvent(){
		resultData = new ResultData();
	}
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try{
			String fileSplit = Constant.fileSplit ;
			//tomcat获取服务器路径
			String  fileRealPathl = ServletActionContext.getServletContext().getRealPath(fileSplit);
			//webLogic获取服务器路径
			if(fileRealPathl==null){
				try {
					fileRealPathl = ServletActionContext.getServletContext().getResource(fileSplit).toString();
				} catch (MalformedURLException e) {
					e.printStackTrace();
				}
			}
			//文件的真实路径
			String realPath = fileRealPathl + fileSplit;
			
			//创建导出目录
			File folder = new File(realPath + "/" + Constant.exprotFilePath) ;
			if(!folder.exists()) {
				folder.mkdirs() ;
			}
			List<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>() ;
			for(File file : folder.listFiles()) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("fileName", file.getName()) ;
				map.put("fileSize", file.length() + "") ;
				map.put("tableName", file.getName().substring(0, file.getName().lastIndexOf("."))) ;
				map.put("tableCnName", StringUtil.tableToChina(file.getName().substring(0, file.getName().lastIndexOf(".")))) ;
				list.add(map) ;
			}
			resultData.setIntResult(1);
			resultData.setList(list) ;
		}catch(Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExportDataFileListEvent.class);
			log.error(error);
			throw e;
		}
		
		return resultData ;
	}
}
