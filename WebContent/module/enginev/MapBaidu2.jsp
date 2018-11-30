<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="java.io.*,java.util.* "%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=85c51be32793482f551cfaca82fe144e"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<title></title>
</head>
<body>
<div id="allmap"></div>
</body>
</html>
<script type="text/javascript">

var city=artDialog.open.origin.document.getElementById("erCityName").value;
//alert(city);
var erlalo = art.dialog.data('erlalo');
//平面地图
var map = new BMap.Map("allmap");          
//卫星地图
//var map = new BMap.Map("allmap",{mapType: BMAP_HYBRID_MAP});
map.enableScrollWheelZoom();    

// 坐标  位置
map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);
var local = new BMap.LocalSearch(map, {
	renderOptions:{map: map}
});
local.search(city);  ;	
	 	
 
</script>