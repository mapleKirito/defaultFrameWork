<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
	var obj = new Array(${paramMap.key});
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
		        onComplete: hasUser,
		        asynchronous:false
		    });
		}
	}
}

function hasUser(result){
	var resultList = result.responseText.evalJSON().datas;
	if(resultList){
		if(resultList.length!=0){
			alert("选中的机构下有子机构，不能删除！");
			document.getElementById("BtnOk").disabled = true;
			flag = false;
		}else{
			var url = 'ajaxAction.action';
		    var pars = 'command=list&defaultSqlID=test|org.has_user&paramMap.orgCode='+key;
		    var myAjax = new Ajax.Request(  
		    url, 
		    {
		        method: 'post', 
		        parameters:  pars,
		        onComplete: resultShowFunc,
		        asynchronous:false
		    });
		}
	}
}

function resultShowFunc(result){
	var resultList = result.responseText.evalJSON().datas;
	if(resultList){
		if(resultList.length!=0){
			alert("选中的机构下有用户，不能删除！");
			document.getElementById("BtnOk").disabled = true;
			flag = false;
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
<input type="hidden" name="paramMap.orgParentID" value="${paramMap.orgParentID}">
<input type="hidden" name="paramMap.orgID" value="${paramMap.orgID}">
<input type="hidden" name="paramMap.orgCode" value="${paramMap.orgCode}">
<input type="hidden" name="paramMap.isdeleorg" value="true">
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_org_mgr.imitationStep}">
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
												<td width="46%" valign="middle">
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
													<td align="center" valign="middle">
														
														<s:if test="initMap.userCount > 0" >
															此班级已关联其他数据暂时无法删除，请将关联数据清空，再进行此操作或通知管理员进行此操作
														</s:if>
														<s:if test="initMap.userCount <= 0" >
															&nbsp;确认要删除所选择的班级？
														</s:if>
					                                </td>
												</tr>
											</table>
											</td>
										</tr>
							            <tr > 
							                <td align="center" valign="middle">
							                <s:if test="initMap.userCount <= 0" >
							                <input type="submit" value="确定" id="BtnOk">&nbsp;&nbsp;
							                </s:if>
							                <input type="button" value="取消" onclick="window.history.back();" >
							                </td>
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
