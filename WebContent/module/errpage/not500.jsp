<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=utf8">
<meta charset="utf-8">
<title>数字历史馆</title>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<style type="text/css">
body,html{margin:0;padding:0;font-size:14px;font-family:"宋体",Arial, Helvetica, sans-serif;color: #606373;}
a{text-decoration:none;color: #606373;}
</style>
<script language="JavaScript" >
$(document).ready(function(){
	$("#rep").click(function(){
		parent.location.reload();
	});	
});
</script>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.keydown.js" type="text/javascript"></script>
</head>
<body bgcolor="#e8e8e8">
<table border="0" width="60%" align="center">
	<tr>
		<td valign="middle">
			<a href="<%=request.getContextPath()%>/index.jsp"><h1>数字历史馆</h1></a>
		</td>
	</tr>
</table>
<table border="0" width="60%" align="center">
	<tr>
		<td valign="top">
			<img src="<%=request.getContextPath()%>/images/pic/sorry.png" height="100px">
			<h2><p>请您重新<a href="javascript:void(0)" id="rep">刷新浏览器!</a>
			<br><br></p><hr color="#606373" size="1"></h2>
		</td>
	</tr>
</table>
</body>
</html>