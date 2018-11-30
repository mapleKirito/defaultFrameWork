<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><s:text name="systemName"/></title>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<style type="text/css" media="screen">

</style>
<script language="JavaScript">

$(document).ready(function(){
	var imgpath = art.dialog.data('imgpath');
	$("#divimg img").attr("src",imgpath);
	$("#divimg img").LoadImage(true,$("#windowwidth",parent.document).val()-16,parseInt(window.parent.f())-50);
	$("#divimg").css("height",parseInt(window.parent.f())-50+"px");
	$("#divimg img").toggle(function(){
		$(this).css("width",$("#ywidth").val()+"px").css("height",$("#yheight").val()+"px");
	},function(){
		$(this).css("width",$("#xwidth").val()+"px").css("height",$("#xheight").val()+"px");
	});
	
});	
jQuery.fn.LoadImage = function(scaling, width, height, loadpic) {
	if (loadpic == null) loadpic = "images/loadingl.gif";
	return this.each(function() {
		var t = $(this);
		var src = $(this).attr("src");
		var img = new Image();
		img.src = src;
		var autoScaling = function() {
			if (scaling) {
				if (img.width > 0 && img.height > 0) {
					$("#ywidth").val(img.width);
					$("#yheight").val(img.height);
					if (img.width / img.height >= width / height) {
						if (img.width > width) {
							t.width(width);
							$("#xwidth").val(width);
							t.height((img.height * width) / img.width);
							$("#xheight").val((img.height * width) / img.width);
						} else {
							t.width(img.width);
							$("#xwidth").val(img.width);
							t.height(img.height);
							$("#xheight").val(img.height);
						}
					} else {
						if (img.height > height) {
							t.height(height);
							$("#xheight").val(height);
							t.width((img.width * height) / img.height);
							$("#xwidth").val((img.width * height) / img.height);
						} else {
							t.width(img.width);
							$("#xwidth").val(img.width);
							t.height(img.height);
							$("#xheight").val(img.height);
						}
					}
				}
			}
		};
		if (img.complete) {
			autoScaling();
			return;
		}
		$(this).attr("src", "");
		var loading = $("<img alt=\"加载中\" title=\"图片加载中\" src=\"" + loadpic + "\" />");

		t.hide();
		t.after(loading);
		$(img).load(function() {
			autoScaling();
			loading.remove();
			t.attr("src", this.src);
			t.show();
		});
	});
}
</script>
</head>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<input type="hidden" id="ywidth">
<input type="hidden" id="yheight">
<input type="hidden" id="xwidth">
<input type="hidden" id="xheight">
<table id="divimg" width="100%"><tr><td align="center" valign="middle" style="background: #e8e8e8;"><img src="" border="0" style="cursor: pointer;"></td></tr></table>
</body>
</html>