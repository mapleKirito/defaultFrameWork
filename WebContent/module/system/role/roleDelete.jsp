<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<%
	String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();	
%>
<html>
<head>
<title></title>
</head>
<body style="background-color: #F7F2FF; margin-top: 100;">
<form name="actionForm" method="post" id="actionForm"  action="uploadDataAction.action">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.roleID" value="${paramMap.roleID}"> 
<input type="hidden" name="paramMap.name" value="${paramMap.roleName}">
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_role_mgr.imitationStep}">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
	<tr>
		<td class="tableCcenter">
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
			<tr>
				<td class="SkyTDLine">
				<table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="100%" border="0">
					<tr class="MeNewTDLine" align="center">
						<td align="left"> 
							<table width="300" align="center" border="0" cellpadding="0" cellspacing="0" class="tableT">
								<tr>
									<td class="tableTleft">&nbsp;</td>
									<td class="tableTcenter">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="46%" valign="middle">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="5%">
													<div align="center"><img src="<%=request.getContextPath()%>/images/window/message.png"></div>
													</td>
													<td width="95%" class="tableTBig">${promptInfo.contentDescInfo}</td>
												</tr>
											</table>
											</td>
											<td width="54%">&nbsp;</td>
										</tr>
									</table>
									</td>
									<td class="tableTright">&nbsp;</td>
								</tr>
							</table>
							<table width="300" align="center" height="100" border="0" cellpadding="0" cellspacing="0" class="tableC">
								<tr>
									<td class="tableCleft">&nbsp;</td>
									<td class="tableCcenter">
									<table width="100%" height="130" border="0" cellpadding="0" cellspacing="0" class="tableC">
										<tr>
											<td class="tableCcenter">
											<table width="100%" border="0" cellpadding="0" cellspacing="1" class="">
												<tr>
													<td align="center">
													<s:if test="initMap.userCount > 0" >
													此角色已关联其他数据暂时无法删除，请将关联数据清空，再进行此操作或通知管理员进行此操作
													</s:if> 													
													<s:if test="initMap.userCount <= 0" >
													&nbsp;是否确认要删除所选择的记录？
													</s:if> 
													</td>
												</tr>
											</table>
											</td>
										</tr>
										<tr>
											<td align="center" valign="middle">
											<s:if test="initMap.userCount <= 0" >
											<input type="submit" value="确定">&nbsp;&nbsp;
											</s:if> 
											<input type="button" value="取消" onclick="window.history.back();">
											</td>
										</tr>
									</table>
									</td>
									<td class="tableCright">&nbsp;</td>
								</tr>
							</table>
						<table width="300" align="center" border="0" cellpadding="0" cellspacing="0" class="tableF">
							<tr>
								<td class="tableFleft">&nbsp;</td>
								<td class="tableFcenter">&nbsp;</td>
								<td class="tableFright">&nbsp;</td>
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
