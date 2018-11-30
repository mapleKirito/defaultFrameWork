<!DOCTYPE html>
<%@page import="com.ow.framework.listener.event.EventExecutor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>

<html>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">	
<script src="<%=request.getContextPath()%>/js/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/autoscroll.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	if(IEversion()<= 8){
		$("#si").css({
			"height":"30px",
		    "line-height":"30px",
		    "padding":"5px 0"
		});
		$("#wu").css({
			"height":"30px",
		    "line-height":"30px",
		    "padding":"5px 0"
		});
		$("#liu").css({
			"height":"30px",
		    "line-height":"30px",
		    "padding":"5px 0"
		});
		$("#qi").css({
			"height":"30px",
		    "line-height":"30px",
		    "padding":"5px 0"
		});
			}else if(IEversion()== 9 ){}
			
	    selectFour();
	    //selectFive();
	    //selectSix();
		if ('${paramMap.cateSign}' != 'expand') {
			$("#funbig2").hide();
			$("#funbig1").show();
		} else {
			$("#funbig2").show();
			$("#funbig1").hide();
		}

		$('#table2page').pageTB();
		$('#table3page').pageTB();

		//（翻页/回显）获取页面两种展示方式效果 之一    1：imageflow展示     2：块状缩略图展示

		var type = '${paramMap.changeType}';
		if(type=='1'){ 
			$(".table_to").eq(type).show().siblings().hide();
		}
		if(type=='0'){ 
			 $(".table_to").eq(type).show().siblings().hide();
		}
				
});
	//级联更新分类信息
	function selectFour() {
		var ciValue = $('#si');
		var string = $('#path').val();
		var sArray = string.split(',');
		var catePath;
		//alert(sArray[4]);
		/* if(sArray[4]==""){
			  catePath = "," + sArray[1] + "," + sArray[2] + "," + sArray[3]
				+ ",";
		}else{ */
	      catePath = "," + sArray[1] + "," + sArray[2] + "," + sArray[3]
				+ ","+ sArray[4]+ ",";
	      currentPath="," + sArray[1] + "," + sArray[2] + "," + sArray[3]
			+ ","+ sArray[4]+ ","+ sArray[5]+ ",";
	      //alert(catePath);
	     // alert(currentPath);
		var cateLevel = 4;
		$.ajax({
			url : 'ajaxAction.action?code=003006009&paramMap.cateLevel='
					+ cateLevel + '&paramMap.catePath=' + catePath,
			type : 'post',
			timeout : '60000',
			data : Array(),
			dataType : 'json',
			beforeSend : function(request) {
			},
			complete : function(request, textStatus) {
			},
			success : function(jsonData, textStatus) {
				var cateList = new Array();
				if (textStatus == "success") {
					if (jsonData.data) {
						jrinitData = jsonData.data;
						if(jsonData.data.length<=0){
							 $("#si").prop("disabled", true);
							 $("#si").find("option").html("没有三级分类");
							 $("#wu").prop("disabled", true);

							 $("#wu").find("option").html("没有四级分类");
							 $("#liu").prop("disabled", true);

							 $("#liu").find("option").html("没有五级分类");
							 $("#qi").prop("disabled", true);

							 $("#qi").find("option").html("没有六级分类");

							 //alert(1);
							 //$ ("#changeButton:hover").css({"background-color":"#AE9B84"});
							 $("#changeButton").prop("disabled", true);
						}
						
						for (var i = 0; i < jsonData.data.length; i++) {
							var cateID = jsonData.data[i].cateID;
							var cateName = jsonData.data[i].cateName;
							var catePath = jsonData.data[i].catePath;
							var cateLevel = jsonData.data[i].cateLevel;
							if(catePath==currentPath){
								ciValue.append('<option value="'+catePath+'" selected = "selected" >'
										+ cateName + '</option>');
								selectFive();
							}else{
								ciValue.append('<option value="'+catePath+'">'
										+ cateName + '</option>');
							}
							
							
						}
					}
				}
			}
		});
		
	}
	function selectFive() {
		var ciValue = $('#wu');
		var catePath = $('#si').val();
		var cateLevel = 5;
		ciValue.html("");
		var string = $('#path').val();
		var sArray = string.split(',');
		 currentPath="," + sArray[1] + "," + sArray[2] + "," + sArray[3]
			+ ","+ sArray[4]+ ","+ sArray[5]+ ","+ sArray[6]+ ",";
		// alert(currentPath);
			//ciValue.append('<option value="">请选择五级分类</option>');
		$.ajax({
			url : 'ajaxAction.action?code=003006009&paramMap.cateLevel='
					+ cateLevel + '&paramMap.catePath=' + catePath,
			type : 'post',
			timeout : '60000',
			data : Array(),
			dataType : 'json',
			beforeSend : function(request) {
			},
			complete : function(request, textStatus) {
			},
			success : function(jsonData, textStatus) {
				var cateList = new Array();
				if (textStatus == "success") {
					if (jsonData.data) {
						jrinitData = jsonData.data;
						if(jsonData.data.length<=0){
							 $("#wu").prop("disabled", true);	
							 ciValue.append('<option value="">' + "没有四级分类"
										+ '</option>');
							 $("#liu").prop("disabled", true);

							 $("#liu").find("option").html("没有五级分类");
							 $("#qi").prop("disabled", true);

							 $("#qi").find("option").html("没有六级分类");
						}else{
							 $("#wu").prop("disabled", false);
							ciValue.append('<option value="all">全部</option>');
						}
						for (var i = 0; i < jsonData.data.length; i++) {
							var cateID = jsonData.data[i].cateID;
							var cateName = jsonData.data[i].cateName;
							var catePath = jsonData.data[i].catePath;
							var cateLevel = jsonData.data[i].cateLevel;
							if(catePath==currentPath){
								ciValue.append('<option value="'+catePath+'" selected = "selected" >'
										+ cateName + '</option>');
								selectSix();
							}else{
								ciValue.append('<option value="'+catePath+'">'
										+ cateName + '</option>');
							}
						}
						

					}
				}
			}
		});
	}
	function selectSix() {
		$('#liuLabel').show();
		var ciValue = $('#liu');
		var catePath = $('#wu').val();
		var cateLevel = 6;
		ciValue.html("");
		var string = $('#path').val();
		var sArray = string.split(',');
		 currentPath="," + sArray[1] + "," + sArray[2] + "," + sArray[3]
			+ ","+ sArray[4]+ ","+ sArray[5]+ ","+ sArray[6]+ ","+ sArray[7]+ ",";
		 //alert(currentPath);
			//ciValue.append('<option value="">请选择五级分类</option>');
		$.ajax({
			url : 'ajaxAction.action?code=003006009&paramMap.cateLevel='
					+ cateLevel + '&paramMap.catePath=' + catePath,
			type : 'post',
			timeout : '60000',
			data : Array(),
			dataType : 'json',
			beforeSend : function(request) {
			},
			complete : function(request, textStatus) {
			},
			success : function(jsonData, textStatus) {
				var cateList = new Array();
				if (textStatus == "success") {
					if (jsonData.data) {
						jrinitData = jsonData.data;
						if(jsonData.data.length<=0){
							 $("#liu").prop("disabled", true);	
							 ciValue.append('<option value="">' + "没有五级分类"
										+ '</option>');
							 $("#qi").prop("disabled", true);

							 $("#qi").find("option").html("没有六级分类");
						}else{
							 $("#liu").prop("disabled", false);
							ciValue.append('<option value="all">全部</option>');
						}
						for (var i = 0; i < jsonData.data.length; i++) {
							var cateID = jsonData.data[i].cateID;
							var cateName = jsonData.data[i].cateName;
							var catePath = jsonData.data[i].catePath;
							var cateLevel = jsonData.data[i].cateLevel;
							if(catePath==currentPath){
								ciValue.append('<option value="'+catePath+'" selected = "selected" >'
										+ cateName + '</option>');
								selectSeven();
							}else{
								ciValue.append('<option value="'+catePath+'">'
										+ cateName + '</option>');
							}
						}
						

					}
				}
			}
		});
	}
	function selectSeven() {
		$('#qiLabel').show();
		var ciValue = $('#qi');
		var catePath = $('#liu').val();
		var cateLevel = 7;
		ciValue.html("");
		var string = $('#path').val();
		var sArray = string.split(',');
		 currentPath="," + sArray[1] + "," + sArray[2] + "," + sArray[3]
			+ ","+ sArray[4]+ ","+ sArray[5]+ ","+ sArray[6]+ ","+ sArray[7]+ ","+ sArray[8]+ ",";
		 //alert(currentPath);
			//ciValue.append('<option value="">请选择五级分类</option>');
		$.ajax({
			url : 'ajaxAction.action?code=003006009&paramMap.cateLevel='
					+ cateLevel + '&paramMap.catePath=' + catePath,
			type : 'post',
			timeout : '60000',
			data : Array(),
			dataType : 'json',
			beforeSend : function(request) {
			},
			complete : function(request, textStatus) {
			},
			success : function(jsonData, textStatus) {
				var cateList = new Array();
				if (textStatus == "success") {
					if (jsonData.data) {
						jrinitData = jsonData.data;
						if(jsonData.data.length<=0){
							 $("#qi").prop("disabled", true);	
							 ciValue.append('<option value="">' + "没有六级分类"
										+ '</option>');
						}else{
							 $("#qi").prop("disabled", false);
							ciValue.append('<option value="all">全部</option>');
						}
						for (var i = 0; i < jsonData.data.length; i++) {
							var cateID = jsonData.data[i].cateID;
							var cateName = jsonData.data[i].cateName;
							var catePath = jsonData.data[i].catePath;
							var cateLevel = jsonData.data[i].cateLevel;
							if(catePath==currentPath){
								ciValue.append('<option value="'+catePath+'" selected = "selected" >'
										+ cateName + '</option>');
							}else{
								ciValue.append('<option value="'+catePath+'">'
										+ cateName + '</option>');
							}
						}
						

					}
				}
			}
		});
	}
	function changeList(v) {
		//根据五级分类异步请求分类内容
		if($('#wu').val() =="null" &&$('#si').val() == "null"&&$('#liu').val() == "null"&&$('#qi').val() == "null"){
			
		}else {
		var path = "";
		//判断有没有五级分类
		if ($('#wu').val() == ""||$('#wu').val() == "all") {
			path = $('#si').val();
		} else {
			path = $('#wu').val();
			//判断有没有六级分类
			if ($('#liu').val() == ""||$('#liu').val() == "all") {
				path = $('#wu').val();
			} else {
				path = $('#liu').val();
				//判断有没有七级分类
				if ($('#qi').val() == ""||$('#qi').val() == "all") {
					path = $('#liu').val();
				} else {
					path = $('#qi').val();
				}
			}
		}
		
	
		
		var cateSign = $("#cateSign").val();
		var paramPath =path.split(',');
		var param = "&path="+path + "&pageSize=8&type=1";
		var path_length = paramPath.length;
		if (cateSign == 'exhibition'){
			 if (  path_length == 5){//第一级
				
				param += "&paramMap.erTotalID=" + paramPath[3];
			}
			else if (path_length == 6){
				param += "&paramMap.erJieID=" + paramPath[4];
			}
			else if (path_length == 7){
				param += "&paramMap.erChorID=" + paramPath[5];
			}
			else if (path_length == 8){
				param += "&paramMap.erGangID=" + paramPath[6];
			}
			else if (path_length == 9){
				param += "&paramMap.erOrderID=" + paramPath[7];
			}
			else if (path_length == 10){
				param += "&paramMap.erCategory=" + paramPath[8];
			}
		}
		else if (cateSign == 'observation'){
			if (path_length == 5){
				param += "&paramMap.orCategory=" + paramPath[3];
			}
			else if (path_length == 6){
				param += "&paramMap.orCateTwLevel=" + paramPath[4];
			}
			else if (path_length == 7){
				param += "&paramMap.orCateTHLevel=" + paramPath[5];
			}
			else if (path_length == 8){
				param += "&paramMap.orCateFoLevel=" + paramPath[6];
			}
		}
		else if (cateSign == 'laboratory'){
			if (path_length == 5){
				param += "&paramMap.lrCategory=" + paramPath[3];
			}
			else if (path_length == 6){
				param += "&paramMap.lrCateTwLevel=" + paramPath[4];
			}
		}
		else if (cateSign == 'projection'){
			if (path_length == 5){
				param += "&paramMap.path="+path+"&paramMap.prCategory=" + paramPath[3];
			}
			else if (path_length == 6){
				param += "&paramMap.prCateTwLevel=" + paramPath[4];
			}
		}
		else if (cateSign == 'lovely'){
			if (path_length == 5){
				param += "&paramMap.path="+path+"&paramMap.crResType=" + paramPath[3];
			}
			else if (path_length == 6){
				param += "&paramMap.crCateTwLevel=" + paramPath[4];
			}
		}		
		//alert(param);
		window.location.href = "decorateForwardAction.action?code=-701"+param+"&pageSize=8&type=1";
		}
	}
	
function tab_click(flag) {
		if (flag == 0) {
			$("#funbig1").hide();
			$("#funbig2").show();
			$("#changeType").val(1);
		}else if (flag == 1) {
			$("#funbig1").show();
			$("#funbig2").hide();
			$("#changeType").val(0);
		}

}
function clickLike(this_){
	$.tipsBox({
		obj: $(this_),
		str: "赞+1",
           callback: function() {
           }
	});
	var roomtype = $(this_).attr("roomtype");
	var resid = $(this_).attr("resid");
	 $.ajax({
		url:		'ajaxAction.action?code=-701025&paramMap.roomtype='+roomtype+'&paramMap.id='+resid+'&suiji='+new Date().getTime(),
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){
			if (textStatus == "success"){
				//点赞  +1
				if (jsonData.data.length > 0) {
					
					for (var i = 0; i < jsonData.data.length; i++) {
						var likeCount = "";
						if(jsonData.data[i].count>999){
							likeCount = "999+";
						}else{
							likeCount = jsonData.data[i].count;
						}
						$(this_).find("label").html(likeCount);
					}
				}
			}
		},
		error:function(request,textStatus,error){}
	}); 
}
function qcode(code,name){
	var curWwwPath=window.document.location.href; 
	var pathName=window.document.location.pathname; 
	var pos=curWwwPath.indexOf(pathName); 
	var localhostPaht=curWwwPath.substring(0,pos); 
	var st=localhostPaht+"/dm/show_page?id="+code+"&pageName=scanner";
	art.dialog.data('str', st);
	art.dialog.data('code', code);
	art.dialog.data('contextPath', '<%=request.getContextPath()%>');
	art.dialog.open('<%=request.getContextPath()%>/qrcode.jsp',{width:266,height:304,title:name+'-二维码扫描',lock:'true',background:'#666666',opacity: '0.15'}) ;
}
function IEversion(){
	var browser=navigator.appName; 
	var b_version=navigator.appVersion;
	var version=b_version.split(";");
	if (version.length<2){
        return "";
	}else{
	var trim_Version=version[1].replace(/[ ]/g,""); 
	if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0") 
	{ 
		return "6.0";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0") 
	{ 
		return "7.0";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0") 
	{ 
		return "8.0";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0") 
	{ 
		return "9.0";
	}
	}
}
</script>

<style type="text/css">

</style>
</head>
<body leftmargin="0" bottommargin="0" rightmargin="0" topmargin="0" >
<input type="hidden" id="changeType" value="${paramMap.changeType }">
<input type="hidden" id="cateSign" value="${paramMap.cateSign }">

	<div id="layout_mainbody">
		<!--资源列表开始-->
		<div class="page-container">
			<div class="res-list">
				<div class="res-list-query">
					<label>三级分类：<select id="si" name="si"	onchange="selectFive();">
						<option value="null">请选择三级分类</option> </select>
					</label> <label> 四级分类：<select id="wu" name="wu" onchange="selectSix();"><option value="null">请选择四级分类</option></select>
					</label>
					<label id="liuLabel"style="display:none">五级分类：<select id="liu" name="liu"	onchange="selectSeven();">
						<option value="null">请选择五级分类</option> </select>
					</label> <label id="qiLabel" style="display:none"> 六级分类：<select id="qi" name="qi"><option value="null">请选择六级分类</option></select>
					</label>
					<lable> <input id="changeButton" type="button" value="确定"
						name="changeButton" onclick="changeList();" height="20px" width="100px" /> </lable>
					<span class="list-type">
					<a  onclick="tab_click(0)" href="javascript:void(0)"
						class="list-type-list"></a>
					 <a onclick="tab_click(1)"
						href="javascript:void(0)" class="list-type-grid"></a> 
					</span>
				</div>
			</div>

			<s:if test="initMap.funcView.isEmpty()">
				<center>
					<h3 style="color: red; margin-top: 100px;">没有相关数据</h3>
					<script type="text/javascript">
						$(".table_to").hide();
						$("#ladingImag").hide();
					</script>
				</center>
			</s:if>
			<input type="hidden" id="path" name="path"
				value="${paramMap.catePath}" /> <input type="hidden" id="resType"
				value="${paramMap.cateSign}" />
			<div class="rg-image-controls"
				style="width: 100%; background-color: #e8e8e8; position: fixed; z-index: 300; top: 0px; left: 0px; display: none;">
				<table border="0" width="100%" height="100%" cellspacing="0"
					cellpadding="0" id="talbe_screen"
					style="opacity: 0.8; margin: 0 auto; color: #333;">
				</table>
				<div class="rg-image-fo"
					style="text-align: right; margin-right: 20px;">
					<img src="images/left.png" border="0">
				</div>
			</div>
			<form name="actionForm" method="post"
				action="decorateForwardAction.action" id="actionForm"
				>
				<s:if test="initMap.funcView.isEmpty()== false">

					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="table_to res_info" id="funbig1" style="display: none;">
						<tr>
							<s:iterator value="initMap.funcView" id="fv" status="fvindx">
								<s:if test="#fvindx.index%4 ==0">
									<tr>
									<tr height="20px">
									</tr>
								</s:if>
								<td align="center">
									<div id="boxgrid<s:property value=" #fvindx.index " />" class="gallery" style="position: relative; top: 5px;">
										<div style="height: 180px; background: #e8ddd0;" id="outdiv">
											<s:set name="pcode" value="''" />
											<s:set name="pname" value="''" />
											<s:set name="expurl" value="''" />
											<s:if test="#fv.resType == 'exhibition'">
												<s:set name="pcode" value="'-701003'" />
												<s:set name="pname" value="'erID'" />
												<s:set name="broomname" value="'er'" />
												<s:if test="#fv.fileType == '1011'||#fv.fileType == '1073'">
													<s:set name="pcode" value="'-701001'" />
												</s:if>
												<s:if
													test="#fv.fileType == '1084'">
													<s:set name="pcode" value="'-701002'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
													<s:set name="pcode" value="'-701018'" />
												</s:if>
											</s:if>
											<s:if test="#fv.resType == 'observation'">
												<s:set name="pcode" value="'-701006'" />
												<s:set name="pname" value="'orID'" />
												<s:set name="broomname" value="'or'" />
												<s:if
													test="#fv.fileType == '1011' || #fv.fileType == '1022'||#fv.fileType == '1073'||#fv.fileType == '4033' ">
													<s:set name="pcode" value="'-701004'" />
												</s:if>
												<s:if test="#fv.fileType == '4033' ">
													<s:set name="pcode" value="'-701004'" />
												</s:if>
												<s:if
													test="#fv.fileType == '1084'">
													<s:set name="pcode" value="'-701005'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2041' || #fv.fileType == '2033'">
													<s:set name="pcode" value="'-701019'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2055'">
													<s:set name="pcode" value="'-701004'" />
												</s:if>
											</s:if>
											<s:if test="#fv.resType == 'laboratory'">
												<s:set name="pcode" value="'-701009'" />
												<s:set name="pname" value="'lrID'" />
												<s:set name="broomname" value="'lr'" />
												<s:if
													test="#fv.fileType == '1011' || #fv.fileType == '1022'||#fv.fileType == '1073'||#fv.fileType == '4033'">
													<s:set name="pcode" value="'-701007'" />
												</s:if>
												<s:if
													test="#fv.fileType == '1084'">
													<s:set name="pcode" value="'-701008'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2041' || #fv.fileType == '2033'">
													<s:set name="pcode" value="'-701020'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2055'">
													<s:set name="pcode" value="'-701007'" />
												</s:if>
											</s:if>
											<s:if test="#fv.resType == 'projection'">
												<s:set name="pcode" value="'-701012'" />
												<s:set name="pname" value="'prID'" />
												<s:set name="broomname" value="'pr'" />
												<s:if
													test="#fv.fileType == '1011' || #fv.fileType == '1022'">
													<s:set name="pcode" value="'-701010'" />
												</s:if>
												<s:if test="#fv.fileType == '1084'">
													<s:set name="pcode" value="'-701011'" />
												</s:if>
												<s:if test="#fv.fileType == '1073'">
													<s:set name="pcode" value="'-701024'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
													<s:set name="pcode" value="'-701021'" />
												</s:if>
											</s:if>
											<s:if test="#fv.resType == 'lovely'">
												<s:set name="pcode" value="'-701013'" />
												<s:set name="pname" value="'crID'" />
												<s:set name="broomname" value="'cr'" />
												<s:if
													test="#fv.fileType == '1011' || #fv.fileType == '1022'||#fv.fileType == '1073'||#fv.fileType == '4033'">
													<s:set name="pcode" value="'-701016'" />
												</s:if>
												<s:if
													test="#fv.fileType == '1084'">
													<s:set name="pcode" value="'-701017'" />
												</s:if>
												<s:if test="#fv.fileType == '2095' ">
													<s:set name="pcode" value="'-701013'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2041' || #fv.fileType == '2033'">
													<s:set name="pcode" value="'-701022'" />
												</s:if>
												<s:if
													test="#fv.fileType == '2055'">
													<s:set name="pcode" value="'-701016'" />
												</s:if>
											</s:if>
											<s:if test="#expurl == ''">
												<a href="javascript:void(0)" code="${pcode}" onclick="window.parent.showView(this)"	param="&path=${fv.path}&paramMap.${broomname}Type=${fv.fileType}&paramMap.${pname}=${fv.id}&paramMap.fileType=${fv.fileType}&paramMap.st=1&paramMap.temppname=${pname}&paramMap.temppid=${fv.id}&paramMap.name=${fv.name}&paramMap.roomtype=${fv.resType}">
													<img src="${fv.thumbnail}" title="${fv.name}" alt="${fv.name}"	style="" height="180px" class="image eightPic"
													id="imas<s:property value=" #fvindx.index" />" />
												</a>
											</s:if>
											<s:if test="#expurl != ''">
												<s:if test="session.s_userType == 1">
													<a href="${expurl}&code=002001004"> <span
														style="color: #000000;"> <img src="${fv.thumbnail}" title="${fv.name}"
															alt="${fv.name}" style="" height="180px"
															class="image eightPic"
															id="imas<s:property value=" #fvindx.index
										" />" />
													</span>
													</a>
												</s:if>
												<s:if test="session.s_userType == 2">
													<a href="${expurl}&code=001001003"> <span
														style="color: #000000;"> <img src="${fv.thumbnail}" title="${fv.name}"
															alt="${fv.name}" style="" height="180px"
															class="image eightPic"
															id="imas<s:property value=" #fvindx.index
										" />" />
													</span>
													</a>
												</s:if>
												<s:if test="session.s_userType == 3">
													<a href="${expurl}&code=3002001004"> <span
														style="color: #000000;"> <img src="${fv.thumbnail}" title="${fv.name}"
															alt="${fv.name}" style="" height="180px"
															class="image eightPic"
															id="imas<s:property value=" #fvindx.index
										" />" />
													</span>
													</a>
												</s:if>
											</s:if>
											<div class="textPdown title" id="textPdown${fvindx.index}">
												<span> <a href="javascript:void(0)"
													style="color: white;"> <s:if
															test="#fv.name.length() > 9">
															<s:property value="#fv.name.substring(0,9)" />
								...
							</s:if> <s:else>
															<s:property value="#fv.name" />
														</s:else>
												</a>
												</span>
												<!-- 如果是文物博览室带音频的资源应该与提示 -->

												<p>
													<a href="javascript:void(0)" onclick="qcode('${fv.code}','${fv.name}');" style="background: url(images/icon-spriter.png) no-repeat;left: 65px;background-position: 2px -950px;" class="icon-qrcode"></a>
													<!-- //收藏 -->
													<s:if test="#fv.audio!=''&&#fv.audio!=null">
													<a href="javascript:void(0)" style=" background:url(images/media-types.png) no-repeat;background-position: 0px 0px;left: 125px;" class="icon-love"></a>
													</s:if>
												</p>

											</div>
													<em class="res-type" roomtype="${fv.resType}" resid="${fv.id }" onclick="clickLike(this)"><i style="background: url(images/icon-spriter.png) no-repeat;background-position: -77px -947px;" class="res-type-media"></i><label>${fv.countLike }</label></em>
											</div>
								</td>
							</s:iterator>
						</tr>
						<tr height="20px">
						</tr>
						<tr>
							<td colspan="7" height="30" align="right">
								<div class="pageb" id="table2page">
									${initMap.paginated.pageContent}</div>
							</td>
						</tr>
					</table>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="table_to table_list" id="funbig2"
						style="line-height: 30px; margin-top: 20px; display: none;">

						<thead>
							<tr>
								<th style="text-align: center;">序号</th>
								<th style="text-align: center;">资源类型</th>
								<th style="text-align: center;">中文名</th>
								<th style="text-align: center;">创建时间</th>
								<th style="text-align: center;">操作</th>
							</tr>
						</thead>
						<s:iterator value="initMap.funcView" id="fv" status="fvindx">

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
								<s:if test="#fv.fileType == '1084'">
									<s:set name="type" value="'高清视频'" />
									<s:set name="pcode" value="'-1001005'" />
								</s:if>
								<s:if test="#fv.fileType == '1073' ">
									<s:set name="pcode" value="'-1001004'" />
									<s:set name="type" value="'音频'" />
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
								<s:if test="#fv.fileType == '1084'">
									<s:set name="pcode" value="'-1001008'" />
									<s:set name="type" value="'高清视频'" />
								</s:if>
								<s:if test="#fv.fileType == '1073'">
									<s:set name="pcode" value="'-1001007'" />
									<s:set name="type" value="'音频'" />
								</s:if>
								<s:if test="#fv.fileType == '2002'">
									<s:set name="pcode" value="'-1001009'" />
									<s:set name="type" value="'虚拟仿真实验'" />
								</s:if>
								<s:if
									test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
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
							<s:if test="#fv.resType == 'lovely'">
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
								<s:if
									test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
									<s:set name="type" value="'文档课件'" />
									<s:set name="pcode" value="'-1001020'" />
								</s:if>
								<s:if test="#fv.erTaskId != null && #fv.erTaskId != ''">
									<s:set name="expurl" value="#fv.erContent" />
								</s:if>
							</s:if>
							<tr>
								<td width="10%" class="onlyex" align="center"><img
									src="<%=request.getContextPath()%>/images/resImage/s_<s:property value="
					#fv.fileType " escape="false " />.gif"
									border="0" style="cursor: default;"> <span>${fvindx.index+1}</span>
								</td>
								<td width="10%" class="onlyex" align="center">${type}</td>
								<td width="45%" class="onlyex" align="left">&nbsp;&nbsp;
								 <a code="${pcode}" onclick="window.parent.showView(this)" href="javascript:void(0)"
									param="&paramMap.path=${fv.path}&paramMap.${broomname}Type=${fv.fileType}&paramMap.${pname}=${fv.id}&paramMap.fileType=${fv.fileType}&paramMap.st=1&paramMap.temppname=${pname}&paramMap.temppid=${fv.id}&paramMap.name=${fv.name}&paramMap.roomtype=${fv.resType}">
										<span> <s:property value="#fv.name" />
									</span>
								</a>
								</td>
								<td width="10%" align="center" class="onlyex">
										<s:property value="#fv.createTime.substring(0,10)" />
									</td>
								<td width="25%" class="onlyex" align="left">&nbsp; <s:if
										test="#fv.upload != ''">
										<a class="lt-button fade-button"
											 href="javascript:void(0)" code="${pcode}"
													onclick="window.parent.showView(this)"
													param="&paramMap.path=${fv.path}&paramMap.${broomname}Type=${fv.fileType}&paramMap.${pname}=${fv.id}&paramMap.fileType=${fv.fileType}&paramMap.st=1&paramMap.temppname=${pname}&paramMap.temppid=${fv.id}&paramMap.name=${fv.name}&paramMap.roomtype=${fv.resType}">
													
											预览 </a>
										<a class="lt-button fade-button"
											href="downloadAction.action?code=-706&paramMap.resDownRoom=${fv.resType}&paramMap.resDownType=${fv.fileType}&paramMap.resPath=${fv.upload}">
											资源下载 </a>
									</s:if>
								</td>
							</tr>

						</s:iterator>
						<tfoot>
							<tr>
								<td colspan="5" align="right">
									<div class="pageb" id="table3page">
										${initMap.paginated.pageContent}</div>
								</td>
							</tr>
						</tfoot>
					</table>

				</s:if>
			</form>
		</div>
	</div>
	<script src="js/tweenmax.min.js"></script>
	<script src="js/scripts.js"></script>
		<!-- 点赞初始化 -->
<script>
    ;(function($) {
        $.extend({
            tipsBox: function(options) {
                options = $.extend({
                    obj: null,  //jq对象，要在那个html标签上显示
                    str: "+1",  //字符串，要显示的内容;也可以传一段html，如: "<b style='font-family:Microsoft YaHei;'>+1</b>"
                    startSize: "12px",  //动画开始的文字大小
                    endSize: "30px",    //动画结束的文字大小
                    interval: 600,  //动画时间间隔
                    color: "#ca4f4f",    //文字颜色
                    callback: function() {}    //回调函数
                }, options);
                $("body").append("<span class='num'>"+ options.str +"</span>");
                var box = $(".num");
                var left = options.obj.offset().left + options.obj.width() / 2;
                var top = options.obj.offset().top - options.obj.height();
                box.css({
                    "position": "absolute",
                    "left": left + "px",
                    "top": top + "px",
                    "z-index": 9999,
                    "font-size": options.startSize,
                    "line-height": options.endSize,
                    "color": options.color
                });
                box.animate({
                    "font-size": options.endSize,
                    "opacity": "0",
                    "top": top - parseInt(options.endSize) + "px"
                }, options.interval , function() {
                    box.remove();
                    options.callback();
                });
            }
        });
    })(jQuery);
</script>
</body>
</HTML>