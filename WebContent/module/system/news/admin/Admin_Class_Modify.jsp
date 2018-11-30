<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0.1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(function(){	
	//input验证
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert('校验没有通过，具体错误请看错误提示')},onsuccess:function(){}});//表单提交  
	$("#bigClassName").formValidator({onshow:"请输入分类名称",onfocus:"请输入分类名称",oncorrect:"选择正确"}).inputValidator({min:1,onerror:"分类名称不能为空,请确认"});
	$("#bigClassInfo").formValidator({onshow:"请输入分类信息",onfocus:"请输入分类信息",oncorrect:"选择正确"}).inputValidator({min:1,onerror:"分类信息不能为空,请确认"});
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
<input name="paramMap.bigClassID" type="hidden" id="bigClassID" value="${initMap.newsbigclass.bigClassID}"/>
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_resource_News_class_List.imitationStep}">
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
										<td width="15%" class="tatd" align="right">分类名称：</td>
										<td width="85%" class="tatd" align="left">
											<input name="paramMap.bigClassName" type="text" id="bigClassName" style="width: 200px;"  value="${initMap.newsbigclass.bigClassName}" />
											&nbsp;<font color="red">*</font><span id="bigClassNameTip" style="position:absolute;height:22px;"></span>
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">分类信息：</td>
										<td width="85%" class="tatd" align="left">
											<input name="paramMap.bigClassInfo" type="text" id="bigClassInfo" style="width: 200px;" value="${initMap.newsbigclass.bigClassInfo}"  />
											&nbsp;<font color="red">*</font><span id="bigClassInfoTip" style="position:absolute;height:22px;"></span>
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