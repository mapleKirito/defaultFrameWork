package com.ow.module.event.sysmgr.gagellery;
import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.common.Constant;
import com.ow.framework.controller.action.UploadDataAction;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.CompressionPictureSize;
import com.ow.framework.util.DBUtil;
import com.ow.framework.util.FileHelper;
import com.ow.framework.util.StringUtil;
public class GagelleryCreateEvent implements EventListener {
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	public GagelleryCreateEvent() {
		resultData = new ResultData();
	}
	@SuppressWarnings({ "rawtypes", "unused" })
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
			String insert = eventExecutor.getSqlidByIndex(0);
			String fileRealPath = ServletActionContext.getServletContext().getRealPath("/");
			fileRealPath = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "");
			if ((UploadDataAction) eventExecutor.getBaseAction() instanceof UploadDataAction) {
				if (!"".equals(insert)) {
					String gaSrc = (String)paramMap.get("gaSrc") == null ? "":(String)paramMap.get("gaSrc");
					String snNO = StringUtil.intToSN(DBUtil.findSN(eventExecutor, "Mygallery"), 8, "0") ; 
					String resNO = "gagellery" + snNO ;
					String namefile = gaSrc.substring(gaSrc.lastIndexOf("/")+1,gaSrc.lastIndexOf("."));
					FileHelper.deleteFile(fileRealPath + gaSrc.replace(namefile, resNO)) ;
					FileHelper.reName(fileRealPath + gaSrc.replace(namefile, resNO),fileRealPath + gaSrc) ;
					
					String uploadPath=gaSrc.replace(namefile, resNO);
					String uploadPath_1=uploadPath.substring(0, uploadPath.lastIndexOf("/")+1);
					String uploadPath_2=CompressionPictureSize.getSmallJPG(fileRealPath+uploadPath,fileRealPath+uploadPath_1);
					paramMap.put("gaSrc", gaSrc.replace(namefile, resNO));
					int rvalue = eventExecutor.getSqlSession().insert(insert,paramMap);
					resultData.setIntResult(1);
				}	
			}
			return resultData;
		}
		catch (Exception e)
		{
			resultData.setIntResult(0);
			String error = DetailException.expDetail(e, GagelleryCreateEvent.class);
			log.error(error);
		}
		return resultData;
	}
}
