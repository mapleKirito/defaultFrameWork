<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<title></title>
<head>
<link href="qc/css/style.css" rel="stylesheet" />
<link href="qc/css/calendar.css" rel="stylesheet">
<script src="qc/js/scripts.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<style type="text/css">

</style>






</head>
<body>
<input type="hidden" id="uid" value="${paramMap.userID }" >
	<div id="layout_mainbody">
		<div class="my-article panel" style="margin-top: 0px;">
							<p class="title topborder">
								最新动态
								<%-- <span><a href="javascript:void(0)">更多</a></span> --%>
							</p>
							<div class="body">
								<ul class="my-article-list">
								<s:iterator id="l" value="initMap.articleList" status="newsIndex">
									<li>
										<div class="user-info-area">
											<img style="width: 64px;height: 64px;display: block;" src="${l.userImg}" onerror="this.src='images/default/default_img.jpg'" />
											<a href="javascript:void(0)">${l.aCreaterName}</a>
											<p>${l.aTime}</p>
										</div>
										<div class="article-info-area">
											<p class="title">
												${l.aTitle}
											</p>
											<p class="content">
												${l.aContent}...
												[<a href="decorateForwardAction.action?code=002031003&paramMap.aID=${l.aID}"class="red">查看原文</a>]
											</p>
										</div>
									</li>
								</s:iterator>
								</ul>
							</div>
						</div>
	</div>


<script type="text/javascript">
	$(document).ready(function () {
		$('#table3page').pageTB();
	});



	$(document).ready(function(){
		$('.my-article img').each(function(){ 
			console.info("done");
	        if($(this).attr('src')==''){                   
	            $(this).attr('src','images/default/default_img.jpg');               
	        }           
	    }); 
	});


</script>
</body>
</HTML>
