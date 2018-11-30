<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript">
$(document).ready(function(){	
	
	$("#all").click(function() { 
		var $child = $("input[class='param_class']");
		if($(this).attr("checked")){
			$child.each(function() { 
				$(this).attr("checked", true);
				$("#"+$(this).attr("id")+"_").val(1);
			}); 
		}else{
			$child.each(function() { 
				$(this).attr("checked", false); 
				$("#"+$(this).attr("id")+"_").val(0);
			}); 
		}
	});	
	
	var $subBox = $("input[class='param_class']");  
	$subBox.click(function(){  
		$("#all").attr("checked",$subBox.length == $("input[class='param_class']:checked").length ? true : false);  
		
		if($(this).attr("checked")){
			$("#"+$(this).attr("id")+"_").val(1);
		}else{
			$("#"+$(this).attr("id")+"_").val(0);
		}
	});  
	
	$("#little").click(function(){
	     $("input[class='param_class']").each(function(){
	  	     $(this).attr("checked",!this.checked);   
	  	   	 if($(this).attr("checked")){
	  	   		$("#"+$(this).attr("id")+"_").val(1);
			 }else{
				$("#"+$(this).attr("id")+"_").val(0);
			 }
	     });
	     $("#all").attr("checked",$subBox.length == $("input[class='param_class']:checked").length ? true : false);  
	});

	$("#all").attr("checked",$subBox.length == $("input[class='param_class']:checked").length ? true : false); 
	
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm" onsubmit="fun()">
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_settings_db_param.imitationStep}">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" >
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#e8e8e8" valign="top">
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
									<tr bgcolor="#ae9b84">
										<td colspan="4" class="tatd" align="center"><h2>系统全局参数设置</h2></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">顶部菜单操作：</td>
										<td width="35%" class="tatd" align="left">
											<input type="checkbox" id="srAlertFlssh" class="param_class" ${initMap.settings.srAlertFlssh eq '1' ? 'checked="checked"':'' }>
											<input type="hidden" name="paramMap.srAlertFlssh_"  id="srAlertFlssh_" value="${initMap.settings.srAlertFlssh}" >
											<span>弹出flash/搜索本科室资源</span>
										</td>
										<td width="15%" class="tatd" align="right">网络是否畅通：</td>
										<td width="35%" class="tatd" align="left">
											<input type="checkbox" id="srUnicomNet" class="param_class" ${initMap.settings.srUnicomNet eq '1' ? 'checked="checked"':'' }>
											<input type="hidden" name="paramMap.srUnicomNet_"  id="srUnicomNet_" value="${initMap.settings.srUnicomNet}">
											<span>勾选为网络畅通</span>
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">教师用户发问是否自动过审：</td>
										<td width="35%" class="tatd" align="left">
											<input type="checkbox" id="srTeaIsAuditing" class="param_class" ${initMap.settings.srTeaIsAuditing eq '1' ? 'checked="checked"':'' }>
											<input type="hidden" name="paramMap.srTeaIsAuditing_"  id="srTeaIsAuditing_" value="${initMap.settings.srTeaIsAuditing}" >
											<span>勾选为教师用户发问自动过审</span>
										</td>
										<td width="15%" class="tatd" align="right">学生用户发问是否自动过审：</td>
										<td width="35%" class="tatd" align="left">
											<input type="checkbox" id="srStuIsAuditing" class="param_class" ${initMap.settings.srStuIsAuditing eq '1' ? 'checked="checked"':'' }>
											<input type="hidden" name="paramMap.srStuIsAuditing_"  id="srStuIsAuditing_" value="${initMap.settings.srStuIsAuditing}">
											<span>勾选为学生用户发问自动过审</span>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" align="center">
										<td colspan="4"><input type="submit" name="BtnOk" value="确认" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
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