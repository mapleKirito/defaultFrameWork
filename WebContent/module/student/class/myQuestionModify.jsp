<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0.1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}}); 
	$("#title").formValidator({onshow:"请输入问题标题",onfocus:"请输入问题标题",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"问题标题不能为空,请确认"});
});
function confirm()
{
	var rcontent = CKEDITOR.instances.editor1.getData() == '' ? false : true;
	if (!rcontent){
		alert("问题描述不能为空！");
		return false;
	}
}
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm"  onsubmit="return confirm();">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input name="paramMap.type" type="hidden" value="2"/>
<input name="paramMap.isLock" type="hidden" value="0"/>
<input name="paramMap.isRecommend" type="hidden" value="0"/>
<input name="paramMap.taskId" type="hidden" value="${initMap.questionmodify.taskId}"/>
<input type="hidden" name="imitateStep" value="${pmsIndex.myTask_mgr.imitationStep}"> 
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
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">问题标题：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.title" type="text" maxlength="200" id="title" style="width: 400;"  value="${initMap.questionmodify.title}"/>
									<font color="red" style="vertical-align: top;">*</font><span id="titleTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">问题描述：</td>
									<td width="85%" class="tatd" align="left">
										<textarea cols="80" id="editor1" name="paramMap.content" rows="10" height="100px">${initMap.questionmodify.content}</textarea>
									    <script type="text/javascript">
											  CKEDITOR.replace('editor1',{ filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
										</script>	 
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td colspan="4" align="center">
										<input type="submit" name="BtnOk" value="确定" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
										<input type="button" name="BtnReturn" value="返回" id="BtnReturn" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" />
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