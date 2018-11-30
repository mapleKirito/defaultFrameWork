<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>

<html>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript">
var setting = {
	check: {
		enable: true
	},
	data: {
		simpleData: {
			enable: false
		}
	},
	callback: {
		onCheck: onCheck
	}
};
function onCheck(e, treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	var sval = zTree.getCheckedNodes();
	if (sval && sval.length >= 0){
		var auth = "";
		for(var i=0; i<sval.length; i++){
			if (i ==0){
				auth = sval[i].id;
			}
			else{
				auth += "," + sval[i].id;
			}
		}
		$("body",window.parent.document).find("#userOrgID").val(auth);
	}
	else{
		$("body",window.parent.document).find("#userOrgID").val("");
	}
}	
var  tcode = "${tempCode}";
var zNodes;
if(tcode=='003003001'){
	zNodes = ${initMap.userOrgInfo};
	var j = zNodes.length-1;
	for(var i=0; i<=zNodes.length; i++){
		if(zNodes[i].checked){
			zNodes[i].checked = "false";
		}
		if(j-i<=0){break;}
	} 
}else{
	zNodes = ${initMap.userOrgInfo};
}
$(document).ready(function(){
	
	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	zTree.setting.check.chkboxType = {"Y":"ps", "N":"s"};
	
});
</script>
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top">
			<div>
				<ul id="treeDemo" class="ztree" style="margin-top:0px;width:100%;"></ul>
			</div>		
		</td>
	</tr>
</table>
</form> 
</body>
</HTML>
