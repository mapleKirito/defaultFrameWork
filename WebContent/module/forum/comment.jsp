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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/skin.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<script type="text/javascript">
function confirm()
{
	var rcontent = CKEDITOR.instances.editor1.getData() == '' ? false : true;
	if (!rcontent){
		alert("评语内容不能为空！");
		return false;
	}
}
$(document).ready(function(){
	$("#BtnClose").click(function(){
		$("html",window.parent.document).find("#screen__").css("display","none");
		$("html",window.parent.document).find("#message__").css("display","none");
	});
});
</script>
</head>
<body style="background-color:#e0ebee; margin:0; padding:0; font-family:'宋体'">
<form name="actionForm" method="post" id="actionForm" onsubmit="return confirm();" enctype="multipart/form-data"  action="confirmAction.action">
<input type="hidden" name="code" value="002001004003">
<input type="hidden" name="paramMap.tiId" value="${paramMap.tiId}">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
    	<textarea rows="14" cols="66" name="paramMap.tiComment"></textarea>
	</td>
  </tr>
  <tr>
    <td valign="top" align="center" style="padding:5px;">
    	<input type="submit" name="BtnOk" value="确定" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
    	<input type="button" name="BtnOk" value="关闭" id="BtnClose"  class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
	</td>
  </tr>    
</table>
</form>
</body>
</html>