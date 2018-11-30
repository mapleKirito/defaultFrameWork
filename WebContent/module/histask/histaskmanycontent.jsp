<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<html> 
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<title></title>
<head>
<script type="text/javascript">

$(document).ready(function(){	
	
	
});
</script>
</head>
<body>
<div id="manycontent-issh" wealth="${initMap.testmanydetail.htaskWealthval}">
	<ul>
		<li>
			${initMap.testmanydetail.htaskContent}
		</li>
	</ul>
</div>
</body>
</HTML>