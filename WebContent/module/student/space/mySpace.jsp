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
			url:"ajaxAction.action?code=${pmsIndex.bsms_category_select_tree.code}",
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
	$("#cateParentID").attr("value", id);
	$("#cateParentName").attr("value", name);
	hideMenu();
}

function showMenu() {
	var cityObj = $("#cateParentName");
	var cityOffset = $("#cateParentName").offset();
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
$(document).ready(function(){	
	//input验证

	 $('#BtnOk').screenTB({
        	windowDocument:window.parent.document,
    		width:'250',
    		height:'150',
    		content:'测试内容',
    		contentAlign:'center',
    		contentValign:'middle',
			title:'系统提示信息',
			buttonValueYes:'确定',	
			buttonValueNo:'取消',	
			dialogType:'alert',
			iframeSrc:''				
    		},{
    		clickEvent:function(data){
    			if (parseInt($("#orglID").val())==parseInt($("#orgParentID").val())){
    				data = $.extend(data,{content:'不能选择当前分类为上级分类，请重新选择'})
    			}
    			else{
    				$.extend(data,{returnValue:'true'});
    				$("#actionForm").submit();
    			}
    		}
    	});
	
	 $.fn.zTree.init($("#treeDemo"), setting);	
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="operateAction.action" id="actionForm">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.userID" value="${initMap.userInfo.userID}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.my_info_mgr.imitationStep}"> 
<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top: 0; width: 160px;"></ul>
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableC">
	<tr>
		<td class="tableCcenter">
		<table width="100%" border="0" cellpadding="0" cellspacing="1" class="SkyTDLine">
			<tr>
				<td class="SkyTDLine">
				<table class="SkyTDLine" cellSpacing="1" cellPadding="0" width="100%" border="0">
					<tr class="MeNewTDLine" align="center">
						<td align="left">
						<table class="Ntable" cellSpacing="1" cellPadding="0" width="100%" border="0">
							
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="10%">登录帐号：</td>
								<td class="SkyTDLine">
								<input name="paramMap.userAccount" style="background:#EFEBDE;" type="text" maxlength="180" readonly="readonly" id="userAccount" style="width: 200px;" value="${initMap.userInfo.userAccount}" />
								<font color="red">*</font><span id="orgCodeTip"  style="position:absolute;height:22px;width:250px;"></span></td>
							</tr>
							<tr class="MeNewTDLine">                
								<td align="right" class="SkyTDLine" width="10%">姓名：</td>
								<td class="SkyTDLine"><input name="paramMap.name" value="${initMap.userInfo.userName}" type="text" maxlength="180" id="cateSign"  style="width: 200px;" />&nbsp;<font color="red">*</font><span id="orgNameTip" style="position:absolute;height:22px;width:250px"></span></td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine" width="10%">性别：</td>
                                 <s:if test="initMap.userInfo.userGender == 1">
									<td class="SkyTDLine">&nbsp;
									<input type="radio" name="paramMap.gender" checked="checked" value="1" />男 &nbsp;
									<input type="radio" value="0" name="paramMap.gender" />女&nbsp;
									</td>
                                 </s:if> 
								 <s:else>
									<td class="SkyTDLine">&nbsp;
									<input type="radio" name="paramMap.gender" value="1" />男 &nbsp;
									<input type="radio" value="0" name="paramMap.gender"  checked="checked" />女&nbsp;
									</td>
								 </s:else>	
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine">移动电话：</td>
								<td class="SkyTDLine"><input name="paramMap.userMobilePhone" type="text" id="cateKeyWord" value="${initMap.userInfo.userMobilePhone}" style="width: 200px;" />&nbsp;<font color="red">*</font><span id="orgPostcodeTip" style="position:absolute;height:22px;width:250px"></span></td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine">办公电话：</td>
								<td class="SkyTDLine"><input name="paramMap.userOfficePhone" type="text" id="cateKeyWord" value="${initMap.userInfo.userOfficePhone}" style="width: 200px;" />&nbsp;<font color="red">*</font><span id="orgPostcodeTip" style="position:absolute;height:22px;width:250px"></span></td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine">电子邮件：</td>
								<td class="SkyTDLine"><input name="paramMap.userEmail" type="text" id="cateKeyWord" value="${initMap.userInfo.userEmail}" style="width: 200px;" />&nbsp;<font color="red">*</font><span id="orgPostcodeTip" style="position:absolute;height:22px;width:250px"></span></td>
							</tr>
							<tr class="MeNewTDLine">
								<td align="right" class="SkyTDLine">个人简介：</td>
								<td class="SkyTDLine"><input name="paramMap.description" type="text" id="cateKeyWord" value="${initMap.userInfo.userDesc}" style="width: 200px;" />&nbsp;<font color="red">*</font><span id="orgPostcodeTip" style="position:absolute;height:22px;width:250px"></span></td>
							</tr>
							<tr class="MeNewTDLine" align="center">
								<td colSpan="2" class="SkyTDLine">
										<input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
										<input type="button" name="BtnReturn" value="返回" id="BtnReturn" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
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