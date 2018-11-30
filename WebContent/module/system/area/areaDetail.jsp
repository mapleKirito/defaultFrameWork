
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
						<td width="100%" bgcolor="#e8e8e8" valign="top">
							<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
							<table class="table_9" cellSpacing="1" cellPadding="0" width="100%" border="0" style="background-color: #F5F9FC;">
								<s:if test="#request.initMap.areaInfo.orgParentID!=0">
									<tr bgcolor="#ae9b84" >
										<td align="right" class="tatd" width="10%">上级分类：</td>
										<td class="tatd">&nbsp;
										
										<s:if test='initMap.areaInfo.areaParentName == "椤剁骇鍦板尯" '>
											顶级地区
										</s:if>
										<s:else>
											${initMap.areaInfo.areaParentName }
										</s:else>
										</td>
									</tr>
								</s:if>	
								<tr bgcolor="#ae9b84" >
									<td align="right" class="tatd" width="10%">分类名称：</td>
									<td class="tatd">&nbsp;${initMap.areaInfo.areaName}</td>
								</tr>				
								<tr bgcolor="#ae9b84" >
									<td align="right" class="tatd" width="10%">分类标识：</td>
									<td class="tatd">&nbsp;${initMap.areaInfo.areaSign}</td>
								</tr>
								<tr bgcolor="#ae9b84" >
									<td align="right" class="tatd">创建时间：</td>
									<td class="tatd">&nbsp;${initMap.areaInfo.areaCreateTime}</td>
								</tr>
								<tr bgcolor="#ae9b84" >
									<td align="right" class="tatd">创建者：</td>
									<td class="tatd">&nbsp;${initMap.areaInfo.areaCreator}</td>
								</tr>
								<tr bgcolor="#ae9b84"  align="center">
									<td colSpan="2" class="tatd"><input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
								</tr>
							</table>
	                         </form>
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
