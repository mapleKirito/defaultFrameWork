package com.ow.module.event.sysmgr.export;

import java.io.File;
import java.net.MalformedURLException;
import java.sql.Connection;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.DBUtil;
import com.ow.framework.util.FileHelper;

public class ExportDataEvent implements EventListener  {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public ExportDataEvent(){
		resultData = new ResultData();
	}
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		Connection conn = null ;
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
			File file = new File(realPath + "/" + Constant.exprotFilePath) ;
			if(!file.exists()) {
				file.mkdirs() ;
			}
			
			conn = eventExecutor.getSqlSession().getConnection() ;
			String exportTable = Constant.exportTable ;
			for(int i = 0; i < exportTable.split(",").length; i ++) {
				StringBuffer buffer = DBUtil.tableMetaData(conn, exportTable.split(",")[i]) ;
				FileHelper.writeFile(realPath + "/" + Constant.exprotFilePath + exportTable.split(",")[i] + ".exp", buffer.toString(), true) ;
			}
			resultData.setIntResult(1);
		}catch(Exception e) {
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, ExportDataEvent.class);
			log.error(error);
			throw e;
		}finally {
			if ((conn != null) && !conn.isClosed()) {
				//conn.close();
			}
		}
		
		return resultData ;
	}
}
