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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript">
var setting = {
	async: {
		enable: true,
		url:"ajaxAction.action?code=-600",
		dataType:"json",
		autoParam:["id"],
		dataFilter: filter
	},
	callback: {
		beforeAsync: beforeAsync,
		//beforeClick: beforeClick,
		onClick: onClick
	}
};




$(document).ready(function(){
	
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}}); 
	$("#name").formValidator({onshow:"请输入收藏夹名称",onfocus:"请输入请输入收藏夹名称",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"收藏夹名称不能为空,请确认"});
});
</script>
</head>
<body >
<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top: 0; width: 160px;"></ul>
</div>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.favoriteId" value="${initMap.favorite.favoriteId}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.my_favorite_mgr.imitationStep}"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
	<tr>
		<td class="tableCcenter">
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
			<tr>
				<td class="SkyTDLine">
				<table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="100%" border="0">
					<tr class="MeNewTDLine" align="center">
						<td align="center">
						<table class="Ntable" cellSpacing="1" cellPadding="0" width="100%" border="0">
												
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="10%">收藏夹名称：</td>
								<td class="SkyTDLine"><input name="paramMap.name" type="text" value="${initMap.favorite.name}" maxlength="180" id="name" style="width: 200px;" />&nbsp;<font color="red">*</font><span id="nameTip" style="position:absolute;height:22px;width:250px"></span></td>
							</tr>
							
							<tr class="MeNewTDLine" align="center">
							<td colSpan="2" class="SkyTDLine">
									<input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
									<input type="button" name="BtnReturn" value="返回" id="BtnReturn" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" />
							</td>
							</tr>
						</table>
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
