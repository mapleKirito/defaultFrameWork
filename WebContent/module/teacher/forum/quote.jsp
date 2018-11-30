<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0.1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/skin.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<script type="text/javascript">
function confirm()
{
	var rcontent = CKEDITOR.instances.editor1.getData() == '' ? false : true;
	if (!rcontent){
		alert("引用回复内容不能为空！");
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
<input type="hidden" name="code" value="002001004008">
<input type="hidden" name="paramMap.tiQuotePath" value="${initMap.quoteInfo.tiQuotePath}">

<s:if test="paramMap.tId != null && paramMap.tId != ''">
<input type="hidden" name="paramMap.taskId" value="${paramMap.tId}">
</s:if>
<s:if test="paramMap.tiId != null && paramMap.tiId != ''">
<input type="hidden" name="paramMap.tiId" value="${paramMap.tiId}">
</s:if>
<s:if test="initMap.quoteInfo.tiUserAccount != null && initMap.quoteInfo.tiUserAccount != ''">
<input type="hidden" name="paramMap.tiQuoteOfName" value="${initMap.quoteInfo.tiUserAccount}">
</s:if>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="table">
  <tr>
    <td valign="top" style="padding:5px;">
       <div style="width:725;height:365;overflow:auto;" >
		<textarea cols="80" id="editor1" name="paramMap.tiContent" rows="10"></textarea>
	    <script type="text/javascript">
			  CKEDITOR.replace('editor1',{ filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
		</script>	
	  </div>
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