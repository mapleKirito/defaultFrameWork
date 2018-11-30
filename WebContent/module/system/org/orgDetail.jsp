
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
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
	<tr>
		<td class="tableCleft">&nbsp;</td>
		<td class="tableCcenter">
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
			<tr>
				<td class="SkyTDLine">
				<table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="100%" border="0">
					<tr bgcolor="#ae9b84" align="center">
						<td align="left">
						<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
						<table class="Ntable" cellSpacing="1" cellPadding="0" width="100%" border="0" style="table-layout:fixed;word-wrap:break-word;">
							<s:if test="#request.initMap.orgInfo.orgParentID!=0">
								<tr bgcolor="#ae9b84">
									<td align="right" class="SkyTDLine" width="10%">上级班级：</td>
									<td class="SkyTDLine">&nbsp;${initMap.orgInfo.orgParentName}								
									</td>
								</tr>
							</s:if>	
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine" width="10%">班级编号：</td>
								<td class="SkyTDLine">&nbsp;${initMap.orgInfo.orgCode}</td>
							</tr>				
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine" width="10%">班级名称：</td>
								<td class="SkyTDLine">&nbsp;${initMap.orgInfo.orgName}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine" width="10%">班级电话：</td>
								<td class="SkyTDLine">&nbsp;${initMap.orgInfo.orgPhone}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine" width="10%">机构传真：</td>
								<td class="SkyTDLine">&nbsp;${initMap.orgInfo.orgFax}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine">详细地址：</td>
								<td class="SkyTDLine">&nbsp;${initMap.orgInfo.orgAddress}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine">邮政编码：</td>
								<td class="SkyTDLine">&nbsp;${initMap.orgInfo.orgPostcode}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine">班级描述：</td>
								<td class="SkyTDLine">&nbsp;${initMap.orgInfo.orgDesc}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine">创建时间：</td>
								<td class="SkyTDLine">&nbsp;${initMap.orgInfo.orgCreateTime}</td>
							</tr>
							<tr bgcolor="#ae9b84">
								<td align="right" class="SkyTDLine">创建者：</td>
								<td class="SkyTDLine">&nbsp;${initMap.orgInfo.orgCreator}</td>
							</tr>
							<tr bgcolor="#ae9b84" align="center">
								<td colSpan="2" class="SkyTDLine"><input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
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
		<td class="tableCright">&nbsp;</td>
	</tr>
</table>
</body>
</html>
