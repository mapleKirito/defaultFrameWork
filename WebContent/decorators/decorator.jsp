<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0.1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="../WEB-INF/taglib/sitemesh-decorator.tld" prefix="decorator" %>
<%@ taglib uri="../WEB-INF/taglib/sitemesh-page.tld" prefix="page" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title><s:text name="systemName"/></title>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv=”X-UA-Compatible”content=”IE=8″/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/decorators/decorator.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.grid.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.grid.tree.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.form.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.grid.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.screen.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.wresize.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/formValidator.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/formValidatorRegex.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/writenavigation.js" type="text/javascript"></script>
<decorator:head />
</head>
<body>
<span id="navigationhead" style="display:none;"><s:property value="navigation" escape="false"/><s:property value="bussessNavigation" escape="false"/></span>
<decorator:body />      
</body>
</html>
