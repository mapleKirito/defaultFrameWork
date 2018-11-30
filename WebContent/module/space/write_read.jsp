<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>数字生物馆</title>
<!-- <SCRIPT type=text/javascript src="space/jquery.js"></SCRIPT> -->
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<%-- <link href="<%=request.getContextPath()%>/space/read.css" rel="stylesheet" type="text/css" /> --%>
</head>
<body>
<input type="hidden" id="writeID" value="${paramMap.wID}" />
<div id="res_create" >努力加载中。。。。</div>
<!-- 评论 -->
<div id="revM" >
	<div id="revL" style="width: 100%;height: 350px;background: #9EC1F5;float: left;overflow-x: hidden;overflow-y: scroll;position: relative;">评论加载中...</div>
	<script type="text/javascript">
	/* $("#revR").click(function(){
		//$("#revL").load("decorateForwardAction.action?code=-600604&paramMap.ptype=exhibition&paramMap.pid=${initMap.picDetail.erID}");
		$("#revM").animate({"top":"40px"});
	}); */
		$("#revL").load("decorateForwardAction.action?suiji="+new Date().getTime()+"&code=-600604&paramMap.ptype=write&paramMap.pid="+$("#writeID").val()+"&paramMap.userID=${paramMap.s_userID}");
	/* $("#revM").mouseleave(function(){
		$("#revM").animate({"top":"-540px"});
	}); */
	</script>
</div>

<script type="text/javascript">
$.ajax({
	url:		'ajaxAction.action?suiji='+new Date().getTime()+'&code=-600703&paramMap.wID=' + $("#writeID").val(),
	type:	    'post',
	timeout:	'60000',
	data:	Array(),
	dataType:	'json',
	beforeSend:function(request){},
	complete:function(request,textStatus){},
	success:function(jsonData,textStatus){
		if (textStatus == "success"){
			var HTML='<div style="text-align: center;font-size: x-large;color: #000;">'+jsonData.title+'</div>'+
			'<div>'+jsonData.content+'</div>';
			$("#res_create").html(HTML);
		}
	},
	
	error:function(request,textStatus,error){}
}); 
</script>
</body>
</html>