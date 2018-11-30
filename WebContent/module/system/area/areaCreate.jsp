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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.autocomplete.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/progressBar.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/progressBar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rsync_progress_bar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dataUtils.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/res/category.js"></script>
<script type="text/javascript">
var setting = {
	async: {
		enable: true,
		url:"ajaxAction.action?code=${pmsIndex.sys_area_select_tree.code}",
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

function filter(treeId, parentNode, childNodes) {
	if (!childNodes) return null;
	if (childNodes.data){
		childNodes = childNodes.data;
	}
	return childNodes;
}
function beforeAsync(treeId, treeNode) {
	return treeNode ? treeNode.level < 8 : true;
}

function onClick(e, treeId, treeNode) {
	var id = treeNode.id;
	var name = treeNode.name;
	$("#areaParentID").attr("value", id);
	$("#areaParentName").attr("value", name);
	hideMenu();
}

function showMenu() {
	var cityObj = $("#areaParentName");
	var cityOffset = $("#areaParentName").offset();
	$("#menuContent").css({
		left : cityOffset.left + "px",
		top : cityOffset.top + cityObj.outerHeight() + "px"
	}).slideDown("fast");

	$("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
	$("#menuContent").hide();
	$("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
	if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(
			event.target).parents("#menuContent").length > 0)) {
		hideMenu();
	}
}
$(document).ready(function() {
	
	$.fn.zTree.init($("#treeDemo"), setting);
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert('校验没有通过，具体错误请看错误提示')},onsuccess:function(){}});//表单提交 
	$("#areaName").formValidator({onshow:"请输入地区名称",onfocus:"请输入地区名称",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"地区名称不能为空,请确认"});
	$("#areaSign").formValidator({onshow:"请输入地区标识",onfocus:"请输入地区标识",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"地区标识不能为空,请确认"});
	$("#areaParentName").formValidator({onshow:"请输入上级地区",onfocus:"请输入上级地区",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"地区标识上级地区,请确认"});
	
	/*$("#areaSort").formValidator({onshow:"请输入地区标识",onfocus:"请输入地区标识",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"地区标识不能为空,请确认"});
	 */
	
	$("#actionForm").submit(function(){
			
			if ($("#check").val() == 1){
				$("#areaNameTip").attr("class","onError").html("此地区已经存在");
				alert("此地区已经存在"); 
				return false;
			}else{
				return true;
			}			
				
	 }); 
	 
});


//新添加地区校验
function checkCount(){
	var areaName = $("#areaName").val();
	areaName = encodeURI(areaName);
	areaName = encodeURI(areaName);
	$.ajax({
		url:		'ajaxAction.action?code=003010009&paramMap.areaParentID='+$("#areaParentID").val()+'&paramMap.areaName=' +areaName,
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){
			if (textStatus == "success" && jsonData.data){
				if (jsonData.data.length > 0){
					$("#areaNameTip").attr("class","onError").html("此地区已经存在");
					$("#check").val(1);
				}	else{
					$("#check").val(0);
				}			
			}
		},
		
		error:function(request,textStatus,error){
		
		}
	});
	
	
}



</script>
</head>
<body >
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top: 0; width: 190px;"></ul>
</div>
<input type="hidden" value="orgName" name="paramMap.logColumn" /> 
<input type="hidden" value="1" name="paramMap.areaIsShow" id="areaIsShow" />
<input type="hidden" name="code" value="${code}"> 
<input type="hidden"  id="check"  value="0"/> 
<input type="hidden" name="imitateStep" value="${pmsIndex.sys_area_mgr.imitationStep}">
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#e8e8e8" valign="top">
							<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
							<table class="table_9" cellSpacing="1" cellPadding="0" width="100%" border="0" style="background-color: #F5F9FC;">
								<tr bgcolor="#ae9b84" >
								<td align="right" class="tatd" width="10%">上级地区：</td>
								<td  class="tatd"> 
								  <input name="paramMap.areaParentID" type="hidden" maxlength="180" id="areaParentID" style="width: 200px;" value="0" /> 
								  <input name="paramMap.areaParentName" type="text" maxlength="180" readonly id="areaParentName" style="width: 200px;" value="顶级地区" /> 
								<a id="menuBtn" href="javascript:void(0)" onclick="showMenu(); return false;">选择</a>
								&nbsp;<font color="red">*</font><span id="areaParentNameTip"  style="position:absolute;height:22px;width:250px;"></span>
								</td>
								</tr>
								<tr bgcolor="#ae9b84" >
									<td align="right" class="tatd" width="10%">地区名称：</td>
									<td class="tatd">
									<input name="paramMap.areaName" type="text" maxlength="180" id="areaName" onblur="checkCount()" style="width: 200px;" />
									&nbsp;<font color="red">*</font><span id="areaNameTip"  style="position:absolute;height:22px;width:250px;"></span></td>
								</tr>
								<tr bgcolor="#ae9b84" >                
									<td align="right" class="tatd" width="10%">地区标识：</td>
									<td class="tatd"><input name="paramMap.areaSign" type="text" maxlength="180" id="areaSign"  style="width: 200px;" />
									&nbsp;<font color="red">*</font><span id="areaSignTip" style="position:absolute;height:22px;width:250px"></span></td>
								</tr>
								<tr bgcolor="#ae9b84" >
									<td align="right" class="tatd" width="10%">地区排序：</td>
									<td class="tatd"><input name="paramMap.areaSort" value="100" type="text" maxlength="180" id="areaSort" style="width: 200px;" />
									<%-- &nbsp;<font color="red">*</font><span id="areaSortTip" style="position:absolute;height:22px;width:250px"></span> --%>
									</td>
								</tr>
								<tr bgcolor="#ae9b84" align="center">
									<td align="center" colspan="2" class="tatd">
									<input type="submit" name="BtnOk" value="创建" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
									<input type="button" name="BtnReturn" value="返回" id="BtnReturn" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" />
									</td>
								</tr>
							</table>
	                         </form>
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
