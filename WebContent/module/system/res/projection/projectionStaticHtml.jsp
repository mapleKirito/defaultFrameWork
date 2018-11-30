<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<%
	String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();	
%>
<html>
<title></title>
<head>
<script>
var key = "";
var flag = true;
function hasChild(){
	var obj = new Array('${paramMap.key}');
	//var obj = [${paramMap.key}];
	for(var i=0;i<obj.length;i++){
		if(flag){
			key = obj[i];
		    var url = 'ajaxAction.action';
		    var pars = 'command=list&defaultSqlID=test|org.has_child&paramMap.orgCode='+key;
		    var myAjax = new Ajax.Request(  
		    url, 
		    {
		        method: 'post', 
		        parameters:  pars,
		        asynchronous:false
		    });
		}
	}
}

</script>
</head>
<body onload="hasChild();">
<form name="actionForm" method="post" id="actionForm"  action="uploadDataAction.action">
<input type="hidden" value="name" name="logColumn" />
<input type="hidden" value="true" name="islog" />
<input type="hidden" name="code" value="${code}">
<input name="paramMap.code" type="hidden" id="code" value="${paramMap.prNO}"/>
<input type="hidden" name="imitateStep" value="${pmsIndex.res_projection_room_mgr.imitationStep}">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
	<tr>
		<td class="tableCcenter">
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
			<tr>
				<td class="SkyTDLine">
				<table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="100%" border="0">
					<tr class="MeNewTDLine" align="center">
						<td align="left">
								<table width="300" align="center" border="0" cellpadding="0" cellspacing="0"
									class="tableT">
									<tr>
										<td class="tableTleft">&nbsp;</td>
										<td class="tableTcenter">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="78%" valign="middle">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="5%">
														<div align="center"><img
															src="<%=request.getContextPath()%>/images/window/message.png"></div>
														</td>
														<td width="95%" class="tableTBig">${promptInfo.contentDescInfo}</td>
													</tr>
												</table>
												</td>
												<td width="22%">&nbsp;</td>
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
													<td align="center" valign="middle">
														是否生成静态模版？
					                                </td>
												</tr>
											</table>
											</td>
										</tr>
							            <tr > 
							                <td align="center" valign="middle"><input type="submit" value="确定" id="BtnOk">&nbsp;&nbsp;<input type="button" value="取消" onclick="window.history.back();"></td>
							            </tr>
									</table>
									</td>
									<td class="tableCright">&nbsp;</td>
								</tr>
							</table>
							<table width="300" border="0" align="center" cellpadding="0" cellspacing="0" class="tableF">
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
