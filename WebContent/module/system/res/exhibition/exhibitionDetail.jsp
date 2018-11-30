
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.autocomplete.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/progressBar.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/progressBar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rsync_progress_bar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dataUtils.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/res/category.js"></script>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<div>
								<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
									<table class="table_9" cellSpacing="1" cellPadding="0" width="100%" border="0" style="background-color: #F5F9FC;">
										<tr  bgcolor="#f5f9fc">
											<td align="right"  class="tatd "width="15%">条形码号：</td>
											<td class="tatd">${initMap.exhiInfo.erCode}</td>
										</tr>
										<tr  bgcolor="#f5f9fc">
											<td align="right"  class="tatd"width="15%">资源名称：</td>
											<td class="tatd">${initMap.exhiInfo.erName}</td>
										</tr>
										<s:if test="initMap.exhiInfo.erTotal != null && initMap.exhiInfo.erTotal!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right"  class="tatd" width="10%">资源分类：</td>
											<td class="tatd" > 
											  ${initMap.exhiInfo.erTotal}
											</td>
										</tr>
										</s:if>
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">资源类型：</td>
											<td  class="tatd"> 
												${initMap.exhiInfo.erType eq "1011" ? '高清图片':'' }
											</td>
									   	</tr>
									   <s:if test="initMap.exhiInfo.erJie != null && initMap.exhiInfo.erJie!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">二级分类：</td>
											<td  class="tatd"> 
												${initMap.exhiInfo.erJie}&nbsp;
											</td>
									   	</tr>
									   	</s:if>
									   	
									   	<s:if test="initMap.exhiInfo.erChor != null && initMap.exhiInfo.erChor!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">三级分类：</td>
											<td  class="tatd"> 
												${initMap.exhiInfo.erChor}&nbsp;
											</td>
									   	</tr>
									   	</s:if>
									   	
									   	<s:if test="initMap.exhiInfo.erGang != null && initMap.exhiInfo.erGang!='' ">
									   	<tr  bgcolor="#f5f9fc">
											<td align="right"  class="tatd" width="15%">四级分类：</td>
											<td class="tatd" > 
												${initMap.exhiInfo.erGang}&nbsp;
											</td>
									   	</tr>
									   	</s:if>
									   <%-- 	<s:if test="initMap.exhiInfo.erOrder != null && initMap.exhiInfo.erOrder!='' ">
									   	<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">五级分类：</td>
											<td class="tatd" > 
												${initMap.exhiInfo.erOrder}&nbsp;
											</td>
									   	</tr>
									   	</s:if> --%>
									   <%-- 	<s:if test="initMap.exhiInfo.erCategoryName != null && initMap.exhiInfo.erCategoryName!='' ">
									   	<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">中文科名：</td>
											<td class="tatd" > 
												${initMap.exhiInfo.erCategoryName}&nbsp;
											</td>
									   	</tr>
									   	</s:if> --%>
									   	<%-- <s:if test="initMap.exhiInfo.erGenus != null && initMap.exhiInfo.erGenus!='' ">
									   	<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">中文属名：</td>
											<td  class="tatd"> 
												${initMap.exhiInfo.erGenus}&nbsp;
											</td>
									   	</tr>
									   	</s:if> --%>
									   	<%-- <s:if test="initMap.exhiInfo.erCustom != null && initMap.exhiInfo.erCustom!='' ">
									   	<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">俗名：</td>
											<td class="tatd" > 
												${initMap.exhiInfo.erCustom}
											</td>
									   	</tr>
									   	</s:if> --%>
									   	 <%-- <s:if test="initMap.exhiInfo.erLatinName != null && initMap.exhiInfo.erLatinName!='' ">
									   	<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">拉丁学名：</td>
											<td class="tatd" > 
												${initMap.exhiInfo.erLatinName}
											</td>
									   	</tr>
									   		</s:if>
									   	<s:if test="initMap.exhiInfo.erHunters != null && initMap.exhiInfo.erHunters!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">采集人：</td>
											<td class="tatd">${initMap.exhiInfo.erHunters}</td>
										</tr>
											</s:if>
										<s:if test="initMap.exhiInfo.erSpecimensNo != null && initMap.exhiInfo.erSpecimensNo!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">采集号：</td>
											<td class="tatd">${initMap.exhiInfo.erSpecimensNo}</td>
										</tr>
										</s:if>
										<s:if test="initMap.exhiInfo.erSpecimensDate != null && initMap.exhiInfo.erSpecimensDate!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">采集日期：</td>
											<td class="tatd">
												<fmt:formatDate value='${initMap.exhiInfo.erSpecimensDate }' pattern='yyyy-MM-dd' />
											</td>
										</tr>
										</s:if> --%>
										<s:if test="initMap.exhiInfo.erArea != null && initMap.exhiInfo.erArea!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="10%">选择地区：</td>
											<td class="tatd" > 
												${initMap.exhiInfo.erArea == null ? initMap.exhiInfo.erCityName : initMap.exhiInfo.erAreaName }
											</td>
										</tr>
										</s:if>
										<%-- <s:if test="initMap.exhiInfo.erPlaceName != null && initMap.exhiInfo.erPlaceName!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">出土地：</td>
											<td class="tatd">${initMap.exhiInfo.erPlaceName}</td>
										</tr>
										</s:if>
										<s:if test="initMap.exhiInfo.erLongitude != null && initMap.exhiInfo.erLongitude!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">经度：</td>
											<td class="tatd">${initMap.exhiInfo.erLongitude}</td>
										</tr>
										</s:if>
										<s:if test="initMap.exhiInfo.erLatitude != null && initMap.exhiInfo.erLatitude!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right"  class="tatd" width="15%">纬度：</td>
											<td class="tatd" >${initMap.exhiInfo.erLatitude}</td>
										</tr>
										</s:if>
										<s:if test="initMap.exhiInfo.erHabitat != null && initMap.exhiInfo.erHabitat!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">生境：</td>
											<td class="tatd" >${initMap.exhiInfo.erHabitat}</td>
										</tr>
										</s:if>
										<s:if test="initMap.exhiInfo.erCharacteristics != null && initMap.exhiInfo.erCharacteristics!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">性状：</td>
											<td class="tatd" >${initMap.exhiInfo.erCharacteristics}</td>
										</tr>
										</s:if>
										
										<s:if test="initMap.exhiInfo.erElevation != null && initMap.exhiInfo.erElevation!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">海拔：</td>
											<td class="tatd">${initMap.exhiInfo.erElevation}</td>
										</tr>
										</s:if>
										<s:if test="initMap.exhiInfo.erIdentifier != null && initMap.exhiInfo.erIdentifier!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">鉴定人：</td>
											<td class="tatd">${initMap.exhiInfo.erIdentifier}</td>
										</tr>
										</s:if>
										<s:if test="initMap.exhiInfo.erIdentifierDate != null && initMap.exhiInfo.erIdentifierDate!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">鉴定日期：</td>
											<td class="tatd"><fmt:formatDate value='${initMap.exhiInfo.erIdentifierDate }' pattern='yyyy-MM-dd' /></td>
										</tr>
										</s:if>
										<s:if test="initMap.exhiInfo.erUse != null && initMap.exhiInfo.erUse!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">用途：</td>
											<td class="tatd">${initMap.exhiInfo.erUse}</td>
										</tr>
										</s:if> --%>
										<s:if test="initMap.exhiInfo.erDescription != null && initMap.exhiInfo.erDescription!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd"  width="15%">详细说明：</td>
											<td class="tatd" >${initMap.exhiInfo.erDescription}</td>
										</tr>
										</s:if>
										<s:if test="initMap.exhiInfo.erRemarks != null && initMap.exhiInfo.erRemarks!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">备注：</td>
											<td class="tatd">${initMap.exhiInfo.erRemarks}</td>
										</tr>
										</s:if>
										<s:if test="initMap.exhiInfo.erThumbnail != null && initMap.exhiInfo.erThumbnail!='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">缩略图：</td>
											<td class="tatd"> 
												<img alt="" src="${initMap.exhiInfo.erThumbnail}" width="50px" height="50px">
											</td>
										</tr>
										</s:if>
										
										<tr  bgcolor="#f5f9fc" align="center">
											<td colSpan="2"  class="tatd"><input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
										</tr>
									</table>
                         		</form>
							</div>						
						 </td>
				      </tr>
					</table>
			  	</td>
			</tr>
		</table>
	</td>
  </tr>
</table>
</body>
</html>
