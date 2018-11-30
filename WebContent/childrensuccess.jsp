<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<%
	String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();	
%>
<html>
<head>
<title>成功提示</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript">
$(document).ready(function(){ });	
</script>
</head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/skin.css">
<body style="background-color: #F7F2FF; margin-top: 100;">
<form name="actionForm" method="post" action="childrenDecorateAction.action?cutchangepage=${session.cutchangepage}" id="actionForm">
<input type="hidden" name="imitateStep" value="${pmsIndex.tea_histask_param.directName}">
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
									src="<%=request.getContextPath()%>/images/window/message.png"></div>
								</td>
								<td width="95%" class="tableTBig">信息提示children</td> 
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
							class="" style="line-height: 20px;">
							<tr>
								<td align="center" valign="middle">
									 
									&nbsp;${promptInfo.resultDescInfo}
                                </td>
							</tr>
						</table>
						</td>
					</tr>
		            <tr > 
		                <td align="center" valign="middle"><input type="submit" value="确定" ></td>
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
</form>
</body>
</html>
