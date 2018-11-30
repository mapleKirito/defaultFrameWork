package com.ambow.base.grm.onlineread.web;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ambow.base.grm.common.ConstantI;
import com.ambow.base.grm.onlineread.business.FileConvertBusiness;
import com.ambow.base.grm.util.FileUtil;
import com.ambow.base.grm.util.RandomUtil;
import com.ow.framework.common.Constant;


public class OnlineReadEntrance {
	
	//应用相对路径
	private String  absolutePath = "swf"+File.separator;
	static Logger log = Logger.getLogger(Constant.FRAMEWORK);

	/**
	 * 
	 * @param filePath 文件实际路径
	 * @param realPath 工程实际路径
	 * @return rtnMap 
	 * error: 0  正常
	 * 		  1 该文件无法转化
	 * 		  2 没有该文件
	 * 		  3 pdf转化异常
	 * 		  4 swf转化异常
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public HashMap getSWF(String filePath,String realPath){
		HashMap rtnMap = new HashMap();
		try{
			//替换所有路径中的文件间隔符“\”
			realPath = realPath.replaceAll("\\\\", "/").replaceAll("//", "/");
			filePath = filePath.replaceAll("\\\\", "/").replaceAll("//", "/");
			//截取掉jsp页面之前的
			realPath = realPath.substring(0,realPath.lastIndexOf("/"));
			//返回的相对路径
			String rtnValue = "";
			//文件绝对路径文件夹
			String fileFolder = filePath.substring(0,filePath.lastIndexOf("/"));
			//项目swf绝对路径
			String realTempPath = realPath+File.separator+absolutePath;
			//文件名(无后缀)
			String fileRealName =  filePath.substring(filePath.lastIndexOf("/")+1);
			//文件类型
			String fileType = fileRealName.substring(fileRealName.lastIndexOf("."));
			String randomStr = RandomUtil.getRandomString(24);
			String fileTempName =  URLEncoder.encode(fileRealName.replace(fileType, ""));
			String convertPDFName = fileTempName + ".pdf";
			//转换pdf文件名
			String convertSWFName = fileTempName + ".swf";
//			//转换pdf文件名
//			String convertPDFName = randomStr+".pdf";//fileRealName.replace(fileType, ".pdf");
//			//转换pdf文件名
//			String convertSWFName = randomStr+".swf";
			//判断是否存在该文件
			boolean sameFileFlag = FileUtil.validSwfFileName(fileFolder,convertSWFName);
			//存在相同文件，复制文件到该文件夹下
			if(sameFileFlag){
				//判断是否有该文件夹，并创建
				FileUtil.createFolder(realTempPath);
				//复制swf文件到指定文件夹下
//				FileUtil.copySwfFile(fileFolder+File.separator+convertSWFName,realTempPath+convertSWFName);
//				rtnValue = absolutePath + convertSWFName;
//				rtnMap.put("swfPath", rtnValue.replaceAll("\\\\", "/"));
				rtnMap.put("error", "0");
			//不存在相同文件则进行转换
			}else{
				FileConvertBusiness fCBusiness= new FileConvertBusiness();
				//判断类型是否允许转换  
				if(ConstantI.ONLINEREADFILETYPE_KEY.contains(fileType.replace(".", ""))){
					boolean convertPDFFlag = false;
					if(fileType.toLowerCase().equals(".pdf")){
						convertPDFFlag = true;
					}else{
						convertPDFFlag = fCBusiness.docToPdf(new File(filePath), new File(fileFolder+File.separator+convertPDFName),ConstantI.PDFJARPATH_KEY,ConstantI.TRANSFORTYPEFLAG_KEY);
					}
					
					if(convertPDFFlag){//pdf 是否转化完成
						boolean convertSWFFlag = fCBusiness.PdfToSwf(new File(fileFolder+File.separator+convertPDFName),new File(fileFolder+File.separator+convertSWFName), ConstantI.SWFTOOLSPATH_KEY);
						if(convertSWFFlag){//swf 是否转化完成
//							FileUtil.copySwfFile(fileFolder+File.separator+convertSWFName, realTempPath+convertSWFName);
//							rtnValue = absolutePath + convertSWFName;
//							rtnMap.put("swfPath", rtnValue.replaceAll("\\\\", "/"));
							rtnMap.put("error", "0");
						}else{
							rtnMap.put("error", "4");//swf转换失败
						}
					}else{
						rtnMap.put("error", "3");//pdf转换失败
					}
				}else{
					rtnMap.put("error", "1");//该文件无法转换
				}
			}
		}catch(Exception e){
			log.error(e.getMessage()) ;
			rtnMap.put("error", "2");//无效文件
		}
        return rtnMap;
	}
}
