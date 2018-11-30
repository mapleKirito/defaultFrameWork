<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title>${promptInfo.totalDescInfo}</title>
<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/cutimg/jquery.Jcrop.js" type="text/javascript"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/cutimg/jquery.Jcrop.css" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/cutimg/demos.css" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/space/progressBar.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/space/progressBar.css" type="text/css" />
<script type="text/javascript">
var userAgent = navigator.userAgent, 
rMsie = /(msie\s|trident.*rv:)([\w.]+)/, 
rFirefox = /(firefox)\/([\w.]+)/, 
rOpera = /(opera).+version\/([\w.]+)/, 
rChrome = /(chrome)\/([\w.]+)/, 
rSafari = /version\/([\w.]+).*(safari)/;
var browser;
var version;
var ua = userAgent.toLowerCase();

var browserMatch = uaMatch(userAgent.toLowerCase());
if (browserMatch.browser) {
	browser = browserMatch.browser;
	version = browserMatch.version;
}	
if(browser=="IE" && version=="11.0"){  
	$(".textPdown").css("top","-30px");
}
function uaMatch(ua) {
	var match = rMsie.exec(ua);
	if (match != null) {
		return { browser : "IE", version : match[2] || "0" };
	}
	var match = rFirefox.exec(ua);
	if (match != null) {
		return { browser : match[1] || "", version : match[2] || "0" };
	}
	var match = rOpera.exec(ua);
	if (match != null) {
		return { browser : match[1] || "", version : match[2] || "0" };
	}
	var match = rChrome.exec(ua);
	if (match != null) {
		return { browser : match[1] || "", version : match[2] || "0" };
	}
	var match = rSafari.exec(ua);
	if (match != null) {
		return { browser : match[2] || "", version : match[1] || "0" };
	}
	if (match != null) {
		return { browser : "", version : "0" };
	}
}
//alert(browser+" -- "+version);
jQuery.fn.LoadImage = function(scaling, width, height) {
	return this.each(function() {
		var t = $(this);
		var src = $(this).attr("src");
		var img = new Image();
		img.src = src;
		var autoScaling = function() {
			if (scaling) {
				if (img.width > 0 && img.height > 0) {
					if (img.width / img.height >= width / height) {
						if (img.width > width) {
							t.width(width);
							t.height((img.height * width) / img.width);
							
							$("#heightold").val((img.height * width) / img.width);
							$("#widthold").val(width);
							
						} else {
							t.width(img.width);
							t.height(img.height);
							
							$("#heightold").val(img.height);
							$("#widthold").val(img.width);
						
						}
					} else {
						if (img.height > height) {
							t.height(height);
							t.width((img.width * height) / img.height);
							
							$("#heightold").val(height);
							$("#widthold").val((img.width * height) / img.height);
							
						} else {
							t.width(img.width);
							t.height(img.height);
							
							$("#heightold").val(img.height);
							$("#widthold").val(img.width);
							
						}
					}
				}
			}
		}
		
		if (img.complete) {
			autoScaling();
			return;
		}
		$(this).attr("src", "");
		var loading = $("<img alt=\"加载中\" title=\"图片加载中\" src=\"\" />");
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
var x; var y; var width; var height;
$(document).ready(function(){
	$("#uploadBigFile").change(function(){
		$("#uploadBigFile").select();
		var realFile = $("#uploadBigFile").val() ;
		var date = new Date() ;
		var path = "upload/user/" ;
		var fileType = realFile.substring(realFile.lastIndexOf(".") + 1 ,realFile.length) ;
		
		var name = '${session.s_userID}';
		var fileName = name+"_"+name + "." + fileType ; 
		$("#uploadFileName").val(fileName) ;
		$("#uploadFilePath").val(path) ;		
	}) ;
	 
	$("#close").click(function(){
		$("#btnUpload").hide();
	});
	 
	 $("#jfyescut").click(function(){
		//alert($('#width').val() + " -- " + $('#height').val() + " -- " + $('#x').val() + " -- " + $('#y').val()) + $("#uploadFileName").val()  + " -- " + $("#uploadFilePath").val() + " -- " + $("#heightold").val(t.height()) + " -- " + $("#widthold").val(t.width());
		$.ajax({
			url:		"ajaxAction.action?code=-22100&paramMap.isAll="+$('#isAll').val()+"&paramMap.width="+$('#width').val()+"&paramMap.height="+$('#height').val()+"&paramMap.x="+$('#x').val()+"&paramMap.y="+$('#y').val()+"&paramMap.uploadCutPath="+$("#uploadFilePath").val() +"&paramMap.uploadCutName=" + $("#uploadFileName").val()+"&paramMap.heightold="+$("#heightold").val() + "&paramMap.widthold=" + $("#widthold").val()+"&suijiimg="+new Date().getTime(),
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				if (textStatus == "success"){
					//alert($('#uploadFileName').val());
					$('#jcPreview').html("<img src='/dm/upload/user/n_"+$('#uploadFileName').val()+"'   id='preview' alt='Preview' />" );
					location.href="decorateForwardAction.action?code=002032009&suijichileren="+new Date();
				}
			},
			
			error:function(request,textStatus,error){}
		});
	 });
	 
	 $("#Cancel").click(function(){
		 location.href="decorateForwardAction.action?code=002032009&suijichileren="+new Date();
	 });
	 
	 
});
</script>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body >
<table border="0" height="590" width="100%" style=" background: #AE9B84;">
<tr >
	<td>
	<div style="position: relative;">
		<table border="1" height="100%" width="100%" >
			<tr style="height: 150px;">
				<td valign="top" id="jfold">
					<span>操作：</span><br/>
					<span>&lt; 1 &gt;如果
					<input type="button" value="重新上传"  onclick="location.reload();" class="spaceBtn" />
					，请刷页该面。</span><br/>
					<span>&lt; 2 &gt;上传原图：</span>
					<div class="uploadDiv">
						<iframe id='target_upload' name='target_upload' src='' style='display: none'></iframe>
						<form action="/dm/uploadFile/upload?uploadflag=1" id="uploadForm" enctype="multipart/form-data" method="post" target="target_upload">
							<input type="hidden" name="uploadFileName" id="uploadFileName">
							<input type="hidden" name="uploadFilePath" id="uploadFilePath">
							<input type="hidden" name="uploadFileType" id="uploadFileType" value="main">
							<span id="fileup">
								<input type="file" name="upload" id="uploadBigFile" > 
								<input type="button" id="btnUpload" class="spaceBtn subButton"  value="上传">
							</span>
						</form>
					</div>
					<div id="progress">
						<div id="title">
							<div id="close">关闭</div>
						</div>
						<div id="progressBar">
							<div id="uploaded"></div>
						</div>
						<div id="info"></div>
					</div>
					<span>&lt; 3 &gt;在原图区域中截图，在预览框中预览。</span><br/>
					<span>&lt; 4 &gt;点击&nbsp;
						<input type="hidden" name="image.x" id="x"/>
						<input type="hidden" name="image.y" id="y"/>
						<input type="hidden" name="image.width" id="width"/>
						<input type="hidden" name="image.height" id="height"/>
						<input type="hidden" name="image.heightold" id="heightold"/>
						<input type="hidden" name="image.widthold" id="widthold"/>  
						<input type="hidden" name="image.isAll" id="isAll" value="0"/>  
						<input type="button" value="确定"  class="spaceBtn" id="jfyescut"/>
					&nbsp;设置完成。
					</span><br/>
					<span>&lt; 5 &gt;点击&nbsp;
						<input type="button" value="取消"  id="Cancel" class="spaceBtn" />
					&nbsp;放弃修改。
					</span>
				</td>
				<td valign="top" align="center">
					<span style="width:150px;height:150px;overflow:hidden;position: absolute;left: 450px;border: 1px solid gray;" id="jcPreview">
						<img src="<%=request.getContextPath()%>/images/old.png" id="preview" alt="Preview"  />
					</span>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center" valign="middle" id="jcTarget">
					<img src="<%=request.getContextPath()%>/images/old.png" id="target" alt="Flowers" />
				</td>
			</tr>
		</table>
		</div>
	</td>
</tr>
</table>

</body>
</html>