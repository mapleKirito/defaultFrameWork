<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><s:text name="systemName"/></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<style type="text/css">
*{margin: 0;padding: 0;color: #ffffff;}
#censta{cursor: pointer;}
</style>
<script type="text/javascript">
$(document).ready(function(){	
	
	var srOperaPath = '${initMap.parcenter.userCenterPath}';
	if(srOperaPath!='')
		$("#parpspan span").html("当前备课中心路径为：<font style='font-weight:bold;'>"+srOperaPath+"</font>");
	else
		$("#parpspan span").html("您还没有配置备课中心路径");
	
	$("#censta").click(function(){
		 $.ajax({
		    url:		'ajaxAction.action?code=-1200',
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			contentType: "application/x-www-form-urlencoded; charset=utf-8", 
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){	
					if(jsonData.is1 == 'startfail'){
						alert("打开程序失败");
					}else if(jsonData.is1 == 'nopath'){
						alert("找不到该备课中心路径："+jsonData.is1+"");
					}
				}
			},
			error:function(request,textStatus,error){}
		});
	});
	
});
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.quick_preparingcenter_index.imitationStep}">
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
										<td width="15%" class="tatd" align="right">备课中心路径：</td>
										<td width="50%" class="tatd" align="left"  colspan="3" id="parpspan">
											<input type="text" name="paramMap.srOperaPath"  id="sdparpare" style="width: 200px;" value="${initMap.parcenter.userCenterPath}">
											<span>请按照备课中心实际安装路径填写（如：D:\bsmsBKZX\bsmsBKZX.exe）,点击启动备课中心</span>
										</td>
										<td width="35%"><input type="button" id="censta" value="启动备课中心"> </td>
									</tr>
									<tr bgcolor="#ae9b84" align="center">
										<td colspan="5"><input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
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