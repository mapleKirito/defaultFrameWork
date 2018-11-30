package com.ow.module.event.sysmgr.exhibition;

import java.util.HashMap;

import com.ow.framework.util.FileHelper;
import com.ow.framework.util.StringUtil;


public class ExhibitionUploadHelp {
	private static String _fileRealPath;
	private static String _uploadPath;
	/**
	 *@param fileRealPath 文件重命名后的名称
	 *@param uploadPath 文件重命名后的upload后名称  upload/...
	 *@param resUpload  文件重命名前的名称
	 **/	
	public static void exhibitionHandleDelRen(String resType,String fileRealPath,String uploadPath,String resUpload,HashMap paramMap){
		_fileRealPath = fileRealPath; _uploadPath = uploadPath;
		FileHelper.deleteFile(fileRealPath + "/" + uploadPath) ;
		FileHelper.reName(fileRealPath + "/" + uploadPath, fileRealPath + "/" + resUpload) ;
		String resUploadName = StringUtil.reResAbbreviated(resType) + "Upload" ;
		paramMap.put(resUploadName, uploadPath) ;
	}
	
	@SuppressWarnings("unchecked")
	public static void exhibitionHandleAudio(String resType,String s_userType,String snNO,HashMap paramMap){
		String resAudioUploadName = StringUtil.reResAbbreviated(resType) + "Audio" ;
		String resAudioUpload = paramMap.get(resAudioUploadName) == null ? "" : (String)paramMap.get(resAudioUploadName) ;
		if(resAudioUpload.length() > 0) {
			String uploadAudioPath = ("upload/" + StringUtil.reResTypeThum(resType) + "/" + s_userType + "/" + StringUtil.resExpentNum(resType) + "/" + snNO + "." + resAudioUpload.substring(resAudioUpload.lastIndexOf(".") + 1)).replace("//","/") ;
			paramMap.put(resAudioUploadName, uploadAudioPath) ;
			FileHelper.deleteFile(_fileRealPath + "/" + uploadAudioPath) ;
			FileHelper.reName(_fileRealPath + "/" + uploadAudioPath, _fileRealPath + "/" + resAudioUpload) ;
		}		
	}
}
