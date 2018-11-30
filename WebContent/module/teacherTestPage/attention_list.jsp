<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>数字生物馆</title>
<SCRIPT type=text/javascript src="space/jquery.js"></SCRIPT>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
</head>
<body>
<h3>关注好友</h3>
<div>
<table>
<tr>
	<th>ID</th>
	<th>名称</th>
	<th>类型</th>
</tr>

<s:subset source="initMap.lists" start="0" count="10">
	<s:iterator id="l" status="newsIndex">
	<tr>
		<td>${l.targetID}</td>
		<td>${l.userName}</td>
		<td>${(l.userType==1)?'老师':(l.userType==2?'学生':'管理员')}</td>
	</tr>
	</s:iterator>
</s:subset>

</table>
</div>
</body>
</html>