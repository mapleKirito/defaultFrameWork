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
<script>
$(document).ready(function(){
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}}); 
	$("#oldPassword").formValidator({onshow:"请输入原密码",onfocus:"原密码不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"原密码不能为空,请确认"});
	$("#newPassword").formValidator({onshow:"请输入新密码",onfocus:"新密码由6-15位的字母或数字组成",oncorrect:"新密码合法"}).inputValidator({min:6,max:15,empty:{leftempty:false,rightempty:false,emptyerror:"新密码两边不能有空符号"},onerror:"新密码的长度不正确"}).regexValidator({regexp:"password",datatype:"enum",onerror:"新密码格式不正确"});
	$("#confirmPwd").formValidator({onshow:"请输入重复密码",onfocus:"两次密码必须一致",oncorrect:"密码一致"}).inputValidator({min:6,max:15,empty:{leftempty:false,rightempty:false,emptyerror:"重复密码两边不能有空符号"},onerror:"重复密码的长度不正确"}).compareValidator({desid:"newPassword",operateor:"=",onerror:"两次密码不一致,请确认"});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm" >
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_password_modify.imitationStep}"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
<tr>
<td class="tableCleft">&nbsp;</td>
<td class="tableCcenter">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
	<tr>
		<td class="SkyTDLine">
		<table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="100%" border="0">
			<tr class="MeNewTDLine" align="center">
				<td align="left">
					<table class="Ntable" cellSpacing="1" cellPadding="0" width="100%" border="0">
						<tr class="MeNewTDLine">
							<td align="right" class="SkyTDLine" width="10%">原始密码：</td>
							<td class="SkyTDLine">&nbsp; <input name="paramMap.oldPassword" type="password" maxlength="180" id="oldPassword" style="width: 200px;" />&nbsp;<font color="red">*</font><span id="oldPasswordTip" style="position:absolute;height:22px;width:250px"></span></td>
						</tr>
						<tr class="MeNewTDLine">
							<td align="right" class="SkyTDLine" width="10%">新&nbsp;&nbsp;密&nbsp;&nbsp;码：</td>
							<td class="SkyTDLine">&nbsp; <input name="paramMap.newPassword" type="password" maxlength="180" id="newPassword" style="width: 200px;"/>&nbsp;<font color="red">*</font><span id="newPasswordTip" style="position:absolute;height:22px;width:250px"></span></td>
						</tr>
						<tr class="MeNewTDLine">
							<td align="right" class="SkyTDLine" width="10%">确认密码：</td>
							<td class="SkyTDLine">&nbsp; <input name="paramMap.confirmPwd" type="password" maxlength="180" id="confirmPwd" style="width: 200px;"/>&nbsp;<font color="red">*</font><span id="confirmPwdTip" style="position:absolute;height:22px;width:250px"></span></td>
						</tr>
						<tr class="MeNewTDLine" align="center">
							<td colSpan="2" class="SkyTDLine"><input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;<input type="reset" name="BtnOk" value="重置" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" /></td>
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
</HTML>
