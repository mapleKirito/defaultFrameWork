
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
        String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<html>
<title></title>
<head>
<script type="text/javascript">
	<!--
	function funcConfirm()
	{
		var $path = '<%=request.getContextPath()%>';
		//$("#subBtn").attr({"disabled":"disabled"}); 
		$(document.getElementById("subBtn")).hide();
		$("#showWaitTD").append($("<img></img>")).append("导出中请稍后......完成后，请返回！");
		$("#actionForm").submit();
	}
	-->
</script>
</head>
<body style="background-color: #F7F2FF; margin-top: 100;">
<form name="downloadAction" method="post" action="downloadAction.action" id="actionForm" enctype="multipart/form-data">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" value="0" name="timer" />
<input type="hidden" name="code" value="${code}">
<input type="hidden" name="paramMap.select_default_value" value="${paramMap.select_default_value1}">
<input type="hidden" name="paramMap.name" value="${paramMap.name1}">
<input type="hidden" name="paramMap.timeStart" value="${paramMap.timeStart1}">
<input type="hidden" name="paramMap.timeEnd" value="${paramMap.timeEnd1}">
<input type="hidden" name="downloadFileName" value="pointManageExport.xls">
<input type="hidden" name="paramMap.fileType" value="xls"> 
<input type="hidden" name="paramMap.title" value="系统日志下载"> 
<input type="hidden" name="paramMap.columnName" value="序号,用户名称,IP地址,操作时间,操作内容">
<input type="hidden" name="paramMap.column" value="userName,olAccessIP,olOperateTime,olContent"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_operate_log.imitationStep}"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
	<tr>
		<td class="tableCleft">&nbsp;</td>
		<td class="tableCcenter">
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
			<tr>
				<td class="SkyTDLine">
				<table width="300" align="center" height="150" border="0"
					cellpadding="0" cellspacing="0" class="tablemain">
					<tr>
						<td>
						<table width="300" align="center" border="0" cellpadding="0"
							cellspacing="0" class="tableT">
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
													src="<%=request.getContextPath()%>/images/common/170.gif"></div>
												</td>
												<td width="95%" class="tableTBig">操作日志导出</td>
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
						<table width="300" align="center" height="100" border="0"
							cellpadding="0" cellspacing="0" class="tableC">
							<tr>
								<td class="tableCleft">&nbsp;</td>
								<td class="tableCcenter">
								<table width="100%" height="130" border="0" cellpadding="0"
									cellspacing="0" class="tableC">
									<tr>
										<td class="tableCcenter">
										<table width="100%" border="0" cellpadding="0" cellspacing="1"
											class="">
											<tr>
												<td align="center" >
														&nbsp;确定要导出日志文件？
												</td>
											</tr>
											<tr>
												<td align="center" id="showWaitTD"></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td align="center" valign="middle" >
										<input type="button" id="subBtn" value="确定" onclick="funcConfirm();">&nbsp;&nbsp; 
										<input type="button" id="back" value="返回" onclick="history.go(-1);"></td>
									</tr>
								</table>
								</td>
								<td class="tableCright">&nbsp;</td>
							</tr>
						</table>
						<table width="300" align="center" border="0" cellpadding="0"
							cellspacing="0" class="tableF">
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
		<td class="tableCright">&nbsp;</td>
	</tr>
</table>
</form>
</body>
</html>
