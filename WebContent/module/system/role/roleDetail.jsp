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
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
<input type="hidden" name="paramMap.key" value="${paramMap.roleID}"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
	<tr>
		<td class="tableCcenter">
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
			<tr>
				<td class="SkyTDLine">
				<table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="100%" border="0">
					<tr bgcolor="#ae9b84" align="center">
						<td align="left">
						<table class="Ntable" cellSpacing="1" cellPadding="0" width="100%" border="0">
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine" width="10%">角色名称：</td>
								<td class="SkyTDLine">&nbsp;${initMap.roleInfo.roleName}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine">角色说明：</td>
								<td class="SkyTDLine">&nbsp;${initMap.roleInfo.roleDesc}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine">创建时间：</td>
								<td class="SkyTDLine">&nbsp;${initMap.roleInfo.roleCreateTime}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine">创建者：</td>
								<td class="SkyTDLine">&nbsp;${initMap.roleInfo.roleCreator}</td>
							</tr>
							<tr bgcolor="#ae9b84" align="center">
								<td colSpan="2" class="SkyTDLine"><input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
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
