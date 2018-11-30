<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/pageToolbar.js"></script>
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<script type="text/javascript">
$(document).ready(function(){	
	$("#change_type").val("4");
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.userID" value="${initMap.userInfo.userID}"> 
<input type="hidden" name="imitateStep" value="myTask_mgr_list"> 
<input type="hidden" id="change_type" value="0"> 
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr height="120px;">
				<td valign="middle">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>					
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_x">
								  <tr>
									<th width="40%" align="center">标题</th>
									<th width="40%" align="center">回复/查看</th>
									<th width="20%" align="center">发布时间</th>
								  </tr>
								  <s:iterator value="initMap.question" id="qu" status="tindx">
								  <tr bgcolor="#ae9b84">
									<td class="tatd" align="center" bgcolor="#606373"><a href="decorateForwardAction.action?code=001001004&paramMap.taskId=${qu.taskId}">${qu.title}</a></td>
									<td class="tatd" align="center" bgcolor="#606373">${qu.replyCount}/${qu.viewCount}</td>
									<td class="tatd" align="center" bgcolor="#606373">${qu.createTime}&nbsp;</td>
								  </tr>								  
								  </s:iterator>
								  <tr>
									<td colspan="4">
										<div class="pageb">
											${initMap.questionClassPaginated.pageContent}
										</div>									
									</td>
								  </tr>
								</table>																					
							</div>						
						 </td>
				      </tr>
					</table>
			  	</td>
			</tr>
		</table>
	</td>
  </tr>
</table>
</form>
</body>
</html>