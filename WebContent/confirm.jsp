<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<%
	String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();	
%>
<html>
<head>
<title>成功提示</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/skin.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#btnok").click(function(){
		$("html",window.parent.document).find("#screen__").css("display","none");
		$("html",window.parent.document).find("#message__").css("display","none");
    	
		if(window.parent.frames["content_002001"]){
			window.parent.frames["content_002001"].document.location.reload();//我的信息
		}
		if(window.parent.frames["content_002011"]){
			window.parent.frames["content_002011"].document.location.reload();//教学成果管理
		}
		if(window.parent.frames["content_002012"]){
			window.parent.frames["content_002012"].document.location.reload();//学生提问管理
		}
		if(window.parent.frames["content_002007003"]){
			window.parent.frames["content_002007003"].document.location.reload();//学生作业 
		}
		if(window.parent.frames["content_002006"]){
			window.parent.frames["content_002006"].document.location.reload(); 
		}
		
		if(window.parent.frames["content_001001"]){
			window.parent.frames["content_001001"].document.location.reload();//我的主页
		}
		if(window.parent.frames["content_001003"]){
			window.parent.frames["content_001003"].document.location.reload();//我的主页
		}
		if(window.parent.frames["content_001007"]){
			window.parent.frames["content_001007"].document.location.reload();//我要做作业
		}
		if(window.parent.frames["content_001005"]){
			window.parent.frames["content_001005"].document.location.reload();//未完成作业
		}
		if(window.parent.frames["content_001008"]){
			window.parent.frames["content_001008"].document.location.reload();//我要提问
		}
	});
	
});	
</script>
</head>
<body style="background-color: #F7F3FF; margin-top: 50;">
<table width="100%" height="130" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="0" cellspacing="1">
			<tr>
				<td align="center" valign="middle">  
					&nbsp;${promptInfo.resultDescInfo}
                </td>
			</tr>
		</table>
		</td>
	</tr>
     <tr > 
         <td align="center" valign="middle">
         <input type="submit" id="btnok" value="确定" >
         </td>
     </tr>
</table>
</body>
</html>
