<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Explorer.js"></script>
<title><s:text name="systemName"/></title>
<script type="text/javascript">
$(document).ready(function(){		
	if(window.screen.width<1920){
		$("#Title").css({"height":"13px",
			"font-size":"16px",
			"margin-top":"3px",
			"font-family":"微软雅黑",
			"width":$("#windowwidth",parent.document).val()-300+"px",
			"font-weight":"bold"});			
		$("#info").css("height","0px");
		$("#NewsContent p img").width($("#windowwidth",parent.document).val()-300);
	}else{
		$("#Title").css({"height":"13px",
			"font-size":"45px",
			"font-family":"微软雅黑",
			"width":$("#windowwidth",parent.document).val()-300+"px",
			"font-weight":"bold"});	
	}
});
 function toHistory(){
	var newsID=$("#newsID").val(); 
	var path;
	alert($(".aui_close"));
   $(".aui_close").click();
	if(newsID=18){
		path="";
	}else if(newsID=19){
		path="";
	}else if(newsID=20){
		path="";
	}else if(newsID=21){
		path="";
	}else if(newsID=22){
		path="";
	}else if(newsID=23){
		path="";
	}else if(newsID=24){
		path="";
	}else if(newsID=25){
		path="";
	}else if(newsID=26){
		path="";
	}
	var link1=$(".aui_close").attr("href");
	window.location.href=link1;
 }
</script>
</head>
<body>
<input type="hidden"  id="newsID" name="newsID" value="${initMap.newsList.newsID  }">
<table align="center" cellpadding="0" cellspacing="0" width="100%" id="newsTs">
	<tr>
		<td align="center" valign="top" >
			<div id="Content" > 
				<div id="ContentText">				
					<div id="Title" ><%-- ${initMap.newsList.newsTitle } --%></div><br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<!-- <a href="javascript:void(0)"  onclick="toHistory();">点击进入相关历史时期</a> -->
					<div id="NewsContent">${initMap.newsList.newsContent }</div>
				</div>
			</div>  
		</td>
	</tr>
</table>
</body>
</html>