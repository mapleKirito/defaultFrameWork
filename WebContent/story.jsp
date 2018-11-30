<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<style type="text/css">
p,a{color: #000000;}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/flexpaper_flash_debug.js"></script>
<script type="text/javascript">
$(document).ready(function(){	
	
});
function check(reg) {
	  var ug = navigator.userAgent.toLowerCase();
	  return reg.test(ug);
	}
</script>
</head>
<body>
<%-- 
<s:if test="paramMap.roomname != null && paramMap.roomname !='' && paramMap.roomname == 'exhibition' ">
	${initMap.storyone.erContent}		
</s:if>
<s:if test="paramMap.roomname != null && paramMap.roomname !='' && paramMap.roomname == 'observation' ">
	${initMap.storyone.orContent}
</s:if>
<s:if test="paramMap.roomname != null && paramMap.roomname !='' && paramMap.roomname == 'laboratory' ">
	${initMap.storyone.lrContent}
</s:if>
<s:if test="paramMap.roomname != null && paramMap.roomname !='' && paramMap.roomname == 'projection' ">
	${initMap.storyone.prContent}
</s:if>
<s:if test="paramMap.roomname != null && paramMap.roomname !='' && paramMap.roomname == 'expand' ">
	${initMap.storyone.erContent}
</s:if>			 --%>	

<center>
<div id="viewerPlaceHolder"></div>
<script type="text/javascript">
var cliheight = $("#windowheight",parent.document).val();   
var cliwidth = document.body.scrollWidth;  
var userAgent = document.getElementById("userAgent");
var IE = (navigator.userAgent.toLowerCase()).match(/msie\s*\d\.\d/);
var isIE = check(/msie/);
/* if(isIE) {
	$("#content_left").css({"width":(cliwidth-730)/2});
} */ 
$("#viewerPlaceHolder").css({"height":(cliheight-15)+"px","width":"730px","margin-top":"10px"});
var swfPath = "<%=request.getContextPath()%>/";

if('${paramMap.roomname}' == 'exhibition'){
	swfPath += '${initMap.storyone.erContent}';
}else if('${paramMap.roomname}' == 'observation'){
	swfPath += '${initMap.storyone.orContent}';
}else if('${paramMap.roomname}' == 'laboratory'){
	swfPath += '${initMap.storyone.lrContent}';
}else if('${paramMap.roomname}' == 'projection'){
	swfPath += '${initMap.storyone.prContent}';
}else if('${paramMap.roomname}' == 'expand'){
	swfPath += '${initMap.storyone.erContent}';
}

var fp = new FlexPaperViewer(	
 '<%=request.getContextPath()%>/online_read_module/FlexPaperViewer',
 'viewerPlaceHolder', { config : {
 SwfFile : swfPath,
 Scale : 1.3, 
 ZoomTransition : 'easeOut',
 ZoomTime : 0.5,
 ZoomInterval : 0.2,
 FitPageOnLoad : false,
 FitWidthOnLoad : false,
 PrintEnabled : true,
 FullScreenAsMaxWindow : false,
 ProgressiveLoading : false,
 MinZoomSize : 0.2,
 MaxZoomSize : 5,
 SearchMatchAll : false,
 InitViewMode : 'Portrait',
 ViewModeToolsVisible : true,
 ZoomToolsVisible : true,
 NavToolsVisible : true,
 CursorToolsVisible : true,
 SearchToolsVisible : true,
		 localeChain: 'en_US'
 }});
</script>

			</center>
</body>
</html>