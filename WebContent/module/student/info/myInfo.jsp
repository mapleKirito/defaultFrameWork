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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/pageToolbar2.js"></script>
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<script type="text/javascript">
$(document).ready(function(){	
	var $div_li =$(".teacherTab li");
	$div_li.click(function(){
		$(this).addClass("curr").siblings().removeClass("curr");  //去掉其它同辈<li>元素的高亮
		var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
		$("#change_type").val(index);
		$(".table_9").eq(index).show().siblings().hide(); //隐藏其它几个同辈的<div>元素
	});	
	
	var change_type_index = '${paramMap.change_type}' == '' ? '0' : '${paramMap.change_type}';
	$div_li.eq(change_type_index).addClass("curr").siblings().removeClass("curr");
	$(".table_9").eq(change_type_index).show().siblings().hide();
	$("#change_type").val(change_type_index);
	
	$('#table1page').pageTB();
	$('#table2page').pageTB();
	$('#table3page').pageTB();
	$('#table4page').pageTB();
	$('#table5page').pageTB();
	
	
	
});
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.userID" value="${initMap.userInfo.userID}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.student_my_info_mgr.imitationStep}"> 
<input type="hidden" id="change_type" value="0">
<s:if test="paramMap.changeTypeInfo!= null && paramMap.changeTypeInfo != ''">
<input type="hidden" id="changeTypeInfo" value="${paramMap.changeTypeInfo}">
</s:if>
<s:if test="paramMap.changeTypeInfo == null || paramMap.changeTypeInfo == ''">
<input type="hidden" id="changeTypeInfo" value="one">
</s:if>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="161" valign="top" bgcolor="#606373"  class="touxTd1" style="padding:0;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="info_tb">
							  <tr>
								<td class="touxTd2">
									<p><img src="images/main/toux1.jpg" width="145" height="147"></p>
									<p class="table_6P">${session.s_userLoginName}</p>
								</td>
							  </tr>
							  <tr>
								<td>
									<p class="table_6P1">姓名：${session.s_userLoginName}</p>
									<p class="table_6P1">性别：<s:if test="empty session.s_userGender">未知</s:if><s:if test="#session.s_userGender == 1">男</s:if><s:if test="#session.s_userGender == 0">女</s:if></p>
									<p class="table_6P1">班级：<s:iterator value="session.s_userOrgMapper" id="uo" status="uoindx">${uo.orgName}<br></s:iterator></p>
									<s:if test="session.s_userMail!=''">
									<p class="table_6Pemail">${session.s_userMail}</p>
									</s:if>
									<p class="table_6Ppersonal"><a href="decorateForwardAction.action?code=001001001&paramMap.userID=${session.s_userID}" class="bule">修改个人资料</a></p>	
									<p class="table_6Presource"><a href="decorateForwardAction.action?code=001001002&paramMap.userID=${session.s_userID}" class="bule">我的提醒（${initMap.alertCount}）</a></p>
								</td>
							  </tr>
							</table>
						</td>
						<td width="100%" bgcolor="#606373" valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_7">
							  <tr bgcolor="#ae9b84">
								<td width="20%" align="center">学习成果 </td>
								<td width="20%" align="center">推荐数</td>
							    <td width="20%" align="center">精彩回答</td>
							  </tr>
							  <tr>
								<td class="tab7td">${initMap.atatistics.lockCount}</td>
								<td class="tab7td">${initMap.atatistics.recommendCount}</td>
							    <td class="tab7td">${initMap.atatistics.excellentCount}</td>
							  </tr>
							</table>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_8">
							  <tr>
								<td style="height:32px;">
									<ul class="teacherTab" style="width: 480px;border-right: 1px solid">
										<li class="curr">作业习题</li>
										<li>学习成果</li>
										<li>未完成作业</li>
										<li>我的提问</li>
										<li>同学提问</li>
									</ul>
								</td>
							  </tr>
							</table>
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
								  <tr>
									<th>标题</th>
									<th width="22%">回复/查看</th>
									<th width="25%">发表时间</th>
								  </tr>
								  <s:iterator value="initMap.task" id="task" status="tindx">
								  <s:if test="tindx%2 == 0">
								  <tr bgcolor="#ae9b84">
									<td class="tatd">
										<s:if test="task.isLock==1">
											<img src="images/main/bg_15.png" width="13" height="14">										
										</s:if>
										<s:if test="task.isRecommend==1">
											<img src="images/main/bg_14.png" width="13" height="14">
										</s:if>
										<s:else>
											<img src="images/main/bg_13.png" width="13" height="14">
										</s:else>
										<a href="decorateForwardAction.action?code=001001006&paramMap.taskId=${task.taskId}"><span>${task.title}</span></a>
									</td>
									<td align="center" class="tatd">${task.replyCount}/${task.viewCount}</td>
									<td align="center" class="tatd">${task.createTime}&nbsp;</td>
								  </tr>								  
								  </s:if>
								  <s:if test="tindx%2 != 0">
								  <tr>
									<td class="tatd">
										<s:if test="task.isLock==1">
											<img src="images/main/bg_15.png" width="13" height="14">										
										</s:if>
										<s:if test="task.isRecommend==1">
											<img src="images/main/bg_14.png" width="13" height="14">
										</s:if>
										<s:else>
											<img src="images/main/bg_13.png" width="13" height="14">
										</s:else>
										<a href="decorateForwardAction.action?code=001001003&paramMap.taskId=${task.taskId}"><span>${task.title}</span></a>
									</td>
									<td align="center" class="tatd">${task.replyCount}/${task.viewCount}</td>
									<td align="center" class="tatd">${task.createTime}&nbsp;</td>
								  </tr>
								  </s:if>
								  </s:iterator>
								  <tr>
									<td colspan="4">
										<div class="pageb" id="table1page">
											${initMap.taskPaginated.pageContent}
										</div>									
									</td>
								  </tr>
								</table>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
								  <tr>
									<th>标题</th>
									<th width="22%">回复/查看</th>
									<th width="25%">发表时间</th>
								  </tr>
								  <s:iterator value="initMap.result" id="result" status="rindx">
								  <s:if test="rindx%2 == 0">
								  <tr bgcolor="#ae9b84">
								  	
									<td class="tatd">
										<img src="images/main/bg_15.png" width="13" height="14">
										<a href="decorateForwardAction.action?code=001001006&paramMap.taskId=${result.taskId}"><span>${result.title}</span></a>
									</td>
									<td align="center" class="tatd">${result.replyCount}/${result.viewCount}</td>
									<td align="center" class="tatd">${result.createTime}&nbsp;</td>
								  </tr>								  
								  </s:if>
								  <s:if test="rindx%2 != 0">
								  <tr>
									<td class="tatd">
										<img src="images/main/bg_15.png" width="13" height="14">
										<a href="decorateForwardAction.action?code=001001006&paramMap.taskId=${result.taskId}"><span>${result.title}</span></a>														
									</td>
									<td align="center" class="tatd">${result.replyCount}/${result.viewCount}</td>
									<td align="center" class="tatd">${result.createTime}&nbsp;</td>
								  </tr>
								  </s:if>
								  </s:iterator>								  
								  <tr>
									<td colspan="4">
										<div class="pageb" id="table2page">
										${initMap.resultPaginated.pageContent}
										</div>									
									</td>
								  </tr>
								</table>
								
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
								  <tr>
								
									<th colspan="2">标题</th>
									<th width="22%">回复/查看</th>
									<th width="25%">发表时间</th>
								  </tr>
								  <s:iterator value="initMap.unfinished" id="un" status="uindx">
								  <s:if test="uindx%2 == 0">
								  <tr bgcolor="#ae9b84">
									<td width="5%">
							  	  		<s:if test="#un.isLock==1">
											<img src="images/main/bg_15.png" width="13" height="14">										
										</s:if>
									</td>
									<td class="tatd">
										
										<s:if test="#un.isRecommend==1">
											<img src="images/main/bg_14.png" width="13" height="14">
										</s:if>
										<s:else>
											<img src="images/main/bg_13.png" width="13" height="14">
										</s:else>
										<a href="decorateForwardAction.action?code=001001005&paramMap.taskId=${un.taskId}"><span>${un.title}</span></a>
									</td>
									<td align="center" class="tatd">${un.replyCount}/${un.viewCount}</td>
									<td align="center" class="tatd">${un.createTime}&nbsp;</td>
								  </tr>								  
								  </s:if>
								  <s:if test="uindx%2 != 0">
								  <tr>
									<td width="5%">
							  	  		<s:if test="#un.isLock==1">
											<img src="images/main/bg_15.png" width="13" height="14">										
										</s:if>
									</td>
									<td class="tatd">
										
										<s:if test="#un.isRecommend==1">
											<img src="images/main/bg_14.png" width="13" height="14">
										</s:if>
										<s:else>
											<img src="images/main/bg_13.png" width="13" height="14">
										</s:else>
										<a href="decorateForwardAction.action?code=001001005&paramMap.taskId=${un.taskId}"><span>${un.title}</span></a>
									</td>
									<td align="center" class="tatd">${un.replyCount}/${un.viewCount}</td>
									<td align="center" class="tatd">${un.createTime}</td>
								  </tr>
								  </s:if>
								  </s:iterator>									  
								  <tr>
									<td colspan="5">
										<div class="pageb" id="table3page">
											${initMap.unfinishedPaginated.pageContent}
										</div>									
									</td>
								  </tr>
								</table>
								
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
								  <tr bgcolor="#ae9b84" style="border-bottom:1px solid #ffffff;">
									<td colspan="6" ><a href="decorateForwardAction.action?code=001008001&paramMap.step=${pmsIndex.student_my_info_mgr.imitationStep}">我要提问</a></td>
								  </tr>
								  <tr>
									<th colspan="2">标题</th>
									<th width="22%">回复/查看</th>
									<th width="25%">发表时间</th>
								  </tr>
								  <s:iterator value="initMap.question" id="qu" status="qindx">
								  <s:if test="qindx%2 == 0">
								  <tr bgcolor="#ae9b84">
									<td width="5%">
							  	  		<s:if test="#qu.isLock==1">
											<img src="images/main/bg_15.png" width="13" height="14">										
										</s:if>
									</td>
									<td class="tatd">
										
										<s:if test="#qu.isRecommend==1">
											<img src="images/main/bg_14.png" width="13" height="14">
										</s:if>
										<s:else>
											<img src="images/main/bg_13.png" width="13" height="14">
										</s:else>
										<a href="decorateForwardAction.action?code=001001003&paramMap.taskId=${qu.taskId}"><span>${qu.title}</span></a>
									</td>
									<td align="center" class="tatd">${qu.replyCount}/${qu.viewCount}</td>
									<td align="center" class="tatd">${qu.createTime}&nbsp;</td>
								  </tr>								  
								  </s:if>
								  <s:if test="qindx%2 != 0">
								  <tr>
									<td width="5%">
							  	  		<s:if test="#qu.isLock==1">
											<img src="images/main/bg_15.png" width="13" height="14">										
										</s:if>
									</td>
									<td class="tatd">
										
										<s:if test="#qu.isRecommend==1">
											<img src="images/main/bg_14.png" width="13" height="14">
										</s:if>
										<s:else>
											<img src="images/main/bg_13.png" width="13" height="14">
										</s:else>
										<a href="decorateForwardAction.action?code=001001003&paramMap.taskId=${qu.taskId}"><span>${qu.title}</span></a>
									</td>
									<td align="center" class="tatd">${qu.replyCount}/${qu.viewCount}</td>
									<td align="center" class="tatd">${qu.createTime}</td>
									
								  </tr>
								  </s:if>
								  </s:iterator>									  
								  <tr>
									<td colspan="5">
										<div class="pageb" id="table4page">
											${initMap.questionPaginated.pageContent}
										</div>									
									</td>
								  </tr>
								</table>	
								
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
								  <tr bgcolor="#ae9b84" style="border-bottom:1px solid #ffffff;">
									<td colspan="6" ><%-- <a href="decorateForwardAction.action?code=001008001&paramMap.step=${pmsIndex.student_my_info_mgr.imitationStep}">我要提问</a> --%></td>
								  </tr>
								  <tr>
									<th colspan="2">标题</th>
									<th width="22%">回复/查看</th>
									<th width="25%">发表时间</th>
								  </tr>
								  <s:iterator value="initMap.question_class" id="qu" status="qindx">
								  <s:if test="qindx%2 == 0">
								  <tr bgcolor="#ae9b84">
									<td width="5%">
							  	  		<s:if test="#qu.isLock==1">
											<img src="images/main/bg_15.png" width="13" height="14">										
										</s:if>
									</td>
									<td class="tatd">
										
										<s:if test="#qu.isRecommend==1">
											<img src="images/main/bg_14.png" width="13" height="14">
										</s:if>
										<s:else>
											<img src="images/main/bg_13.png" width="13" height="14">
										</s:else>
										<a href="decorateForwardAction.action?code=001001004&paramMap.taskId=${qu.taskId}"><span>${qu.title}</span></a>
									</td>
									<td align="center" class="tatd">${qu.replyCount}/${qu.viewCount}</td>
									<td align="center" class="tatd">${qu.createTime}&nbsp;</td>
									
								  </tr>								  
								  </s:if>
								  <s:if test="qindx%2 != 0">
								  <tr>
									<td width="5%">
							  	  		<s:if test="#qu.isLock==1">
											<img src="images/main/bg_15.png" width="13" height="14">										
										</s:if>
									</td>
									<td class="tatd">
										
										<s:if test="#qu.isRecommend==1">
											<img src="images/main/bg_14.png" width="13" height="14">
										</s:if>
										<s:else>
											<img src="images/main/bg_13.png" width="13" height="14">
										</s:else>
										<a href="decorateForwardAction.action?code=001001004&paramMap.taskId=${qu.taskId}"><span>${qu.title}</span></a>
									</td>
									<td align="center" class="tatd">${qu.replyCount}/${qu.viewCount}</td>
									<td align="center" class="tatd">${qu.createTime}</td>
									
								  </tr>
								  </s:if>
								  </s:iterator>									  
								  <tr>
									<td colspan="5">
										<div class="pageb" id="table5page">
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