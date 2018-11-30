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
.table_9 tr td.tatd input,.table_9 tr th input{width: 13px;height: 13px;}
</style>
<script type="text/javascript">
$(document).ready(function(){	
	$("#alert").css("cursor","pointer");
	$('#alert').screenTB({
    	windowDocument:window.parent.parent.document,
		width:'250',
		height:'150',
		content:'测试内容',
		contentAlign:'center',
		contentValign:'middle',
		title:'系统提示信息',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',	
		dialogType:'alert',
		iframeSrc:''
		},{
		clickEvent:function(data){
   			if ($("#grid input[type='checkbox']:checked").size() == 0){
   				data = $.extend(data,{content:'请选择您要提示的学生数据！'});
   			}
   			else{
   				$.extend(data,{returnValue:'true'});
   				var faction = $("#actionForm").attr("action");
   				$("#actionForm").attr("action",faction+"?code=002007002");
   				$("#actionForm").submit();		    			
   			}
		}
	});
	
	$("#tot_all_check").click(function() { 
		var tmp=1;
		var $child = $("input[class='student_']");
		if($(this).attr("checked")){
			$child.each(function() { 
				if(!$(this).attr("disabled")){
					$(this).attr("checked", true); 
					tmp=0;
				}
			}); 
		}else{
			$child.each(function() { 
				if(!$(this).attr("disabled"))
					$(this).attr("checked", false); 
			}); 
		}
		if(tmp)
			$(this).attr("checked", false);
	});	
	
	var $subBox = $("input[class='student_']");  
	$subBox.click(function(){  
		$("#tot_all_check").attr("checked",$subBox.length == $("input[class='student_']:checked").length ? true : false);  
	});  
	
});

</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="paramMap.tID" value="${paramMap.taskId}"> 
 
<input type="hidden" name="imitateStep" value="${pmsIndex.student_my_info_mgr.imitationStep}"> 
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
		 <tr width="90%">
			<td colspan="2" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_yj">					
					<tr>
						<td width="85%" align="left"><div id="create_b_div"><span>作业名称：${paramMap.title}</span></div></td>
						<td width="15%" align="right">
							<a id="alert"><div id="create_a_div"><img src="<%=request.getContextPath()%>/images/common/216.gif" align="top" width="14" border="0" height="14"><span>提示</span></div></a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="120px;">
				<td valign="middle">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>					
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<div>
								<table id="grid"  width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
								  <tr>
								  	<th width="5%"><input type="checkbox" name="checkbox" value="checkbox" id="tot_all_check"></th>
								  	<th>提醒状态</th>
									<th>姓名</th>
									<th>性别</th>
									<th>班级</th>
								  </tr>
								  <s:iterator value="initMap.unfinshedTaskUserList" id="user" status="tindx">
									  <tr bgcolor="#ae9b84">
										  	<td align="center" class="tatd"><input value="${user.studentID }" name="paramMap.studentID" type="checkbox" class="student_" <s:if test="#user.taskAlert==1"> disabled="disabled" </s:if>></td>		
										  	<td align="center" class="tatd"><s:if test="#user.taskAlert==1">已提醒</s:if><s:if test="#user.taskAlert==0">未提醒</s:if><s:if test="#user.taskAlert<>1 && #user.taskAlert<>0">未知</s:if></td>						  
											<td align="center" class="tatd">${user.userName}</td>
											<td align="center" class="tatd"><s:if test="#user.userGender==1">男</s:if><s:if test="#user.userGender==0">女</s:if><s:if test="#user.userGender<>1 && #user.userGender<>0">未知</s:if></td>
											<td align="center" class="tatd">${user.orgName}</td>
									  </tr>								  
								  </s:iterator>
								  <tr bgcolor="#ae9b84">
									<td colspan="5">
										<div class="pageb">
											${initMap.taskPaginated.pageContent}
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