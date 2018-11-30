<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0.1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript">  
$(document).ready(function(){	
	//input验证
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert('校验没有通过，具体错误请看错误提示')},onsuccess:function(){}});//表单提交 
	$("#isHot").formValidator({onshow:"请选择资源状态",onfocus:"请选择资源状态",oncorrect:"选择正确"}).inputValidator({min:1,onerror:"资源状态不能为空,请确认"});
	$("#bigClassID").formValidator({onshow:"请选择资源分类",onfocus:"请选择资源分类",oncorrect:"选择正确"}).inputValidator({min:1,onerror:"资源分类不能为空,请确认"});
	$("#newsTitle").formValidator({onshow:"请输入资源标题",onfocus:"请输入资源标题",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"资源标题不能为空,请确认"});
	$("#newsInfo").formValidator({onshow:"请输入资源摘要",onfocus:"请输入资源摘要",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"资源摘要不能为空,请确认"});
});
function confirm()
{
	var rcontent = CKEDITOR.instances.newsContent.getData() == '' ? false : true;
	if (!rcontent){
		alert("资源内容不能为空！");
		return false;
	}
	return true;
}
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm" onsubmit="return confirm();">
<input name="paramMap.newsID" type="hidden" id="newsID" value="${initMap.newsnews.newsID}"/>
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_resource_news.imitationStep}">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#e8e8e8" valign="top">
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
								  	
									
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源标题：</td>
										<td width="85%" class="tatd" align="left">
											<input name="paramMap.newsTitle" type="text" id="newsTitle" style="width: 200px;" value="${initMap.newsnews.newsTitle}"/>
											&nbsp;<font color="red">*</font><span id="newsTitleTip" style="position:absolute;height:22px;"></span>
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源摘要：</td>
										<td width="85%" class="tatd" align="left">
											<textarea name="paramMap.newsInfo" cols="95" rows="2" id="newsInfo">${initMap.newsnews.newsInfo}</textarea> 
											<br/>&nbsp;<font color="red">*</font><span id="newsInfoTip" style="position:absolute;height:22px;"></span>
										</td>
									</tr>
			
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源内容：</td>
										<td width="85%" class="tatd" align="left">
											<textarea name="paramMap.newsContent" id="newsContent" style="display:none">${initMap.newsnews.newsContent}</textarea>
									   		<script type="text/javascript">
									   		CKEDITOR.replace('newsContent',{ filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=modifynews&newsno='+'${initMap.newsnews.newsNum}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=modifynews&newsno='+'${initMap.newsnews.newsNum}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=modifynews&newsno='+'${initMap.newsnews.newsNum}'});
											</script>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" align="center">
										<td colspan="4"><input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
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