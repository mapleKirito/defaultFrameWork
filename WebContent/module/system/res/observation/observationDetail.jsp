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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
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
<script type="text/javascript">
var gridTreeTB,treeTB;
$(document).ready(function(){	
});
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top: 0; width: 160px;"></ul>
</div>
<input type="hidden" name="code" value="${code}"> 
<input name="paramMap.orID" type="hidden" id="orID" value="${initMap.obseInfo.orID}"/>
<input type="hidden" name="imitateStep" value="${pmsIndex.res_observation_room_mgr.imitationStep}">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<div>
								<table class="table_9" cellSpacing="1" cellPadding="0" width="100%" border="0" style="background-color: #F5F9FC;">
									<tr  bgcolor="#f5f9fc">
										<td align="right" class="tatd" width="15%">资源编号：</td>
										<td class="tatd">${initMap.obseInfo.orNO}</td>
										</tr>
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">资源名称：</td>
											<td class="tatd">${initMap.obseInfo.orName}</td>
										</tr>
									   	<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">资源类型：</td>
											<td  class="tatd"> 
												${initMap.obseInfo.orType eq "1011" ? '高清图片':'' }
												${initMap.obseInfo.orType eq "1022" ? '3D图片':'' }
												${initMap.obseInfo.orType eq "1084" ? '高清视频':'' }
												${initMap.obseInfo.orType eq "4033" ? 'RAR/ZIP':'' }
											</td>
									   	</tr>
									   	<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源分类：</td>
										<td width="85%" class="tatd" align="left">
											${initMap.obseInfo.orCategoryName}
										</td>
										<s:if test="initMap.obseInfo.orCateTwLevelName != null && initMap.obseInfo.orCateTwLevelName !='' ">
										<tr bgcolor="#ae9b84">
											<td width="15%" class="tatd" align="right">二级分类：</td>
											<td width="85%" class="tatd" align="left">
												${initMap.obseInfo.orCateTwLevelName}
											</td>
										</tr>
										</s:if>
									   	<%-- <s:if test="initMap.obseInfo.orCustom != null && initMap.obseInfo.orCustom !='' ">
									   	<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">俗名：</td>
											<td  class="tatd"> 
												${initMap.obseInfo.orCustom}
											</td>
									   	</tr>
									   	</s:if> --%>
									   	<%-- <s:if test="initMap.obseInfo.orLatinName != null && initMap.obseInfo.orLatinName !='' ">
									   	<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">拉丁学名：</td>
											<td  class="tatd"> 
												${initMap.obseInfo.orLatinName}
											</td>
									   	</tr>
									   	</s:if>
									   	
										<s:if test="initMap.obseInfo.orIdentifier != null && initMap.obseInfo.orIdentifier !='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">鉴定人：</td>
											<td class="tatd">${initMap.obseInfo.orIdentifier}</td>
										</tr>
										</s:if> --%>
										<s:if test="initMap.obseInfo.orDescription != null && initMap.obseInfo.orDescription !='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">详细说明：</td>
											<td class="tatd">${initMap.obseInfo.orDescription}</td>
										</tr>
										</s:if>
										<s:if test="initMap.obseInfo.orRemarks != null && initMap.obseInfo.orRemarks !='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">备注：</td>
											<td class="tatd">${initMap.obseInfo.orRemarks}</td>
										</tr>
										</s:if>
										<s:if test="initMap.obseInfo.orThumbnail != null && initMap.obseInfo.orThumbnail !='' ">
										<tr  bgcolor="#f5f9fc">
											<td align="right" class="tatd" width="15%">缩略图：</td>
											<td class="tatd">
												<img alt="" src="${initMap.obseInfo.orThumbnail}" width="50px" height="50px">
											</td>
										</tr>
										</s:if>
										<tr  bgcolor="#f5f9fc" align="center">
											<td colSpan="2" class="tatd"><input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
										</tr>
								</table>
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
</form>
</body>
</html>
