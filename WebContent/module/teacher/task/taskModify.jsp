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
	var title = $("input[name='paramMap.title']").val();
	if (!title){
		alert("作业标题不能为空！");
		$("input[name='paramMap.title']").focus();
		return false;
	}	
	
	var rcontent = CKEDITOR.instances.editor1.getData() == '' ? false : true;
	if (!rcontent){
		alert("编辑内容不能为空！");
		return false;
	}
	
	var chval =  $("input[name='paramMap.orgID'][checked]").val();   
	if (!chval){
		alert("请选择归属班级！");
		return false;
	}
	return true;
}
$(document).ready(function(){	
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}}); 
	$("#title").formValidator({onshow:"请输入标题",onfocus:"标题不能为空",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"输入正确"});
	$("input[name='paramMap.orgID']").formValidator({tipid:"orgidsTip",onshow:"请至少选择一个班级",onfocus:"请至少选择一个班级",oncorrect:"选择正确"}).inputValidator({min:1,onerror:"你选的个数不对"});
});
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" onsubmit="return confirm();" enctype="multipart/form-data"  action="uploadDataAction.action">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.type" value="1"> 

<input type="hidden" name="paramMap.taskId" value="${initMap.task.taskId}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.study_task_mgr.imitationStep}"> 
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
									<td width="15%" class="tatd" align="right">作业标题：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.title" value="${initMap.task.title}" type="text" maxlength="100" id="title" style="width: 350px;" />
									<font color="red">*</font><span id="titleTip"  style="position:absolute;height:22px;width:250px;"></span>									
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">作业内容：</td>
									<td width="85%" class="tatd" align="left">
									<textarea cols="80" id="editor1" name="paramMap.content" rows="10" height="500px">${initMap.task.content}</textarea>
								    <script type="text/javascript">
										  CKEDITOR.replace('editor1',{ filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=userFile&userFileID='+'${paramMap.s_userID}' } );
									</script>
								  </td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">归属班级：</td>
									<td width="85%" class="tatd" align="left">
									<s:iterator value="initMap.org" id="org" status="ind">
					 				 <s:set name="temp" value="0"></s:set>	
					 					<s:iterator value="initMap.taskOrg" id="taskOrg" status="ind">					 						
					 						<s:if test="#taskOrg.orgId==#org.orgID">				 						
					 							<s:set name="temp" value="1"></s:set>					 							
					 						</s:if>
					 					</s:iterator>
					 					<input <s:if test='#temp==1'>checked</s:if> id="orgid${org.orgID}" type="checkbox" name="paramMap.orgID" value="${org.orgID}"/>${org.orgName}					 									 					
	                                </s:iterator>	
									<font color="red">*</font><span id="orgidsTip"  style="position:absolute;height:22px;width:250px;"></span>									
									</td>
								  </tr>					  
								 					  
								  <tr bgcolor="#ae9b84">
									<td colspan="4" align="center">
										<input type="submit" name="BtnOk" value="确认" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
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