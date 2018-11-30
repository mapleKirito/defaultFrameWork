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
<input name="paramMap.crID" type="hidden" id="crID" value="${initMap.lovely.crID}"/>
<input type="hidden" name="imitateStep" value="${pmsIndex.res_lovely_room_mgr.imitationStep}">
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
	<tr>
		<td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					<tr >
						<td width="100%" bgcolor="#E8E8E8" valign="top">
						<table class="table_9" cellSpacing="1" cellPadding="0" width="100%" border="0" style="background-color: #F5F9FC;">
							<tr bgcolor="#ae9b84">
								<td align="right" class="tatd" width="15%">资源分类：</td>
								<td  class="tatd">${initMap.lovelyInfo.crResTypeName}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="tatd" width="15%">二级分类：</td>
								<td  class="tatd">${initMap.lovelyInfo.crCateTwLevelName}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="tatd" width="15%">资源名称：</td>
								<td class="tatd">${initMap.lovelyInfo.crName}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="tatd" width="15%">资源类型：</td>
								<td class="tatd">
									${initMap.lovelyInfo.crType eq "1011" ? '高清图片':'' }
									${initMap.lovelyInfo.crType eq "1084" ? '高清视频':'' }
									${initMap.lovelyInfo.crType eq "2041" ? 'PPT课件':'' }
									${initMap.lovelyInfo.crType eq "2033" ? 'WORD课件':'' }
									${initMap.lovelyInfo.crType eq "2055" ? 'PDF课件':'' }
								</td>
							</tr>
							<s:if test="initMap.lovelyInfo.crContent != null && initMap.lovelyInfo.crContent !='' ">
							<tr bgcolor="#ae9b84">
								<td align="right" class="tatd" width="15%">详细内容：</td>
								<td class="tatd">${initMap.lovelyInfo.crContent}</td>
							</tr>
							</s:if>
							<s:if test="initMap.lovelyInfo.crThumbnail != null && initMap.lovelyInfo.crThumbnail !='' ">
							
							<tr bgcolor="#ae9b84">
								<td align="right" class="tatd" width="15%">缩略图：</td>
								<td class="tatd">
									<img alt="" src="${initMap.lovelyInfo.crThumbnail}" width="50px" height="50px">
								</td>
							</tr>
							</s:if>
							
							<tr class="MeNewTDLine" align="center">
								<td colSpan="2" class="tatd"><input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
							</tr>
						</table>
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
