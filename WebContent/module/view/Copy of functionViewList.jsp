<%@page import="com.ow.framework.listener.event.EventExecutor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<html>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<title>图片相册弹出预览特效</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
*{padding:0; margin:0}
#mbOverlay { position:fixed; z-index:9998; top:0; left:0; width:100%; height:100%; background-color:#000; cursor:pointer; }
#mbOverlay.mbOverlayFF { background:transparent url(80.png) repeat; }
#mbOverlay.mbOverlayIE { position:absolute; }
#mbCenter { height:557px; position:absolute; z-index:9999; left:50%; background-color:#fff; -moz-border-radius:10px; -webkit-border-radius:10px; -moz-box-shadow:0 10px 40px rgba(0, 0, 0, 0.70); -webkit-box-shadow:0 10px 40px rgba(0, 0, 0, 0.70); }
#mbCenter.mbLoading { background:#fff url(images/WhiteLoading.gif) no-repeat center; -moz-box-shadow:none; -webkit-box-shadow:none; }
#mbImage { left:0; top:0; font-family:Myriad, Verdana, Arial, Helvetica, sans-serif; line-height:20px; font-size:12px; color:#fff; text-align:left; background-position:center center; background-repeat:no-repeat; padding:10px; }
#mbImage a, #mbImage a:link, #mbImage a:visited { color:#ddd; }
#mbImage a:hover, #mbImage a:active { color:#fff; }
#mbBottom { min-height:20px; font-family:Myriad, Verdana, Arial, Helvetica, sans-serif; line-height:20px; font-size:12px; color:#999; text-align:left; padding:0 10px 10px; }
#mbTitle { display:inline; color:#999; font-weight:bold; line-height:20px; font-size:12px; }
#mbNumber { background:url(images/mbNumber_bg.gif) no-repeat center; display:inline; color:#C00; line-height:26px; font-size:12px; position: absolute; bottom: 10px; right: 10px; text-align: center; width:65px; height:26px; }
#mbCaption { display:block; color:#999; line-height:14px; font-size:10px; }
#mbPrevLink, #mbNextLink, #mbCloseLink { display:block; float:right; height:20px; margin:0; outline:none; }
#mbPrevLink { width:32px; height:100px; background:transparent url(images/CustomBlackPrevious.gif) no-repeat center; position: absolute; top:38%; left:-32px; }
#mbNextLink { width:32px; height:100px; background:transparent url(images/CustomBlackNext.gif) no-repeat center; position: absolute; top:38%; right:-32px; }
#mbCloseLink { width:24px; background:transparent url(images/CustomBlackClose.gif) no-repeat center; position:absolute; top:10px; right:10px; }
#mbError { position:relative; font-family:Myriad, Verdana, Arial, Helvetica, sans-serif; line-height:20px; font-size:12px; color:#fff; text-align:center; border:10px solid #700; padding:10px 10px 10px; margin:20px; -moz-border-radius:5px; -webkit-border-radius:5px; }
#mbError a, #mbError a:link, #mbError a:visited, #mbError a:hover, #mbError a:active { color:#d00; font-weight:bold; text-decoration:underline; }
.layout_default{float:left; margin:5px}
.mod_gallerylist{width:665px; margin:0 auto}
.meta{font-size:12px; text-align:center;}
.image_container img{border:1px solid #CCC; padding:2px}
.meta a{color:#333; text-decoration:none}
</style>
<script type="text/javascript" src="js/mootools-core.js"></script>
<script type="text/javascript" src="js/mediabox.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.zoomy1.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/pageToolbar2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Explorer.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.preload.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/pubuliu/wordpress.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/autoscroll.js"></script>
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
document.onreadystatechange = function () {
   if(document.readyState=="complete") {
     document.getElementById('actionForm').style.display='block';
     document.getElementById('ladingImag').style.display='none';
    } ;
}; 
$(document).ready(function() {
	
	if('${paramMap.cateSign}'!= 'expand'){
		$("#funbig2").hide();
		$("#funbig1").show();
	}else{
		$("#funbig2").show();
		$("#funbig1").hide();
	}
	
	$('#table2page').pageTB();
	$('#table3page').pageTB();		
	
	$("#funbig2 tr td").css("border","1px dotted green").css("border-collapse","collapse");
	$("#funbig2 tr:even").css({'background':'#F8F8FF'});
	$("#funbig2 tr td").last().css("border","0px dashed green").css("bottom","10px");

});
//级联更新分类信息
function selectFour(){
	var ciValue=$('#si');
	var string=$('#path').val();
	var sArray=string.split(',');
	var catePath=","+sArray[1]+","+sArray[2]+","+sArray[3]+",";
	//document.write(catePath);
	var cateLevel=4;
	//ciValue.html("");
	//ciValue.append('<option value="">请选择五级分类</option>');
	$.ajax({
		url:		'ajaxAction.action?code=003006009&paramMap.cateLevel='+cateLevel+'&paramMap.catePath='+catePath,
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){
			var cateList = new Array();
			if (textStatus == "success"){
				if (jsonData.data){
					jrinitData = jsonData.data;
					for (var i=0; i<jsonData.data.length;i++){
						var cateID = jsonData.data[i].cateID;
						var cateName = jsonData.data[i].cateName;
						var catePath = jsonData.data[i].catePath;
						var cateLevel = jsonData.data[i].cateLevel;
						ciValue.append('<option value="'+catePath+'">'+cateName+'</option>');
					}
					ciValue.append(html.join(''));  
}
			}
		}
	});
}
function selectFive(){  
	var ciValue=$('#wu');
	var catePath=$('#si').val();
	var cateLevel=5;
	ciValue.html("");
	//ciValue.append('<option value="">请选择五级分类</option>');
	$.ajax({
		url:		'ajaxAction.action?code=003006009&paramMap.cateLevel='+cateLevel+'&paramMap.catePath='+catePath,
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){
			var cateList = new Array();
			if (textStatus == "success"){
				if (jsonData.data){
					jrinitData = jsonData.data;
					for (var i=0; i<jsonData.data.length;i++){
						var cateID = jsonData.data[i].cateID;
						var cateName = jsonData.data[i].cateName;
						var catePath = jsonData.data[i].catePath;
						var cateLevel = jsonData.data[i].cateLevel;
						ciValue.append('<option value="'+catePath+'">'+cateName+'</option>');
					}
					ciValue.append('<option value="">'+"五级分类结束"+'</option>');
					ciValue.append(html.join(''));
					
}
			}
		}
	});
}  
function changeList(v){
	//根据五级分类异步请求分类内容
	var catePath;
	var cateLevel;
	//判断有没有五级分类
	if($('#wu').val()==""){
		 catePath=$('#si').val();
		 cateLevel=4;
	}else{
		 catePath=$('#wu').val();
		 cateLevel=5;
	}
	window.location.href="decorateForwardAction.action?code=-701&paramMap.path="+catePath+"&paramMap.cateLevel="+cateLevel+"&paramMap.erTotalID=2&paramMap.cateSign=exhibition&pageSize=8&type=1";
}
</script>
<script type="text/javascript">
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
</script>

<style type="text/css">
.gallery{ width:200px;height:180px;padding: 5px; border: 1px solid #000; -moz-box-shadow: 3px 3px 4px #000; 
-webkit-box-shadow: 3px 3px 4px #000; box-shadow: 3px 3px 4px #000; background: #fff; 
filter: progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#000000' ); position: relative; border: 0; }
.textp { font-weight: bold; font-size: 14px; color :white;  margin-left:5px;background-color:#000000;
position: relative;top: -35px;height: 30px;text-align: center; opacity:0.8; filter: alpha(opacity=80);}
.textp p{position:relative;top:-20px;}
.textPdown{font-weight: bold; font-size: 14px; color :white; background-color:#000000;position: relative;top: -34px;
height: 30px;text-align: center; opacity:0.8; filter: alpha(opacity=80); line-height: 30px;}
table{border-collapse: collapse;}
.rg-image-controls table tr td{font-size: 14px; border: 1px dotted #606373;line-height: 30px; table-layout: fixed; word-wrap: break-word;}
.rg-image-controls table tr td span{margin: 0 10px;cursor: pointer;}
.tr_selected{color: red;}
.onlyex img,.onlyex span{vertical-align: middle;}
</style>
</head>
<body leftmargin="0" bottommargin="0" rightmargin="0" topmargin="0" onload="selectFour();">

     
<table id='ladingImag' width="100%"><tr><td align="center" valign="middle"><img src='<%=request.getContextPath()%>/images/loadingl.gif' border='0'></td></tr></table>
                    <!--资源列表开始-->
                    <div class="page-container">
                    <div class="res-list">
                        <div class="res-list-query">
                            <label>
                                四级分类：<select id="si" name="si" onchange="selectFive();"/>
                           <option>请选择四级分类</option>
                                </select>
                            </label>
                            <label>
                                五级分类：<select id="wu" name="wu" ><option>请选择五级分类</option></select>
                            </label>
                           <lable>
                           <input type="button" value="确定" onclick="changeList();"  height="20px" width="100px"/>
                           </lable>
                        </div>
                        </div>
                         </div>
<s:if test="initMap.funcView.isEmpty()">
	<center>
 			<h3 style="color: red;margin-top:100px;  ">没有相关数据</h3>
 			<script type="text/javascript">
 				$(".table_to").hide(); 
			$("#ladingImag").hide(); 
 			</script>
  	</center>
</s:if>
<input type="hidden" id="path" name="path" value="${paramMap.catePath}" />
<input type="hidden" id="resType" value="${paramMap.cateSign}"/>
<div class="rg-image-controls" style="width:100%;background-color: #e8e8e8;position: fixed; z-index: 300; top: 0px; left: 0px;display: none;">
	<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0" id="talbe_screen" style="opacity: 0.8; margin: 0 auto; color: #333;">
	</table>
	<div class="rg-image-fo" style="text-align: right; margin-right: 20px;"><img src="images/left.png" border="0"></div>
</div>

<form name="actionForm" method="post" action="decorateForwardAction.action" id="actionForm" style="display: none;">
<s:if test="initMap.funcView.isEmpty()== false">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_to" id="funbig1" style="display: none;">
	<tr>
	<s:subset source="initMap.funcView" start="0" count="8">
		<s:iterator id="fv" status="fvindx">
			<s:if test="#fvindx.index%4 ==0">
				<tr>
					<tr height="20px">
					</tr>
			</s:if>
			<td align="center">
				<div id="boxgrid<s:property value=" #fvindx.index " />" class="gallery" style="position: relative;top:5px;">
					<div style="height:180px;background:#606373;" id="outdiv">
						<s:set name="pcode" value="''" />
						<s:set name="pname" value="''" />
						<s:set name="expurl" value="''" />
						<s:if test="#fv.resType == 'exhibition'">
							<s:set name="pcode" value="'-701003'" />
							<s:set name="pname" value="'erID'" />
							<s:set name="broomname" value="'er'" />
							<s:if test="#fv.fileType == '1011'">
								<s:set name="pcode" value="'-701001'" />
							</s:if>
							<s:if test="#fv.fileType == '1073' || #fv.fileType == '1084'">
								<s:set name="pcode" value="'-701002'" />
							</s:if>
							<s:if test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
								<s:set name="pcode" value="'-701018'" />
							</s:if>
						</s:if>
						<s:if test="#fv.resType == 'observation'">
							<s:set name="pcode" value="'-701006'" />
							<s:set name="pname" value="'orID'" />
							<s:set name="broomname" value="'or'" />
							<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
								<s:set name="pcode" value="'-701004'" />
							</s:if>
							<s:if test="#fv.fileType == '4033' ">
								<s:set name="pcode" value="'-701023'" />
							</s:if>
							<s:if test="#fv.fileType == '1073' || #fv.fileType == '1084'">
								<s:set name="pcode" value="'-701005'" />
							</s:if>
							<s:if test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
								<s:set name="pcode" value="'-701019'" />
							</s:if>
						</s:if>
						<s:if test="#fv.resType == 'laboratory'">
							<s:set name="pcode" value="'-701009'" />
							<s:set name="pname" value="'lrID'" />
							<s:set name="broomname" value="'lr'" />
							<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
								<s:set name="pcode" value="'-701007'" />
							</s:if>
							<s:if test="#fv.fileType == '1073' || #fv.fileType == '1084'">
								<s:set name="pcode" value="'-701008'" />
							</s:if>
							<s:if test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
								<s:set name="pcode" value="'-701020'" />
							</s:if>
						</s:if>
						<s:if test="#fv.resType == 'projection'">
							<s:set name="pcode" value="'-701012'" />
							<s:set name="pname" value="'prID'" />
							<s:set name="broomname" value="'pr'" />
							<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
								<s:set name="pcode" value="'-701010'" />
							</s:if>
							<s:if test="#fv.fileType == '1084'">
								<s:set name="pcode" value="'-701011'" />
							</s:if>
							<s:if test="#fv.fileType == '1073'">
								<s:set name="pcode" value="'-701024'" />
							</s:if>
							<s:if test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
								<s:set name="pcode" value="'-701021'" />
							</s:if>
						</s:if>
						<s:if test="#fv.resType == 'expand'">
							<s:set name="pcode" value="'-701013'" />
							<s:set name="pname" value="'erID'" />
							<s:set name="broomname" value="'er'" />
							<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
								<s:set name="pcode" value="'-701016'" />
							</s:if>
							<s:if test="#fv.fileType == '1073' || #fv.fileType == '1084'">
								<s:set name="pcode" value="'-701017'" />
							</s:if>
							<s:if test="#fv.fileType == '2095' ">
								<s:set name="pcode" value="'-701013'" />
							</s:if>
							<s:if test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
								<s:set name="pcode" value="'-701022'" />
							</s:if>
							<s:if test="#fv.erTaskId != null && #fv.erTaskId != ''">
								<s:set name="expurl" value="#fv.erContent" />
							</s:if>
						</s:if>
						<s:if test="#expurl == ''">
							<a onclick="window.parent.frames.showView(this)" name="${fv.name}" codeNum="${pcode}"
							param="paramMap.path=${fv.path}&path=${fv.path}&paramMap.${broomname}Type=${fv.fileType}&paramMap.${pname}=${fv.id}&paramMap.fileType=${fv.fileType}&paramMap.st=1&paramMap.temppname=${pname}&paramMap.temppid=${fv.id}&paramMap.name=${fv.name}&paramMap.roomtype=${fv.resType}">
								<img src="${fv.thumbnail}" alt="${fv.name}" style=""
								height="180px" class="image eightPic" id="imas<s:property value=" #fvindx.index
								" />" />
							</a>
						</s:if>
						<s:if test="#expurl != ''">
							<s:if test="session.s_userType == 1">
								<a href="${expurl}&code=002001004">
									<span style="color:#000000;">
										<img src="${fv.thumbnail}" alt="${fv.name}" style=""
										height="180px" class="image eightPic" id="imas<s:property value=" #fvindx.index
										" />" />
									</span>
								</a>
							</s:if>
							<s:if test="session.s_userType == 2">
								<a href="${expurl}&code=001001003">
									<span style="color:#000000;">
										<img src="${fv.thumbnail}" alt="${fv.name}" style=""
										height="180px" class="image eightPic" id="imas<s:property value=" #fvindx.index
										" />" />
									</span>
								</a>
							</s:if>
							<s:if test="session.s_userType == 3">
								<a href="${expurl}&code=3002001004">
									<span style="color:#000000;">
										<img src="${fv.thumbnail}" alt="${fv.name}" style=""
										height="180px" class="image eightPic" id="imas<s:property value=" #fvindx.index
										" />" />
									</span>
								</a>
							</s:if>
						</s:if>
						<div class="textPdown" id="textPdown${fvindx.index}">
							<!-- 如果是文物博览室带音频的资源应该与提示 -->
							<s:if test="#fv.audio!='' && #fv.audio!='null' && #fv.audio!=null">
								<img style="height:20px; position: relative; top: 7px;" src="<%=request.getContextPath()%>/images/detail/yinpin.png">
							</s:if>
							<s:if test="#fv.name.length() > 9">
								<s:property value="#fv.name.substring(0,9)" />
								...
							</s:if>
							<s:else>
								<s:property value="#fv.name" />
							</s:else>
						</div>
					</div>
			</td>
		</s:iterator>
	</s:subset>
	</tr>
	<tr height="20px">
	</tr>
	<tr>
		<td colspan="7" height="30" align="right">
			<div class="pageb" id="table2page">
				${initMap.paginated.pageContent}
			</div>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_to" id="funbig2" style="line-height: 30px;margin-top:20px;display: none;">
	<tr>
	<td height="40px" width="10%" class="onlyex" align="center">
		资源号码
	</td>
	<td width="10%" class="onlyex" align="center">
		资源类型
	</td>
	<td width="50%" class="onlyex" align="center">
		资源名称
	</td>
	<td width="15%" align="center" class="onlyex">
		资源创建日期
	</td>
	<td width="15%" class="onlyex" align="center">
		下载
	</td>
	</tr>
	<s:subset source="initMap.funcView" start="0" count="8">
		<s:iterator id="fv" status="fvindx">
			<tr>
				<s:set name="pcode" value="''" />
				<s:set name="pname" value="''" />
				<s:set name="expurl" value="''" />
				<s:set name="type" value="''" />
				<s:if test="#fv.resType == 'exhibition'">
					<s:set name="pcode" value="'-1001003'" />
					<s:set name="pname" value="'erID'" />
					<s:set name="broomname" value="'er'" />
					<s:if test="#fv.fileType == '1011'">
						<s:set name="pcode" value="'-1001001'" />
						<s:set name="type" value="'高清图片'" />
					</s:if>
				</s:if>
				<s:if test="#fv.resType == 'observation'">
					<s:set name="pcode" value="'-1001006'" />
					<s:set name="pname" value="'orID'" />
					<s:set name="broomname" value="'or'" />
					<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
						<s:set name="pcode" value="'-1001004'" />
						<s:set name="type" value="'高清图片'" />
					</s:if>
					<s:if test="#fv.fileType == '4033' ">
						<s:set name="pcode" value="'-1001021'" />
						<s:set name="type" value="'多维观察'" />
					</s:if>
					<s:if test="#fv.fileType == '1073' || #fv.fileType == '1084'">
						<s:set name="type" value="'高清视频'" />
						<s:set name="pcode" value="'-1001005'" />
					</s:if>
				</s:if>
				<s:if test="#fv.resType == 'laboratory'">
					<s:set name="pcode" value="'-1001009'" />
					<s:set name="pname" value="'lrID'" />
					<s:set name="broomname" value="'lr'" />
					<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
						<s:set name="pcode" value="'-1001007'" />
						<s:set name="type" value="'高清图片'" />
					</s:if>
					<s:if test="#fv.fileType == '1073' || #fv.fileType == '1084'">
						<s:set name="pcode" value="'-1001008'" />
						<s:set name="type" value="'高清视频'" />
					</s:if>
					<s:if test="#fv.fileType == '2002'">
						<s:set name="pcode" value="'-1001009'" />
						<s:set name="type" value="'虚拟仿真实验'" />
					</s:if>
					<s:if test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
						<s:set name="pcode" value="'-1001018'" />
						<s:set name="type" value="'文档课件'" />
					</s:if>
				</s:if>
				<s:if test="#fv.resType == 'projection'">
					<s:set name="pcode" value="'-1001012'" />
					<s:set name="pname" value="'prID'" />
					<s:set name="broomname" value="'pr'" />
					<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
						<s:set name="pcode" value="'-1001010'" />
						<s:set name="type" value="'高清图片'" />
					</s:if>
					<s:if test="#fv.fileType == '1073'">
						<s:set name="type" value="'音频'" />
						<s:set name="pcode" value="'-1001023'" />
					</s:if>
					<s:if test="#fv.fileType == '1084'">
						<s:set name="type" value="'高清视频'" />
						<s:set name="pcode" value="'-1001011'" />
					</s:if>
				</s:if>
				<s:if test="#fv.resType == 'expand'">
					<s:set name="pcode" value="'-1001013'" />
					<s:set name="pname" value="'erID'" />
					<s:set name="broomname" value="'er'" />
					<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
						<s:set name="pcode" value="'-1001014'" />
						<s:set name="type" value="'高清图片'" />
					</s:if>
					<s:if test="#fv.fileType == '1073'">
						<s:set name="type" value="'音频'" />
						<s:set name="pcode" value="'-1001024'" />
					</s:if>
					<s:if test="#fv.fileType == '1084'">
						<s:set name="type" value="'高清视频'" />
						<s:set name="pcode" value="'-1001015'" />
					</s:if>
					<s:if test="#fv.fileType == '2095' ">
						<s:set name="pcode" value="'-1001013'" />
						<s:set name="type" value="'swf文件'" />
					</s:if>
					<s:if test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
						<s:set name="type" value="'文档课件'" />
						<s:set name="pcode" value="'-1001020'" />
					</s:if>
					<s:if test="#fv.erTaskId != null && #fv.erTaskId != ''">
						<s:set name="expurl" value="#fv.erContent" />
					</s:if>
				</s:if>
				<td width="10%" class="onlyex" align="center">
					<img src="<%=request.getContextPath()%>/images/resImage/s_<s:property value="
					#fv.fileType " escape="false " />.gif" border="0" style="cursor: default;">
					<span>${fvindx.index+1}</span>
				</td>
				<td width="10%" class="onlyex" align="center">
					${type}
				</td>
				<td width="45%" class="onlyex" align="left">
					&nbsp;&nbsp;
					<a onclick="window.parent.frames.showView(this)" name="${fv.name}" codeNum="${pcode}"
						param="paramMap.path=${fv.path}&paramMap.${broomname}Type=${fv.fileType}&paramMap.${pname}=${fv.id}&paramMap.fileType=${fv.fileType}&paramMap.st=1&paramMap.temppname=${pname}&paramMap.temppid=${fv.id}&paramMap.name=${fv.name}&paramMap.roomtype=${fv.resType}">
						<span>
							<s:property value="#fv.name" />
						</span>
					</a>
				</td>
				<td width="10%" align="center" class="onlyex">
					<s:if test="#fv.createTime.length() > 9"><s:property value="#fv.createTime.substring(0,9)" /></s:if>
				</td>
				<td width="25%" class="onlyex" align="left">
					&nbsp;
					<s:if test="#fv.upload != ''">
						<a href="downloadAction.action?code=-706&paramMap.resPath=${fv.rrUpload}">
							<img src="<%=request.getContextPath()%>/images/common/101.png" border="0"
							title="资源下载">
						</a>
					</s:if>
					<s:if test="#fv.rrAudio!= '' and #fv.rrAudio!= null   and #fv.fileType == '1011'">
						<a href="downloadAction.action?code=-706&paramMap.resPath=<s:property value="
						#fv.rrAudio " />">
							<img src="<%=request.getContextPath()%>/images/common/top_laba.gif" title="音频下载"
							border="0">
						</a>
					</s:if>
				</td>
			</tr>
		</s:iterator>
	</s:subset>
	<tr height="20px">
	</tr>
	<tr>
		<td colspan="7" height="40px" align="center" bgcolor="#F8F8FF">
			<div class="pageb" id="table3page">
				${initMap.paginated.pageContent}
			</div>
		</td>
	</tr>
</table>

</s:if>
</form>	
</body>
</HTML>