<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/progressBar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dataUtils.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/progressBar.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bodyfocus.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />


<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<script type="text/javascript">
$(document).ready(function(){	
	
	$(".uploadDiv").css("left",$("#uploadShowDiv").offset().left + 8);
    $(".uploadDiv").css("top",$("#uploadShowDiv").offset().top + 7);
	
	//input验证
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){},onsuccess:function(){}});//表单提交 //表单提交 
	$("#prName").formValidator({onshow:"请输入影片名称",onfocus:"请输入影片名称",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("影片名称不能为空,请确认");}});
	$("#prCategory").formValidator({onshow:"请选择资源分类",onfocus:"请选择资源分类",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源分类不能为空,请确认");}});
	$("#prType").formValidator({onshow:"请选择资源类型",onfocus:"请选择资源类型",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源类型不能为空,请确认");}});
	$("#prUpload").formValidator({onshow:"请上传资源文件",onfocus:"请上传资源文件",oncorrect:"上传正确"}).inputValidator({min:1,onerror:function(){alert("资源不能为空,请确认");}});
	$("#isUpload").formValidator({onshow:"请上传资源文件",onfocus:"请上传资源文件",oncorrect:"上传正确"}).inputValidator({min:1,onerror:function(){alert("资源不能为空,请确认");}});
	var userType = "${s_userType}" ;//用户类型 管理员录入数据： 0 ，老师录入数据： 1
	var expentNum = "0000" ;	//未来扩展值
	var resBeginType = "pr" ;
	
	//上传资源文件
	$("#uploadBigFile").change(function(){
		$("#isUpload").val(null);
		$("#uploadBigFile").select();
		var realFile = $("#uploadBigFile").val() ;
		var date = new Date() ;
		var path = "upload/ZLS/" + userType + "/" + expentNum + "/" ;
	    var fileType = realFile.substring(realFile.lastIndexOf(".") + 1 ,realFile.length) ;
		var fileName = date.getTime() + "." + fileType ; 
		$("#uploadFileName").val(fileName) ;
		$("#uploadFilePath").val(path) ;
		
		var TypeValue = $("#prType").val();
		if(TypeValue==""){
			alert("您填写顺序有误,请按顺序填写。");	
			$(".subButton").hide();	
			return false;
		}else if(TypeValue=="1084"){
			//alert(fileType);
			var prs = RegExp("(.*)\\.(asx|asf|mpg|wmv|3gp|mp4|mov|avi|flv|rmvb|rm|ASX|ASF|MPG|WMV|3GP|MP4|MOV|AVI|FLV|RMVB|RM)$");
			if(prs.test("."+fileType)){
				$(".subButton").show();	
			}else{
				alert("您上传的资源格式不正确,请确认");
				$(".subButton").hide();		
			}
		}else if(TypeValue=="1073"){
			if(fileType.toLowerCase().indexOf("mp3".toLowerCase()) > -1){
				$(".subButton").show();	
			}else{
				alert("您上传的资源格式不正确,请确认");
				$(".subButton").hide();		
			}
		}else if(TypeValue=="2002"){
			if(fileType.toLowerCase().indexOf("swf".toLowerCase()) > -1){
				$(".subButton").show();	
			}else{
				alert("您上传的资源格式不正确,请确认");
				$(".subButton").hide();		
			}
		}
		
		
		if($("#uploadFileType").val() == "handled"){
			var uploadFile = $("#"+resBeginType+"Upload").val() ;
			var upFileType = uploadFile.substring(uploadFile.lastIndexOf(".") + 1 ,uploadFile.length) ;
			if($("#"+resBeginType+"Type").val() != "1084"){
				alert("只有高清视频才能上传资源处理文件！！") ;
			}else if(uploadFile == "") {
				alert("请先上传资源主文件！") ;
			}else if(fileType == uploadFile.substring(uploadFile.lastIndexOf(".") + 1 ,uploadFile.length)) {
				alert("不能上传相同文件类型！") ;
			}else {
				$("#"+resBeginType+"FileSwf").val(path + fileName);
			}
		}else {
			$("#"+resBeginType+"Upload").val(path + fileName);
		}
		
	}) ;
	$("#uploadFileType").change(function(){
		if($("#uploadFileType").val() == "handled" && $("#"+resBeginType+"Type").val() != "1084") {
			alert("只有高清视频才可以上传资源处理文件！") ;
			$("#uploadFileType").val("main") ;
		}
		
		if($("#uploadFileType").val() == "handled" && $("#"+resBeginType+"Type").val() == "1084"){
			$("#enableUp").html("（允许上传视频格式包括：.flv）");
		}
		
		if($("#uploadFileType").val() == "main" && $("#"+resBeginType+"Type").val() == "1084"){
			$("#enableUp").html("（允许上传视频格式包括：.mp4）");
		}
		
	});
	
	//$("#uploadShowDivRecommen").append("<span>允许上传首页推荐展示图片格式包括：.jpg、.png</span>");
	
	 $("#projectionmodify #upload").change(function(){
    	$("#projectionmodify #thumformat").html("");
    	$(this).siblings("font").remove();
    	$(this).after("<font color='red'>*</font>");
		$(this).formValidator({}).regexValidator({regexp:"picture",datatype:"enum",onerror:"文件格式不正确（允许上传文件格式有jpg、gif、png）"});
	
    });
	 
	//初始化推荐到首页操作
    var prRecommen = '${initMap.projInfo.prRecommen}';
    if(prRecommen!=null && prRecommen.indexOf("1")>-1){
    	$("input.prRecommen:checkbox").attr("checked",true);
    	$("#uploadShowDivRecommen input.Recommensize").show();
    	$("#uploadShowDivRecommen span").show();
    	
    	if(prRecommen.indexOf("11")>-1)
    		$("input.Recommensize:first").attr("checked",true);
    	else if(prRecommen.indexOf("22")>-1)
    		$("input.Recommensize:last").attr("checked",true);
   	}else{
		$("input.prRecommen:checkbox").attr("checked",false);
   	}
    
 	 //点击推荐到首页按钮操作
    $(".prRecommen").change(function(){   	
    	if($('input.prRecommen:checkbox:checked').val()=="0"){
    		$(".Recommensize").show();   
    		$("#uploadShowDivRecommen span").show(); 
    	}else{
    		$(".Recommensize").hide();	
    		$("#recommenFile").hide();
    		$("input.Recommensize:radio").attr("checked",false);
			$("#uploadShowDivRecommen span").hide();   
			
			$("#recommenFile").siblings("font").remove();
    		$("#recommenFile").formValidator({});
			
			$("#prRecommen").val("0");	
			$("#Recommensize").val("0");	
			
    	}
    });
    
 	 //点击推荐图片尺寸操作
    $(".Recommensize").change(function(){    			
		$("#recommenFile").show();
		$("#Recommensize").val($('input.Recommensize:radio:checked').val());
		$("#recommenFile").siblings("font").remove();
		$("#recommenFile").after("<font color='red'>*</font>");
		$("#recommenFile").formValidator({onshow:"请选择文件",onfocus:"请选择文件",oncorrect:"请选择文件"}).regexValidator({regexp:"picture",datatype:"enum",onerror:"文件格式不正确"});
   	});
    
  	//点击推荐后，上传图片操作
    $("#recommenFile").change(function(){    
    	$("#orRecommenFile").val($("#recommenFile").val());
    	$("#titleuploadRecommenFile").val("titleuploadRecommenFile");   
    }); 
  	
    $("#contentfile").change(function(){    
    	$("#titlecontentfileFile").val("titlecontentfileFile");
    	$(this).siblings("font").remove();
    	$(this).after("<font color='red'>*</font>");
    	$(this).formValidator({}).regexValidator({regexp:"word",datatype:"enum",onerror:"文件格式不正确（允许上传文件格式有doc、docx）"});
    });
	
  //添加缩略图上传图片格式验证
    $("#thumformat").html("允许上传缩略图文件格式包括：.jpg、.png");
	
	//ajax 
    var cid = $("#prCategory").val();
	/* $.ajax({
		url:		'ajaxAction.action?code=003006008&paramMap.cateID=' + cid,
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){
			if (textStatus == "success"){
				if (jsonData.data){
					if(jsonData.data.length != 0){
						var $cobj = $("#jie2"); 
						$cobj.find("option").remove();
						var ctempid = $("#prCateTwLevel").val();
						$cobj.append($("<option></option>").attr("value","").text("----请选择----"));
						for (var i=0; i<jsonData.data.length;i++){
							var cateID = jsonData.data[i].cateID;
							var cateName = jsonData.data[i].cateName;
							if (cateID == ctempid){
								$cobj.append($("<option></option>").attr("value",cateID).text(cateName).attr("selected","selected"));
							}
							else{
								$cobj.append($("<option></option>").attr("value",cateID).text(cateName));
							}
						}	
					}else{
						document.getElementById("jie2").disabled=true;
						var $cobj = $("#jie2"); 
    					$cobj.find("option").remove();
    					$cobj.append($("<option></option>").attr("value","").text("----请选择----"));
    					$("#prCateTwLevel").val("");
    			    	$("#prCateTwLevelName").val("");	
					}
				} 
			}
		},
		error:function(request,textStatus,error){}
	}); */


    /* $("#jie").change(function(){
    	var sval = $(this).val();
    	var stxt = $(this).find("option:selected").text();
    	
    	$("#prCategory").val(sval) ;
    	$("#prCategoryName").val(stxt) ;
   
    	$.ajax({
    		url:		'ajaxAction.action?code=003006008&paramMap.cateID=' + sval,
    		type:	    'post',
    		timeout:	'60000',
    		data:	Array(),
    		dataType:	'json',
    		beforeSend:function(request){},
    		complete:function(request,textStatus){},
    		success:function(jsonData,textStatus){
    			if (textStatus == "success"){
    				if (jsonData.data){
    					if(jsonData.data.length > 0){
	    					document.getElementById("jie2").disabled=false;
	    					var $cobj = $("#jie2"); 
	    					$cobj.find("option").remove();
	    					$cobj.append($("<option></option>").attr("value","").text("----请选择----"));
	    					for (var i=0; i<jsonData.data.length;i++){
	    						var cateID = jsonData.data[i].cateID;
	    						var cateName = jsonData.data[i].cateName;
	    						$cobj.append($("<option></option>").attr("value",cateID).text(cateName));
	    					}
    					}else{
    						document.getElementById("jie2").disabled=true;
    						var $cobj = $("#jie2"); 
        					$cobj.find("option").remove();
        					$cobj.append($("<option></option>").attr("value","").text("----请选择----"));
    						$("#prCateTwLevel").val("");
    				    	$("#prCateTwLevelName").val("");
    					}
    				} 
    			}
    		},
    		error:function(request,textStatus,error){}
    	});
    });   
    
    $("#jie2").change(function(){
    	var sval = $(this).val() ;
    	var stxt = $(this).find("option:selected").text() ;
    	//alert(sval + "---" + stxt);
    	if (sval){
    		$("#prCateTwLevel").val(sval);	
    	}
    	if (stxt){
    		$("#prCateTwLevelName").val(stxt);
    	}
    	
    }); */
    
    
  //初始化页面上传文件提示。
    var initOrType ='${initMap.projInfo.prType}';
    if(initOrType == '1011'){
		$("#enableUp").html("（允许上传高清图片格式包括：.jpg、.png）");
	}else if(initOrType == '1084'){
		$("#enableUp").html("（允许视频格式：rmvb、wmv、mp4、flv、mpg等）");
	}else if(initOrType == '1073'){
		$("#enableUp").html("（允许上传音频格式包括：.mp3）");
	}else if(initOrType == '2002'){
		$("#enableUp").html("（允许上传动画类格式包括：.swf）");
	}
    
    
  //点击资源类型时,页面上传文件提示操作
    $("#"+resBeginType+"Type").change(function(){ 
		var ty = $(this).val();
		if(ty == '1011'){
			$("#enableUp").html("（允许上传高清图片格式包括：.jpg、.png）");
			$("#res_change_name").html("高清图片："); 
		}else if(ty == '1022'){
			$("#enableUp").html("（允许上传3D图片格式包括：.jpg、.png）");
			$("#res_change_name").html("3D图片："); 
		}else if(ty == '1084'){
			$("#enableUp").html("（允许视频格式：rmvb、wmv、mp4、flv、mpg等）");
			$("#res_change_name").html("高清视频："); 
		}else if(ty == '4033'){
			$("#enableUp").html("（允许上传压缩格式包括：.rar、.zip）");
			$("#res_change_name").html("多维资源：");  
		}else if(ty == '1073'){
			$("#enableUp").html("（允许上传音频格式包括：.mp3）");
			$("#res_change_name").html("音频资源：");  
		}
	});
  
});
//推荐触发事件
function Change(_this){
	
	if(_this.checked==true){
		
		//判断 是否填写关键字 没有填写关键字  或者是否 选择创建资源的分类目录
		var keyWords=$("#orKeywords").val();		 
		var category=$("#orCategory").val();
		var cateTwLevel=$("#orCateTwLevel").val();
		
		
		keyWords = encodeURI(keyWords);
		keyWords = encodeURI(keyWords); 
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/forwardAction.action?code=-110001&paramMap.orCategory='+category+'&paramMap.orCateTwLevel='+cateTwLevel+'&paramMap.keyWords='+keyWords+'&paramMap.roomtype='+$("#roomtype").val()+'&paramMap.resType=1011&paramMap.offsetAbout=10&paramMap.start=0',{width:1000,height:574,title:'资源推荐',lock:'true',background:'#000000',opacity: '0.15'}) ;
	
	}
}
function onchangeUpload(uploadFile){
	$("#" + uploadFile).val("1") ;
	$("#title" + uploadFile).val("title" + uploadFile) ;
}
function attr(y){
	var reg = /^\s+$/;
	return (typeof y != 'undefined' && y != '' && y != null && !reg.test(y) && y!='null');
}

</script>
</head>
<body>
<div id="layout_mainbody" >
<input type="hidden" id="roomtype" value="projection">
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top: 0; width: 190px;"></ul>
</div>
<input type="hidden" name="code" value="${code}"> 
<input name="paramMap.prIsShare" type="hidden" id="prIsShare" value="1"/>
<input name="paramMap.isUpdate" type="hidden" id="isUpdate" value="xiugai"/>
<input name="paramMap.prID" type="hidden" id="prID" value="${initMap.projInfo.prID}"/>
<input type="hidden" name="imitateStep" value="${pmsIndex.res_projection_room_mgr.imitationStep}">
<input name="paramMap.resType" type="hidden" value="projection"/>
<input name="paramMap.prAbout" type="hidden" id="relations" value="${initMap.projInfo.prAbout}"/>
<input name="paramMap.prRelation" type="hidden" id="setRelations" value="${initMap.projInfo.prRelation}"/>
<input name="paramMap.thecode" type="hidden" value="${initMap.projInfo.prNO}"/>
<input name="paramMap.modifycateerprCategory" type="hidden" value="${initMap.projInfo.prCategory}"/>
<input name="paramMap.modifycateerprCateTwLevel" type="hidden" value="${initMap.projInfo.prCateTwLevel}"/>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#e8e8e8" valign="top">
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
								  	<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源名称：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.prName" type="text" value="${initMap.projInfo.prName}" maxlength="180" id="prName" style="width: 200px;" />&nbsp;
										<font color="red">*</font><span id="prNameTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">搜索关键词：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.prKeywords" type="text" id="prKeywords" style="width: 200px;" value="${initMap.projInfo.prKeywords }"/>&nbsp;
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td align="right" class="tatd" width="10%">资源分类：</td>
										<td  class="tatd"> 
											<input type="hidden" name="paramMap.prCategory" id="prCategory"  value="${initMap.projInfo.prCategory}" style="width: 200px;">
											<input type="hidden" name="paramMap.prCategoryName" id="prCategoryName"  value="${initMap.projInfo.prCategoryName}" style="width: 200px;">

											<select name="jie" id="jie" style="width: 100;">
												<option>----请选择----</option>
												<s:iterator value="initMap.resCategoryList" id="cate" status="ind">
											 		<option value="${cate.cateID}" ${initMap.projInfo.prCategory eq cate.cateID ? 'selected':'' }>${cate.cateName}</option>
												</s:iterator>
											</select>
											<font color="red">*</font><span id="prCategoryTip" style="position:absolute;height:22px;width:100px"></span>
								
										</td>
									</tr>
									<!-- <tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">相关资源推荐：</td>
										<td width="85%" class="tatd" align="left" >
										<input type="checkbox"  id="outside" value="0" onclick="Change(this);" >
										</td>
									</tr> -->
									
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源类型：</td>
										<td width="85%" class="tatd" align="left">
											<select name="paramMap.prType" id="prType">
												<option value="">----请选择----</option>
												<option value="1073" ${initMap.projInfo.prType eq "1073" ? 'selected':'' }>音频</option>
												<option value="1084" ${initMap.projInfo.prType eq "1084" ? 'selected':'' }>高清视频</option>
											</select>
											<input type="hidden" name="paramMap.oldResType" id="oldResType" value="${initMap.projInfo.prType}" >
											&nbsp;<font color="red">*</font><span id="prTypeTip" style="position:absolute;height:22px;width:297px"></span>
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="res_change_name">资源文件：</td>
										<td width="85%" class="tatd" align="left" id="uploadShowDiv">
										<input type="hidden" name="paramMap.oldResUpload" id="oldResUpload" value="${initMap.projInfo.prUpload}" >
										<input type="hidden" name="paramMap.prUpload" id="prUpload" value="${initMap.projInfo.prUpload}">
										<input type="hidden" name="paramMap.isUpload" id="isUpload" value="1">
										<s:if test="initMap.projInfo.prType == '1084' ">
											<input type="hidden" name="paramMap.prFileSwf" id="prFileSwf" value="${initMap.projInfo.prFileSwf}">
										</s:if>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" id="projectionmodify">
										<td align="right" class="tatd" width="15%">缩略图：</td>
										<td class="tatd">
										<img alt="" src="${initMap.projInfo.prThumbnail}" width="50px" height="50px">
										<input type="file" name=upload id="upload" onchange="onchangeUpload('uploadThumFile');" />
										<span id="uploadTip" style="position:absolute;height:22px;width:270px"></span>
										<input type="hidden" name="paramMap.uploadThumFile" id="uploadThumFile" value="0">
										<input type="hidden" name="paramMap.olduploadThumFile" id="olduploadThumFile" value="${initMap.projInfo.prThumbnail}">
										<input type="hidden" name="paramMap.prThumbnail"  value="${initMap.projInfo.prThumbnail}">
										<input type="hidden" name="paramMap.prInThum"  value="${initMap.projInfo.prInThum}">
										<input type="hidden" name="title" id="titleuploadThumFile" >
										<span id="thumformat"></span>
										<span id="uploadTip" style="position:absolute;height:22px;width:297px"></span>
										</td>
									</tr> 
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">推荐到首页：</td>
										<td width="85%" class="tatd" align="left" id="uploadShowDivRecommen">
											<input type="checkbox" name="orRec" value="0" class="prRecommen"> 

											<input type="radio" name="Recommensize" value="11" class="Recommensize" style="display: none;"><span style="display: none;">305*145</span>
											<input type="radio" name="Recommensize" value="22" class="Recommensize" style="display: none;"><span style="display: none;">143*145</span>
											
											<input type="file" name=upload id="recommenFile" onchange="onchangeUpload('prRecommen');" style="display: none;" />
											<span id="recommenFileTip" style="position:absolute;height:22px;width:270px"></span>
											<input type="hidden" name="paramMap.prRecommen" id="prRecommen" value="${initMap.projInfo.prRecommen}">
											<input type="hidden" name="paramMap.Recommensize" id="Recommensize" value="${initMap.projRecommen.reSize}">
											<input type="hidden" name="paramMap.OldprRecommenFile" id="OldprRecommenFile" value="${initMap.projRecommen.reRecoFileUP}">
											<input type="hidden" name="title" id="titleuploadRecommenFile" value="">
										</td>
									</tr>
									<tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">相关资源推荐：</td>
										<td width="85%" class="tatd" align="left" >
										<input type="checkbox"  id="outside" value="0" onclick="Change(this);" >
										</td>
									</tr>
									<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">二级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.prCateTwLevel" id="prCateTwLevel" style="width: 200px;" value="${initMap.projInfo.prCateTwLevel}">
											<input type="hidden" name="paramMap.prCateTwLevelName" id="prCateTwLevelName" style="width: 200px;" value="${initMap.projInfo.prCateTwLevelName}">
											<select id="jie2" name="jie2"  style="width: 100;"  ><option>----请选择----</option>
											</select>
										</td>
									</tr> --%>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">详细说明：</td>
										<td width="85%" class="tatd" align="left">
										<textarea cols="80" id="prDescription" name="paramMap.prDescription" rows="10">${initMap.projInfo.prDescription}</textarea>&nbsp;
										<span id="prDescriptionTip" style="position:absolute;height:22px;width:270px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源简介：</td>
										<td width="85%" class="tatd" align="left">
											<textarea cols="80" id="editor1" name="paramMap.prContent" rows="10">${initMap.projInfo.prContent}</textarea>
										    <script type="text/javascript">
											CKEDITOR.replace('editor1',{ filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=projection&prno='+'${initMap.projInfo.prNO}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=projection&prno='+'${initMap.projInfo.prNO}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=projection&prno='+'${initMap.projInfo.prNO}' } );
 											</script>
 											<input type="file" name="upload" id="contentfile" >
 											<input type="hidden" name="title" id="titlecontentfileFile" value="">
 											<input type="hidden" name="paramMap.prContent" value="${initMap.projInfo.prContent}">
 											<span id="contentfileTip" style="position:absolute;height:22px;width:293px"></span>
										</td>
									</tr> --%>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">学科关联：</td>
										<td width="85%" class="tatd" align="left">
											<s:include value="/module/system/res/science.jsp"></s:include>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">小学分类：</td>
										<td width="85%" class="tatd" align="left">
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="303" <s:if test="initMap.projInfo.prGrade.indexOf('303') > -1">checked</s:if>><span>三年级</span>
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="304" <s:if test="initMap.projInfo.prGrade.indexOf('304') > -1">checked</s:if>><span>四年级</span>
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="305" <s:if test="initMap.projInfo.prGrade.indexOf('305') > -1">checked</s:if>><span>五年级</span>
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="306" <s:if test="initMap.projInfo.prGrade.indexOf('306') > -1">checked</s:if>><span>六年级</span> 
										</td>
									</tr> --%>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">中学分类：</td>
										<td width="85%" class="tatd" align="left">
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="311" <s:if test="initMap.projInfo.prGrade.indexOf('311') > -1">checked</s:if>>七年级
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="312" <s:if test="initMap.projInfo.prGrade.indexOf('312') > -1">checked</s:if>>八年级
										
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="313" <s:if test="initMap.projInfo.prGrade.indexOf('313') > -1">checked</s:if>>九年级
										</td>
									</tr>
 									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">高中分类：</td>
										<td width="85%" class="tatd" align="left">
									
											 <input type="checkbox" name="paramMap.grGrades" id="grGrades" value="321" <s:if test="initMap.projInfo.prGrade.indexOf('321') > -1">checked</s:if>><span>必修一</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="322" <s:if test="initMap.projInfo.prGrade.indexOf('322') > -1">checked</s:if>><span>必修二</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="323" <s:if test="initMap.projInfo.prGrade.indexOf('323') > -1">checked</s:if>><span>必修三</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="331" <s:if test="initMap.projInfo.prGrade.indexOf('331') > -1">checked</s:if>><span>选修一</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="332" <s:if test="initMap.projInfo.prGrade.indexOf('332') > -1">checked</s:if>><span>选修二</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="333" <s:if test="initMap.projInfo.prGrade.indexOf('333') > -1">checked</s:if>><span>选修三</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="334" <s:if test="initMap.projInfo.prGrade.indexOf('334') > -1">checked</s:if>><span>选修四</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="335" <s:if test="initMap.projInfo.prGrade.indexOf('335') > -1">checked</s:if>><span>选修五</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="336" <s:if test="initMap.projInfo.prGrade.indexOf('336') > -1">checked</s:if>><span>选修六</span>&nbsp;
							
										
										
									</tr>
									<!-- <tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">高中竞赛：</td>
										<td width="85%" class="tatd"  align="left">
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3241" <s:if test="initMap.projInfo.prContest.indexOf('3241') > -1">checked</s:if>>细胞生物学
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3242" <s:if test="initMap.projInfo.prContest.indexOf('3242') > -1">checked</s:if>>植物解剖和生理
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3243" <s:if test="initMap.projInfo.prContest.indexOf('3243') > -1">checked</s:if>>动物解剖和生理
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3244" <s:if test="initMap.projInfo.prContest.indexOf('3244') > -1">checked</s:if>>动物行为学
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3245" <s:if test="initMap.projInfo.prContest.indexOf('3245') > -1">checked</s:if>>遗传学与进化
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3246" <s:if test="initMap.projInfo.prContest.indexOf('3246') > -1">checked</s:if>>生态学
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3247" <s:if test="initMap.projInfo.prContest.indexOf('3247') > -1">checked</s:if>>生物系统学 
										</td>
									</tr> -->
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">备注：</td>
										<td width="85%" class="tatd" align="left">
										<textarea cols="80" id="prRemarks" name="paramMap.prRemarks" rows="10">${initMap.projInfo.prRemarks}</textarea>&nbsp;
										<span id="prRemarksTip" style="position:absolute;height:22px;width:270px"></span></td>
					 				</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">日期：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.prCreateTime" type="text" class="Wdate" maxlength="10" value="${initMap.projInfo.prCreateTime }" id="prCreateTime" style="width: 200;" onFocus="WdatePicker({isShowWeek:true,dateFmt:'yyyy-MM-dd',readOnly:true});" />&nbsp;
										</td>
									</tr>
									<tr bgcolor="#ae9b84" align="center">
										<td colspan="4"><input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
									</tr>
								</table>
							</div>						
						 </td>
				      </tr>
					</table>
			  	</td>
			</tr>
		</table>
	</td>
  </tr>
</table>
</form>
<div class="uploadDiv" style="position:absolute;">
	<iframe id='target_upload' name='target_upload' src='' style='display: none'></iframe>
	<form action="/dm/uploadFile/upload" id="uploadForm" enctype="multipart/form-data" method="post" target="target_upload">
		<input type="hidden" name="uploadFileName" id="uploadFileName">
		<input type="hidden" name="uploadFilePath" id="uploadFilePath">
		<input type="hidden" name="uploadFileType" id="uploadFileType" value="main">
		
		<span id="fileup">
			<input type="file" name="upload" id="uploadBigFile" > 
			<input type="button" class="subButton" value="上传">
		</span>
		<span id="enableUp" ></span>
		&nbsp;<font color="red">*</font><span id="isUploadTip" style="position:absolute;height:22px;width:120px;"></span>
		&nbsp;<span style="margin-left:100px;">
		<%-- <a href="downloadAction.action?code=-706&paramMap.resDownRoom=projection&paramMap.resDownType=${initMap.projInfo.prType}&paramMap.resPath=${initMap.projInfo.prUpload}" >下载</a> --%>
		</span>
	</form>
</div>
<div id="progress">
	<div id="title">
		<%-- <span id="text" class="fontStyle">上传进度</span> --%>
		<div id="close">关闭</div>
	</div>
	<div id="progressBar">
		<div id="uploaded"></div>
	</div>
	<div id="info"></div>
</div>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/scripts.js"></script>
</body>
</html>