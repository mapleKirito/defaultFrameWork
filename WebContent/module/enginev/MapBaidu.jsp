<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
#l-map{height:100%;width:100%;float:left;border-right:2px solid #bcbcbc;}
</style>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=85c51be32793482f551cfaca82fe144e"></script>
<title></title>
</head>
<body>
<div id="l-map"></div>
</body>
</html>
<script type="text/javascript">
var map = new BMap.Map("l-map",{mapType: BMAP_HYBRID_MAP});
map.centerAndZoom("兰州",4);                   // 初始化地图,设置城市和地图级别。
map.enableScrollWheelZoom();                            //启用滚轮放大缩小
var contextCode = "003011";

map.addEventListener("click", function(e){
	var gerval = window.parent.getareaval("content_"+contextCode);
	if(gerval!=""){
	 gerval = gerval + "|";
	}
	window.parent.setareaval("content_"+contextCode,gerval + e.point.lng + "," + e.point.lat); 
});
</script>