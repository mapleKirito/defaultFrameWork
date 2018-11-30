<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String basePath = "http://" + request.getLocalAddr() + ":"
			+ request.getLocalPort() + request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.autocomplete.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/res/category.js"></script>
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<script type="text/javascript">
$(document).ready(function(){	

	$(".menuTabTextNavigation",parent.document).html($("<span>${pmsIndex.sys_search_resource.name}</span>"));
	
	  $('[name="paramMap.resType"]:radio')[0].checked=true;
	  $("select").val("") ;
	for(var i = 0; i < 16 ; i ++){
		$("#exhibition_" + i).show() ;
	}
	$('[name="paramMap.resType"]:radio').each(function(){
		$(this).click(function(){
			var index = 0 ;
			var resType = $(this).val() ;
		
			for(var i = 0; i < 9 ; i ++){
				$("#exhibition_" + i).hide() ;
				$("#observation_" + i).hide() ;
				$("#laboratory_" + i).hide() ;
				$("#projection_" + i).hide() ;
				$("#lovely_" + i).hide() ;
			}
			
			   if(resType == "exhibition") {
				    $("#typeV").val("er") ;
					for(var i = 0; i < 9 ; i ++){
						$("#exhibition_" + i).show() ;
					}
				} 
				if(resType == "observation") {
					 $("#typeV").val("or") ;
					for(var i = 0; i < 8 ; i ++){
						$("#observation_" + i).show() ;
					}
				}
				if(resType == "laboratory") {
					 $("#typeV").val("or") ;
					for(var i = 0; i < 5 ; i ++){
						$("#laboratory_" + i).show() ;
					}
				}
				if(resType == "projection") {
					 $("#typeV").val("pr") ;
					for(var i = 0; i < 5 ; i ++){
						$("#projection_" + i).show() ;
					}
				}
				if(resType == "lovely") {
					 $("#typeV").val("cr") ;
					for(var i = 0; i < 5 ; i ++){
						$("#lovely_" + i).show() ;
					}
				}
    		});
	});
	$("#searchButton").click(function(){
		var faction = $("#actionForm").attr("action");
		$("#actionForm").attr("action",faction);
		$("#actionForm").submit(); 
	}) ;
	
	$("#erTotalID").change(function(){
		changeTotal("er","") ;
	});	
	$("#erJieID").change(function(){
		changeJie("er","") ;
	});
	$("#erChorID").change(function(){
		changeChor("er","") ;
	});
	$("#erGangID").change(function(){
		changeGang("er","") ;
	});
	 $("#erOrderID").change(function(){ 
			changeOrder("er","") ;
		}); 
	 $("#erCategory").change(function(){
		changeCategory("er") ;
	}); 
	
	//加载资源分类
	//$.fn.zTree.init($("#treeDemo"), setting);
    $(".jie2").change(function(){
    	var sval = $(this).val() ;
    	var stxt = $(this).find("option:selected").text() ;  	
    	
    	var typeV = $("#typeV").val();
    	$("#"+typeV+"CateTwLevel").val(sval);
    	$("#"+typeV+"CateTwLevelName").val(stxt);	
    });
    
    $(".jie").change(function(){
    	var flag = $(this).attr("flag");
    	var sval = $(this).val();
    	var stxt = $(this).find("option:selected").text();

    	var typeV = $("#typeV").val();
    	if(flag>2){
    		
    	}else{
    		$("#"+typeV+"Category").val(sval) ;
    		$("#"+typeV+"CategoryName").val(stxt) ;
    	}
    	
    	   	
    	$.ajax({
    		url:		'ajaxAction.action?code=003006008&paramMap.cateID=' + sval,
    		type:	    'post',
    		timeout:	'60000',
    		data:	Array(),
    		dataType:	'json',
    		beforeSend:function(request){},//ajax执行前调用函数
    		complete:function(request,textStatus){},//ajax请求完成后调用函数
    		success:function(jsonData,textStatus){//ajax请求成功调用函数
    			if (textStatus == "success"){
    				if (jsonData.data){
   						//alert($.toJSON(jsonData.data)) ;
    					var $cobj = $(".jie"+flag); 
    					//$cobj.attr("disabled","");
    					$cobj.find("option").remove();
    					
    					$cobj.append($("<option></option>").attr("value","").text("----请选择----"));
	    				
	    				for (var i=0; i<jsonData.data.length;i++){
    						var cateID = jsonData.data[i].cateID;
    						var cateName = jsonData.data[i].cateName;
    						$cobj.append($("<option></option>").attr("value",cateID).text(cateName));
    					}	    			
    				} 
    			}
    		},
    		error:function(request,textStatus,error){}
    	});
    }); 
    //单独处理 情系家园  
    
    $("#love_jie").change(function(){
    	var sval = $(this).val();
    	var stxt = $(this).find("option:selected").text();
		$("#crResType").val(sval);
    	$.ajax({
    		url:		'ajaxAction.action?code=003006008&paramMap.cateID=' + sval,
    		type:	    'post',
    		timeout:	'60000',
    		data:	Array(),
    		dataType:	'json',
    		beforeSend:function(request){},//ajax执行前调用函数
    		complete:function(request,textStatus){},//ajax请求完成后调用函数
    		success:function(jsonData,textStatus){//ajax请求成功调用函数
    			if (textStatus == "success"){
    				if (jsonData.data){
    					
    					var $cobj = $("#love_jie2"); 
    					$cobj.find("option").remove();
    					$cobj.append($("<option></option>").attr("value","").text("----请选择----"));
	    				for (var i=0; i<jsonData.data.length;i++){
    						var cateID = jsonData.data[i].cateID;
    						var cateName = jsonData.data[i].cateName;
    						$cobj.append($("<option></option>").attr("value",cateID).text(cateName));
    					}
    				} 
    			}
    		},
    		error:function(request,textStatus,error){}
    	});
    });	
	
	
	$("#showMap").click(function(){
		if($("#erLongitude").val() == "" || $("#erLatitude").val() == "") {
			alert("经度或者纬度不能为空！") ;
		}else {
			art.dialog.data('x', $("#erLongitude").val());
			art.dialog.data('y', $("#erLatitude").val());
			art.dialog.open('<%=request.getContextPath()%>/map.html') ;
		}
	});
	
});
/***************文物博览室结束******************/
/****************下拉输入框****************/
function filter(treeId, parentNode, childNodes) {
	if (!childNodes) return null;
	if (childNodes.data){
		childNodes = childNodes.data;
	}
	return childNodes;
}
function beforeAsync(treeId, treeNode) {
	return treeNode ? treeNode.level < 10 : true;
}
/****************下拉输入框****************/

/****************操作地区输入框****************/
function findChildArea(level) {
	var parentID = 0 ;
	if(level == 1) {
		parentID = $("#erCountry").val() ;
		$("#erCountryName").val($("#erCountry").find("option:selected").text()) ;
		$("#erProvinceName").val("") ;
		$("#erCityName").val("") ;
		$("#erAreaName").val("") ;
	}else if(level == 2) {
		parentID = $("#erProvince").val() ;
		$("#erProvinceName").val($("#erProvince").find("option:selected").text()) ;
		$("#erCityName").val("") ;
		$("#erAreaName").val("") ;
	}else if(level == 3) {
		parentID = $("#erCity").val() ;
		$("#erCityName").val($("#erCity").find("option:selected").text()) ;
		$("#erAreaName").val("") ;
	}else if(level == 4) {
		parentID = $("#erArea").val() ;
		$("#erAreaName").val($("#erArea").find("option:selected").text()) ;
	}else if(level == 0) {
		parentID = 0 ;
	}
	if(level == 0) {
		$("#erProvince").empty();
		$("#erCity").empty();
		$("#erArea").empty();
		$("#erCountry").append($("<option>").text("--请选择国家--").val("")) ;
		$("#erProvince").append($("<option>").text("--请选择省份--").val("")) ;
		$("#erCity").append($("<option>").text("--请选择市区县--").val("")) ;
		$("#erArea").append($("<option>").text("--请选择出土地--").val("")) ;
		document.getElementById("erProvince").disabled = true ;
		document.getElementById("erCity").disabled = true ;
		document.getElementById("erArea").disabled = true ;
	}else if(level == 1) {
		$("#erProvince").empty();
		$("#erCity").empty();
		$("#erArea").empty();
		$("#erProvince").append($("<option>").text("--请选择省份--").val("")) ;
		$("#erCity").append($("<option>").text("--请选择市区县--").val("")) ;
		$("#erArea").append($("<option>").text("--请选择出土地--").val("")) ;
		document.getElementById("erCity").disabled = true ;
		document.getElementById("erArea").disabled = true ;
	}else if(level == 2) {
		$("#erCity").empty();
		$("#erArea").empty();
		$("#erCity").append($("<option>").text("--请选择市区县--").val("")) ;
		$("#erArea").append($("<option>").text("--请选择出土地--").val("")) ;
		document.getElementById("erArea").disabled = true ;
	}
	if(parentID!=''){
		$.ajax({
			url:		'ajaxAction.action?code=003010007&paramMap.id=' + parentID,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
				var cateList = new Array();
				if (textStatus == "success" && jsonData.data){
					if (jsonData.data.length > 0){
						jrinitData = jsonData.data;
						
						for (var i=0; i<jsonData.data.length;i++){
							var optVal = jsonData.data[i].areaID ;
							var optText = jsonData.data[i].areaName;
							if(optVal != '' && optText != '') {
								var option = $("<option>").text(optText).val(optVal) ;
								if(level == 0) {
									$("#erCountry").append(option);
								}else if(level == 1) {
									$("#erProvince").append(option);
								}else if(level == 2) {
									$("#erCity").append(option);
								}else if(level == 3) {
									$("#erArea").append(option);
								}
							}
						}
						if(level == 1) {
							document.getElementById("erProvince").disabled = false ;
							document.getElementById("erCity").disabled = true ;
							document.getElementById("erArea").disabled = true ;
						}else if(level == 2) {
							document.getElementById("erCity").disabled = false ;
							document.getElementById("erArea").disabled = true ;
						}else if(level == 3) {
							document.getElementById("erArea").disabled = false ;
						}
					}else {
						if(level == 1) {
							document.getElementById("erProvince").disabled = true ;
							document.getElementById("erCity").disabled = true ;
							document.getElementById("erArea").disabled = true ;
							$("#erProvince").append($("<option>").text("--请选择省份--").val("")) ;
							$("#erCity").append($("<option>").text("--请选择市区县--").val("")) ;
							$("#erArea").append($("<option>").text("--请选择出土地--").val("")) ;
						}else if(level == 2) {
							document.getElementById("erCity").disabled = true ;
							document.getElementById("erArea").disabled = true ;
							$("#erCity").append($("<option>").text("--请选择市区县--").val("")) ;
							$("#erArea").append($("<option>").text("--请选择出土地--").val("")) ;
						}else if(level == 3) {
							document.getElementById("erArea").disabled = true ;
							$("#erArea").append($("<option>").text("--请选择出土地--").val("")) ;
						}
					}
				}
			},
			
			error:function(request,textStatus,error){}
		});
	}else{
		$("#erProvince option[value='']").attr("selected", true);
		$("#erCity option[value='']").attr("selected", true);
		$("#erArea option[value='']").attr("selected", true);
		document.getElementById("erProvince").disabled = true ;
		document.getElementById("erCity").disabled = true ;
		document.getElementById("erArea").disabled = true ;
	}
}
/****************操作地区输入框****************/

</script>
</head>
<body>
<form name="actionForm" method="post" id="actionForm" action="decorateForwardAction.action">
<input type="hidden" name="code" value="-1601"> 
<input type="hidden" name="type" value="1"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.res_mgr.imitationStep}">
<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top: 0; width: 190px;"></ul>
</div>
<div id="menuContentArea" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeAreaDemo" class="ztree" style="margin-top: 0; width: 160px;"></ul>
</div>
<input type="hidden" name="typeV" value="" id="typeV"> 
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
				      	<tr>
							<td width="100%" bgcolor="#e8e8e8" valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源类别：</td>
										<td width="85%" class="tatd" align="left">
											<label><input type="radio" name="paramMap.resType" value="exhibition"  checked="checked">文物博览室</label>
											<label><input type="radio" name="paramMap.resType" value="observation">专题研读室</label>
											<label><input type="radio" name="paramMap.resType" value="projection">影像资料室</label>
											<label><input type="radio" name="paramMap.resType" value="laboratory">教学研究室</label>
											<label><input type="radio" name="paramMap.resType" value="lovely">情系家园</label>
										</td>
								  	</tr>
								  	<!-- 文物博览室 -->
								    <tr bgcolor="#ae9b84" style="display: none;" id="exhibition_0">
										<td width="15%" class="tatd" align="right">资源编号：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.erCode" type="text" maxlength="200" id="erCode" style="width: 200;"/>&nbsp;
										</td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="exhibition_1">
										<td width="15%" class="tatd" align="right">中文名：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.erName" type="text" maxlength="200" id="erName" style="width: 200;" />
										</td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="exhibition_2">
										<td width="15%" class="tatd" align="right">资源类型：</td>
										<td width="85%" class="tatd" align="left">
											<select name="paramMap.erType" id="erType">
												<option value="">----请选择----</option>
												<option value="1011">高清图片</option>
											</select>
										</td>
								   	</tr>
								 	<tr bgcolor="#ae9b84" id="exhibition_3">
										<td width="15%" class="tatd" align="right">资源分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.erTotal" id="erTotal" >
											<select name="paramMap.erTotalID" id="erTotalID">
													<option value="">----请选择----</option>
													<option value="160">原始社会时期</option>
													<option value="47">夏商西周时期</option>
													<option value="62">春秋战国时期</option>
													<option value="75">秦汉时期</option>
													<option value="30">三国两晋南北朝时期</option>
													<option value="96">隋唐五代时期</option>
													<option value="2">辽宋夏金元时期</option>
													<option value="116">明清时期</option>
													<option value="133">中国近现代时期</option>
													<option value="271">世界古代时期</option>
													<option value="272">世界近现代时期</option>
										
											</select>
										</td>
									</tr>
								   	<tr bgcolor="#ae9b84" id="exhibition_4">
										<td width="15%" class="tatd" align="right">二级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.erJie" id="erJie" >
											<select id="erJieID" name="paramMap.erJieID" disabled="disabled"><option value="">--请选择--</option></select>
										</td>
								   	</tr>
								   	<tr bgcolor="#ae9b84" id="exhibition_5">
										<td width="15%" class="tatd" align="right">三级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.erChor" id="erChor" >
											<select id="erChorID" name="paramMap.erChorID" disabled="disabled"><option value="">--请选择--</option></select>
										</td>
								   	</tr>
									<tr bgcolor="#ae9b84" id="exhibition_6">
										<td width="15%" class="tatd" align="right">四级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.erGang" id="erGang" >
											<select id="erGangID" name="paramMap.erGangID" disabled="disabled"><option value="">--请选择--</option></select>
										</td>
								   	</tr>
									 <tr bgcolor="#ae9b84"  id="exhibition_7">
										<td width="15%" class="tatd" align="right" id="exhibition_3">五级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.erOrder" id="erOrder">
											<select id="erOrderID" name="paramMap.erOrderID" disabled="disabled" ><option value="">--请选择--</option></select>
										</td>
								   	</tr> 
								   	<tr bgcolor="#ae9b84" id="exhibition_8">
										<td width="15%" class="tatd" align="right" id="exhibition_4">六级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.erCategoryName" id="erCategoryName">
											<select id="erCategory" name="paramMap.erCategory" disabled="disabled"><option value="">--请选择--</option></select>
										</td>
								   	</tr>
								
									
									<!-- 专题研读室 -->
									<tr bgcolor="#ae9b84" style="display: none;" id="observation_0">
										<td width="15%" class="tatd" align="right">资源编号：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.orNO" type="text" maxlength="200" id="orNO" style="width: 200;" />&nbsp;
										<font color="red"></font></td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="observation_1">
										<td width="15%" class="tatd" align="right">中文名：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.orName" type="text" maxlength="200" id="orName" style="width: 200;" />&nbsp;
										<font color="red"></font><span id="orNameTip" style="position:absolute;height:22px;width:250px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="observation_2">
										<td width="15%" class="tatd" align="right">资源类型：</td>
										<td width="85%" class="tatd" align="left">
											<select name="paramMap.orType" id="orType">
												<option value="">----请选择----</option>
												<option value="1011">高清图片</option>
												<option value="1022">3D图片</option>
												<option value="1073">音频</option>
												<option value="1084">高清视频</option>
												<option value="2041">PPT课件</option>
												<option value="2033">WORD课件</option>
												<option value="2055">PDF课件</option>
												<option value="2002">动画类课件</option>
											</select>
											&nbsp;<font color="red"></font>
										</td>
								   	</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="observation_3">
										<td width="15%" class="tatd" align="right">资源分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.orCategory" id="orCategory" maxlength="200" style="width: 200;">
											<input type="hidden" name="paramMap.orCategoryName" id="orCategoryName" maxlength="200" style="width: 200;">
											<select name="jie" flag="2" class="jie">
												<option value="">----请选择----</option>
													<option value="274">历史事件</option>
													<option value="224">政治制度史</option>
													<option value="225">经济制度史</option>
													<option value="226">思想史</option>
													<option value="227">艺术史</option>
													<option value="228">历史人物</option>
											</select>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="observation_4">
										<td width="15%" class="tatd" align="right">二级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.orCateTwLevelName" id="orCateTwLevelName" style="width: 200;">
											<select class="jie jie2"  flag="3" name="paramMap.orCateTwLevel" id="orCateTwLevel"  style="width: 100;" ><option value="">----请选择----</option></select>
										</td>
									</tr>
									
									<tr bgcolor="#ae9b84" style="display: none;" id="observation_5">
										<td width="15%" class="tatd" align="right">三级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.orCateTHLevelName" id="orCateThLevelName" style="width: 200;">
											<select class="jie jie3" flag="4" name="paramMap.orCateThLevel" id="orCateThLevel"  style="width: 100;" ><option value="">----请选择----</option></select>
										</td>
									</tr>
									
									<tr bgcolor="#ae9b84" style="display: none;" id="observation_6">
										<td width="15%" class="tatd" align="right">四级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.orCateFoLevelName" id="orCateFoLevelName" style="width: 200;">
											<select class="jie jie4"  flag="5" name="paramMap.orCateFoLevel" id="orCateFoLevel"  style="width: 100;" ><option value="">----请选择----</option></select>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="observation_7">
										<td width="15%" class="tatd" align="right">五级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.orCateFiveLevelName" id="orCateFiveLevelName" style="width: 200;">
											<select class="jie jie5" flag="6" name="paramMap.orCateFiveLevel" id="orCateFiveLevel"  style="width: 100;" ><option value="">----请选择----</option></select>
										</td>
									</tr>
									
									
									
									<!-- 影像资料室 -->
									<tr bgcolor="#ae9b84" style="display: none;" id="projection_4">
										<td width="15%" class="tatd" align="right">资源编号：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.prNO" type="text" maxlength="200" id="orNO" style="width: 200;" />&nbsp;
										<font color="red"></font></td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="projection_0">
										<td width="15%" class="tatd" align="right">影片名称：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.prName" type="text" maxlength="200" id="prName" style="width: 200;" />&nbsp;
										</td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="projection_1">
										<td width="15%" class="tatd" align="right">资源类型：</td>
										<td width="85%" class="tatd" align="left">
											<select name="paramMap.prType" id="prType">
												<option value="">----请选择----</option>
												<option value="1073">音频</option>
												<option value="1084">高清视频</option>
											</select>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="projection_2">
										<td align="right" class="tatd" width="10%">资源分类：</td>
										<td  class="tatd"> 
											<input type="hidden" name="paramMap.prCategoryName" id="prCategoryName" style="width: 200;">

											<select  name="paramMap.prCategory" id="prCategory"  class="jie" flag="2" style="width: 100;">
												<option value="">----请选择----</option>
												    <option value="215">纪录片</option>
												    <option value="216">历史剧</option>
												    <option value="214">近现代影像资料</option>
													<option value="217">科学还原</option>

											</select>
										</td>
									</tr>
									
									
									<!-- 教学研究室 -->
									
									
									<tr bgcolor="#ae9b84" style="display: none;" id="laboratory_0">
										<td width="15%" class="tatd" align="right">资源编号：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.lrNO" type="text" maxlength="200" id="lrNO" style="width: 200;"/>&nbsp;
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="laboratory_1">
										<td width="15%" class="tatd" align="right">资源名称：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.lrName" type="text" maxlength="200" id="lrName     " style="width: 200;" />&nbsp;
										</td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="laboratory_2">
										<td width="15%" class="tatd" align="right">资源类型：</td>
										<td  class="tatd"> 
											<select name="paramMap.lrType" id="lrType">
												<option value="">----请选择----</option>
												<option value="1011">高清图片</option>
												<option value="1084">高清视频</option>
												<option value="2041">PPT课件</option>
												<option value="2033">WORD课件</option>
												<option value="2055">PDF课件</option>
												<option value="2002">动画类课件</option>
											</select>
										</td>
								   	</tr>
								   	<tr bgcolor="#ae9b84" style="display: none;" id="laboratory_3">
										<td width="15%" class="tatd" align="right">资源分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.lrCategory" id="lrCategory" maxlength="200" style="width: 200;">
											<input type="hidden" name="paramMap.lrCategoryName" id="lrCategoryName" maxlength="200" style="width: 200;">
											<select name="jie" flag="2" class="jie">
												<option value="">----请选择----</option>
												 <option value="221">课件参考</option>
												 <option value="564">微课程</option>
												 <option value="222">公开课</option>
											</select>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="laboratory_4">
										<td width="15%" class="tatd" align="right">二级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" style="width: 200;">
											<input type="hidden" name="paramMap.lrCateTwLevelName" id="lrCateTwLevelName" style="width: 200;">
											<select class="jie2"  name="paramMap.lrCateTwLevel" id="lrCateTwLevel"   style="width: 100;" ><option value="">----请选择----</option></select>
										</td>
									</tr>
			
									<!-- 情系家园 -->
									<tr bgcolor="#ae9b84" style="display: none;" id="lovely_0">
										<td width="15%" class="tatd" align="right">资源编号：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.crNO" type="text" maxlength="200" id="crNO" style="width: 200;"/>&nbsp;
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="lovely_1">
										<td width="15%" class="tatd" align="right">资源名称：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.crName" type="text" maxlength="200" id="crName" style="width: 200;" />&nbsp;
										</td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="lovely_2">
										<td width="15%" class="tatd" align="right">资源类型：</td>
										<td  class="tatd"> 
											<select name="paramMap.crType" id="crType">
												<option value="">----请选择----</option>
												<option value="1011">高清图片</option>
												<option value="1084">高清视频</option>
												<option value="2041">PPT课件</option>
												<option value="2033">WORD课件</option>
												<option value="2055">PDF课件</option>
												<option value="2002">动画类课件</option>
											</select>
										</td>
								   	</tr>
								   	<tr bgcolor="#ae9b84" style="display: none;" id="lovely_3">
										<td width="15%" class="tatd" align="right">资源分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.crResType" id="crResType" maxlength="200" style="width: 200;">
											<input type="hidden" name="paramMap.crResTypeName" id="crResTypeName" maxlength="200" style="width: 200;">
											<select name="jie" id="love_jie">
												<option value="">----请选择----</option>
												 <option value="260">家乡探秘</option>
												 <option value="265">校园追风</option>
											</select>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" style="display: none;" id="lovely_4">
										<td width="15%" class="tatd" align="right">二级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.crCateTwLevelName" id="crCateTwLevelName" style="width: 200;">
											<select id="love_jie2" name="paramMap.crCateTwLevel"  id="crCateTwLevel"  style="width: 100;" ><option value="">----请选择----</option></select>
										</td>
									</tr>
			
				
								</table>
								
							 </td>
				      	</tr>
				      	<tr bgcolor="#ae9b84" align="center">
							<td ><input type="button" name="BtnOk" value="查询" id="searchButton" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />
						</tr>
					</table>
			  	</td>
			</tr>
		</table>
	</td>
  </tr>
</table>
</form>
</body>
</html>