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
.table_9 tr td label,.table_9 tr td span{vertical-align: middle;}
</style>
<script type="text/javascript">
<%
String errorMessage = (String)request.getAttribute("errorMessage") ;
errorMessage = errorMessage == null ? "" : errorMessage ;
if("success".equals(errorMessage)) {
	out.println("alert('操作成功！');") ;
}else if(errorMessage.length() > 0) {
	out.println("alert('" + errorMessage + "');") ;
}
%>
$(document).ready(function(){	
	var $div_li =$(".teacherTab li");
	$div_li.click(function(){
		$(this).addClass("curr")            //当前<li>元素高亮
			   .siblings().removeClass("curr");  //去掉其它同辈<li>元素的高亮
		var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
		$(".table_9")   	//选取子节点。不选取子节点的话，会引起错误。如果里面还有div 
				.eq(index).show()   //显示 <li>元素对应的<div>元素
				.siblings().hide(); //隐藏其它几个同辈的<div>元素
	});
	
	$('input:radio.room_choose').change(function(){
		var resType = $('input:radio.room_choose:checked').val() ;
		if(resType == "exhibition") {
			window.location.href="decorateForwardAction.action?code=005001" ;
		}else if(resType == "observation") {
			window.location.href="decorateForwardAction.action?code=005002" ;
		}else if(resType == "laboratory") {
			window.location.href="decorateForwardAction.action?code=005003" ;
		}else if(resType == "projection") {
			window.location.href="decorateForwardAction.action?code=005004" ;
		}else if(resType == "expand") {
			window.location.href="decorateForwardAction.action?code=005005" ;
		}
	}) ;
});
</script>
</head>
<body>
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
									<td width="15%" class="tatd" align="right">选择科室名称：</td>
									<td width="85%" class="tatd" align="left">
										<label><input type="radio" name="paramMap.resType" class="room_choose" value="exhibition"><span>文物博览室</span></label>
										<label><input type="radio" name="paramMap.resType" class="room_choose" value="observation"><span>专题研读室</span></label>
										<label><input type="radio" name="paramMap.resType" class="room_choose" value="laboratory"><span>教学研究室</span></label>
										<label><input type="radio" name="paramMap.resType" class="room_choose" value="projection"><span>影像资料室</span></label>
										<label><input type="radio" name="paramMap.resType" class="room_choose" value="expand"><span>自主探究室</span></label>
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