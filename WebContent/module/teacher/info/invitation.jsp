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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/userfilepic.js"></script>
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<script type="text/javascript">

$(document).ready(function(){	
	$('.reply').screenTB({
		windowDocument:window.parent.parent.document,
		width:'750',
		height:'450',
		content:'测试内容',
		contentAlign:'center',
		contentValign:'middle',
		title:'系统提示信息',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',	
		buttons:'no',
		dialogType:'iframe',
		iframeSrc:'forwardAction.action?code=002001005001'
		},{
			paramEvent:function(data,o){
				var $obj = $(o);
				var id = $obj.attr("id");
				return "paramMap.tId=" + id;
			}
		}); 	
	
	$('.quote').screenTB({
			windowDocument:window.parent.parent.document,
			width:'750',
			height:'450',
			content:'测试内容',
			contentAlign:'center',
			contentValign:'middle',
			title:'系统提示信息',
			buttonValueYes:'确定',	
			buttonValueNo:'取消',	
			buttons:'no',
			dialogType:'iframe',
			iframeSrc:'forwardAction.action?code=002001004008'
		},{
			paramEvent:function(data,o){
			var $obj = $(o);
			var id = $obj.attr("id");
			var arr = id.split("_");
			var tId,tiId;
			if (arr.length == 2){
				tId = arr[0];
				tiId = arr[1];
			}
			else{
				tId = id;
			}
			var name = $obj.attr("name");
			if (name == 'tquote'){
				return "paramMap.tId=" + tId;
			}
			else{
				return "paramMap.tId="+ tId + "&paramMap.tiId=" + tiId;
			}				
		}
	});  
	$('.edit').screenTB({
			windowDocument:window.parent.parent.document,
			width:'750',
			height:'450',
			content:'测试内容',
			contentAlign:'center',
			contentValign:'middle',
			title:'系统提示信息',
			buttonValueYes:'确定',	
			buttonValueNo:'取消',	
			buttons:'no',
			dialogType:'iframe',
			iframeSrc:'forwardAction.action?code=002001004002'
		},{
			paramEvent:function(data,o){
			var $obj = $(o);
			var id = $obj.attr("id");
			var name = $obj.attr("name");
			if (name == 'tname'){
				return "paramMap.tId=" + id;
			}
			else{
				return "paramMap.tiId=" + id;
			}
		}
	}); 
	$('.comment').screenTB({
		windowDocument:window.parent.parent.document,
		width:'500',
		height:'300',
		content:'测试内容',
		contentAlign:'center',
		contentValign:'middle',
		title:'系统提示信息',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',
		buttons:'no',
		dialogType:'iframe',
		iframeSrc:'forwardAction.action?code=002001004003'
		},{
			paramEvent:function(data,o){
				var $obj = $(o);
				var id = $obj.attr("id");
				var arr = id.split("_");
				var tId,tiId;
				if (arr.length == 2){
					tId = arr[0];
					tiId = arr[1];
				}
				else{
					tId = id;
				}				
				var id = $obj.attr("id");
				var name = $obj.attr("name");
				if (name == 'tcomment'){
					return "paramMap.tId=" + id;
				}
				else{
					return "paramMap.tId="+ tId + "&paramMap.tiId=" + tiId;
				}
			}		
	});	
    $('.excellent').screenTB({
    	windowDocument:window.parent.parent.document,
		width:'300',
		height:'150',
		content:'测试内容',
		contentAlign:'center',
		contentValign:'middle',
		title:'系统提示信息',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',	
		dialogType:'confirm',
		iframeSrc:''
		},{
		clickEvent:function(data){
    			data = $.extend(data,{content:'确认要设置此作业为优秀吗？'});
			},
			submitEvent:function(data,$obj){
				var id = $obj.attr("id");
				if (data.returnValue == 1){
					$.extend(data,{returnValue:'true'});
    				var faction = $("#actionForm").attr("action");
    				$.ajax({
    					
    					url:		'ajaxAction.action?code=002001004004&paramMap.tiExcellent=1&paramMap.tiId=' + id,
    					
    					type:	    'post',
    					
    					timeout:	'60000',
    					
    					data:	Array(),
    					
    					dataType:	'json',
    					
    					beforeSend:function(request){},
    					
    					complete:function(request,textStatus){},
    					
    					success:function(jsonData,textStatus){
    						
    						
    						if (textStatus == "success"){
    							location.href=location.href; 
    						}
    					},
    					
    					error:function(request,textStatus,error){}
    				});    				
				}
			}
		});	
    $('.chanelexcellent').screenTB({
    	windowDocument:window.parent.parent.document,
		width:'300',
		height:'150',
		content:'测试内容',
		contentAlign:'center',
		contentValign:'middle',
		title:'系统提示信息',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',	
		dialogType:'confirm',
		iframeSrc:''
		},{
		clickEvent:function(data){
   			data = $.extend(data,{content:'确认要取消设置此作业为优秀吗？'});
		},
		submitEvent:function(data,$obj){
			var id = $obj.attr("id");
			if (data.returnValue == 1){
				$.extend(data,{returnValue:'true'});
   				var faction = $("#actionForm").attr("action");
   				$.ajax({
   					
   					url:		'ajaxAction.action?code=002001004004&paramMap.tiExcellent=0&paramMap.tiId=' + id,
   					
   					type:	    'post',
   					
   					timeout:	'60000',
   					
   					data:	Array(),
   					
   					dataType:	'json',
   					
   					beforeSend:function(request){},
   					
   					complete:function(request,textStatus){},
   					
   					success:function(jsonData,textStatus){
   						
   						
   						if (textStatus == "success"){
   							location.href=location.href; 
   						}
   					},
   					
   					error:function(request,textStatus,error){}
   				});    				
			}
		}
	});
    $('.invRecommend').screenTB({
    	windowDocument:window.parent.parent.document,
		width:'300',
		height:'150',
		content:'测试内容',
		contentAlign:'center',
		contentValign:'middle',
		title:'系统提示信息',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',	
		dialogType:'confirm',
		iframeSrc:''
		},{
		clickEvent:function(data){
    			data = $.extend(data,{content:'确认要推荐此作业吗？'});
			},
			submitEvent:function(data,$obj){
				var id = $obj.attr("id");
				if (data.returnValue == 1){
					$.extend(data,{returnValue:'true'});
    				var faction = $("#actionForm").attr("action");
    				$.ajax({
    					
    					url:		'ajaxAction.action?code=002001004005&paramMap.isRecommend=1&paramMap.taskId=${initMap.invitation.taskId}',
    					
    					type:	    'post',
    					
    					timeout:	'60000',
    					
    					data:	Array(),
    					
    					dataType:	'json',
    					
    					beforeSend:function(request){},
    					
    					complete:function(request,textStatus){},
    					
    					success:function(jsonData,textStatus){
    						
    						
    						if (textStatus == "success"){
    							location.href=location.href; 
    						}
    					},
    					
    					error:function(request,textStatus,error){}
    				});    				
				}
			}
		});	 
    $('.chanelRecommend').screenTB({
    	windowDocument:window.parent.parent.document,
		width:'300',
		height:'150',
		content:'测试内容',
		contentAlign:'center',
		contentValign:'middle',
		title:'系统提示信息',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',	
		dialogType:'confirm',
		iframeSrc:''
		},{
		clickEvent:function(data){
    			data = $.extend(data,{content:'确认要取消推荐此作业吗？'});
			},
			submitEvent:function(data,$obj){
				var id = $obj.attr("id");
				if (data.returnValue == 1){
					$.extend(data,{returnValue:'true'});
    				var faction = $("#actionForm").attr("action");
    				$.ajax({
    					
    					url:		'ajaxAction.action?code=002001004005&paramMap.isRecommend=0&paramMap.taskId=${initMap.invitation.taskId}',
    					
    					type:	    'post',
    					
    					timeout:	'60000',
    					
    					data:	Array(),
    					
    					dataType:	'json',
    					
    					beforeSend:function(request){},
    					
    					complete:function(request,textStatus){},
    					
    					success:function(jsonData,textStatus){
    						
    						
    						if (textStatus == "success"){
    							location.href=location.href; 
    						}
    					},
    					
    					error:function(request,textStatus,error){}
    				});    				
				}
			}
		});	 
    $('.invDelete').screenTB({
    	windowDocument:window.parent.parent.document,
		width:'300',
		height:'150',
		content:'测试内容',
		contentAlign:'center',
		contentValign:'middle',
		title:'系统提示信息',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',	
		dialogType:'confirm',
		iframeSrc:''
		},{
		clickEvent:function(data){
    			data = $.extend(data,{content:'确认要删除此作业吗？'});
			},
			submitEvent:function(data,$obj){
				var id = $obj.attr("id");
				var arr = id.split("_");
				var tId,resultId;
				if (arr.length == 2){
					tId = arr[0];
					resultId = arr[1];
				}
				else{
					tId = id;
				}				
				if (data.returnValue == 1){
					$.extend(data,{returnValue:'true'});
    				$.ajax({
    					
    					url:		'ajaxAction.action?code=002001004007&paramMap.taskId=' +tId+ '&paramMap.erID=' + resultId,
    					
    					type:	    'post',
    					
    					timeout:	'60000',
    					
    					data:	Array(),
    					
    					dataType:	'json',
    					
    					beforeSend:function(request){},
    					
    					complete:function(request,textStatus){},
    					
    					success:function(jsonData,textStatus){
    						
    						
    						if (textStatus == "success"){
    							window.parent.document.frames['content_002001'].src = "decorateForwardAction.action?code=001001&"+ new Date();
    						}
    					},
    					
    					error:function(request,textStatus,error){}
    				});    				
				}
			}
		});	 
    $('.invLock').screenTB({
    	windowDocument:window.parent.parent.document,
		width:'300',
		height:'150',
		content:'测试内容',
		contentAlign:'center',
		contentValign:'middle',
		title:'系统提示信息',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',	
		dialogType:'confirm',
		iframeSrc:''
		},{
		clickEvent:function(data){
   			data = $.extend(data,{content:'确认要锁定此作业吗？'});
		},
		submitEvent:function(data,$obj){
			var id = $obj.attr("id");
			if (data.returnValue == 1){
				$.extend(data,{returnValue:'true'});
   				var faction = $("#actionForm").attr("action");
   				$.ajax({
   					
   					url:		'ajaxAction.action?code=002001004006&paramMap.isLock=1&paramMap.taskId=${initMap.invitation.taskId}',
   					
   					type:	    'post',
   					
   					timeout:	'60000',
   					
   					data:	Array(),
   					
   					dataType:	'json',
   					
   					beforeSend:function(request){},
   					
   					complete:function(request,textStatus){},
   					
   					success:function(jsonData,textStatus){
   						
   						
   						if (textStatus == "success"){
   							location.href=location.href; 
   						}
   					},
   					
   					error:function(request,textStatus,error){}
   				});    				
			}
		}
	});	    
    $('.invUnlock').screenTB({
    	windowDocument:window.parent.parent.document,
		width:'300',
		height:'150',
		content:'测试内容',
		contentAlign:'center',
		contentValign:'middle',
		title:'系统提示信息',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',	
		dialogType:'confirm',
		iframeSrc:''
		},{
		clickEvent:function(data){
   			data = $.extend(data,{content:'确认要解锁此作业吗？'});
		},
		submitEvent:function(data,$obj){
			var id = $obj.attr("id");
			if (data.returnValue == 1){
				$.extend(data,{returnValue:'true'});
   				var faction = $("#actionForm").attr("action");
   				$.ajax({
   					
   					url:		'ajaxAction.action?code=002001004006&paramMap.isLock=0&paramMap.taskId=${initMap.invitation.taskId}',
   					
   					type:	    'post',
   					
   					timeout:	'60000',
   					
   					data:	Array(),
   					
   					dataType:	'json',
   					
   					beforeSend:function(request){},
   					
   					complete:function(request,textStatus){},
   					
   					success:function(jsonData,textStatus){
   						
   						
   						if (textStatus == "success"){
   							location.href=location.href; 
   						}
   					},
   					
   					error:function(request,textStatus,error){}
   				});    				
			}
		}
	});	
    
    $('.score').screenTB({
    	windowDocument:window.parent.parent.document,
		width:'300',
		height:'150',
		content:'测试内容',
		contentAlign:'center',
		contentValign:'middle',
		title:'系统提示信息',
		buttonValueYes:'确定',	
		buttonValueNo:'取消',	
		dialogType:'confirm',
		iframeSrc:''
		},{
		clickEvent:function(data){
   			data = $.extend(data,{content:'确认要对此回复进行评价吗？'});
		},			
		submitEvent:function(data,$obj){
			if (data.returnValue == 1){
				var id = $obj.attr("id");
				var name = $obj.attr("name");
				var param  = "";
				if (name == 'good'){
					param = "paramMap.tisGood=1&paramMap.tisMedium=0&paramMap.tisDifferential=0&paramMap.tiId=" + id;
				}
				else if (name == 'medium'){
					param = "paramMap.tisGood=0&paramMap.tisMedium=1&paramMap.tisDifferential=0&paramMap.tiId=" + id;
				}
				else if (name == 'differential'){
					param = "paramMap.tisGood=0&paramMap.tisMedium=0&paramMap.tisDifferential=1&paramMap.tiId=" + id;
				}			
				$.ajax({
					
					url:		'ajaxAction.action?code=002001004009&'+param,
					
					type:	    'post',
					
					timeout:	'60000',
					
					data:	Array(),
					
					dataType:	'json',
					
					beforeSend:function(request){},
					
					complete:function(request,textStatus){},
					
					success:function(jsonData,textStatus){
						
						
						if (textStatus == "success"){
							if (jsonData.singleData == 1){
								alert("对不起，您已经评价过此内容。");
							}
							else{
								location.href=location.href; 
							}
						}
					},
					
					error:function(request,textStatus,error){}
				});    
			}
		}
	});	    
});
</script>
</head>
<body style="background-color:#e0ebee; margin:0; padding:0; font-family:'宋体'">
<body style="background-color:#e0ebee; margin:0; padding:0; font-family:'宋体'">
<table width="99%" height="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
    <td valign="top" style="padding:5px;">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="table_611">
					  <tr>
					    <td valign="top" bgcolor="#fdfeff" class="table_1121">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_911">
								<tr>
									<td bgcolor="#f5f9fc">
										<table width="60%" border="0" cellspacing="0" cellpadding="0" class="table_yj" style="margin-top: 10xp;">
										  <tr height="50px">
											<td width="18%">&nbsp;&nbsp;&nbsp;&nbsp;
											
											<s:if test="initMap.invitation.isLock == 0">
											<a href="javascript:void(0)" class="reply" id="${initMap.invitation.taskId}" ><img src="images/main/ima_35.png" border="0"></a>
											</s:if>
											
											</td>
									        <td width="32%">
									        <span class="span2 font_2">
									        <s:if test="initMap.invitation.isRecommend == 0">
									        <a href="javascript:void(0)" class="invRecommend" id="${initMap.invitation.taskId}">推荐</a>
									        </s:if>
									        <s:if test="initMap.invitation.isRecommend == 1">
									        <a href="javascript:void(0)" class="chanelRecommend" id="${initMap.invitation.taskId}">取消推荐</a>
									        </s:if>
									        </span>|
									        <span class="span2 font_2">
									        <s:if test="initMap.invitation.isLock == 0"><a href="javascript:void(0)" class="invLock"  id="${initMap.invitation.taskId}" name="${initMap.invitation.isLock}">锁定</a></s:if>
									        <s:if test="initMap.invitation.isLock == 1"><a href="javascript:void(0)" class="invUnlock" id="${initMap.invitation.taskId}" name="${initMap.invitation.isLock}">解锁</a></s:if>
									        </span>
									        <s:if test="initMap.invitation.isLock == 0">
									        |<span class="span2 font_2"><a href="javascript:void(0)" class="invDelete" id="${initMap.invitation.taskId}_${initMap.invitation.resultId}">删除</a></span>
									        </s:if>
									        </td>
									      </tr>
										</table>
									</td>
								</tr>
								<tr>
									<td valign="top">
										<table border="0" cellspacing="0" cellpadding="0" class="table_611_1"  width="100%">
										  <tr>
										  	<th colspan="2"  height="34" >
												<div class="left">${initMap.invitation.taskTitle}</div>
												<div class="right">
													<img src="images/main/louzhu.jpg">
													<span class="font_5 fnormal size_1 span2">发表于${initMap.invitation.createTime}</span>
													<span class="font_4 size_2">楼主</span>							
												</div>					
											</th>
										  </tr>
										  <tr>
											<td width="97" valign="top"  style="background:url(images/main/bg_17.png) no-repeat; padding:0;">
												<table width="97" border="0" cellspacing="0" cellpadding="0">
												  <tr>
													<td>
														<p align="center">
															<s:if test="initMap.invitation.userType == 1">									
																<img src="images/main/toux.jpg" width="75" height="74">
															</s:if>
															<s:if test="initMap.invitation.userType == 2">									
																<img src="images/main/toux1.jpg" width="75" height="74">
															</s:if>									
														</p>
														<p class="table_6P2">${initMap.invitation.userAccount}</p>
													</td>
												  </tr>
												</table>
											</td>
											<td width="100%" valign="top" bgcolor="#fdfeff">
					                        	<p class="lineheight_1">
					                        	${initMap.invitation.taskContent}
												</p>
											</td>
									      </tr>
										  <tr>
											<td width="97" valign="top"  style="background:url(images/main/bg_17.png) no-repeat; padding:0;">&nbsp;</td>
											<td width="100%" valign="top" bgcolor="#fdfeff" >
												<s:if test="initMap.invitation.isLock == 0">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												  <tr>
													<td style="border-top:1px dashed #CCCCCC; padding-top:12px;">
													<div class="left span2"><img src="images/main/bbs_2.jpg"></div>
													<div class="left"><a href="javascript:void(0)" id="${initMap.invitation.taskId}" name="tquote" class="quote">引用</a></div>
													<s:if test="session.s_userLoginAccount==initMap.invitation.userAccount">
													<div class="left span2"><img src="images/main/bbs_3.jpg"></div>
													<div class="left">
														<a href="javascript:void(0)" id="${initMap.invitation.taskId}" name="tname" class="edit">编辑</a>
													</div>
													</s:if>
													</td>
												  </tr>
												</table>
												</s:if>
											</td>
									      </tr>
									  	</table>
									  	<s:iterator value="initMap.invitationList" id="invitationList" status="ilindex">
					                    <table border="0" cellspacing="0" cellpadding="0" class="margin_top1"  width="100%">
										  <tr>
										  	<th colspan="2"  height="34" >
												<div class="left" style="padding-left:28px;">
												<s:if test="#invitationList.tiExcellent == 1">
													<div style="position:absolute; margin-top:-8px; margin-left:-28px;">
													<img src="images/main/bbs_5.jpg"></div>
													优秀答案
												</s:if>
												</div>
												<div class="right">
													<div class="left"><img src="images/main/shafa.png"></div>
													<span class="font_5 fnormal size_1 span2">发表于 ${invitationList.tiCreateTime}</span>
													<span class="font_4 size_2">${((initMap.invitationPaginated.currentPage - 1)*initMap.invitationPaginated.pageSize) + (ilindex.index + 1)}楼</span>							
												</div>						
											</th>
										  </tr>
										  <tr>
											<td width="97" valign="top"  style="background:url(images/main/bg_17.png) no-repeat; padding:0;">
												<table width="97" border="0" cellspacing="0" cellpadding="0">
												  <tr>
													<td>
														<p align="center">
															<s:if test="#invitationList.userType == 1">									
																<img src="images/main/toux.jpg" width="75" height="74">
															</s:if>
															<s:if test="#invitationList.userType == 2">									
																<img src="images/main/toux1.jpg" width="75" height="74">
															</s:if>	
														</p>
														<p class="table_6P2">${invitationList.userAccount}</p>
													</td>
												  </tr>
												</table>
											</td>
											<td width="100%" valign="top" bgcolor="#fdfeff">
					                        <p class="lineheight_1">
					                        	${invitationList.tiContent}
					                        </p>
					                        <s:if test="#invitationList.userType==2">
											<p class="teacherhf">
					                        	<h2 class="teachertt">老师评语</h2>
					                            <div class="teachernr">${invitationList.tiComment}<span class="font_5 span3">${invitationList.tiCommentTime}</span></div>
					                        </p>
					                        </s:if>
					                        </td>
									      </tr>
										  <tr>
											<td width="97" valign="top"  style="background:url(images/main/bg_17.png) no-repeat; padding:0;">&nbsp;</td>
											<td width="100%" valign="top" bgcolor="#fdfeff" >
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												  <tr>
													<td style="border-top:1px dashed #CCCCCC;padding-top:12px;">
					                                    <div class="czuoq">
															<s:if test="initMap.invitation.isLock == 0 ">					                                        <div class="left" style="width:300px;">
					                                        	<div class="left span2"><img src="images/main/bbs_2.jpg"></div>
					                                            <div class="left"><a href="javascript:void(0)" id="${initMap.invitation.taskId}_${invitationList.tiID}" name="tiquote" class="quote">引用</a></div>
					                                            <s:if test="#session.s_userLoginAccount==#invitationList.userAccount">
					                                            <div class="left span2"><img src="images/main/bbs_3.jpg"></div>
					                                            <div class="left"><a href="javascript:void(0)" id="${invitationList.tiID}" name="tiname" class="edit">编辑</a></div>
					                                            </s:if>
					                                            <s:if test="#invitationList.userType==2">
					                                            <div class="left span2"><img src="images/main/bbs_1.jpg"></div>
					                                            <div class="left pingyu"><a href="javascript:void(0)" id="${initMap.invitation.taskId}_${invitationList.tiID}" class="comment">评语</a></div>
					                                            <div class="left span2"><img src="images/main/bbs_4.png"></div>
					                                            <div class="left">
							                                            <s:if test="#invitationList.tiExcellent == 0">
						                                            		<a href="javascript:void(0)" id="${invitationList.tiID}" class="excellent">评为优秀</a>
						                                            	</s:if>
						                                            	<s:if test="#invitationList.tiExcellent == 1">
						                                            		<a href="javascript:void(0)" id="${invitationList.tiID}" class="chanelexcellent">取消评为优秀</a>
						                                            	</s:if>
					                                            </div>
							                                 </s:if>
					                                    </div>
				                                        <div class="right" style=" width:380px;">
				                                        <span class="span2 font_2"><a href="javascript:void(0)" class="score" name="good" id="${invitationList.tiID}">非常满意</a></span>（${invitationList.tiGoodScorePercent}%）${invitationList.tiGoodScore} |
				                                        <span class="span2 font_2"><a href="javascript:void(0)" class="score" name="medium" id="${invitationList.tiID}">基本满意</a></span>（${invitationList.tiMediumScorePercent}%）${invitationList.tiMediumScore} |
				                                        <span class="span2 font_2"><a href="javascript:void(0)" class="score" name="differential" id="${invitationList.tiID}">一般</a></span>（${invitationList.tiDifferentialScorePercent}%）${invitationList.tiDifferentialScore}</div>
				                                        </s:if>
					                                    </div>
													</td>
												  </tr>
												</table>
											</td>
									      </tr>
									  	</table>				  		
									  	</s:iterator>
								  	</td>
								</tr>
					            <tr>
									<td>
					                	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_yj">
										  <tr>
									        <td>
												<div class="pageb">
												${initMap.invitationPaginated.pageContent}
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
	</td>
</tr>
</table>
</body>
</html>