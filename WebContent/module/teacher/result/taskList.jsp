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
	$("#change_type").val("0");
});

</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.userID" value="${initMap.userInfo.userID}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.reault_list.imitationStep}"> 
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
								  	<th width="2%"> &nbsp;</th>
									<th width="2%"> &nbsp;</th>
									<th width="55%" align="center"><b>标题</b></th>
									<th width="15%" align="center"><b>回复/查看</b></th>
									<th width="26%" align="center"><b>发表时间</b></th>
								  </tr>
								  <s:iterator value="initMap.taskList" id="task" status="tindx">
								  <s:if test="tindx%2 == 0">
								  <tr bgcolor="#ae9b84">
								    <td class="tatd" algin="right">
							  	  		<s:if test="#task.isLock==1">
											<img src="images/main/bg_15.png" width="13" height="14">										
										</s:if>
									</td>
								  	<td class="tatd" algin="left">
								  		
										<s:if test="#task.isRecommend == 1">
											<img src="images/main/bg_14.png" width="13" height="14">
										</s:if>
										<s:else>
											<img src="images/main/bg_13.png" width="13" height="14">
										</s:else>
									</td>
									<td class="tatd" align="left"><a href="decorateForwardAction.action?code=002001004&paramMap.locaflag=result_mgr&paramMap.taskId=${task.taskId}">${task.title}</a></td>
									<td class="tatd" align="center">${task.replyCount}/${task.viewCount}</td>
									<td class="tatd" align="center">${task.createTime}</td>
								  </tr>								  
								  </s:if>
								  <s:if test="tindx%2 != 0">
								  <tr>
								  	<td class="tatd">
										<s:if test="#sList.isRecommend == 1">
											<img src="images/main/bg_14.png" width="13" height="14">
										</s:if>
										<s:else>
											<img src="images/main/bg_13.png" width="13" height="14">
										</s:else>
									</td>
									<td class="tatd" align="center"><a href="decorateForwardAction.action?code=002001004&paramMap.locaflag=result_mgr&paramMap.taskID=${task.taskID}">${task.title}</a></td>
									<td class="tatd" align="center">${task.replyCount}/${task.viewCount}</td>
									<td class="tatd" align="center">${task.createTime}</td>
								  </tr>
								  </s:if>
								  </s:iterator>
								  <tr bgcolor="#ae9b84">
									<td colspan="5">
										<div class="pageb">
											${initMap.taskPaginated1.pageContent}
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