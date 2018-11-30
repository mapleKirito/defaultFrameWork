<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<html>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<title></title>
<head>
<script type="text/javascript">

$(document).ready(function() {

	$(".gradesbox").click(function(){
		var testGrades = $(this).parent().attr("testGrades");
		window.parent.tabClick('R_-17010','考题浏览','-17010',"paramMap.testGrades=" + testGrades + "&pageSize=8&type=1");
	});
	
});

</script>
<style type="text/css">
.gradesbox{ border:1px solid #f60; width:100px; height:100px; margin:0 auto; cursor:pointer;
-webkit-border-radius:50px; -moz-border-radius:50px; -o-border-radius:50px; border-radius:50px;  } 
</style>
</head>
<body leftmargin="0" bottommargin="0" rightmargin="0" topmargin="0">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_to" id="funbig2" style="border-collapse: collapse;">
	<tr>
		<td align="center" width="60%">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="line-height: 100px;">
				<tr height="280px">
					<td testGrades="311" class="onlyex" align="center"><div class="gradesbox">
						七年级
					</div></td>
					<td testGrades="312" class="onlyex" align="center"><div class="gradesbox">
						八年级
					</div></td>
					<td testGrades="313" class="onlyex" align="center"><div class="gradesbox">
						九年级
					</div></td>
				</tr>
				<tr>
					<td testGrades="321" class="onlyex" align="center"><div class="gradesbox">
						必修一
					</div></td>
					<td testGrades="322" class="onlyex" align="center"><div class="gradesbox">
						必修二
					</div></td>
					<td testGrades="323" class="onlyex" align="center"><div class="gradesbox">
						必修三
					</div></td>
				</tr>
			</table>
		</td>
		<td align="center" width="40%">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="line-height: 35px;text-align: center;">
				<tr>
					<th colspan="2" align="center">今日之星</th>
				</tr>
				<s:iterator value="initMap.testGradesView" id="testGradesid" status="testgradesindex">
					<tr>				   
						<td><s:property value="#testGradesid.tcAccount"/></td>
						<td><s:property value="#testGradesid.tcAccountval"/></td>
					</tr>
				</s:iterator>
			</table>
		</td>
	</tr>
</table>

</body>
</HTML> --%>