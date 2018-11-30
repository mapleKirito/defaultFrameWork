<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0.1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<script type="text/javascript">
function confirm()
{
	var rcontent = CKEDITOR.instances.editor1.getData() == '' ? false : true;
	if (!rcontent){
		alert("回复内容不能为空！");
		return false;
	}

}
$(document).ready(function(){	
	$("#BtnClose").click(function(){
		$("html",window.parent.document).find("#screen__").css("display","none");
		$("html",window.parent.document).find("#message__").css("display","none");
	});});
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" onsubmit="return confirm();" enctype="multipart/form-data"  action="confirmAction.action">
<input type="hidden" name="code" value="001001003001">
<s:if test="paramMap.tId != null && paramMap.tId != ''">
<input type="hidden" name="paramMap.taskId" value="${paramMap.tId}">
</s:if>
<s:if test="paramMap.tiId != null && paramMap.tiId != ''">
<input type="hidden" name="paramMap.tiId" value="${paramMap.tiId}">
</s:if>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
								    <tr bgcolor="#f5f9fc">
									<td width="725px" class="tatd" align="left">
										<textarea cols="80" id="editor1" name="paramMap.tiContent" rows="10" height="500px"></textarea>
									    <script type="text/javascript">
											  CKEDITOR.replace('editor1',{ filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
										</script>	
								  	</td>
								  </tr>
								  <tr  bgcolor="#f5f9fc">
									<td align="center">
										<input type="submit" name="BtnOk" value="确认" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
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
</html>