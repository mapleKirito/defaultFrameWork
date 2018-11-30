<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>数字生物馆</title>
<!-- <SCRIPT type=text/javascript src="space/jquery.js"></SCRIPT> -->
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<link href="qc/css/style.css" rel="stylesheet" />
<%-- <link href="<%=request.getContextPath()%>/space/read.css" rel="stylesheet" type="text/css" /> --%>
<script src="qc/js/scripts.js"></script>
<style type="text/css">
.TI{
color: #000;
font-size: 24px;
padding-bottom: 10px;
margin-bottom: 10px;
border-bottom: 1px dotted #999;
}
img{
  max-width: 840px;
}
p{text-indent:2em;line-height:40px;font-size: 16px;}
</style>
</head>
<body>
<%-- <h3><a href="decorateForwardAction.action?code=00203200503&paramMap.aID=${paramMap.aID}">修改</a></h3> --%>
<input type="hidden" id="writeID" value="${paramMap.aID}" />
<div id="layout_mainbody">
	<div class="page-container ssjh">
		<div class="my-article panel" style="margin-top: 0px;width: 98%;">
			<input type="hidden" id="userID" value="${session.s_userID }">
			<p class="title topborder">
				文章阅读 <span> 
					</span>
			</p>
			<div class="tabcontent">
				<div id="res_create" style="border: 1px solid #cbcbcb;padding: 5px;font-size: 14px;color: #444;">努力加载中。。。。</div>
			</div>
			<div class="pageb" id="table3page" style="margin-right: 20px;"   >
				${initMap.paginated.pageContent}</div>
		</div>

		</div>
	</div>
<script type="text/javascript">
if($("body").width()<920){
	$(".ssjh").css({"width": "100%"})
}
/* $(function(){
	$("img").each(function(){
		if($("body").width()<$(this).width()){
			alert();
		}
	});
}) */

$.ajax({
	url:		'ajaxAction.action?suiji='+new Date().getTime()+'&code=-2220005&paramMap.aID=' + $("#writeID").val(),
	type:	    'post',
	timeout:	'60000',
	data:	Array(),
	dataType:	'json',
	beforeSend:function(request){},//ajax执行前调用函数
	complete:function(request,textStatus){},//ajax请求完成后调用函数
	success:function(jsonData,textStatus){//ajax请求成功调用函数
		if (textStatus == "success"){
			var HTML='<div style="text-align: center;font-size: x-large;color: #000;"><h1 class="TI">'+jsonData.title+'</h1></div>'+
			'<div style="margin-left: 20px;width:600px;">'+jsonData.content+'</div>';
			$("#res_create").html(HTML);
			$("#res_create").find("img").each(function(i){
				if($("body").width()<$(this).width()){
					$(this).css({"height":"auto"}).css({"width":"100%"});
				}
			});
			
		}
	},
	//ajax请求错误后调用函数
	error:function(request,textStatus,error){}
}); 
</script>
</body>
</html>