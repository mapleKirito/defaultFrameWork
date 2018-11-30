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
	var $div_li =$(".looktab li");
	$div_li.click(function(){
		$(this).addClass("curr")            //当前<li>元素高亮
			   .siblings().removeClass("curr");  //去掉其它同辈<li>元素的高亮
		var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
		$(".table_9")   	//选取子节点。不选取子节点的话，会引起错误。如果里面还有div 
				.eq(index).show()   //显示 <li>元素对应的<div>元素
				.siblings().hide(); //隐藏其它几个同辈的<div>元素
	});		
	$("#create_1_div").click(function(){
		var haveorg = '${session.haveOrg}';
		if(haveorg == null || haveorg == ''){
			var rv = confirm("本账号不属于任何班级，如继续提问，问题无法在列表中显示。您确认要继续提问吗？");
			if (rv)
			{
				window.location.href = "decorateForwardAction.action?code=001008001&paramMap.step=${pmsIndex.myTask_mgr.imitationStep}";
			}
		}else{
			window.location.href = "decorateForwardAction.action?code=001008001&paramMap.step=${pmsIndex.myTask_mgr.imitationStep}";
		}	
	});
	
	$("#change_type").val("3");
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
			 <tr>
				<td height="30">
                   <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:1px solid #cdcdcd;" id="tbstu_question">
                       <tr>                           
                          <td width="69%" class="size_2" align="right">
                              <div id="create_1_div"><img src="images/main/question.png" border="0" id="questionBtn"/>&nbsp;&nbsp;<span>提问</span></div>
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
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_x">
								  <tr>
									<th width="25%" align="center">标题</th>
									<th width="25%" align="center">回复/查看</th>
									<th width="25%" align="center">发布时间</th>
									<th width="25%" align="center">操作</th>
								  </tr>
								  <s:iterator value="initMap.question" id="qu" status="tindx">
								  <tr bgcolor="#ae9b84">
									<td class="tatd" align="center"><a href="decorateForwardAction.action?code=001001003&paramMap.taskId=${qu.taskId}">${qu.title}</a></td>
									<td class="tatd" align="center">${qu.replyCount}/${qu.viewCount}</td>
									<td class="tatd" align="center">${qu.createTime}&nbsp;</td>
									
									<s:if test="#qu.isLock != 1">
								 		<td class="tatd" align="center"><a href="decorateForwardAction.action?code=001008002&paramMap.taskId=${qu.taskId}">修改</a></td>
								 	</s:if>
								 	<s:else>
								 		<td class="tatd" align="center"><span style="text-decoration:line-through">修改</span></td>
								 	</s:else>
								  </tr>								  
								  </s:iterator>
								  <tr bgcolor="#ae9b84">
									<td colspan="4">
										<div class="pageb">
											${initMap.questionPaginated.pageContent}
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