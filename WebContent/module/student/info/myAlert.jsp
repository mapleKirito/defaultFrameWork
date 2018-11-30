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
table tr td span{cursor: pointer;}
</style>

<script type="text/javascript">
$(document).ready(function(){	
	$('.noalert span').screenTB({
		windowDocument:window.parent.document,
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
			data = $.extend(data,{content:'确认取消此作业提醒吗？'}); 
		},
		submitEvent:function(data,$obj){
			var id = $obj.attr("id");
			if (data.returnValue == 1){
				$.extend(data,{returnValue:'true'});
				var faction = $("#actionForm").attr("action");
				$.ajax({
					
					url:		'ajaxAction.action?code=001001002001&paramMap.userID='+'${paramMap.s_userID}'+'&paramMap.tID=' + id,
					
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
});
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.userID" value="${paramMap.s_userID}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.student_my_info_mgr.imitationStep}"> 
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="161" valign="top" bgcolor="#606373" class="touxTd1" style="padding:0;">
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
						<td width="100%" bgcolor="#E8E8E8" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_x">
                                     <tr style="background:url(images/main/teacher_14.jpg) repeat-x;">
                                      <th width="55%" align="center">标题</th>
                                      <th width="10%" align="center">回复/查看</th>
                                      <th width="10%" align="center">取消提醒</th>
                                      <th width="25%" align="center">发表时间</th>
                                      </tr>
									  <s:iterator value="initMap.studentAlertInfo" id="alert" status="aindx">
									  <s:if test="aindx%2 == 0">
									  <tr bgcolor="#ae9b84">
										<td width="55%" align="left" class="tatd">${alert.title}</td>
										<td width="10%" align="center" class="tatd">${alert.replyCount}/${alert.viewCount}</td>
										<td width="10%" align="center" class="tatd noalert"><span id="${alert.tID}">取消提醒</span></td>
										<td width="25%" align="center" class="tatd">${alert.createTime}</td>
									  </tr>
									  </s:if>
									  <s:if test="aindx%2 != 0">
									  <tr >
										<td width="55%" align="left" class="tatd">${alert.title}</td>
										<td width="10%" align="center" class="tatd">${alert.replyCount}/${alert.viewCount}</td>
										<td width="10%" align="center" class="tatd noalert"><span id="${alert.tID}">取消提醒</span></td>
										<td width="25%" align="center" class="tatd">${alert.createTime}</td>
									  </tr>
									  </s:if>								  
									  </s:iterator>                                                                        
                                      <tr>
                                      <td colspan="4">
                                          <div class="pageb">
                                          ${initMap.alertPaginated.pageContent}
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