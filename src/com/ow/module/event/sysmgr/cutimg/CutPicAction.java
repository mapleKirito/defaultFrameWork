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

public class CutPicAction implements EventListener{

	static Logger log = Logger.getLogger(Constant.FRAMEWORK);
	private ResultData resultData;
	private OperateImage image = new OperateImage();
	
	public CutPicAction()
	{
		resultData = new ResultData();
	}	
	
	public ResultData event(EventExecutor eventExecutor) throws Exception {
		try
		{
			String idsql =  eventExecutor.getSqlidByIndex(0);
			HashMap<String, String> map = eventExecutor.getBaseAction().getParamMap();

			String widthold = map.get("widthold") == null ? "" : (String)map.get("widthold") ;
			String heightold = map.get("heightold") == null ? "" : (String)map.get("heightold") ;
			String uploadCutName = map.get("uploadCutName") == null ? "" : (String)map.get("uploadCutName") ;
			String uploadCutPath = map.get("uploadCutPath") == null ? "" : (String)map.get("uploadCutPath") ;
			String name = ServletActionContext.getServletContext().getRealPath("/"+uploadCutPath+uploadCutName);
				   name = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "").replace("\\", "/") + uploadCutPath + uploadCutName;
			CompressionPictureSize.CutImae_((int)(Math.floor(Double.parseDouble(widthold)))+5, (int)(Math.floor(Double.parseDouble(heightold)))+5, name);

			String height = map.get("height") == null ? "0" : (String)map.get("height") ;
			String width = map.get("width") == null ? "0" : (String)map.get("width") ;
			String x = map.get("x") == null ? "0" : (String)map.get("x") ;
			String y = map.get("y") == null ? "0" : (String)map.get("y") ;
			//如果没有选定区域，则使用原图
			height=height.equals("")?(String)map.get("heightold"):height;
			width=width.equals("")?(String)map.get("widthold"):width;
			x=x.equals("")?"0":x;
			y=y.equals("")?"0":y;
			String path = ServletActionContext.getServletContext().getRealPath(uploadCutPath+"n_"+uploadCutName);
				   path = ConstantI.UPLOADPATH_KEY.substring(0, ConstantI.UPLOADPATH_KEY.lastIndexOf("\\"))+ConstantI.UPLOADPATH_KEY.substring(ConstantI.UPLOADPATH_KEY.lastIndexOf("\\")).replace("upload", "").replace("\\", "/") + uploadCutPath+"n_"+uploadCutName;
			
			image.setHeight(Integer.parseInt(height));
			image.setWidth(Integer.parseInt(width));
			image.setX(Integer.parseInt(x));
			image.setY(Integer.parseInt(y));
			
			image.setSrcpath(name);
			image.setSubpath(path);
			try {
				image.cut(); 
			} catch (IOException e) {
				e.printStackTrace();
			}
		
			map.put("userImg", uploadCutPath+"n_"+uploadCutName);
			
			//int va = eventExecutor.getSqlSession().update("user_info.update_HeadImg", map);
			int va = eventExecutor.getSqlSession().update(idsql, map);
			
			resultData.setIntResult(1);  
			return resultData;
		}
		catch (Exception e)
		{
			String error = DetailException.expDetail(e, CutPicAction.class);
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