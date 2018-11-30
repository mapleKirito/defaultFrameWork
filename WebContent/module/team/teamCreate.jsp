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
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){alert("校验没有通过，具体错误请看错误提示")}}); 
	$("#tName").formValidator({onshow:"请输入小组名称(最多8个汉字)",onfocus:"小组名称不能为空",oncorrect:""}).inputValidator({min:1,onerror:"输入正确"});
	
	
});
function checkSize(){
	var teamPreName=$("#tName").val();
	
	if(teamPreName.length>16){
		alert("您输入的小组名称超过了16个字符(8个汉字)！");
		return false;
	}else{
		return true;
	}
	
}
</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action" onsubmit="return checkSize();">
<input type="hidden" value="name" name="logColumn" /> 
<input type="hidden" value="true" name="islog" /> 
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="paramMap.userID" value="${session.s_userID}"> 
<input type="hidden" name="imitateStep" value="myTeam_step_1"> 
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
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9" >
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">小组名称：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.tName" value="${initMap.userInfo.userName}" type="text" maxlength="16" id="tName"  style="width: 200px;" />&nbsp;
									<font color="red">*</font><span id="tNameTip" style="position:absolute;height:22px;width:250px"></span>
									</td>
								  </tr>
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">描述：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.tDescription" type="text" id="description" style="width: 200px;" />&nbsp;
									</td>
								  </tr>	
								  <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">是否公开：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.isPublic" type="radio" id="isPublic" style="width: 15px;" value="0"/>不公开&nbsp;
									<input name="paramMap.isPublic" type="radio" id="isPublic" checked style="width: 15px;" value="1"/>公开&nbsp;
									<span>公开后非小组成员也可以访问您的小组</span>
									</td>
								  </tr>			
								   <tr bgcolor="#ae9b84">
									<td width="15%" class="tatd" align="right">小组公告：</td>
									<td width="85%" class="tatd" align="left">
									<input name="paramMap.attention" value="${initMap.teamInfo.attention}" type="text" maxlength="180" id="name"  style="width: 200px;" />&nbsp;
									<%-- <font color="red">*</font><span id="nameTip" style="position:absolute;height:22px;width:250px"></span> --%>
									</td>				  
								  <tr bgcolor="#ae9b84">
									<td colspan="4" style="text-align: center;">
										<input type="submit" name="BtnOk" value="确定" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;
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
</body>
</html>