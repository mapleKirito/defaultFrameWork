package com.ow.module.event.sysmgr;

import java.util.HashMap;

import com.ow.framework.common.Constant;
import com.ow.framework.listener.event.EventExecutor;
import com.ow.framework.util.StringUtil;

/**
 * 
 * 资源工具类
 *
 */
public class ResourceUtil {

	/**
	 * 详细页面，按功能查询，根据当前信息返回面包屑
	 * @param eventExecutor
	 * @param path 面包屑 分类ID串
	 * @param code 当前资源所属code
	 * @param paramName	当前资源id对应ibatis中名称
	 * @param name 当前资源名称
	 * @param id 当前资源id
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String returnCategoryPath(EventExecutor eventExecutor, String paramName, String name, String id){
		String path = eventExecutor.getBaseAction().getPath() == null ? "" : eventExecutor.getBaseAction().getPath();
		String arrPath [] = path.split(",");
		String  bname = "";
		HashMap paramMap = eventExecutor.getBaseAction().getParamMap();
		//String subpath = (String)paramMap.get(ResourceUtil.returnResourceListPathText((String)paramMap.get("roomtype"),(String)paramMap.get("cateLevel")))+",";
		for (int i=0; i<arrPath.length; i++){
			if (arrPath[i] != null && !arrPath[i].equals("")){
				eventExecutor.getBaseAction().getParamMap().put("cateID", arrPath[i]);
				Object one = eventExecutor.getSqlSession().selectOne("category.select_name_by_id", eventExecutor.getBaseAction().getParamMap());
				if (one != null){
					String cName = ((HashMap)one).get("cateName") == null?"" : ((HashMap)one).get("cateName").toString();
					if (bname.equals("")){
						bname = cName;
					}
					else{
						bname +=" &gt; " + cName;
					}
				}
			}
		}
		
		bname +=" &gt; " + name;
		
		return bname ;
	}
	
	/**
	 * 详细页面，按区域查询，根据当前信息返回面包屑
	 * @param eventExecutor
	 * @param paramName
	 * @param name
	 * @param id
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String returnAreaPath(EventExecutor eventExecutor, String paramName, String name, String id) {
		String path = eventExecutor.getBaseAction().getPath() == null ? "" : eventExecutor.getBaseAction().getPath();
		String arrPath [] = path.split(",");
		String  bname = "";
		for (int i=0; i<arrPath.length; i++){
			if (arrPath[i] != null && !arrPath[i].equals("")){
				eventExecutor.getBaseAction().getParamMap().put("areaID", arrPath[i]);
				Object one = eventExecutor.getSqlSession().selectOne("area.select_by_id", eventExecutor.getBaseAction().getParamMap());
				if (one != null){
					String aName = ((HashMap)one).get("areaName") == null?"" : ((HashMap)one).get("areaName").toString();
					if (bname.equals("")){
						bname = aName;
					}
					else{
						bname +=" &gt; " + aName;
					}
				}
			}
		}
		if (!name.equals(""))
			bname += " &gt; " + name ;
		return bname ;
	}
	
	/**
	 * 详细页面，按适用学段、年级查询，根据当前信息返回面包屑
	 * @param eventExecutor
	 * @param paramName
	 * @param name
	 * @param id
	 * @return
	 */
	public static String returnGradePath(String grGrade, String paramName, String name, String id) {
		String bname = "" ;
		String path = grGrade;
		String sunpath = path.substring(0,3);
		String gName = "" ;
		if("311".equals(sunpath)) {
			gName = " 按适用学段、年级浏览 &gt; 初中 &gt; 七年级" ;
		}else if("312".equals(sunpath)) {
			gName = " 按适用学段、年级浏览 &gt; 初中 &gt; 八年级" ;
		}else if("321".equals(sunpath)) {
			gName = " 按适用学段、年级浏览 &gt; 高中 &gt; 必修一" ;
		}else if("322".equals(sunpath)) {
			gName = " 按适用学段、年级浏览 &gt; 高中 &gt; 必修二" ;
		}else if("323".equals(sunpath)) {
			gName = " 按适用学段、年级浏览 &gt; 高中 &gt; 必修三" ;
		}else if("327".equals(sunpath)) {
			gName = " 按适用学段、年级浏览 &gt; 高中 &gt; 选修一" ;
		}else if("325".equals(sunpath)) {
			gName = " 按适用学段、年级浏览 &gt; 高中 &gt; 选修二" ;
		}else if("326".equals(sunpath)) {
			gName = " 按适用学段、年级浏览 &gt; 高中 &gt; 选修三" ;
		}else if("326".equals(sunpath)) {
			gName = " 按适用学段、年级浏览 &gt; 高中 &gt; 选修四" ;
		}else if("326".equals(sunpath)) {
			gName = " 按适用学段、年级浏览 &gt; 高中 &gt; 选修五" ;
		}else if("326".equals(sunpath)) {
			gName = " 按适用学段、年级浏览 &gt; 高中 &gt; 选修六" ;
		}else if("324".equals(sunpath)) {
			gName = " 按适用学段、年级浏览 &gt; 高中 &gt; 高中竞赛" ;
		}
		
		if(!"".equals(gName)) {
			bname += gName;
		}
		if (!name.equals(""))
			bname += " &gt; " + name ;
		return bname ;
	}
	
	/**
	 * 历史上的今天列表，根据当前信息返回面包屑
	 * @param eventExecutor
	 * @param paramName
	 * @param name
	 * @param id
	 * @return
	 */
	public static String returnHisListName(String name,String today,String title) {
		String qname = name + " &gt; " + today.substring(0,10);
		if(!"".equals(title)){
			qname += " &gt; " + title;
		}
		return qname;
	}
	
	/**
	 * 详细页面，按资源查询，根据当前信息返回面包屑
	 * @param eventExecutor
	 * @param paramName
	 * @param name
	 * @param id
	 * @return
	 */
	public static String returnResourcePath(String rrType, String paramName, String name, String id) {
		String bname = "" ;
		String path = rrType ;
		String gName = "" ;
		if("1011".equals(path)) {
			gName = " 按资源类型浏览  &gt; 素材 &gt; 高清图片" ;
		}else if("1022".equals(path)) {
			gName = " 按资源类型浏览 &gt; 素材 &gt; 3D图片" ;
		}else if("1073".equals(path)) {
			gName = " 按资源类型浏览 &gt; 素材 &gt; 音频" ;
		}else if("1084".equals(path)) {
			gName = " 按资源类型浏览 &gt; 素材 &gt; 高清视频" ;
		}else if("1006".equals(path)) {
			gName = " 按资源类型浏览 &gt; 素材 &gt; 其他素材" ;
		}else if("2041".equals(path)) {
			gName = " 按资源类型浏览 &gt; 课件 &gt; PPT课件" ;
		}else if("2002".equals(path)) {
			gName = " 按资源类型浏览 &gt; 课件 &gt; Flash课件" ;
		}else if("2033".equals(path)) {
			gName = " 按资源类型浏览 &gt; 课件 &gt; WORD课件" ;
		}else if("2004".equals(path)) {
			gName = " 按资源类型浏览 &gt; 课件 &gt; 其他课件" ;
		}else if("3031".equals(path)) {
			gName = " 按资源类型浏览 &gt; 文献资料 &gt; 环球百科" ;
		}
		
		if(!"".equals(gName)) {
			bname += gName;
		}
		if (!name.equals(""))
			bname += " &gt; " + name + "";
		return bname ;
	}
	
	/**
	 * 查行文件是否符合资源文件类型
	 * @param fileType 文件格式
	 * @param resType 资源文件类型
	 **/
	public static boolean resourceFileIsOK(String fileType,String isType) {
		fileType = fileType.substring(fileType.lastIndexOf(".")).replace(".", "");
		boolean fileType_ = false;
		if(isType.equals("1011") && Constant.imageFormat.contains(fileType)) { //图片
			fileType_ = true;
		}else if(isType.equals("1084") && Constant.videoFormat.contains(fileType)) {	//视频
			fileType_ = true;
		}else if(isType.equals("2033") && Constant.wordFormat.contains(fileType)) {	//word
			fileType_ = true;
		}else if(isType.equals("2041") && Constant.pptFormat.contains(fileType)) { //ppt
			fileType_ = true;
		}else if(isType.equals("2055") && Constant.pdfFormat.contains(fileType)) { //ppt
			fileType_ = true;
		}else if(isType.equals("2002") && Constant.flashFormat.contains(fileType)) {	//虚拟
			fileType_ = true;
		}else if(isType.equals("4033") && Constant.rarFormat.contains(fileType)) {	//压缩文件
			fileType_ = true;
		}else if(isType.equals("1073") && Constant.audioFormat.contains(fileType)) {	//音频文件
			fileType_ = true;
		}
		return fileType_ ;
	}
	
	/**
	 * 列表页面，按资源查询，根据当前信息返回面包屑
	 * @param eventExecutor
	 * @param paramName
	 * @param name
	 * @param id
	 * @return
	 */
	public static String returnResourceListPath(String resType) {
		String path = resType;
		String gName = "" ;
		if("1011".equals(path)) {
			gName = " 按资源类型浏览 &gt; 素材 &gt; 高清图片" ;
		}else if("1022".equals(path)) {
			gName = " 按资源类型浏览 &gt; 素材 &gt; 3D图片" ;
		}else if("1073".equals(path)) {
			gName = " 按资源类型浏览 &gt; 素材 &gt; 音频" ;
		}else if("1084".equals(path)) {
			gName = " 按资源类型浏览 &gt; 素材 &gt; 高清视频" ;
		}else if("1005".equals(path)) {
			gName = " 按资源类型浏览 &gt; 素材 &gt; 虚拟仿真实验素材" ;
		}else if("1006".equals(path)) {
			gName = " 按资源类型浏览 &gt; 素材 &gt; 其他素材" ;
		}else if("2041".equals(path)) {
			gName = " 按资源类型浏览 &gt; 课件 &gt; PPT课件 " ;
		}else if("2002".equals(path)) {
			gName = " 按资源类型浏览 &gt; 课件 &gt; Flash课件" ;
		}else if("2033".equals(path)) {
			gName = " 按资源类型浏览 &gt; 课件 &gt; WORD课件" ;
		}else if("2004".equals(path)) {
			gName = " 按资源类型浏览 &gt; 课件 &gt; 其他课件" ;
		}else if("2055".equals(path)) {
			gName = " 按资源类型浏览 &gt; 课件 &gt; PDF课件" ;
		}else if("3031".equals(path)) {
			gName = " 按资源类型浏览 &gt; 文献资料 &gt; 环球百科" ;
		}else if("3032".equals(path)) {
			gName = " 按资源类型浏览 &gt; 文献资料 &gt; 文学报告" ;
		}else if("3033".equals(path)) {
			gName = " 按资源类型浏览 &gt; 文献资料 &gt; 论文资料" ;
		}else if("3034".equals(path)) {
			gName = " 按资源类型浏览 &gt; 文献资料 &gt; 资料图书" ;
		}else if("3035".equals(path)) {
			gName = " 按资源类型浏览 &gt; 文献资料 &gt; 适用学段、年级与大纲" ;
		}else if("3036".equals(path)) {
			gName = " 按资源类型浏览 &gt; 文献资料 &gt; 其他资料" ;
		}
		return gName ;
	}
	
	/**
	 * 列表页面，按资源查询，根据当前信息返回面包屑
	 * @param eventExecutor
	 * @param paramName
	 * @param name
	 * @param id
	 * @return
	 */
	public static String returnResourceListPathText(String resType,String cateLevel) {
		String gpath = "" ;
		if("exhibition".endsWith(resType)){
			if("2".equals(cateLevel)) {
				gpath = StringUtil.reResAbbreviated(resType)+"TotalID" ;
			}else if("3".equals(cateLevel)) {
				gpath = StringUtil.reResAbbreviated(resType)+"JieID" ;
			}else if("4".equals(cateLevel)) {
				gpath = StringUtil.reResAbbreviated(resType)+"ChorID" ;
			}else if("5".equals(cateLevel)) {
				gpath = StringUtil.reResAbbreviated(resType)+"GangID" ;
			}
		}
		if("observation".endsWith(resType)){
			if("2".equals(cateLevel)) {
				gpath = StringUtil.reResAbbreviated(resType)+"Category" ;
			}else if("3".equals(cateLevel)) {
				gpath = StringUtil.reResAbbreviated(resType)+"CateTwLevel" ;
			}
		}
		if("laboratory".endsWith(resType)){
			if("2".equals(cateLevel)) {
				gpath = StringUtil.reResAbbreviated(resType)+"Category" ;
			}else if("3".equals(cateLevel)) {
				gpath = StringUtil.reResAbbreviated(resType)+"CateTwLevel" ;
			}
		}
		if("projection".endsWith(resType)){
			if("2".equals(cateLevel)) {
				gpath = StringUtil.reResAbbreviated(resType)+"Category" ;
			}else if("3".equals(cateLevel)) {
				gpath = StringUtil.reResAbbreviated(resType)+"CateTwLevel" ;
			}
		}
		return gpath ;
	}
	
}
