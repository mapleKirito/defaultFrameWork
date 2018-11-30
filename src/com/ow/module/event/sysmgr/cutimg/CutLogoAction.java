package com.ow.module.event.sysmgr.cutimg;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.ambow.base.grm.common.ConstantI;
import com.ow.framework.common.Constant;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.exception.DetailException;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.listener.event.EventListener;
import com.ow.framework.util.CompressionPictureSize;
import com.ow.framework.util.FileHelper;

public class CutLogoAction implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private OperateImage image = new OperateImage();
	
	public CutLogoAction()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			HashMap<String, String> map = eventExecutor.getBaseAction().getParamMap();

			String uploadCutName = map.get("uploadCutName") == null ? "" : (String)map.get("uploadCutName") ;
			String uploadCutPath = map.get("uploadCutPath") == null ? "" : (String)map.get("uploadCutPath") ;
			map.put("welcomeUpload", uploadCutPath+uploadCutName);
			int va = eventExecutor.getSqlSession().update("welcome.update_by_id", map);			
			resultData.setIntResult(1);  
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, CutLogoAction.class);
			log.error(error);
			throw e;
		}
	}

	public OperateImage getImage() {
		return image;
	}

	public void setImage(OperateImage image) {
		this.image = image;
	}
}