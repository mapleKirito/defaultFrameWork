<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/pageToolbar.js"></script>
<script type="text/javascript">
$(function(){
	//移动
	$(".yd").css("cursor","pointer");
	$(".yd").click(function(){
		$(this).parent().parent().parent().siblings().find(".yidong").hide().end().find(".yd").attr("src","images/main/bg_3.png");
		if($(this).parent().next().css("display") == "none"){
			$(this).parent().next().show().end().children().attr("src","images/main/bg_2.png");
		}else{
			$(this).parent().next().hide().end().children().attr("src","images/main/bg_3.png");
			}
		return false;
	});
	$(document).bind('click', function(e) {
		var $clicked = $(e.target);
		if (! ($clicked.hasClass("yd") ||  $parent.find("div").hasClass("yidong")) ){
			$(".yidong").hide();
			$(".yd").attr("src","images/main/bg_3.png");
			return false;	
		}
	});
	$(".closed").css("cursor","pointer");
	$(".closed").bind('click',function(){
		$(".yidong").hide();
		$(".yd").attr("src","images/main/bg_3.png");	
	});
	
	$("#closedPlyd").css("cursor","pointer");
	$("#closedPlyd").bind('click',function(){
		$("#plyd").hide();
	});
	
	$("#clickPlyd").css("cursor","pointer");	
	$("#clickPlyd").bind('click',function(){
		$("#plyd").show();	
	});
	
	$(".classCss").css("cursor","pointer");	
	$(".classCss").bind('click', function(e) {
		var $clicked = $(e.target);
		$orgID=$clicked.attr("id");
		$('.classCss').screenTB({
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
	    				data = $.extend(data,{content:'请选择您要移动的数据！'});
	    			}
	    			else{
	    				$.extend(data,{returnValue:'true'});
	    				var faction = $("#form").attr("action");
						
	    				$("#form").attr("action",faction+"?code=002010004&paramMap.orgID="+$orgID);
	    				$("#form").submit();		    			
	    			}
				}
			});		
			
	});
	
	$("#selectClass").change(function(){
		var faction = $("#actionForm").attr("action");
		var value=$(this).children('option:selected').val();
		$("#actionForm").attr("action",faction);
		$("#actionForm").submit();	
	});
	
	$("#alert_user").css("cursor","pointer");
	$('#alert_user').screenTB({
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
   				data = $.extend(data,{content:'请选择您要提示的用户数据！'});
   			}
   			else{
   				$.extend(data,{returnValue:'true'});
   				var faction = $("#form").attr("action");
				
   				$("#form").attr("action",faction+"?code=002010005");
   				$("#form").submit();		    			
   			}
		}
	});
	
	$("#tot_all_check").click(function() { 
		var $child = $("input[class='userID']");
		if($(this).attr("checked")){
			$child.each(function() { 
				$(this).attr("checked", true); 
			}); 
		}else{
			$child.each(function() { 
				$(this).attr("checked", false); 
			}); 
		}
	});	
	
	var $subBox = $("input[class='userID']");  
	$subBox.click(function(){  
		$("#tot_all_check").attr("checked",$subBox.length == $("input[class='userID']:checked").length ? true : false);  
	});  
	
});
	
</script>
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
.table_1 tr td{padding: 0px;}
</style>
</head>
<body style="background-color:#e0ebee; margin:0; padding:0; font-family:'微软雅黑'" id="tt">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_1" style="border: 1px solid #606373;">
							  <tr>
								<td colspan="2" valign="top">
									<form name="actionForm" method="post" action="decorateForwardAction.action?code=002010" id="actionForm">
			                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_yj" style="line-height: 30px;">
											  <tr>
												<td width="11%" height="25" bgcolor="#606373" >
													<select name="searchMap.orgID" id="selectClass">
													<option value="">--选择班级--</option>
													<s:iterator value="initMap.orgList" id="oList" status="ol">
														<option value="${oList.orgID}" <s:if test="#oList.orgID==searchMap.orgID">selected</s:if> >${oList.orgName}</option>
													</s:iterator>
												</select>							  	</td>
												<td width="56%" bgcolor="#606373" >人数：<span class="font_1"><s:property value="initMap.studentList.size()" /></span>人</td>
												<td width="34%" align="right" bgcolor="#606373" >
													姓名：<input type="text" name="searchMap.userName" value="${paramMap.userName}" id="name" style="height: 21px;" />
													<input type="submit" value="确认" id="search" class="search_1">
												</td>
											  </tr>
										</table>
									</form>
								</td>
							  </tr>
							  <tr>
								<td colspan="2" valign="top">
									<form name="form" method="post" action="decorateForwardAction.action" id="form">
									<table id="grid" width="100%" border="0" cellspacing="0" cellpadding="0" class="tableList_1">
									  <tr>
										<td colspan="12" class="tableList_1bb" height="35" bgcolor="#606373" >
										<span class="span1" >
											<div class="plyd" id="plyd" >
												<ul>										
													<s:iterator value="initMap.orgList" id="oList" status="ol">
														<li class="classCss" id="${oList.orgID}">${oList.orgName}</li>												
													</s:iterator>
														<li id="closedPlyd">关闭</li>
												</ul>
											</div><a id="clickPlyd">批量移动</a>
										</span>
										</td>
									  </tr>
									  <tr>
										<td width="5%" class="tableList_2bb"><label>
										  <input type="checkbox" name="checkbox" value="checkbox" id="tot_all_check">
										</label></td>
										<td width="15%" class="tableList_2bb">用户名</td>
										<td width="19%" class="tableList_2bb">性别</td>
										<td width="18%" class="tableList_2bb">真实姓名</td>
										<td width="14%" class="tableList_2bb">班级</td>
										<td width="16%" class="tableList_2bb">最近登录时间</td>
										<td width="13%" colspan="3" class="tableList_2bb">操作</td>
									  </tr>
									  <s:iterator value="initMap.studentList" id="sList" status="sl">
								  		  <s:if test="#sl.index==0">
									  		<tr rid="2">
									  		
									  	  </s:if>
									  	  <s:if test="#sl.index!=0 && #sl.index/2==0">
									  	  	<tr>
									  	  </s:if>
									  	  <s:else>
									  	  	<tr class="bgcol_1">
									  	  </s:else>
											<td height="35" align="center" class="tableList_2bb"><input type="checkbox" class="userID" name="paramMap.userID" value="${sList.userID}"></td>
											<td height="35" align="center" class="tableList_2bb"class="font_2">${sList.userAccount }</td>
											<td height="35" align="center" class="tableList_2bb">
												<s:if test="#sList.userGender==1">
													男
												</s:if>
												<s:else>
													女
												</s:else>
											</td>
											<td height="35" align="center" class="tableList_2bb">${sList.userName}</td>
											<td height="35" align="center" class="tableList_2bb">${sList.orgName}</td>
											<td height="35" align="center" class="tableList_2bb"><s:date name="#sList.lastLoginTime" format="yyyy-MM-dd hh-mm-ss"/></td>
											<td class="tableList_2bb">
												<div style="width:35px; height:23px;float: left;">移动</div>
												<div style="width:23px; height:23px;float: left;"><img src="<%=request.getContextPath()%>/images/main/bg_3.png" width="23" height="23" class="yd" ></div>
												<div class="yidong">
													<ul>										
														<s:iterator value="initMap.orgList" id="oList" status="ol">
															<li><a href="decorateForwardAction.action?code=002010004&paramMap.orgID=${oList.orgID}&paramMap.userID=${sList.userID}">${oList.orgName}</a></li>												
														</s:iterator>
															<li class="closed">关闭</li>
													</ul>
												</div>
											</td>
											
											<td height="35" class="tableList_2bb" align="left" class="font_2">
												<a href="decorateForwardAction.action?code=002010001&paramMap.userID=${sList.userID}&paramMap.orgID=${sList.orgID}&paramMap.isdeleorg=true">删除</a>							
											</td>
										  </tr>	
									  </s:iterator>
									
								  </table>
								  </form>
								</td>
							  </tr>
							    <tr bgcolor="#ae9b84" height="40px;">
									<td colspan="7">
										<div class="pageb" >
											${initMap.paginated.pageContent}
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
</body>
</html>
