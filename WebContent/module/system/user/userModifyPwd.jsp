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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.autocomplete.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/progressBar.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/progressBar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rsync_progress_bar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dataUtils.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/res/category.js"></script>
<script>
$(document).ready(function(){
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}}); 
	$("#newPassword").formValidator({onshow:"请输入新密码",onfocus:"新密码由6-15位的字母或数字组成",oncorrect:"新密码合法"}).inputValidator({min:6,max:15,empty:{leftempty:false,rightempty:false,emptyerror:"新密码两边不能有空符号"},onerror:"新密码的长度不正确"}).regexValidator({regexp:"password",datatype:"enum",onerror:"新密码格式不正确"});
	$("#confirmPassword").formValidator({onshow:"请输入重复密码",onfocus:"两次密码必须一致",oncorrect:"密码一致"}).inputValidator({min:6,max:15,empty:{leftempty:false,rightempty:false,emptyerror:"重复密码两边不能有空符号"},onerror:"重复密码的长度不正确"}).compareValidator({desid:"newPassword",operateor:"=",onerror:"两次密码不一致,请确认"});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm" onsubmit="return Validator.Validate(this,3);">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.userID" value="${paramMap.userID}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_user_mgr.imitationStep}"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#e8e8e8" valign="top">
							<div>
								<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
									<table class="table_9" cellSpacing="1" cellPadding="0" width="100%" border="0" style="background-color: #F5F9FC;">
										<tr bgcolor="#ae9b84">
											<td align="right" class="tatd" width="10%">新&nbsp;密&nbsp;码：</td>
											<td class="tatd">&nbsp; <input name="paramMap.newPassword" type="password" maxlength="180" id="newPassword" style="width: 200px;" />&nbsp;<font color="red">*</font><span id="newPasswordTip" style="position:absolute;height:22px;width:250px"></span></td>
										</tr>
										<tr bgcolor="#ae9b84">
											<td align="right" class="tatd" width="10%">确认密码：</td>
											<td class="tatd">&nbsp; <input name="paramMap.confirmPassword" type="password" maxlength="180" id="confirmPassword" style="width: 200px;"/>&nbsp;<font color="red">*</font><span id="confirmPasswordTip" style="position:absolute;height:22px;width:250px"></span></td>
										</tr>
										<tr bgcolor="#ae9b84" align="center">
											<td colSpan="2" class="tatd"><input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
										</tr>
									</table>
                         		</form>
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
