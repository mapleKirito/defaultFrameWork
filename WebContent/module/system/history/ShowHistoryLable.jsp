<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/date/scripts.js"></script>	
<script type="text/javascript">
$(document).ready(function(){	
	$("a").attr("href","").css("color","#000000");
	doLinkAll();
});

function doLinkAll(action){ 
	var arr=document.getElementsByTagName("A") ;
	for(var i=0;i <arr.length;i++){ 
		arr[i].setAttribute("rel",arr[i].href) ;
		arr[i].removeAttribute("href") ;
	}
}

</script>
<style type="text/css">
*{font-size: 14px;
color: rgb(0, 0, 0);
}
#ContentText{text-align: left;
}
#Title {font-size: 24px;font-family: "微软雅黑";font-weight: bold;text-align: center;height: 60px;color:#504538;
line-height: 60px;}
#Info {font-size: 16px;font-family: "微软雅黑";font-weight: bold;text-align: left;height: auto;
line-height: 30px;border: 1px dotted #979797;text-align: center;color:#504538;padding: 10px 10px;}
#ContentText p{margin-top: 10px;margin-bottom: 10px;color: #88361F;}
.divHeight{height:400px;height:auto;width:800px; background:#bbeeeb;margin:0 auto;height: auto;} 
</style>
</head>
<body style="background-image: url(../images/81177_bg.jpg) repeat;">
<div id="layout_mainbody">
	<div class="page-container">
<table align="center" cellpadding="0" cellspacing="0" width="100%" id="newsTs">
	<tr>
		<td align="center" valign="top" >
			<div id="Content" > 
				<div id="ContentText" style="width: 850px;">				
					<div id="Title" >${initMap.historyList.historyTitle }</div>
					<div id="Info"   class="divHeight">摘要：${initMap.historyList.historyInfo }</div>
					<div id="NewsContent">${initMap.historyList.historyContent }</div>
				</div>
			</div>  
		</td>
	</tr>
</table>
</div></div>
</body>
</html>