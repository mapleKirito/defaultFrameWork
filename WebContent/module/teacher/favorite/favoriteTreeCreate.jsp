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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree1.main.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery1.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript">
var setting = {
	async: {
		enable: true,
		url:"ajaxAction.action?code=-701015",
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
	return treeNode ? treeNode.level < 5 : true;
}

function onClick(e, treeId, treeNode) {
	var id = treeNode.id;
	var name = treeNode.name;
	var level = treeNode.level;
	var path = treeNode.path;
	$("#rfParentId").attr("value", id);
	$("#rfParentName").attr("value", name);
	hideMenu();
	if (id == 0){
		$("#rfLevel").val("1");
		$("#rfPath").val(",0,");
		$("#selectName").show();
		$("#inputName").hide();
		$("#inputName").val("");
		$("#rfParentName").formValidator({onshow:"请选择上级目录",onfocus:"请选择上级目录",oncorrect:"选择正确"});
		$("#rfSelectName").formValidator({onshow:"请选择当前目录",onfocus:"请选择当前目录",oncorrect:"选择正确"});
		$("#rfName").formValidator();
	}
	else{
		var sort = treeNode.sort;
		$("#rfLevel").val(level + 1);
		$("#rfPath").val(path);		
		$("#rfSort").val(sort);
		$("#selectName").hide();
		$("#inputName").show();	
		$("#rfParentName").formValidator({onshow:"请选择上级目录",onfocus:"请选择上级目录",oncorrect:"选择正确"});
		$("#rfName").formValidator({onshow:"请输入当前目录",onfocus:"请输入当前目录",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"当前目录不能为空,请确认"});
		$("#rfSelectName").formValidator();
	}
}

function showMenu() {
	var cityObj = $("#rfParentName");
	var cityOffset = $("#rfParentName").offset();
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
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}});
	$("#rfParentName").formValidator({onshow:"请选择上级目录",onfocus:"请选择上级目录",oncorrect:"选择正确"});
	$("#rfName").formValidator({onshow:"请输入当前目录",onfocus:"请输入当前目录",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"当前目录不能为空,请确认"});
	$("#rfSelectName").formValidator();	
	$("#actionForm").submit(function(){
		var stext = $("#rfSelectName option:selected").text();
		$("#selectText").val(stext);
	});
});
</script>
</head>
<body >
<form name="actionForm" method="post" action="operateAction.action" id="actionForm" >
<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top: 0; width: 160px;"></ul>
</div>
<input type="hidden" value="rfName" name="paramMap.logColumn" /> 
<input type="hidden" name="paramMap.selectText" id="selectText"/> 
<input type="hidden" name="paramMap.rfLevel" id="rfLevel"/> 
<input type="hidden" name="paramMap.rfPath" id="rfPath"/> 
<input type="hidden" name="paramMap.rfSort" id="rfSort"/> 
<input type="hidden" value="1" name="paramMap.rfIsPath" id="rfIsPath" /> 
<input type="hidden" name="code" value="002002001"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.my_favorite_mgr.imitationStep}">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9" >
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">上级目录：</td>
									<td width="85%" class="tatd" align="left">
								    <input name="paramMap.rfParentId" type="hidden" maxlength="180" id="rfParentId" style="width: 200px;" value="0" /> 
								    <input name="paramMap.rfParentName" type="text" maxlength="180" readonly id="rfParentName" style="width: 200px;"/> 
								    <a id="menuBtn" href="javascript:void(0)" onclick="showMenu(); return false;">选择</a>
									<font color="red">*</font><span id="rpParentNameTip"  style="position:absolute;height:22px;width:250px;"></span>									
									</td>
								  </tr>
								  <tr id="inputName" bgcolor="#606373">
									<td width="15%" class="tatd" align="right">当前目录：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.rfName" type="text" maxlength="180" id="rfName"  style="width: 200px;" />
									<font color="red">*</font><span id="rfNameTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
								  </tr>  
								  <tr id="selectName" style="display:none;" bgcolor="#606373">
									<td width="15%" class="tatd" align="right">当前目录：</td>
									<td width="85%" class="tatd" align="left">
									<select name="paramMap.rfSelectName" id="rfSelectName" style="width:200px;">
									  <option value="exhibition">文物博览室</option>
									  <option value="observation">专题研读室</option>
									  <option value="laboratory">教学研究室</option>
									  <option value="projection">影像资料室</option>
									  <option value="expand">自主探究室</option>
									</select>
									<font color="red">*</font><span id="rfSelectNameTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
								  </tr>
								<tr bgcolor="#ae9b84">
								  <td  colspan="3" style="text-align: center;">
										<input type="submit" name="BtnOk" value="创建" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
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
