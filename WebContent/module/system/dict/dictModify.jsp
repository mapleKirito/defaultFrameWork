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
var gridTreeTB,treeTB;
$(document).ready(function(){	
 //input验证
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert('校验没有通过，具体错误请看错误提示')},onsuccess:function(){}});//表单提交 
	$("#dicDictTypeID").formValidator({onshow:"请选择字典类型",onfocus:"请选择字典类型",oncorrect:"选择正确"}).inputValidator({min:1,onerror:"字典类型不能为空,请确认"});
	$("#dicName").formValidator({onshow:"请输入参数名",onfocus:"请输入参数名",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"参数名不能为空,请确认"});
	$("#dicValue").formValidator({onshow:"请输入参数值",onfocus:"请输入参数值",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"参数值不能为空,请确认"});
	$("#dicDesc").formValidator({onshow:"请输入参数描述",onfocus:"请输入参数描述",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"参数描述不能为空,请确认"});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
<input type="hidden" name="paramMap.dicID" value="${paramMap.dicID}"> 
<input type="hidden" name="code" value="${code}">
<input type="hidden" name="imitateStep" value="${pmsIndex.config_data_dict.imitationStep}"> 
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
							<td align="right" class="SkyTDLine" width="15%">字典类型：</td>
							<td  class="SkyTDLine"> 
								<select style="width:200;" name="paramMap.dicDictTypeID" id="dicDictTypeID">
								   <option value="">请选择字典类型</option>		
                                   <s:iterator value="initMap.dictInfo" id="dict" status="ind">
									 <s:if test="initMap.dictionaryInfo.dicDictTypeValue == #dict.dtValue">
                                      <option value="${dict.dtID}" selected="selected">${dict.dtName}</option>
									 </s:if>
									 <s:else>
                                      <option value="${dict.dtID}">${dict.dtName}</option>
									 </s:else>		
                                   </s:iterator>
								</select>&nbsp;<font color="red">*</font><span id="dicDictTypeIDTip" style="position:absolute;height:22px;width:250px"></span>
							</td>
						   </tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="15%">字典名称：</td>
								<td class="SkyTDLine">
									<input name="paramMap.dicName"  readonly="readonly" value="${initMap.dictionaryInfo.dicName}" type="text" maxlength="180" id="dicName" style="width: 200;;background:#ECE9D8;"/>&nbsp;<font color="red">*</font><span id="dicNameTip" style="position:absolute;height:22px;width:250px"></span>
								</td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine">字典内容：</td>
								<td class="SkyTDLine">
									<input name="paramMap.dicValue" value="${initMap.dictionaryInfo.dicValue}" type="text" maxlength="180" id="dicValue" style="width: 200px;"/>&nbsp;<font color="red">*</font><span id="dicValueTip" style="position:absolute;height:22px;width:250px"></span>
								</td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine">字典描述：</td>
								<td class="SkyTDLine">
									<input name="paramMap.dicDesc" value="${initMap.dictionaryInfo.dicDesc}" type="text" maxlength="180" id="dicDesc" style="width: 200px;"/>&nbsp;<font color="red">*</font><span id="dicDescTip" style="position:absolute;height:22px;width:250px"></span>
								</td>
							</tr>
							<tr class="MeNewTDLine" align="center">
								<td colSpan="2" class="SkyTDLine">
									<input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
									<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" />
								</td>
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
