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
<h3><a href="decorateForwardAction.action?code=002031001">文章发布</a></h3>
<h3>文章列表</h3>
<div>
<table>
<tr>
	<th>标题</th>
	<th>发表人</th>
	<th>创建时间</th>
</tr>

<s:subset source="initMap.lists" start="0" count="10">
	<s:iterator id="l" status="newsIndex">
	<tr>
		<td><a href="decorateForwardAction.action?code=-2220005&paramMap.aID=${l.aID }">${l.aTitle }</a></td>
		<td>${l.aCreaterName}</td>
		<td><fmt:formatDate value="${l.aTime}" pattern="yyyy-M-d" /></td>
	</tr>
	</s:iterator>
</s:subset>

</table>
</div>
</body>
</html>