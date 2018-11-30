<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="css/demo.css" />
<link rel="stylesheet" type="text/css" href="css/style1.css" />
<!--[if !IE]><!--> 
<link rel="stylesheet" type="text/css" href="css/elastislide.css" />
 <!--<![endif]-->
<!--[if IE]> 
<link rel="stylesheet" type="text/css" href="css/elastislide_ie.css" />
<![endif]-->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Himg.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/detailmanager/detail_1084.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/imagesview.css" />
<script type="text/javascript" language="JavaScript"> 
var userAgent = navigator.userAgent, 
rMsie = /(msie\s|trident.*rv:)([\w.]+)/, 
rFirefox = /(firefox)\/([\w.]+)/, 
rOpera = /(opera).+version\/([\w.]+)/, 
rChrome = /(chrome)\/([\w.]+)/, 
rSafari = /version\/([\w.]+).*(safari)/;
var browser;
var version;
var ua = userAgent.toLowerCase(); 
$(document).ready(function(){
	
	$(".onrg-image-wrapper #audiop2").css("margin-top",($("#windowheight",parent.document).val()-256)/2+"px");
	$(".onrg-image-wrapper #audiop").css("margin-top",($("#windowheight",parent.document).val()-370)/2-20+"px");
	var browserMatch = uaMatch(userAgent.toLowerCase());
	if (browserMatch.browser) {
		browser = browserMatch.browser;
		version = browserMatch.version;
	}		
	var ienam1 = browser;
	var  trim_Version;
	if(version[1]!=null){
		trim_Version=version[1].replace(/[ ]/g,"");
	}
	
	if(browser=="IE" && ( parseInt(version)<=parseInt("10.0"))){  
		$("#audiop").show();
		$("#audiop2").hide();
	}
	
	
});
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
var n=0;
function music(){
 	if(n==1){
 		document.getElementById("mp").pause();
 		$("#audioplay img").attr("src","<%=request.getContextPath()%>/images/play.png");
 		n=2;
 	}else{
 		document.getElementById("mp").play();
 		$("#audioplay img").attr("src","<%=request.getContextPath()%>/images/pause.png");
 		n=1;
 	}
} 
function fieldControl(){
	 
	 if(isFieldNull('${initMap.audioDetail.prNO}')) $(".prNO").parent().hide();
	
	 if(isFieldNull('${initMap.audioDetail.prCategoryName}')) $(".prCategoryName").parent().hide();
	 
	 if(isFieldNull('${initMap.audioDetail.prCateTwLevelName}')) $(".prCateTwLevelName").parent().hide();
	 
}
function AboutRes(_This){
	$(".rg-controls-lookdetail").fadeOut(600);
	var code = $(_This).attr("codeParam");
	var param = $(_This).attr("param");
	window.parent.tabClick('xiangguan','相关资源',code,param);
}
</script>  
</head>
<body>
<input type="hidden" class="image_w" value="">
<input type="hidden" class="image_h" value="">
<input type="hidden" class="roomname" value="projection">
<input type="hidden" id="prName" value="${initMap.audioDetail.prName}">
<input type="hidden" id="prAudio" value="${initMap.audioDetail.prAudio}">
<input type="hidden" id="prUpload" value="${initMap.audioDetail.prUpload}">
<div id="rg-gallery" class="rg-gallery">
	<div id = "rg-thumbs" class="rg-thumbs">
		<div class="es-carousel-wrapper">
			<div class="es-carousel" >
				<div style="height:28px;text-align: center;" id="thumleft">
					<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%"  id="es-carouse-tab-table" style="margin-top:1px;">
						<tr>
							<td width="33%" align="center" style="background-position-x:15px;" id="td_2" class="td_2 tabtd"></td>
							<td width="66%"><img src="images/left.png" style="float: right;"></td>
						</tr>
					</table>
				</div>
				<div class="scrolllist tabdiv" id="s1" style="background-color:#e8e8e8;opacity:0.8; filter: alpha(opacity=80);">
					<a class="abtn aleft" href="#left" title="左移"></a>
					<div class="imglist_w">
						<ul class="imglist">
							<s:iterator value="initMap.resAllView" id="fvall" status="fvallindx">
								<s:set name="pcode" value="''" />
			                   		<s:set name="pname" value="''" />
			                   		<s:set name="expurl" value="''" />                   		
			                   		<s:if test="#fvall.resType == 'exhibition'">
			                   			<s:set name="pcode" value="'-701003'" />
			                   			<s:set name="pname" value="'erID'" />
			                   			<s:set name="broomname" value="'er'" />
			                   			<s:if test="#fvall.fileType == '1011'">
			                   				<s:set name="pcode" value="'-701001'" />
			                   			</s:if>
			                   			<s:if test="#fvall.fileType == '1073' || #fvall.fileType == '1084'">
			                   				<s:set name="pcode" value="'-701002'" />
			                   			</s:if>
			                   			<s:if test="#fvall.fileType == '2041' || #fvall.fileType == '2033' || #fvall.fileType == '2055'">
			                   				<s:set name="pcode" value="'-701018'" />
			                   			</s:if>
			                   		</s:if>
			                   		<s:if test="#fvall.resType == 'observation'">
			                    		<s:set name="pcode" value="'-701006'" />
			                   			<s:set name="pname" value="'orID'" />
			                   			<s:set name="broomname" value="'or'" />
			                   			<s:if test="#fvall.fileType == '1011' || #fvall.fileType == '1022'">
			                   				<s:set name="pcode" value="'-701004'" />
			                   			</s:if>
			                   			<s:if test="#fvall.fileType == '4033' ">
			                   				<s:set name="pcode" value="'-701023'" />
			                   			</s:if>
			                   			<s:if test="#fvall.fileType == '1073' || #fvall.fileType == '1084'">
			                   				<s:set name="pcode" value="'-701005'" />
			                   			</s:if>
			                   			<s:if test="#fvall.fileType == '2041' || #fvall.fileType == '2033' || #fvall.fileType == '2055'">
			                   				<s:set name="pcode" value="'-701019'" />
			                   			</s:if>
			                   		</s:if>
			                   		<s:if test="#fvall.resType == 'laboratory'">
			                   			<s:set name="pcode" value="'-701009'" />
			                   			<s:set name="pname" value="'lrID'" />
			                   			<s:set name="broomname" value="'lr'" />
			                   			<s:if test="#fvall.fileType == '1011' || #fvall.fileType == '1022'">
			                   				<s:set name="pcode" value="'-701007'" />
			                   			</s:if>
			                   			<s:if test="#fvall.fileType == '1073' || #fvall.fileType == '1084'">
			                   				<s:set name="pcode" value="'-701008'" />
			                   			</s:if>
			                   			<s:if test="#fvall.fileType == '2041' || #fvall.fileType == '2033' || #fvall.fileType == '2055'">
			                   				<s:set name="pcode" value="'-701020'" />
			                   			</s:if>
			                   		</s:if>
			                   		<s:if test="#fvall.resType == 'projection'">
			                   			<s:set name="pcode" value="'-701012'" />
			                   			<s:set name="pname" value="'prID'" />
			                   			<s:set name="broomname" value="'pr'" />
			                   			<s:if test="#fvall.fileType == '1011' || #fvall.fileType == '1022'">
			                   				<s:set name="pcode" value="'-701010'" />
			                   			</s:if>
			                   			<s:if test="#fvall.fileType == '1073' || #fvall.fileType == '1084'">
			                   				<s:set name="pcode" value="'-701011'" />
			                   			</s:if>
			                   			<s:if test="#fvall.fileType == '2041' || #fvall.fileType == '2033' || #fvall.fileType == '2055'">
			                   				<s:set name="pcode" value="'-701021'" />
			                   			</s:if>
			                   		</s:if>
			                   		<s:if test="#fvall.resType == 'expand'">
			                   			<s:set name="pcode" value="'-701013'" />
			                   			<s:set name="pname" value="'erID'" />
			                   			<s:set name="broomname" value="'er'" />
			                   			<s:if test="#fvall.fileType == '1011' || #fvall.fileType == '1022'">
			                   				<s:set name="pcode" value="'-701016'" />
			                   			</s:if>
			                   			<s:if test="#fvall.fileType == '1073' || #fvall.fileType == '1084'">
			                   				<s:set name="pcode" value="'-701017'" />
			                   			</s:if>
			                   			<s:if test="#fvall.fileType == '2041' || #fvall.fileType == '2033' || #fvall.fileType == '2055'">
			                   				<s:set name="pcode" value="'-701022'" />
			                   			</s:if>
			                    		<s:if test="#fvall.erTaskId != null && #fvall.erTaskId != ''">
			                    			<s:set name="expurl" value="#fv.erContent" />
			                    		</s:if>
			                   		</s:if>
									<li>
										<a href="javascript:void(0)" onclick="AboutRes(this)" codeParam="${pcode}"  param="path=${fvall.path}&paramMap.${broomname}Type=${fvall.fileType}&paramMap.fileType=${fvall.fileType}&paramMap.${pname}=${fvall.id}&paramMap.st=1&paramMap.temppname=${pname}&paramMap.temppid=${fvall.id}&paramMap.name=${fvall.name}&paramMap.roomtype=${fvall.resType}">
											<img src="${fvall.thumbnail}" style="height: 53px;"/>
										</a>
									</li>
							</s:iterator>
						</ul>
					</div>
					<a class="abtn aright" href="#right" title="右移"></a>
				</div>
			</div>
		</div>
	</div>
	
	<div class="rg-image-wrapper onrg-image-wrapper" style="text-align: center;">
				<div id="audiop2" width="256px"  height="256px">
			  <a href="javascript:void();" onclick="music();"id="audioplay"> 
				<img src="<%=request.getContextPath()%>/images/play.png" width="256px"  height="256px" title="点击播放"> 
				</a>
			  <audio src="${initMap.audioDetail.prUpload}"  style="width: 0px;" id="mp"></audio>	
				</div>
				<div id="audiop" height="370px" width="653px" style="display:none;">
					<object id="player" height="370" width="653" classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6">
						<param NAME="AutoStart" VALUE="-1">
						<!--是否自动播放-->
						<param NAME="Balance" VALUE="0">
						<!--调整左右声道平衡,同上面旧播放器代码-->
						<param name="enabled" value="-1">
						<!--播放器是否可人为控制-->
						<param NAME="EnableContextMenu" VALUE="-1">
						<!--是否启用上下文菜单-->
						<param NAME="url" value="<%=request.getContextPath()%>/${initMap.audioDetail.prUpload}">
						<!--播放的文件地址-->
						<param NAME="PlayCount" VALUE="1">
						<!--播放次数控制,为整数-->
						<param name="rate" value="1">
						<!--播放速率控制,1为正常,允许小数,1.0-2.0-->
						<param name="currentPosition" value="0">
						<!--控件设置:当前位置-->
						<param name="currentMarker" value="0">
						<!--控件设置:当前标记-->
						<param name="defaultFrame" value="">
						<!--显示默认框架-->
						<param name="invokeURLs" value="0">
						<!--脚本命令设置:是否调用URL-->
						<param name="baseURL" value="">
						<!--脚本命令设置:被调用的URL-->
						<param name="stretchToFit" value="0">
						<!--是否按比例伸展-->
						<param name="volume" value="50">
						<!--默认声音大小0%-100%,50则为50%-->
						<param name="mute" value="0">
						<!--是否静音-->
						<param name="uiMode" value="mini">
						<!--播放器显示模式:Full显示全部;mini最简化;None不显示播放控制,只显示视频窗口;invisible全部不显示-->
						<param name="windowlessVideo" value="0">
						<!--如果是0可以允许全屏,否则只能在窗口中查看-->
						<param name="fullScreen" value="0">
						<!--开始播放是否自动全屏-->
						<param name="enableErrorDialogs" value="-1">
						<!--是否启用错误提示报告-->
						<param name="SAMIStyle" value>
						<!--SAMI样式-->
						<param name="SAMILang" value>
						<!--SAMI语言-->
						<param name="SAMIFilename" value>
						<!--字幕ID-->
					</object>
				</div>
	</div>	
<input type="hidden" id="srotyIDH" value='${initMap.audioDetail.prID}'>
<div class="rg-image-wrapper"  style="text-align: center;"> </div>
<div class="rg-image-controls" style="height:40px;width:100%;">
	<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0" style="background-color:#666666;opacity:0.8; filter: alpha(opacity=80);">
		<tr>
			<td width="75%" style="font-family:微软雅黑;font-weight: bold;font-size: 15px;float: left;text-align: left;line-height: 40px;">&nbsp;&nbsp;&nbsp;&nbsp;资源名称：${initMap.audioDetail.prName}</td>
			<td width="25%">
				<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0" class="rg-image-con-right">
					<tr>
						<td width="50%">
							<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0">
								<tr>
									<td><a id="lookdetail" ><img style="height:20px;" src="images/main/picview/3.png" border="0"></a></td>
									<s:if test="initMap.audioDetail.prContent != '' && initMap.audioDetail.prContent != 'null' ">
									 	<td><a id="story_btn" href="javascript:void(0)" ><img style="height:23px;"  src="<%=request.getContextPath()%>/images/detail/story.png" title="资源简介"></a></td>
					 				</s:if>
					 				<s:if test="session.s_userType != 3 and paramMap.st == 1">
                          				<td><a href="javascript:void(0)" id="${code}|${paramMap.path}|projection|${paramMap.st}|${initMap.audioDetail.prName}|${initMap.audioDetail.prType}|${paramMap.temppid}" class="addFavorite">
                          					<img src="<%=request.getContextPath()%>/images/top/favorite.png" title="加入收藏" height="24px" border="0" >
                          				</a></td>  
                          			</s:if>
									<td style="display: none;"><a id="imagesview_btn" path="${initMap.audioDetail.prUpload}"><img style="height:20px;" src="images/main/picview/2.png" border="0"></a></td>
									<td><a href="downloadAction.action?code=-706&paramMap.resDownRoom=projection&paramMap.resDownType=${initMap.audioDetail.prType}&paramMap.resPath=${initMap.audioDetail.prUpload}"><img style="height:20px;" src="<%=request.getContextPath()%>/images/main/picview/5.png" title="资源下载"></a></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>		
		</tr>
	</table>
	<div class="rg-image-fo"><img src="images/left.png"></div>
</div>		

<div class="rg-controls-lookdetail" style="display:none; overflow:auto;  width: 250px;background-color:#666666;opacity:0.8; filter: alpha(opacity=80);position: absolute;top: 30px;right: 0px;z-index: 301">
	<table border="0" width="100%" cellspacing="0" cellpadding="0" style="line-height: 30px;table-layout: fixed;word-wrap:break-word;">
		<tr>
			<td width="25%" align="center">资源名称</td>
			<td width="75%" align="center" class="prNO">${initMap.audioDetail.prNO}</td>
		</tr>
		<tr>
			<td width="25%" align="center">资源名称</td>
			<td width="75%" align="center" class="prName">${initMap.audioDetail.prName}</td>
		</tr>
		<tr>
			<td width="25%" align="center">资源类型</td>
			<td width="75%" align="center" class="prType">
				${initMap.audioDetail.prType eq "1073" ? '音频':'' }
				${initMap.audioDetail.prType eq "1084" ? '高清视频':'' }
				${initMap.audioDetail.prType eq "2002" ? '虚拟仿真实验':'' }
			</td>
		</tr>
		<tr>
			<td width="25%" align="center">资源分类</td>
			<td width="75%" align="center" class="prCategoryName">${initMap.audioDetail.prCategoryName}</td>
		</tr>
		<tr>
			<td width="25%" align="center">二级分类</td>
			<td width="75%" align="center" class="prCateTwLevelName">${initMap.audioDetail.prCateTwLevelName}</td>
		</tr>
	</table>
</div>
<script type="text/javascript" src="js/jquery.min1.7.js"></script>

</body>
</html>