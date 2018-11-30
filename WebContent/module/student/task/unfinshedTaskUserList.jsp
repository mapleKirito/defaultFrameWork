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
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<script type="text/javascript">
$(document).ready(function(){	
	var $div_li =$(".teacherTab li");
	$div_li.click(function(){
		$(this).addClass("curr")            //当前<li>元素高亮
			   .siblings().removeClass("curr");  //去掉其它同辈<li>元素的高亮
		var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
		$(".table_9")   	//选取子节点。不选取子节点的话，会引起错误。如果里面还有div 
				.eq(index).show()   //显示 <li>元素对应的<div>元素
				.siblings().hide(); //隐藏其它几个同辈的<div>元素
	})
	$("#alert").css("cursor","pointer");
	$('#alert').screenTB({
    	windowDocument:window.parent.document,
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
						<td width="17%" align="right"><img border="0" align="absmiddle" width="14" height="14" src="<%=basePath %>/images/common/216.gif"><a id="alert">提示</a></td>
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
								  	<th width="5%">全选</th>
									<th >姓名</th>
									<th >性别</th>
									<th >班级</th>
								  </tr>
								  <s:iterator value="initMap.unfinshedTaskUserList" id="user" status="tindx">
								  <s:if test="tindx%2 == 0">
								  <tr bgcolor="#ae9b84">
								  	<td align="center" class="tatd"><input value="${user.studentID }" name="paramMap.studentID" type="checkbox"></a></td>								  
									<td align="center" class="tatd">${user.userName}</a></td>
									<td align="center" class="tatd"><s:if test="#user.userGender==1">男</s:if><s:if test="#user.userGender==0">女</s:if><s:if test="#user.userGender<>1 && #user.userGender<>0">未知</s:if></td>
									<td align="center" class="tatd">${user.orgName}</td>
								  </tr>								  
								  </s:if>
								  <s:if test="tindx%2 != 0">
								  <tr>
								  	<td align="center" class="tatd"><input value="${user.studentID }" name="paramMap.studentID" type="checkbox"></a></td>								  
									<td align="center" class="tatd">${user.userName}</a></td>
									<td align="center" class="tatd"><s:if test="#user.userGender==1">男</s:if><s:if test="#user.userGender==0">女</s:if><s:if test="#user.userGender<>1 && #user.userGender<>0">未知</s:if></td>
									<td align="center" class="tatd">${user.orgName}</td>
								  </tr>
								  </s:if>
								  </s:iterator>
								  <tr>
									<td colspan="4">
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