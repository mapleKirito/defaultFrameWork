<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/page/html/pageUnit/lib/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/page/html/pageUnit/lib/jquery.qrcode.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/page/html/pageUnit/lib/qrcode.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<title></title>
</head>
<body>
<p></p>
<div id="qrcodeShow" style="text-align: center;"></div>
<div style="text-align: center;"><a href="javascript:void(0)" id="downBtn"><img src="/dm/images/download.png" /></a></div>
<canvas id="testHTML5" style="display: none;"></canvas>
<script>
$(function(){
	var content = art.dialog.data('str');
	var code = art.dialog.data('code');
	$("#downBtn").attr("href",contextPath+"/downQRcode?code="+code+"&content="+content);
	
})

var str = art.dialog.data('str');
var contextPath = art.dialog.data('contextPath');

//$("#ScannerTitle").html(str);
var canvas = document.getElementById('testHTML5');


if(canvas.getContext){
	jQuery('#qrcodeShow').qrcode({
		text	: str
	});	
}else{
	jQuery('#qrcodeShow').qrcode({
		render	: "table",
		text	: str
	});	
}

</script>
</body>
</html>