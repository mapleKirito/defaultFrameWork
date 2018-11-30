<%@page import="java.util.Random"%>
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
<link href="qc/css/style.css" rel="stylesheet">
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
	});

});
function modify(_this){
	location.href="decorateForwardAction.action?code=00203200204&paramMap.tID=${paramMap.tID }";
}
</script>
</head>
<body>
<div class="page-container ssjh">
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.tID" value="${initMap.teamInfo.tID}"> 
<input type="hidden" name="imitateStep" value="teacherTestMain_step_1"> 
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
									<td width="15%" class="tatd" align="right">头像：</td>
									<td width="85%" class="tatd" align="left">
									<img src="${(initMap.teamInfo.userImg==null||initMap.teamInfo.userImg=='')?'images/main/toux.jpg':initMap.teamInfo.userImg}?suiji=<%=new Random().nextInt() %>" width="145" height="147">
									<input type="button" name="BtnOk" value="修改" onclick="modify(this)" >
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">小组简介：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.tDescription" value="${initMap.teamInfo.tDescription}" type="text" maxlength="180" id="name"  style="width: 200px;" />&nbsp;
									</td>
								  </tr>	
								   <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">是否公开：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.isPublic" type="radio" id="isPublic" style="width: 15px;" value="0" ${initMap.teamInfo.isPublic eq '0' ? 'checked':'' }/>不公开&nbsp;
									<input name="paramMap.isPublic" type="radio" id="isPublic" style="width: 15px;" value="1" ${initMap.teamInfo.isPublic eq '1' ? 'checked':'' }/>公开&nbsp;
									<span>公开后非小组成员也可以访问您的小组</span>
									</td>
								  </tr>		
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">小组公告：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.attention" value="${initMap.teamInfo.attention}" type="text" maxlength="180" id="attention"  style="width: 200px;" />&nbsp;
									</td>
								  </tr>		  
								  <tr bgcolor="#ae9b84" align="center">
									<td colspan="4">
										<input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
										<input type="button" name="BtnReturn" value="返回" id="BtnReturn" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" />
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
</div>
</body>
</html>