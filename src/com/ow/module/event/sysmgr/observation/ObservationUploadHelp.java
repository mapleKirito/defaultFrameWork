package com.ow.module.event.sysmgr.observation;

import java.io.File;
import java.util.HashMap;
import com.ow.framework.data.po.ResultData;
import com.ow.framework.util.DeCompressUtil;
import com.ow.framework.util.FileHelper;
import com.ow.framework.util.StringUtil;

public class ObservationUploadHelp {
	
	private static String _fileRealPath;
	
	private static String _uploadPath;
	
	/**
	 *@param fileRealPath 文件重命名后的名称
	 *@param uploadPath   文件重命名后的upload后名称  upload/...
	 *@param resUpload    文件重命名前的名称
	 **/	
	public static void observationHandleDelRen(String resType,String fileRealPath,String uploadPath,String resUpload,HashMap paramMap){
	
		_fileRealPath = fileRealPath; _uploadPath = uploadPath;
		
		FileHelper.deleteFile(fileRealPath + "/" + uploadPath) ;
		
		FileHelper.reName(fileRealPath + "/" + uploadPath, fileRealPath + "/" + resUpload) ;
		
		String resUploadName = StringUtil.reResAbbreviated(resType) + "Upload" ;
		
		paramMap.put(resUploadName, uploadPath) ;
	}
	
	public static String observationHandleZipRar(String pfoldpath,String ppath,File[] files,int i, String upload,String oldFileName,String pfileRealPath,String puppath){
		
		FileHelper.createFolder(pfoldpath);
		
		observationHandleOn(ppath,files,i);
		
		String namebeforepath = upload.substring(upload.lastIndexOf("/")+1,upload.lastIndexOf(".")) + oldFileName.substring(oldFileName.lastIndexOf("."));
		
		FileHelper.deleteFile(pfileRealPath + puppath + "/" + namebeforepath) ;
		
		FileHelper.reName(pfileRealPath + puppath + "/" + namebeforepath,ppath) ;
		
		upload = puppath + "/" + namebeforepath;
	
		return upload;
	}
	
	public static ResultData observationHandleOn(String ppath,File[] files,int i){
		
		ResultData resultData = new ResultData();
		
		if (!FileHelper.writeFile(new File(ppath), files[i])) {
		
			resultData.setIntResult(-1);
	
			return resultData;
		}
		
		return resultData;
	}
	
	public static void observationHandlePut(String ziprarUpload,String resType,String smallUpload,String zhongupload,String savepath,HashMap paramMap){
		
		String aa = ziprarUpload.substring(ziprarUpload.lastIndexOf("/"),ziprarUpload.lastIndexOf("."));
		
		String bb = aa.substring(aa.length()-4);
			
		paramMap.put(StringUtil.reResAbbreviated(resType) + "Thumbnail", smallUpload.substring(smallUpload.lastIndexOf(savepath))) ;
		
		paramMap.put(StringUtil.reResAbbreviated(resType) + "InThum", zhongupload.substring(zhongupload.lastIndexOf(savepath))) ;
		
		paramMap.put(StringUtil.reResAbbreviated(resType) + "FileSwf", ziprarUpload.substring(0,ziprarUpload.lastIndexOf("/")) + "/" + bb) ;
	
	}
	
	public static void observationHandleDecom(String realPath,String upload,HashMap paramMap){
		
		String wpath = (realPath + upload.substring(upload.indexOf("/"))).replace("//", "/");
		
		String aa = upload.substring(0,upload.lastIndexOf("."));
		
		String ww = aa.substring(aa.length()-4);
		
		String ss = wpath.substring(0,wpath.lastIndexOf("/")+1);
		
		String wpathafter = (ss + ww).replace("///","//").replace("//", "/");
		
		try {
		
			FileHelper.deleteDirectory(wpathafter) ;
		
			FileHelper.createFolder(wpathafter);
		
			DeCompressUtil.deCompress(wpath,wpathafter);
			
			String ziptype_name = DeCompressUtil.getTlname();
			
			long ziptype_count = DeCompressUtil.getIndexfile();
			
			String JPtype = ziptype_name.substring(ziptype_name.lastIndexOf("."));
			
			String JPname = ziptype_name.substring(0,ziptype_name.lastIndexOf("("));
			
			String _ziptype = JPname + "," + JPtype + "," + ziptype_count;
			
			long lo = 0l;
			DeCompressUtil.setIndexfile(lo);
			
			paramMap.put("orZip", _ziptype) ;
			
			paramMap.put("orFileSwf", upload.substring(0,upload.lastIndexOf("/")+1)+ww) ;
		
		
		} catch (Exception e) {
		
			e.printStackTrace();
		
		}
	}
	
}
