
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
<script type="text/javascript">
//input验证
$(document).ready(function(){	
 //input验证
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert('校验没有通过，具体错误请看错误提示')},onsuccess:function(){}});//表单提交 
	$("#dtName").formValidator({onshow:"请输入字典类型名称",onfocus:"请输入您的字典类型名称",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"字典描述不能为空,请确认"});
	$("#dtValue").formValidator({onshow:"请输入字典描述",onfocus:"请输入您的字典描述",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"字典描述不能为空,请确认"});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
<input type="hidden" name="code" value="${code}"> 
<input name="paramMap.dtID" type="hidden" id="dtID" value="${initMap.dictionarytInfo.dtID}"/>
<input type="hidden" name="imitateStep" value="${pmsIndex.config_dict_type.imitationStep}"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
<tr>
<td class="tableCcenter">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
	<tr>
		<td class="SkyTDLine">			
		<table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="100%" border="0">
			<tr class="MeNewTDLine" align="center">
				<td align="center">
				<table class="Ntable" cellSpacing="1" cellPadding="0" width="100%" border="0">
					<tr class="MeNewTDLine">
						<td align="right" class="SkyTDLine" width="15%">字典类型名称：</td>
						<td class="SkyTDLine"><input name="paramMap.dtName" readonly="readonly" type="text" maxlength="180" id="dtName" value="${initMap.dictionarytInfo.dtName}"  style="width:200;background:#ECE9D8;">&nbsp;<font color="red">*</font><span id="dtNameTip" style="position:absolute;height:22px;width:250px" readonly="readonly"></span></td>
					</tr>
					<tr class="MeNewTDLine">
						<td align="right" class="SkyTDLine">字典描述：</td>
						<td class="SkyTDLine"><input name="paramMap.dtValue" type="text" maxlength="180" id="dtValue" value="${initMap.dictionarytInfo.dtValue}" style="width: 200px;"/>&nbsp;<font color="red">*</font><span id="dtDescTip" style="position:absolute;height:22px;width:250px"></span></td>
					</tr>
					<tr class="MeNewTDLine" align="center">
						<td colSpan="2" class="SkyTDLine"><input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
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
</HTML>
