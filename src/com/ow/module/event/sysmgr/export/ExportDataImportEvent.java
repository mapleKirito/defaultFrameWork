package com.ow.module.event.sysmgr.export;

import java.io.File;
import java.net.MalformedURLException;
import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.exceptions.IbatisException;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.FileHelper;
import com.ow.framework.util.StringUtil;

public class ExportDataImportEvent implements EventListener  {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ExportDataImportEvent(){
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
			
			Connection conn = null ;
			Statement st = null ;
			
			try{
				conn = eventExecutor.getSqlSession().getConnection() ;
				st = conn.createStatement() ;
			
				//导入目录
				File folder = new File(realPath + "/" + Constant.exprotFilePath) ;
				for(File file : folder.listFiles()) {
					if(Constant.exportFileType.equals(file.getName().substring(file.getName().lastIndexOf(".") + 1))){
						List<String> list = FileHelper.readFileToList(file) ;
						for(String sql : list) {
							if(sql != null && !"".equals(sql)) {
								try{
									//log.info("********Execute SQL:" + sql + "********") ;
									//eventExecutor.getSqlSession().insert(sql) ;
									st.executeUpdate(sql) ;
								}catch(Exception e) {
									log.error("********Execute Fail SQL:" + sql + "********") ;
								}
							}
						}
						conn.commit() ;
					}
				}
			}catch(Exception e) {
				
			}finally {
				st.close();
				//conn.close();
			}
			resultData.setIntResult(1);
		}catch(Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExportDataImportEvent.class);
			log.error(error);
			throw e;
		}
		
		return resultData ;
	}
}
