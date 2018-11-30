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
	$("#search").css("cursor","pointer");	
	$("#search").click(function(){
		var faction = $("#actionForm").attr("action");
		$("#actionForm").attr("action",faction+"?code=002006004");
		$("#actionForm").submit();	
	});
});

</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="paramMap.userID" value="${initMap.userInfo.userID}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.student_my_info_mgr.imitationStep}"> 
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			 <tr>
				<td colspan="2" valign="top">
	                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_yj" style="margin-left: -1px;">					
						<tr>
							<td width="64%" align="left">&nbsp;&nbsp;<a href="decorateForwardAction.action?code=002006001"><div id="create_1_div"><img src="images/main/teacher_0.png" border="0" />&nbsp;&nbsp;<span>新建</span></div></a></td>
							<td width="36%" align="right"><span style="color:black;">标题：</span>&nbsp;  <input type="text" name="paramMap.title" style="height:21px;"><input type="button" value="查询" id="search" class="search_1"></td>
						</tr>
					</table>
				</td>
			</tr>
			 <tr>
				<td colspan="2" valign="top" height="5">
				</td>
			</tr>			
			<tr height="120px;">
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>					
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_x">
							  <tr>
								<th width="80%"><b>标题</b></th>
								<th width="20%"><b>操作</b></th>
							  </tr>
							  <s:iterator value="initMap.taskList" id="task" status="tindx">
							  <s:if test="#tindx.index%2 == 0">
							  <tr bgcolor="#ae9b84">
								<td align="left" class="tatd" ><a href="decorateForwardAction.action?code=002006005&paramMap.taskId=${task.taskId}">${task.title}</a></td>
								<td align="center" class="tatd"><a href="decorateForwardAction.action?code=002006002&paramMap.taskId=${task.taskId}"><img border="0" align="absmiddle" width="14" height="14" src="<%=basePath %>/images/common/113.gif"/><span>修改</span></a>&nbsp;&nbsp;&nbsp;<a href="decorateForwardAction.action?code=002006003&paramMap.taskId=${task.taskId}"><img border="0" align="absmiddle" width="14" height="14" src="<%=basePath %>/images/common/109.gif"><span>删除</span></a></td>
							  </tr>								  
							  </s:if>
							  
							  <s:if test="#tindx.index%2 != 0">
							  <tr bgcolor="#ae9b84">
								<td align="left" class="tatd" ><a href="decorateForwardAction.action?code=002006005&paramMap.taskId=${task.taskId}">${task.title}</a></td>
								<td align="center" class="tatd"><a href="decorateForwardAction.action?code=002006002&paramMap.taskId=${task.taskId}"><img border="0" align="absmiddle" width="14" height="14" src="<%=basePath %>/images/common/113.gif" /><span>修改</span></a>&nbsp;&nbsp;&nbsp;<a href="decorateForwardAction.action?code=002006003&paramMap.taskId=${task.taskId}"><img border="0" align="absmiddle" width="14" height="14" src="<%=basePath %>/images/common/109.gif"><span>删除</span></a></td>
							  </tr>
							  </s:if>
							  </s:iterator>
							  <tr bgcolor="#ae9b84">
								<td colspan="4">
									<div class="pageb">
										${initMap.taskPaginated.pageContent}
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
	</td>
  </tr>
</table>
</form>
</body>
</html>