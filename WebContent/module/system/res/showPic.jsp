<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title><s:text name="systemName"/></title>
<link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" />

</head>
<body>
<s:debug></s:debug>
${param.path}
<img src="${param.path}"  />	
<c:forEach items="${resViw111111 }" var="re">
<lable>${re.name }</lable>
</c:forEach>
 
</body>
</html>