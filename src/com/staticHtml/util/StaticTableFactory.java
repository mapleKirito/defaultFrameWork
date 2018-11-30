package com.staticHtml.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.staticHtml.bean.PageInfoBean;
import com.staticHtml.bean.TableBean;

public class StaticTableFactory {
	public static PageInfoBean getPageInfoBeanExhibition(HashMap paramMap){
		PageInfoBean pib=new PageInfoBean();
		if(paramMap.get("erAudio")!=null){
			pib.setAudioPath(paramMap.get("erAudio").toString());
		}
		List<TableBean> staticTbList=new ArrayList<TableBean>();
			staticTbList.add(new TableBean("资源编号", (String)paramMap.get("erCode")));
			staticTbList.add(new TableBean("资源名称", (String)paramMap.get("erName")));
			staticTbList.add(new TableBean("资源类型", paramMap.get("erType").toString().equals("1011")?"高清图片":""));
		pib.setResType("pic");
			staticTbList.add(new TableBean("一级分类", (String)paramMap.get("erTotal")));
		
		if(paramMap.get("erJie")!=null&&!paramMap.get("erJie").toString().equals(""))
			staticTbList.add(new TableBean("二级分类", (String)paramMap.get("erJie")));
		/*if(paramMap.get("erSeco")!=null&&!paramMap.get("erSeco").toString().equals(""))
				staticTbList.add(new TableBean("三级分类", (String)paramMap.get("erSeco")));*/
		if(paramMap.get("erChor")!=null&&!paramMap.get("erChor").toString().equals(""))
				staticTbList.add(new TableBean("四级分类", (String)paramMap.get("erChor")));
		if(paramMap.get("erGang")!=null&&!paramMap.get("erGang").toString().equals(""))
				staticTbList.add(new TableBean("五级分类", (String)paramMap.get("erGang")));
		if(paramMap.get("erOrder")!=null&&!paramMap.get("erOrder").toString().equals(""))
				staticTbList.add(new TableBean("六级分类", (String)paramMap.get("erOrder")));
		if(paramMap.get("erCategoryName")!=null&&!paramMap.get("erCategoryName").toString().equals(""))
				staticTbList.add(new TableBean("七级分类", (String)paramMap.get("erCategoryName")));
		/*if(paramMap.get("erGenus")!=null&&!paramMap.get("erGenus").toString().equals(""))
				staticTbList.add(new TableBean("中文属名", (String)paramMap.get("erGenus")));*/
		/*if(paramMap.get("erCustom")!=null&&!paramMap.get("erCustom").toString().equals(""))
			staticTbList.add(new TableBean("俗名", (String)paramMap.get("erCustom")));*/
		/*if(paramMap.get("erLatinName")!=null&&!paramMap.get("erLatinName").toString().equals(""))
			staticTbList.add(new TableBean("拉丁学名", (String)paramMap.get("erLatinName")));
		if(paramMap.get("erBiologicalReserve")!=null&&!paramMap.get("erBiologicalReserve").toString().equals(""))
			staticTbList.add(new TableBean("保存地", (String)paramMap.get("erBiologicalReserve")));
		if(paramMap.get("erHunters")!=null&&!paramMap.get("erHunters").toString().equals(""))
			staticTbList.add(new TableBean("采集人", (String)paramMap.get("erHunters")));
		if(paramMap.get("erSpecimensNo")!=null&&!paramMap.get("erSpecimensNo").toString().equals(""))
			staticTbList.add(new TableBean("采集编号", (String)paramMap.get("erSpecimensNo")));*/
		if(paramMap.get("erCountryName")!=null&&!paramMap.get("erCountryName").toString().equals(""))
			staticTbList.add(new TableBean("国家", (String)paramMap.get("erCountryName")));
		if(paramMap.get("erProvinceName")!=null&&!paramMap.get("erProvinceName").toString().equals(""))
			staticTbList.add(new TableBean("省份", (String)paramMap.get("erProvinceName")));
		if(paramMap.get("erCityName")!=null&&!paramMap.get("erCityName").toString().equals(""))
			staticTbList.add(new TableBean("市区县", (String)paramMap.get("erCityName")));
		/*if(paramMap.get("erPlaceName")!=null&&!paramMap.get("erPlaceName").toString().equals(""))
			staticTbList.add(new TableBean("出土地", (String)paramMap.get("erPlaceName")));*/
		if(paramMap.get("erLoLaName")!=null&&!paramMap.get("erLoLaName").toString().equals(""))
				staticTbList.add(new TableBean("分布地区", (String)paramMap.get("erLoLaName")));
		/*if(paramMap.get("erHabitat")!=null&&!paramMap.get("erHabitat").toString().equals(""))
				staticTbList.add(new TableBean("生境", (String)paramMap.get("erHabitat")));
		if(paramMap.get("erCharacteristics")!=null&&!paramMap.get("erCharacteristics").toString().equals(""))
				staticTbList.add(new TableBean("性状", (String)paramMap.get("erCharacteristics")));
		if(paramMap.get("erDescription")!=null&&!paramMap.get("erDescription").toString().equals(""))
				staticTbList.add(new TableBean("描述", (String)paramMap.get("erDescription")));
		if(paramMap.get("erElevation")!=null&&!paramMap.get("erElevation").toString().equals(""))
				staticTbList.add(new TableBean("海拔", (String)paramMap.get("erElevation")));
		if(paramMap.get("erIdentifier")!=null&&!paramMap.get("erIdentifier").toString().equals(""))
				staticTbList.add(new TableBean("鉴定人", (String)paramMap.get("erIdentifier")));
		if(paramMap.get("erIdentifierDate")!=null&&!paramMap.get("erIdentifierDate").toString().equals(""))
				staticTbList.add(new TableBean("鉴定日期", (String)paramMap.get("erIdentifierDate")));
		if(paramMap.get("erUse")!=null&&!paramMap.get("erUse").toString().equals(""))
				staticTbList.add(new TableBean("用途", (String)paramMap.get("erUse")));*/
		if(paramMap.get("erRemarks")!=null&&!paramMap.get("erRemarks").toString().equals(""))
				staticTbList.add(new TableBean("备注", (String)paramMap.get("erRemarks")));
		if(paramMap.get("erLoLa")!=null&&!paramMap.get("erLoLa").toString().equals(""))
			pib.setDingwei((String)paramMap.get("erLoLa"));
		pib.setTableList(staticTbList);
		return pib;
	}
	
	public static PageInfoBean getPageInfoBeanLaboratory(HashMap paramMap){
		PageInfoBean pib=new PageInfoBean();
		List<TableBean> staticTbList=new ArrayList<TableBean>();
			staticTbList.add(new TableBean("资源编号", (String)paramMap.get("lrNO")));
			staticTbList.add(new TableBean("资源名称", (String)paramMap.get("lrName")));
		String tmp="";
		if(paramMap.get("lrType").toString().equals("1011")){
			tmp="高清图片";
			pib.setResType("pic");
		}else if(paramMap.get("lrType").toString().equals("1084")){
			tmp="高清视频";
			pib.setResType("video");
		}else if(paramMap.get("lrType").toString().equals("2033")){
			tmp="WORD课件";
			pib.setResType("wendang");
		}
		else if(paramMap.get("lrType").toString().equals("2041")){
			tmp="PPT课件";
			pib.setResType("wendang");
		}
		else if(paramMap.get("lrType").toString().equals("2055")){
			tmp="PDF课件";
			pib.setResType("wendang");
		}
		else if(paramMap.get("lrType").toString().equals("2002")){
			tmp="虚拟仿真实验";
			pib.setResType("shiyan");
		}
		if(paramMap.get("lrType")!=null&&!paramMap.get("lrType").toString().equals(""))
				staticTbList.add(new TableBean("资源类型", tmp));
			staticTbList.add(new TableBean("资源分类", (String)paramMap.get("lrCategoryName")));
		
		if(paramMap.get("lrCateTwLevelName")!=null)
			staticTbList.add(new TableBean("二级分类", (String)paramMap.get("lrCateTwLevelName")));
		pib.setTableList(staticTbList);
		return pib;
	}
	public static PageInfoBean getPageInfoBeanObservation(HashMap paramMap){
		PageInfoBean pib=new PageInfoBean();
		List<TableBean> staticTbList=new ArrayList<TableBean>();
			staticTbList.add(new TableBean("资源编号", (String)paramMap.get("orNO")));
			staticTbList.add(new TableBean("资源名称", (String)paramMap.get("orName")));
		String tmp="";
		if(paramMap.get("orType").toString().equals("1011")){
			tmp="高清图片";
			pib.setResType("pic");
		}else if(paramMap.get("orType").toString().equals("1022")){
			tmp="3D图片";
			pib.setResType("pic");
		}else if(paramMap.get("orType").toString().equals("4033")){
			tmp="压缩包格式文件";
			pib.setResType("duowei");
		}
		if(paramMap.get("orType")!=null&&!paramMap.get("orType").toString().equals(""))
				staticTbList.add(new TableBean("资源类型", tmp));
			staticTbList.add(new TableBean("资源分类", (String)paramMap.get("orCategoryName")));
		
		if(paramMap.get("orCateTwLevelName")!=null&&!paramMap.get("orCateTwLevelName").toString().equals(""))
			staticTbList.add(new TableBean("二级分类", (String)paramMap.get("orCateTwLevelName")));
		/*if(paramMap.get("orCustom")!=null&&!paramMap.get("orCustom").toString().equals(""))
				staticTbList.add(new TableBean("俗名", (String)paramMap.get("orCustom")));*/
		/*if(paramMap.get("orLatinName")!=null&&!paramMap.get("orLatinName").toString().equals(""))
				staticTbList.add(new TableBean("拉丁学名", (String)paramMap.get("orLatinName")));*/
		if(paramMap.get("orDescription")!=null&&!paramMap.get("orDescription").toString().equals(""))
				staticTbList.add(new TableBean("描述", (String)paramMap.get("orDescription")));
		if(paramMap.get("orRemarks")!=null&&!paramMap.get("orRemarks").toString().equals(""))
				staticTbList.add(new TableBean("说明", (String)paramMap.get("orRemarks")));
		pib.setTableList(staticTbList);
		return pib;
	}
	public static PageInfoBean getPageInfoBeanProjection(HashMap paramMap){
		PageInfoBean pib=new PageInfoBean();
		List<TableBean> staticTbList=new ArrayList<TableBean>();
			staticTbList.add(new TableBean("资源编号", (String)paramMap.get("prNO")));
			staticTbList.add(new TableBean("资源名称", (String)paramMap.get("prName")));
		String tmp="";
		if(paramMap.get("prType").toString().equals("1011")){
			tmp="高清图片";
			pib.setResType("pic");
		}else if(paramMap.get("prType").toString().equals("1084")){
			tmp="高清视频";
			pib.setResType("video");
		}else if(paramMap.get("prType").toString().equals("2041")){
			tmp="PPT课件";
			pib.setResType("wendang");
		}else if(paramMap.get("prType").toString().equals("2055")){
			tmp="PDF课件";
			pib.setResType("wendang");
		}else if(paramMap.get("prType").toString().equals("2033")){
			tmp="WORD课件";
			pib.setResType("wendang");
		}
		if(paramMap.get("prType")!=null&&!paramMap.get("prType").toString().equals(""))
				staticTbList.add(new TableBean("资源类型", tmp));
			staticTbList.add(new TableBean("资源分类", (String)paramMap.get("prCategoryName")));
		
		if(paramMap.get("lrCateTwLevelName")!=null&&!paramMap.get("lrCateTwLevelName").toString().equals(""))
			staticTbList.add(new TableBean("二级分类", (String)paramMap.get("prCateTwLevelName")));
		pib.setTableList(staticTbList);
		return pib;
	}
	
	public static PageInfoBean getPageInfoBeanLovely(HashMap paramMap){
		PageInfoBean pib=new PageInfoBean();
		List<TableBean> staticTbList=new ArrayList<TableBean>();
			staticTbList.add(new TableBean("资源编号", (String)paramMap.get("crNo")));
			staticTbList.add(new TableBean("资源名称", (String)paramMap.get("crName")));
		String tmp="";
		if(paramMap.get("crType").toString().equals("1011")){
			tmp="高清图片";
			pib.setResType("pic");
		}else if(paramMap.get("crType").toString().equals("1084")){
			tmp="高清视频";
			pib.setResType("video");
		}else if(paramMap.get("crType").toString().equals("2033")){
			tmp="WORD课件";
			pib.setResType("wendang");
		}
		else if(paramMap.get("crType").toString().equals("2041")){
			tmp="PPT课件";
			pib.setResType("wendang");
		}
		else if(paramMap.get("crType").toString().equals("2055")){
			tmp="PDF课件";
			pib.setResType("wendang");
		}
		else if(paramMap.get("crType").toString().equals("2002")){
			tmp="虚拟仿真实验";
			pib.setResType("shiyan");
		}
		if(paramMap.get("crType")!=null&&!paramMap.get("crType").toString().equals(""))
				staticTbList.add(new TableBean("资源类型", tmp));
			staticTbList.add(new TableBean("资源分类", (String)paramMap.get("crResTypeName")));
		
		if(paramMap.get("crCateTwLevelName")!=null&&!paramMap.get("crCateTwLevelName").toString().equals(""))
			staticTbList.add(new TableBean("二级分类", (String)paramMap.get("crCateTwLevelName")));
		if(paramMap.get("crMarkes")!=null&&!paramMap.get("crMarkes").toString().equals(""))
				staticTbList.add(new TableBean("说明", (String)paramMap.get("crMarkes")));
		pib.setTableList(staticTbList);
		return pib;
	}
}
