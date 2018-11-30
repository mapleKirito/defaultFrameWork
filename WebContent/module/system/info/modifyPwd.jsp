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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
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
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
					 	<td width="100%" bgcolor="#e8e8e8" valign="top">
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">原始密码：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.oldPassword" type="password" maxlength="180" id="oldPassword" style="width: 200px;"/>&nbsp;
									<font color="red">*</font><span id="oldPasswordTip"  style="position:absolute;height:22px;width:250px;"></span>									
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">新&nbsp;密&nbsp;码：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.newPassword" type="password" maxlength="180" id="newPassword"  style="width: 200px;" />&nbsp;
									<font color="red">*</font><span id="newPasswordTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">确认密码：</td>
									<td width="85%" class="tatd">
									<input name="paramMap.confirmPwd" type="password" maxlength="200" id="confirmPwd" style="width: 200px;" />&nbsp;
									<font color="red">*</font><span id="confirmPwdTip" style="position:absolute;height:22px;width:250px"></span></td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td colspan="4" align="center">
										<input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
									</td>
								  </tr>
								</table>
							</div>						
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
