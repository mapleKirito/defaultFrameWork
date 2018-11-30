/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ow.framework.util;

import java.util.HashMap;

/**
 *
 * @author Administrator
 */
public class StringUtil {
    /*
     将对象转成字符串，如果对象为null，则将对象转成""
     */
    public static String objectToString(Object obj) {
        return obj == null ? "" : obj.toString();
    }
    
    /**
     * 根据数值，返回编号
     * @param sn
     * @param len
     * @param ch
     * @return
     */
    public static String intToSN(int sn, int len, String ch) {
    	String snNO = "" ;
    	int snLen = new String(sn + "").length() ;
    	for(int i = 0; i < len - snLen; i ++) {
    		snNO += ch ;
    	}
    	snNO = snNO + sn ;
    	return snNO ;
    }
    
    /**
     * 返回资源文件类型
     * @param uploadName  	upload/BLS/0/0000/890876545.jsp
     * @return
     */
    public static String getUploadFileType(String uploadName) {
    	if(uploadName == null) {
    		return "" ;
    	}
    	return uploadName.substring(uploadName.lastIndexOf(".") + 1) ;
    }
    
    public static void main(String[] args) {
    	System.out.println(getUploadFileType("")); ;
    }

    /**
     * 返回资源的编码型号
     * @param resType 资源类别
     * @return
     */
    public static String reResTypeThum(String resType) {
    	if("exhibition".equals(resType)) {
			return "BLS" ;
		}else if("observation".equals(resType)) {
			return "YDS" ;
		}else if("laboratory".equals(resType)) {
			return "YJS" ;
		}else if("projection".equals(resType)) {
			return "ZLS" ;
		}else if("lovely".equals(resType)) {
			return "XJY" ;
		}
    	return resType ;
    }

    /**
     * 返回资源的上传文件字段 名称
     * @param resType 资源类别
     * @return
     */
    public static String reResTypeToUploadFilename(String resType) {
    	if("exhibition".equals(resType)) {
			return "erUpload" ;
		}else if("observation".equals(resType)) {
			return "orUpload" ;
		}else if("laboratory".equals(resType)) {
			return "lrUpload" ;
		}else if("projection".equals(resType)) {
			return "prUpload" ;
		}else if("lovely".equals(resType)) {
			return "crUpload" ;
		}
    	return resType ;
    }
    
    /**
     * 返回资源的上传文件字段 名称
     * @param resType 资源类别
     * @return
     */
    public static String reResTypeToNewUploadName(String resType) {
    	if("exhibition".equals(resType)) {
			return "erNewUpload" ;
		}else if("observation".equals(resType)) {
			return "orNewUpload" ;
		}else if("laboratory".equals(resType)) {
			return "lrNewUpload" ;
		}else if("projection".equals(resType)) {
			return "prNewUpload" ;
		}else if("lovely".equals(resType)) {
			return "crNewUpload" ;
		}
    	return resType ;
    }
    
    /**
     * 返回资源的上传文件字段 名称
     * @param resType 资源类别
     * @return
     */
    public static String reResTypeToUploadSwfFilename(String resType) {
    	if("exhibition".equals(resType)) {
			return "erFileSwf" ;
		}else if("observation".equals(resType)) {
			return "orFileSwf" ;
		}else if("laboratory".equals(resType)) {
			return "lrFileSwf" ;
		}else if("projection".equals(resType)) {
			return "prFileSwf" ;
		}else if("lovely".equals(resType)) {
			return "crFileSwf" ;
		}
    	return resType ;
    }

    /**
     * 返回资源 扩展
     * @param resType 资源类别
     * @return
     */
    public static String resExpentNum(String resType) {
    	if("exhibition".equals(resType)) {
			return "0000" ;
		}else if("observation".equals(resType)) {
			return "0000" ;
		}else if("laboratory".equals(resType)) {
			return "0000" ;
		}else if("projection".equals(resType)) {
			return "0000" ;
		}else if("lovely".equals(resType)) {
			return "0000" ;
		}
    	return "0000" ;
    }
    
    /**
     * 返回资源的缩写形式
     * @param resType 资源类别
     * @return
     */
    public static String reResAbbreviated(String resType) {
    	if("exhibition".equals(resType)) {
			return "er" ;
		}else if("observation".equals(resType)) {
			return "or" ;
		}else if("laboratory".equals(resType)) {
			return "lr" ;
		}else if("projection".equals(resType)) {
			return "pr" ;
		}else if("lovely".equals(resType)) {
			return "cr" ;
		}
    	return resType ;
    }
    
    /**
     * 返回参考资源缩略图
     * @param resType 文档后缀
     * @return
     */
    public static String reResReferThumbnail(String ReferThumbnail) {
    	if("ppt".equals(ReferThumbnail)) {
			return "images/resImage/file_type_04.jpg" ;
		}else if("doc".equals(ReferThumbnail)) {
			return "images/resImage/file_type_03.jpg" ;
		}else if("pdf".equals(ReferThumbnail)) {
			return "images/resImage/file_type_05.jpg" ;
		}
    	return ReferThumbnail ;
    }
    
    /**
     * 返回资源的文件名称
     * @param resType 资源类别
     * @return
     */
    public static String retrunResCodeFromUpload(String resUpload) {
    	if(resUpload == null || "".equals(resUpload)) {
    		return "" ;
    	}else {
    		return resUpload.substring(resUpload.lastIndexOf("/") + 1, resUpload.lastIndexOf(".")) ;
    	}
    }
    
    public static String addfavoriteToChina(String favorite) {
    	String cn = "" ;
    
    	if("exhibition".equals(favorite)) {
    		cn = "文物博览室" ;
    	}else if("laboratory".equals(favorite)) {
    		cn = "教学研究室" ;
    	}else if("observation".equals(favorite)) {
    		cn = "专题研读室" ;
    	}else if("projection".equals(favorite)) {
    		cn = "影像资料室" ;
    	}else if("expand".equals(favorite)) {
    		cn = "自主探究室" ;
    	}else if("lovely".equals(favorite)) {
    		cn = "情系家园" ;
    	}
    	
    	return cn ;
    }
    
    public static String resToType(String type){
    	String gName = "";
    	if("1011".equals(type)) {
			gName = "高清图片" ;
		}else if("1022".equals(type)) {
			gName = "3D图片" ;
		}else if("4033".equals(type)) {
			gName = "压缩包格式" ;
		}else if("1073".equals(type)) {
			gName = "音频" ;
		}else if("1084".equals(type)) {
			gName = "高清视频" ;
		}else if("1005".equals(type)) {
			gName = "虚拟仿真实验素材" ;
		}else if("2041".equals(type)) {
			gName = "PPT课件 " ;
		}else if("2002".equals(type)) {
			gName = "Flash课件" ;
		}else if("2033".equals(type)) {
			gName = "WORD课件" ;
		}else if("2004".equals(type)) {
			gName = "其他课件" ;
		}else if("2055".equals(type)) {
			gName = "PDF课件" ;
		}
    	return gName;
    }
    
    public static String tableToChina(String tableName) {
    	String cn = "" ;
    	if("res_category".equals(tableName)) {
    		cn = "资源分类表" ;
    	}else if("sys_area".equals(tableName)) {
    		cn = "地区表" ;
    	}else if("res_exhibition_room".equals(tableName)) {
    		cn = "文物博览室" ;
    	}else if("res_laboratory_room".equals(tableName)) {
    		cn = "教学研究室" ;
    	}else if("res_observation_room".equals(tableName)) {
    		cn = "专题研读室" ;
    	}else if("res_projection_room".equals(tableName)) {
    		cn = "影像资料室" ;
    	}else if("lovely_room".equals(tableName)) {
    		cn = "情系家园" ;
    	}else if("res_resource".equals(tableName)) {
    		cn = "资源表" ;
    	}else if("res_grade_relationship".equals(tableName)) {
    		cn = "适用学段、年级表" ;
    	}
    	
    	return cn ;
    }
}
