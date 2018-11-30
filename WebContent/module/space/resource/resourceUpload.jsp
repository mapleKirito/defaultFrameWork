<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title>${promptInfo.totalDescInfo}</title>
<head>
<SCRIPT type=text/javascript src="space/jquery.js"></SCRIPT>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<script type="text/javascript">
$(document).ready(function(){	
	if($("#userType").val()==2){
		$("#resType option[value='exhibition']").remove();
		$("#resType option[value='observation']").remove();
		$("#resType option[value='laboratory']").remove();
		$("#resType option[value='projection']").remove();
	}
	var $div_li =$(".teacherTab li");
	$div_li.click(function(){
		$(this).addClass("curr")            //当前<li>元素高亮
			   .siblings().removeClass("curr");  //去掉其它同辈<li>元素的高亮
		var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
		$(".table_9")   	//选取子节点。不选取子节点的话，会引起错误。如果里面还有div 
				.eq(index).show()   //显示 <li>元素对应的<div>元素
				.siblings().hide(); //隐藏其它几个同辈的<div>元素
	});
	
	$("#resType").change(function(){
		var resType = $("#resType").val() ;
		if(resType == "exhibition") {
			window.location.href="decorateForwardAction.action?code=-006104001001" ;
		}else if(resType == "observation") {
			window.location.href="decorateForwardAction.action?code=-006104001002" ;
		}else if(resType == "laboratory") {
			window.location.href="decorateForwardAction.action?code=-006104001003" ;
		}else if(resType == "projection") {
			window.location.href="decorateForwardAction.action?code=-006104001004" ;
		}else if(resType == "expand") {
			window.location.href="decorateForwardAction.action?code=-006104001005" ;
		}
	}) ;
});
</script>
</head>
<body>
<input type="hidden" id="userType" value="${session.s_userType }" />
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">

</form>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">资源类别：</td>
									<td width="85%" class="tatd" align="left">
										<select id="resType">
											<option value="0">----请选择资源类别----</option>
											<option value="exhibition">陈列M室</option>
											<option value="observation">观察室</option>
											<option value="laboratory">实验室</option>
											<option value="projection">放映室</option>
											<option value="expand">拓展室</option>
										</select>					
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
</body>
</html>