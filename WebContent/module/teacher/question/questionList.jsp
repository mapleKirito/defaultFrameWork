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

$(function(){
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
    				var faction = $("#actionForm").attr("action");
					
    				$("#actionForm").attr("action",faction+"?code=002012001");
    				$("#actionForm").submit();		    			
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
    				var faction = $("#actionForm").attr("action");					
    				$("#actionForm").attr("action",faction+"?code=002012002");
    				$("#actionForm").submit();		    			
    			}
			}
	});
	
    $("#change_type").val("2");
    
    $("#checkAll").click(function() { 
		var $child = $("input[class='checktask']");
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
	
	var $subBox = $("input[class='checktask']");  
	$subBox.click(function(){  
		$("#checkAll").attr("checked",$subBox.length == $("input[class='checktask']:checked").length ? true : false);  
	});  
	
});
</script>
</head>
<body>
<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="paramMap.userID" value="${initMap.userInfo.userID}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.reault_list.imitationStep}">
<input type="hidden" id="change_type" value="0"> 
<table id="grid" width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
		 
		 <tr width="90%">
			<td colspan="2" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_yj">					
					<tr>
						<td width="17%" align="left" style="border-bottom : 1px solid #606373">
							<a id="apply">
								<div id="create_1_div"><img src="images/common/023.gif" width="14" height="14" border="0" />&nbsp;&nbsp;<span>审核提问</span></div>
							</a>
							<a id="delete">
								<div id="create_d_div"><img src="images/common/109.gif" width="14" height="14" border="0" />&nbsp;&nbsp;<span>删除</span></div>
							</a>
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
									<th width="5%" align="left" valign="bottom"><input type="checkbox" value="${aList.taskId}" id="checkAll"></th>
									<th width="10%" align="left">状态</th>
									<th width="65%" align="left">标题</th>
									<th width="20%" align="left">发布时间</th>
								  </tr>
								  <s:iterator value="initMap.applyList" id="aList" status="tindx">
								  <tr bgcolor="#ae9b84">
									<td width="2%" class="tatd" align="left"><input type="checkbox" name="paramMap.taskId" class="checktask" value="${aList.taskId}"></td>
									<td width="10%" class="tatd" align="left">
										<s:if test="#aList.apply==1">
											已审核
										</s:if>
										<s:else>
											未审核
										</s:else>
									</td>
									<td width="60%" class="tatd" align="left"><a href="decorateForwardAction.action?code=002001005&paramMap.taskId=${aList.taskId}">${aList.title}</a></td>
									<td widht="10%" class="tatd" align="left">${aList.createTime}</td>
								  </tr>								  
								  </s:iterator>
								  <tr bgcolor="#ae9b84">
									<td colspan="4">
										<div class="pageb">
											${initMap.taskPaginated2.pageContent}
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