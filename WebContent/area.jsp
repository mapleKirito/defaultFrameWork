<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><s:text name="systemName" /></title>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-1.6.2.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/autoscroll.js"></script>
<link href="<%=request.getContextPath()%>/css/pages/css.css"
	rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/js/pages/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/pages/jquery.kkPages.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/pages/shCore.js"></script>
<link type="text/css" rel="stylesheet"
	href="<%=request.getContextPath()%>/css/pages/shCore.css" />
<link type="text/css" rel="stylesheet"
	href="<%=request.getContextPath()%>/css/pages/shThemeDefault.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/pages/shBrushCss.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/pages/shBrushJScript.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".menuTabTextNavigation",parent.document).html($("<span>${pmsIndex.sys_picDetail_area.name}</span>"));
});
</script>

<style type="text/css">
ul,li {
	list-style: none;
}

#resInfo li {
	width: 80px;
	height: 82px;
	float: left;
	margin: 0 2px;
}

body {
	background-color: #eeeef0;
}

body,html,#allmap {
	overflow: hidden;
	margin: 0;
}

#allmap {
	width: 100%;
	height: 100%;
	position: absolute;
	left: 210px;
}

* {
	margin: 0;
	padding: 0
}
.pName{
position: relative;
top: -21px;
color: #fff;
background: #666666;
opacity: 0.8;
height: 20px;
line-height: 20px;
text-align: center;
}
#CON{background-image:url(images/top/you.png);}
#prev{background-image:url(images/page/pageback2.png);background-repeat: no-repeat;}
#next{background-image:url(images/page/pagenext2.png);background-repeat: no-repeat;}

</style>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/areaRea.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=85c51be32793482f551cfaca82fe144e"></script>
<link
	href="<%=request.getContextPath()%>/css/recomRes/css/jquery-webox.css"
	rel="stylesheet" type="text/css">
<script
	src="<%=request.getContextPath()%>/js/recomRes/js/jquery-webox.js"></script>
<title><s:text name="systemName"/></title>
</head>
<body >
	<div
	id="conT"	style="width: 200px;float:left;  overflow: hidden;"
		>
		<input type="text" id="search_area"  style="height:20px;width: 150px;position: relative;top:-7px;left:3px;">
		<img src="<%=request.getContextPath()%>/images/top/search_1.png" style="position: relative;top: 6px;" border="0" title="查询" onclick="Search_area()" id="search_btn">
			
		<div id="nomal" style="">
			<ul>
				<li><select id="erShi" name="paramMap.erShi"
					onchange="findChildArea(1);"
					style="width: 200px; height: 30px; font-size: 14;"></select></li>
				<li><select id="erDili" name="paramMap.erDili"
					onchange="findChildArea(2);"
					style="width: 200px; height: 30px; font-size: 14;"></select></li>
				<li><select id="erQuan" name="paramMap.erQuan"
					onchange="findChildArea(3);"
					style="width: 200px; height: 30px; font-size: 14;"></select></li>
				<li><select id="erJie" name="paramMap.erJie"
					onchange="findChildArea(4);"
					style="width: 200px; height: 30px; font-size: 14;"></select></li>
				<li><select id="erDai" name="paramMap.erDai"
					onchange="findChildArea(5);"
					style="width: 200px; height: 30px; font-size: 14;"></select></li>
			</ul>
			<!-- 资源参数 -->
			<input type="hidden" name="paramMap.erShiName" id="erShiName">
			<input type="hidden" name="paramMap.erDiliName" id="erDiliName">
			<input type="hidden" name="paramMap.erQuanName" id="erQuanName">
			<input type="hidden" name="paramMap.erJieName" id="erJieName">
			<input type="hidden" name="paramMap.erDaiName" id="erDaiName">
			<!-- 查询参数 -->
			<input type="hidden" name="strart" id="start"> <input
				type="hidden" name="count" id="count">
			<div id="prev" onclick="prev(0)"
				style="width: 100px; height: 31px;  float: left;">
			</div>
			<div id="next" onclick="prev(1)"
				style="width: 100px; height: 31px;  float: left;">
			</div>
			<div id="resInfo" style="width: 200px; height: 350px;overflow-y: auto;padding-left: 15px;"></div>			
		</div>
		<div id="CON" onclick="show()" style="width:7px;height:10px;float: right;position: absolute;top: 245px;left: 200px;">
		</div>
	</div>
	<div id="allmap"></div>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/areaFun.js"></script>
</body>
</html>