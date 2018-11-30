<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>仿微博表情插件(支持多文本框)</title>
<script src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/review/jquery.caretInsert.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/review/face.js"></script>
<link href="<%=request.getContextPath()%>/css/review/main.css" rel="stylesheet" type="text/css" />

<script src="<%=request.getContextPath()%>/js/tweenmax.min.js"></script>
<script src="<%=request.getContextPath()%>/js/scripts.js"></script> 
 
<style>

/*
  
  RollBar - jQuery ScrollBar Plugin
  -----------------------------------------------
  
  @author   flGravity
  @created  4/4/12
  @version  1.5
  @site     http://codecanyon.net/user/flGravity
  
*/
/* rollbar paths style */
.rollbar-path-vertical, .rollbar-path-horizontal { position: absolute; background-color: #eee; background-color: rgba(220,220,220,1); z-index: 100; }
.rollbar-path-horizontal { bottom: 5px; left: 0; width: 100%; height: 10px; }
.rollbar-path-vertical { right: 0px; top: 0; height: 100%; width: 10px; }
/* rollbar paths inner shadow */
.rollbar-path-vertical { box-shadow: inset 1px 0px 1px rgba(0,0,0,0.1); -moz-box-shadow: inset 1px 0px 1 rgba(0,0,0,0.1); -webkit-box-shadow: inset 1px 0px 0 rgba(0,0,0,0.1); }
.rollbar-path-horizontal { box-shadow: inset 0px 1px 1px rgba(0,0,0,0.1); -moz-box-shadow: inset 0px 1px 1 rgba(0,0,0,0.1); -webkit-box-shadow: inset 0px 1px 0 rgba(0,0,0,0.1); }
/* rollbar handle style */
.rollbar-handle { position: relative; top: 0; left: 0; background-color: #ca3d3d; }
/* prevent handle selection */
.rollbar-handle { -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; }
.rollbar-path-vertical .rollbar-handle { height: 20%; width: 100%; }
.rollbar-path-horizontal .rollbar-handle { width: 20%; height: 100%; }
/* round corners for rollbar handle and paths */
.rollbar-path-vertical,
.rollbar-path-horizontal,
.rollbar-handle { -moz-border-radius: 0px; -webkit-border-radius: 0px; border-radius: 0px; }
.r_c{height: auto;}
.ReviewList img{float:none;}
/* isay_content[type="Say"] {
margin: 0px 0; 
} */

.r_c{border-bottom: 1px dotted #000000;}
.comments_op{margin-bottom: 10px;}
</style>
</head>
<body  style="background-color:#e7e7e7">
<script type="text/javascript">
$(function(){
	//alert("${initMap.srCount}");
	$("#isOpen",window.parent.document).attr("value",1);
	getReview();
	
	var heightAuto = function () {
		var hei = 0;
		for(var i=0;i<$('.ReviewList .r_c').length;i++){
			hei += $('.ReviewList .r_c').eq(i).height()+8;
		}
		$('.ReviewList').css('height',hei);
	   setTimeout(heightAuto, 10);
	}
	 setTimeout(heightAuto, 10); 
});
function getReview(){
	//清空列表，准备刷新
	$(".User_info").children(".ReviewList").html("");
	//根据ptype与pid筛选跟资源相关的评论记录
	//replyID回复id 若为0则表示是直接评论
	$.ajax({
		url:		'ajaxAction.action?suiji='+new Date().getTime()+'&code=-600604&paramMap.srPtype=' + $("#ptype").val()
				+'&paramMap.srPID=' +$("#pid").val() ,
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){
			if (textStatus == "success"){
				//alert(jsonData.data[0].srContent);
				if (jsonData.data){
					for (var i=0; i<jsonData.data.length;i++){

						var console="<span  style='background:0;float: right;margin-right: 40px;cursor: pointer;' href='javascript:;' curkey='FirstReply'>回复</span>";
						var console2="<span style='background:0;float: right;margin-right: 40px;cursor: pointer;' href='javascript:;' class='DelReview' review-ID='"+jsonData.data[i].srID+"'>删除</span>";

						var cons=console;
						if($("#userType").val()==3||$("#userType").val()==5){
							cons=console2;
							/* $(".DelReview").die().live("click",function(){
								alert($(this).parent("li").find("p").attr("review-ID"));
							}); */
						}
						var txtAreaObj="<div><p style='word-break: break-all;' review-ID='"+jsonData.data[i].srID+"'>"+jsonData.data[i].srContent+"</br></p></div>";
						//alert("1:=="+txtAreaObj);
						if(jsonData.data[i].srReplyID==0){                            //我也说一句 提交                ┐
							var content=$(".User_info").children(".ReviewList");                  //                                  ├   提交按钮触发事件
						}else {               //一级回复 提交                ┘
							if($(".User_info").find('.sr_'+jsonData.data[i].srReplyID).find('.comments_list').length>0){ //                                           |
								var content=$(".User_info").find('.sr_'+jsonData.data[i].srReplyID).find('.comments_list').find('ul'); //                   |
							}else{                                                 			 //                                                      |
								var content=$(".User_info").find('.sr_'+jsonData.data[i].srReplyID);          //                                                      |
							}                                                                                   //                                                   |
						}
						
						
						
						var now=new Date();
						if(jsonData.data[i].srReplyID==0){                         //点击我也说一句
							DH="<li style='float:left;width:500px;height:auto;;' ><div class='FirstReplyDiv r_c sr_"+jsonData.data[i].srID+"' review-ID='"+jsonData.data[i].srID+"'><div class='ui_avatar'><a  onclick='toPersonalPage("+jsonData.data[i].srUserID+");' target='_self'   href='javascript:void(0);'><img src='/dm/"+jsonData.data[i].user_img+"' onerror='this.src=\"images/default/default_img.jpg\"' width='30'></a></div><div class='FirstReply_list' <c:if test='"+i+"%2+1==1'>style='color:bule'</c:if>><a   onclick='toPersonalPage("+jsonData.data[i].srUserID+");' target='_self'   href='javascript:void(0);'>"+jsonData.data[i].srUserName+"：</a>"+txtAreaObj+"<div class='comments_op'>"+jsonData.data[i].time+cons+"</div></div></div></li>";    
						}else{           //点击一级回复
							if($(".User_info").find('.sr_'+jsonData.data[i].srReplyID).find('.comments_list').length>0){                                        //当ul已存在
								DH="";
							}else{
								DH="<div class='comments_list'><ul>";	
							}
							DH+="<li  style='float:left;width:420px;height:auto;;'><div class='SecondReplyDiv r_c'><div class='ui_avatar'><a  onclick='toPersonalPage("+jsonData.data[i].srUserID+");' target='_self'   href='javascript:void(0);'><img src='/dm/"+jsonData.data[i].user_img+"' onerror='this.src=\"images/default/default_img.jpg\"' width='30'></a></div><div class='SecondReply_list'><a  onclick='toPersonalPage("+jsonData.data[i].srUserID+");' target='_self'   href='javascript:void(0);'>"+jsonData.data[i].srUserName+"：</a>"+txtAreaObj+"<div class='comments_op'>"+jsonData.data[i].time+cons+"</div></div></div></li>";
							if($(".User_info").find('.sr_'+jsonData.data[i].srReplyID).find('.comments_list').length>0){                                        //当ul已存在
								DH+="";
							}else{
								DH+="</ul></div>";	
							}
						}
						//alert(DH);
						content.append(DH);
					}
				}
			}
		},
		
		error:function(request,textStatus,error){}
	});
	
	/* //控制滚动条保持在最下面
	var scrollTop = $("#revL")[0].scrollHeight;
	$("#revL").animate({scrollTop:scrollTop},1000); */
}

function getReviewLast(){
	//获取最新回复消息
	//根据ptype与pid筛选跟资源相关的评论记录
	//replyID回复id 若为0则表示是直接评论
	$.ajax({
		url:		'ajaxAction.action?suiji='+new Date().getTime()+'&code=-600604&paramMap.tag=last&paramMap.srPtype=' + $("#ptype").val()
				+'&paramMap.srPID=' +$("#pid").val() ,
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){
			if (textStatus == "success"){
				//alert(jsonData.data[0].srContent);
				if (jsonData.data){
					for (var i=0; i<jsonData.data.length;i++){
						var console="<span style='background:0;float: right;margin-right: 40px;cursor: pointer;' href='javascript:;' curkey='FirstReply'>回复</span>";
						var console2="<span style='background:0;float: right;margin-right: 40px;cursor: pointer;' href='javascript:;' class='DelReview' review-ID='"+jsonData.data[i].srID+"'>删除</span>";
						var cons=console;
						if($("#userType").val()==3||$("#userType").val()==5){
							cons=console2;
						}
						var txtAreaObj="<div><p style='word-break: break-all;'>"+jsonData.data[i].srContent+"</br></p></div>";
						if(jsonData.data[i].srReplyID==0){                            //我也说一句 提交                ┐
							var content=$(".User_info").children(".ReviewList");                  //                                  ├   提交按钮触发事件
						}else {               //一级回复 提交                ┘
							if($(".User_info").find('.sr_'+jsonData.data[i].srReplyID).find('.comments_list').length>0){ //                                           |
								var content=$(".User_info").find('.sr_'+jsonData.data[i].srReplyID).find('.comments_list').find('ul'); //                   |
							}else{                                                 			 //                                                      |
								var content=$(".User_info").find('.sr_'+jsonData.data[i].srReplyID);          //                                                      |
							}                                                                                   //                                                   |
						}
						
						var regx=/(\[[\u4e00-\u9fa5]*\w*\])/g;//正则查找"[]"格式
						var rs=txtAreaObj.match(regx);
						if(rs!=null){
							for( i = 0; i < rs.length; i++) {
								for( n=0; n< em.length; n++ ){
									if(em[n].phrase == rs[i]){
										var t = "<img src='/dm/images/review/face/"+em[n].url+"' />";
										txtAreaObj = txtAreaObj.replace(rs[i],t);
										break;
									}
								}
							}
						}
						var now=new Date();
						if(jsonData.data[i].srReplyID==0){                         //点击我也说一句
							DH="<li  style='float:left;width:500px;height:auto;;'><div class='FirstReplyDiv r_c sr_"+jsonData.data[i].srID+"' review-ID='"+jsonData.data[i].srID+"'><div class='ui_avatar'><a  onclick='toPersonalPage("+jsonData.data[i].srUserID+");' target='_self'   href='javascript:void(0);'><img src='/dm/"+jsonData.data[i].user_img+"' onerror='this.src=\"images/default/default_img.jpg\"' width='30'></a></div><div class='FirstReply_list'><a   onclick='toPersonalPage("+jsonData.data[i].srUserID+");' target='_self'   href='javascript:void(0);'>"+jsonData.data[i].srUserName+"：</a>"+txtAreaObj+"<div class='comments_op'>"+jsonData.data[i].time+cons+"</div></div></div></li>";    
						}else{           //点击一级回复
							if($(".User_info").find('.sr_'+jsonData.data[i].srReplyID).find('.comments_list').length>0){                                        //当ul已存在
								DH="";
							}else{
								DH="<div class='comments_list'><ul>";	
							}
							DH+="<li  style='float:left;width:420px;height:auto;;'><div class='SecondReplyDiv r_c'><div class='ui_avatar'><a  onclick='toPersonalPage("+jsonData.data[i].srUserID+");' target='_self'   href='javascript:void(0);'><img src='/dm/"+jsonData.data[i].user_img+"' onerror='this.src=\"images/default/default_img.jpg\"' width='30'></a></div><div class='SecondReply_list '><a  onclick='toPersonalPage("+jsonData.data[i].srUserID+");' target='_self'   href='javascript:void(0);'>"+jsonData.data[i].srUserName+"：</a>"+txtAreaObj+"<div class='comments_op'>"+jsonData.data[i].time+cons+"</div></div></div></li>";
							if($(".User_info").find('.sr_'+jsonData.data[i].srReplyID).find('.comments_list').length>0){                                        //当ul已存在
								DH+="";
							}else{
								DH+="</ul></div>";	
							}
						}
						content.append(DH);
					}
				}
			}
		},
		
		error:function(request,textStatus,error){}
	});
	
	/* //控制滚动条保持在最下面
	var scrollTop = $("#revL")[0].scrollHeight;
	$("#revL").animate({scrollTop:scrollTop},1000); */
	
	
}

$(".DelReview").die().live("click",function(){
	//alert($(this).parent().parent().parent().parent().html());
	var target=$(this);
	if(confirm("确定删除这条评论吗")){
		$.ajax({
			url:		'ajaxAction.action?code=-600603&paramMap.srID=' + target.attr("review-ID"),
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){
					if(jsonData.ans==1){
						target.parent().parent().parent().parent().remove();
					}else{
						alert("您没有删除评论权限");
					}
					
				}
			},
			
			error:function(request,textStatus,error){}
		});
	}
}); 
function toPersonalPage(personId){
<%-- 	window.open('<%=request.getContextPath()%>/decorateForwardAction.action?code=-25200&paramMap.userID='+personId,'个人信息','');
 --%>	$("#mainFrameWelcome",window.parent.document).attr("src",'<%=request.getContextPath()%>/decorateForwardAction.action?code=-25200&paramMap.userID='+personId);
}
</script>
<input type="hidden" id="userType" value="${session.s_userType}" />
<input type="hidden" id="ptype" value="${paramMap.ptype}" />
<input type="hidden" id="pid" value="${paramMap.pid}" />
<input type="hidden" id="count" value="${initMap.srCount}" />
<input type="hidden" id="srUserID" value="${session.s_userID}">
<input type="hidden" id="resURL" value="${initMap.srInfo.srResUrl}">
<div class="reviewC" style="padding-left:10px;height: 372px;">
	<div class="User_info" style="margin: 0px 0;" height: 372px;">
		<ul class="ReviewList" ></ul>
		<div class="isay" ut="${session.s_userType }" style="height: 100px;padding-top: 20px;" <s:if test="session.s_userType == 1 || session.s_userType == 2 ">contenteditable="true"</s:if>>
		<s:if test="session.s_userType == 3">管理员不可以参与评论！</s:if>
		<s:if test="session.s_userType == 1 || session.s_userType == 2 ">我也说一句</s:if>
		</div>
	</div>
</div>
</body>
</html>
