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
	
	$("#apply").css("cursor","pointer");
	$('#apply').screenTB({
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
    				data = $.extend(data,{content:'请选择您要审核的数据！'});
    			}
    			else{
    				$.extend(data,{returnValue:'true'});
    				var faction = $("#form").attr("action");
					
    				$("#form").attr("action",faction+"?code=002001002");
    				$("#form").submit();		    			
    			}
			}
		});
	$("#delete").css("cursor","pointer");
	$('#delete').screenTB({
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
    				data = $.extend(data,{content:'请选择您要删除的数据！'});
    			}
    			else{
    				$.extend(data,{returnValue:'true'});
    				var faction = $("#form").attr("action");					
    				$("#form").attr("action",faction+"?code=002001003");
    				$("#form").submit();		    			
    			}
			}
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
										<s:if test="#initMap.userInfo.userNo!=null">
											<p class="table_6P1">教师证号：${initMap.userInfo.userNo}</p>
										</s:if>
										<p class="table_6P1">财富值：${initMap.userInfo.wealth}</p>
										<s:if test="initMap.userInfo.userEmail!=''">
										<p class="table_6Pemail">${initMap.userInfo.userEmail}</p>
										</s:if>
										<p class="table_6Ppersonal"><a href="decorateForwardAction.action?code=002013&paramMap.userID=${initMap.userInfo.userID}" class="bule">修改个人资料</a></p>	
										<p class="table_6Presource"><a href="decorateForwardAction.action?code=002004&paramMap.userID=${initMap.userInfo.userID }" class="bule">我的资源</a></p>
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
								  	  		<DIV class=itemContent>
		<SCRIPT type=text/javascript src="<%=request.getContextPath()%>/space/script_face.js"></SCRIPT>
			<DIV class="talkBox clearfix mgb10">
				<H2 style="border: 0px;"><LABEL for=msgTxt>说说你在做什么，想什么</LABEL></H2>
				<DIV class="sendCnt clearfix">
					<TEXTAREA id=content class="textinput inpw550 inph70 textarea_content" style="overflow: hidden;" name=content placeholder="立刻发表消息，分享每天心情"></TEXTAREA>
					<span class="state_num">0/140</span> 
					<INPUT id=wb_fid type=hidden name=wb_fid>
					<INPUT id=wb_fname type=hidden name=wb_fname>
					<INPUT id=wb_type value=1 type=hidden name=wb_type>
				</DIV>
				<DIV class="publishConItem clearfix pdtb15">
					<DIV class="detail fl">
						<DIV id=face title=插入表情 onclick="showFace($(this).attr('id'), 'content', '<%=request.getContextPath()%>/space/');return false;">
							<IMG src="<%=request.getContextPath()%>/space/insFace.jpg" width=15 height=15>
						</DIV>
					</DIV>
					<DIV style="text-align: right;" class="func clearfix">
					<INPUT id="createState" value=发送 type=button> 
					</DIV>
				</DIV>
			</DIV>
			<script type="text/javascript">
			 $('#content').bind('keyup input paste',function(){  //采用几个事件来触发（已增加鼠标粘贴事件）
				 	if($(this).attr("value").length<=140)
	    			$('.state_num').html($(this).attr("value").length+"/140")  //获取评论框字符长度并添加到ID="num"元素上 
					else{
					$('.state_num').html("<font color='#FF0000'>"+ $(this).attr("value").length+"/140</font>")  //获取评论框字符长度并添加到ID="num"元素
						}
	    			}); 
			 $("#createState").click(function(){
				var content = $("#content").val();
				String.prototype.trim = function() {
					return this.replace(/^\s+|\s+$/g, "");
				}
				if($("#content").val()=='' || content.trim()==''){
					alert("亲，您还没有填写信息哦     ^.^   ");
					return;
				}
				if($("#content").val().length>140){
					var n=$("#content").val().length-140;
					alert("亲，超出"+n+"个字了哦     ^.^   ");
					return;
				}
				content = encodeURI(encodeURI(content)); 
				$("#content").val("");
				 $.ajax({
						url:		'ajaxAction.action?suiji='+new Date().getTime()+'&code=-6000&paramMap.userId='+$("#userId").val()+'&paramMap.content='+content,
						type:	    'post',
						timeout:	'60000',
						data:	Array(),
						dataType:	'json',
						beforeSend:function(request){},//ajax执行前调用函数
						complete:function(request,textStatus){},//ajax请求完成后调用函数
						success:function(jsonData,textStatus){//ajax请求成功调用函数
						$('.state_num').html("0/140");
						var html='<LI class="clearfix " >'+
				  		'<DIV class=mFun>'+
				  			'<A class=feed_opt href="javascript:void(0)">'+
				  				'<EM class=btn_ldrop></EM>'+
				  			'</A>'+
					  		'<DIV class=mFunDrop>'+
					  			'<A class=weibo_del_btn href="javascript:void(0);" data-id="'+jsonData.id+'">删除消息</A>'+
					  		'</DIV>'+
				  		'</DIV>'+
				  		'<DIV class=userPic>'+
				  			'<A href="javascript:void(0)">'+
				  				'<IMG src="/bsms/${paramMap.space_img}?suiji='+new Date().getTime()+'" width=50 height=50>'+
				  			'</A>'+
				  		'</DIV>'+
				  		'<DIV class=msgBox>'+
					  		'<DIV class=userName>'+
					  			'<STRONG>'+
					  				'<A class=blue href="javascript:void(0)">${session.s_userLoginName }</A>'+
					  			'</STRONG>'+
					  		'</DIV>'+
					  		'<DIV class="msgCnt f14">'+jsonData.content+'</DIV>'+
					  		'<DIV style="PADDING-TOP: 5px" class=msgImg></DIV>'+
					  		'<DIV class="pubInfo clearfix">'+
					  			'<SPAN class=fl>刚刚</SPAN>'+
					  			'<SPAN class=fr>'+
					  			'</SPAN> '+
					  		'</DIV>'+
				  		'</DIV>'+
				  	'</LI>';
				  	$("#state_list li:first-child").before(html);
						},
						
						error:function(request,textStatus,error){}
					});
			 });
			</script>
			
		</DIV>
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
