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
<form name="actionForm" method="post" action="operateAction.action" id="actionForm" onsubmit="return Validator.Validate(this,3);">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.key" value="${paramMap.key}"> 
<input type="hidden" name="imitateStep" value="user1"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
	<tr>
		<td class="tableCcenter">
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
			<tr>
				<td class="SkyTDLine">
				<table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="100%" border="0">
					<tr class="MeNewTDLine" align="center">
						<td align="left">
						<table class="Ntable" cellSpacing="1" cellPadding="0" width="100%" border="0">
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="10%">所属机构：</td>
								<td class="SkyTDLine">&nbsp;${initMap.userInfo.userOrgName}</td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="10%">用户姓名：</td>
								<td class="SkyTDLine">&nbsp;${initMap.userInfo.userName}</td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="10%">用户性别：</td>
								<td class="SkyTDLine">&nbsp; 
								<s:if test="initMap.userInfo.userGender == 1">
									&nbsp;男
                                      </s:if> 
                                      <s:elseif test="initMap.userInfo.userGender == 0">
									&nbsp;女
							    </s:elseif> 
							    <s:else>
									&nbsp;未知
								</s:else>
                                 </td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="10%">移动电话：</td>
								<td class="SkyTDLine">&nbsp;${initMap.userInfo.userMobilePhone}</td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="10%">办公电话：</td>
								<td class="SkyTDLine">&nbsp;${initMap.userInfo.userOfficePhone}</td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="10%">邮箱地址：</td>
								<td class="SkyTDLine">&nbsp;${initMap.userInfo.userEmail}</td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine">用户描述：</td>
								<td class="SkyTDLine">&nbsp;${initMap.userInfo.userDesc}</td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine">创建时间：</td>
								<td class="SkyTDLine">&nbsp;${initMap.userInfo.userCreateTime}</td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine">创建者：</td>
								<td class="SkyTDLine">&nbsp;${initMap.userInfo.userCreator}</td>
							</tr>
							<tr class="MeNewTDLine" align="center">
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
