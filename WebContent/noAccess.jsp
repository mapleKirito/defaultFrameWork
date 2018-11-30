<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>失败提示</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/global.css">
</head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/skin.css">
<body style="background-color: #F7F2FF; margin-top: 100;">
<table width="300" align="center"  height="150" border="0" cellpadding="0"
	cellspacing="0" class="tablemain">
	<tr>
		<td>
		<table width="300" align="center" border="0" cellpadding="0" cellspacing="0"
			class="tableT">
			<tr>
				<td class="tableTleft">&nbsp;</td>
				<td class="tableTcenter">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="46%" valign="middle">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="5%">
								<div align="center"><img
									src="<%=request.getContextPath()%>/images/common/115.gif"></div>
								</td>
								<td width="95%" class="tableTBig">信息提示</td>
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
		<table width="300" align="center" height="100" border="0" cellpadding="0" cellspacing="0"
			class="tableC">
			<tr>
				<td class="tableCleft">&nbsp;</td>
				<td class="tableCcenter">
				<table width="100%" height="130" border="0" cellpadding="0" cellspacing="0"
					class="tableC">
					<tr>
						<td class="tableCcenter">
						<table width="100%" border="0" cellpadding="0" cellspacing="1"
							class="">
							<tr>
								<td align="center">
			                    <span style="background-image:url(<%=request.getContextPath()%>/images/window/icon-error.gif);width:32px;height:32px;"></span>
			                    &nbsp;对不起，您无权限访问此页面。
                                </td>
							</tr>
						</table>
						</td>
					</tr>
		            <tr > 
		                <td align="center" valign="middle"><a href="javascript:window.history.back()"> 返回</a></td>
		            </tr>
				</table>
				</td>
				<td class="tableCright">&nbsp;</td>
			</tr>
		</table>
		<table width="300" align="center" border="0" cellpadding="0" cellspacing="0"
			class="tableF">
			<tr>
				<td class="tableFleft">&nbsp;</td>
				<td class="tableFcenter">&nbsp;</td>
				<td class="tableFright">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>
