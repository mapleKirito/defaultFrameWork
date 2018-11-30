<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String redirectUrl = request.getParameter("redirectUrl") ;
String errorMessage = request.getParameter("errorMessage") ;
errorMessage = errorMessage == null ? "" : errorMessage ;
if("success".equals(errorMessage)) {
%>
<script type="text/javascript">
<!--
alert('操作成功！');
window.location.href = "../../../<%=redirectUrl %>" ;
//-->
</script>

<%		
}else if(errorMessage.length() > 0) {
%>
<script type="text/javascript">
<!--
alert('<%=errorMessage%>');
window.history.back();
//-->
</script>

<%	
}
%>
