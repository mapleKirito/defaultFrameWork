<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="java.io.*,java.util.* "%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#isOpen",window.parent.document).attr("value",1);
	//alert(art.dialog.data('tmp'));
var ptype=art.dialog.data('ptype');
var pid=art.dialog.data('reviewID');
var resURL=art.dialog.data('resURL');
//$("#revL").load("decorateForwardAction.action?code=-600604&paramMap.ptype=exhibition&paramMap.pid="+$("#reviewID").val()+"&paramMap.resURL="+$(".addFavorite").attr("id")+"&paramMap.userID=${paramMap.s_userID}&paramMap.userType=${paramMap.s_userType}");
//alert(pid+"=="+resURL+"==="+userID+"=="+userType);
resURL=ignoreSpaces(resURL);
$("#revL").load('decorateForwardAction.action?code=-600604&paramMap.ptype='+ptype+'&paramMap.pid='+pid+'&paramMap.resURL='+resURL);
});

function ignoreSpaces(string) {
	var temp = "";
	string = '' + string;
	splitstring = string.split(" ");
	for(i = 0; i < splitstring.length; i++)
	temp += splitstring[i];
	return temp;
}
</script>
</head>
<body>
<div id="revM" class="hide-popup popup-rc-comment" >
									
									
									<i class="icon-up-arrow"></i>
									<div  class="hide-popup-comment" id="revL" style="height:374px; background-color: rgba(220,220,220,1);position: relative;">暂无评论...</div>
								</div>
</body>
</html>