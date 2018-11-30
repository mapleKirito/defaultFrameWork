<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><s:text name="systemName"/></title>
</head>
<body>
<ul>
<p><img src="${(initMap.userInfo.userImg==null||initMap.userInfo.userImg=='')?'images/main/toux.jpg':initMap.userInfo.userImg}" width="145" height="147"></p>
<p class="table_6P">${initMap.userInfo.userAccount}</p>
<p class="table_6P">名称：${initMap.userInfo.userName}</p>
<p class="table_6P">类型：${(initMap.userInfo.userType==1)?'老师':(initMap.userInfo.userType==2?'学生':'管理员')}</p>
<p class="table_6P">财富值：${initMap.userInfo.wealth}</p>
<p class="table_6P">qq:<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${initMap.userInfo.qq}&site=qq&menu=yes">${initMap.userInfo.qq}</a></p>
</ul>

</body>
</html>