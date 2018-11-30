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

$(function(){
	var $div_li =$(".teacherTab li");
	$div_li.click(function(){
		$(this).addClass("curr").siblings().removeClass("curr");  
		var index =  $div_li.index(this);  
		$("#change_type").val(index);
		$(".table_9").eq(index).show().siblings().hide();
	});
	
	$('#table1page').pageTB();
	$('#table2page').pageTB();
	$('#table3page').pageTB();
	
	var change_type_index = '${paramMap.change_type}' == '' ? '0' : '${paramMap.change_type}';
	$div_li.eq(change_type_index).addClass("curr").siblings().removeClass("curr");
	$(".table_9").eq(change_type_index).show().siblings().hide();
	$("#change_type").val(change_type_index);
	
	$("#selectClass").change(function(){
		var faction = $("#actionForm").attr("action");
		var value=$(this).children('option:selected').val();
		$("#actionForm").attr("action",faction+"?code=002001&paramMap.orgID="+value);
		$("#actionForm").submit();	
	});
	var attentionName=$("#attention").html();
	
	$("#attention").hover(function(){
		$(this).css({"background":"red"});
		if($("#attentionVal").val()=="1"){
			$(this).html("取消关注");
		}else{
			$(this).html("关注TA");
		}
	},function(){
		$(this).removeAttr("style");
		if($("#attentionVal").val()=="1"){
			$(this).html("已关注");
		}else{
			$(this).html("未关注");
		}
	}).click(function(){
		var currentTime= new Date().getTime();
		var attentionType="";
		if($("#attentionVal").val()=="1"){
			attentionType="remove";
		}else{
			attentionType="add";
		}
		$.ajax({
			url:		"ajaxAction.action?code=002018001012&paramMap.attentionType="+attentionType+"&paramMap.targetID="+$("#userID").val()+"&suiji="+currentTime,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){	
					if(jsonData.ans=="1"){
						if($("#attentionVal").val()=="1"){
							$("#attention").html("未关注");
							$("#attentionVal").val("0");
						}else{
							$("#attention").html("已关注");
							$("#attentionVal").val("1");
						}
					}
				}
			},
			
			error:function(request,textStatus,error){}
		});
	});
})
</script>
</head>
<body style="background-color:#e0ebee; margin:0; padding:0; font-family:'微软雅黑'" id="tt">
<input type="hidden" id="change_type" value="0">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
    
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="161" valign="top" class="touxTd1" bgcolor="#606373"  style="padding:0;">
							<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">				
								<table width="100%" border="0" cellspacing="0" cellpadding="0" id="info_tb">
								  <tr>
									<td class="touxTd2">
										<p><img src="${(initMap.userInfo.userImg==null||initMap.userInfo.userImg=='')?'images/main/toux.jpg':initMap.userInfo.userImg}" width="145" height="147"></p>
										<p class="table_6P">${initMap.userInfo.userAccount}</p>
										<input type="hidden" id="attentionVal" value="${initMap.userInfo.attention }">
										<input type="hidden" id="userID" value="${initMap.userInfo.userID}">
										<s:if test="initMap.userInfo.attention==1">
											<p id="attention" class="table_6P">已关注</p>
										</s:if>
										<s:if test="initMap.userInfo.attention!=1">
											<p id="attention" class="table_6P">未关注</p>
										</s:if>
									</td>
								  </tr>
								  <tr>
									<td>
										<p class="table_6P1">姓名：${initMap.userInfo.userName}</p>
										<p class="table_6P1">性别：<s:if test="initMap.userInfo.userGender==1">男</s:if><s:if test="initMap.userInfo.userGender== 0">女</s:if></p>
										<s:if test="initMap.userInfo.qq!=''">
											<p class="table_6P1">QQ聊天：
												<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${initMap.userInfo.qq}&site=qq&menu=yes">
													${initMap.userInfo.qq}
												</a>
											</p>
										</s:if>
										<s:if test="initMap.userInfo.userNo!=''">
											<p class="table_6P1">教师证号：${initMap.userInfo.userNo}</p>
										</s:if>
										<p class="table_6P1">财富值：${initMap.userInfo.wealth}</p>
										<s:if test="initMap.userInfo.userEmail!=''">
										<p class="table_6Pemail">${initMap.userInfo.userEmail}</p>
										</s:if>
										
									</td>
								  </tr>
								</table>
							</form>
						</td>
						<td width="100%" bgcolor="#606373" valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_8">
							  <tr>
								<td style="height:32px;">
									<ul class="teacherTab">
										<li class="curr">我的心情状态</li>
										<li>特别关注</li>
										<li>感兴趣问题</li>
										<li>我的小组</li>
									</ul>								
								</td>
							  </tr>
							</table>
							<div>
							<form name="form" method="post" action="decorateForwardAction.action" id="form">				
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
							  	  	<tr bgcolor="#ae9b84">
								  	  	<td>
								  	  		心情状态加载中。。。
										</td>
									</tr>
								</table>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
								  	<tr bgcolor="#ae9b84">					  	  
										<td class="tatd" align="left">
											特别关注加载中。。。
										</td>	
								  	<tr>
								</table>
								
								<table id="grid" width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
								  <tr bgcolor="#ae9b84">
									<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
										感兴趣问题加载中。。。
									</td>
								  </tr>
								</table>
								
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9 hide">
								  <tr bgcolor="#ae9b84">
									<td colspan="4" style="height:30px;border-bottom:1px dotted #ffffff;">
										小组加载中。。。
									</td>
								  </tr>
								</table>							
							</form>
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
</body>
</html>
