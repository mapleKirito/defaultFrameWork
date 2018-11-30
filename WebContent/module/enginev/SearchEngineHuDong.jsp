<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">

function getWord(){
	var word = document.getElementById("word").value;
	
	window.open('http://www.hudong.com/wiki/'+word+'&prd=button_doc_jinru','','status=0,directories=0,resizable=1,toolbar=0,menubar=no,location=0,scrollbars=1,width=837,height=525');
}
</script>
</head>
<body>
	<table border="0" cellpadding="0" cellspacing="0" bgcolor="#F7F7F7" width="100%">
		<tr>
			<td width="66px;"><img src="<%=request.getContextPath()%>/images/main/HuDong.gif" border="0" /></td>
			<td><input id="word" type="text" value='<s:property value="#session.nameother" />' style="width: 96px; margin-top: 2px" onMouseOver="this.focus()" onFocus="this.select()"/>
			</td>
			<td> <input type="button" class="sb" value="互动百科搜索&nbsp;&nbsp;" style="width: 95px; height: 22px" onclick="getWord();"></td>
		</tr>
	</table>
</body>
</html>