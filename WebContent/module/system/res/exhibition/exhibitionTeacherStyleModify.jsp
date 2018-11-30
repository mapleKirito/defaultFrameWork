<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.autocomplete.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/progressBar.css">
<script src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/progressBar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rsync_progress_bar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dataUtils.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/res/category.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<script type="text/javascript">
var isInitOK = false ;
$(document).ready(function(){	
	
	//input验证
	//表单提交 
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){},onsuccess:function(){}});//表单提交 
	$("#erName").formValidator({onshow:"请输入中文名",onfocus:"请输入中文名",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("中文名不能为空,请确认");}});
	$("#erKeywords").formValidator({onshow:"请输入关键字，关键字中间用、隔开 如：鼎、陶",onfocus:"请输入关键字，关键字中间用、隔开 如：鼎、陶",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("关键字不能为空,请确认");}});

	$("#erTotalID").formValidator({onshow:"请选择资源分类",onfocus:"请选择资源分类",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源分类不能为空,请确认");}});
	/* $("#erChorID").formValidator({onshow:"请选择资源分类",onfocus:"请选择资源分类",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"资源分类不能为空,请确认"});
	$("#erGangID").formValidator({onshow:"请选择资源分类",onfocus:"请选择资源分类",oncorrect:"输入正确"}).inputValidator({min:1,onerror:"资源分类不能为空,请确认"}); */
	$("#erType").formValidator({onshow:"请选择资源类型",onfocus:"请选择资源类型",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源类型不能为空,请确认");}});
	$("#erUpload").formValidator({onshow:"请上传资源文件",onfocus:"请上传资源文件",oncorrect:"上传正确"}).inputValidator({min:1,onerror:function(){alert("资源不能为空,请确认");}});
	$("#isUpload").formValidator({onshow:"请上传资源文件",onfocus:"请上传资源文件",oncorrect:"上传正确"}).inputValidator({min:1,onerror:function(){alert("资源不能为空,请确认");}});


	//编辑分类
	$(".editCate").click(function(){
		var code=$(this).attr("id");
		art.dialog.data('contextPath','/dm');
		art.dialog.open('decorateForwardAction.action?code='+code,
			{
				width : 950,
				height : 371,
				title : '分类管理',
				lock : 'true',
				background : '#666666',
				opacity : '0.15'
			});
	});
	
	
	//加载资源分类
	$("#erTotalID").change(function(){
		if($("#erTotalID").val()== 271 || $("#erTotalID").val()== 272){
			$("#erJieID").formValidator({});
		}else{
 			$("#erJieID").formValidator({onshow:"请选择资源二级分类",onfocus:"请选择资源二级分类",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源二级分类不能为空,请确认");}});
 	     }
		changeTotal("er","") ;
	});	
	$("#erJieID").change(function(){
		changeJie("er","") ;
	});
	$("#erSecoID").change(function(){
		changeSeco("er","") ;
	});
	$("#erChorID").change(function(){
		changeChor("er","") ;
	});
	$("#erGangID").change(function(){
		changeGang("er","") ;
	});
	/* $("#erOrderID").change(function(){ 
		changeOrder("er","") ;
	}); */
	/* $("#erCategory").change(function(){
		changeCategory("er") ;
	}); */
	
	initCategory("er", "${initMap.exhiInfo.erTotalID}","${initMap.exhiInfo.erJieID}","${initMap.exhiInfo.erChorID}", "${initMap.exhiInfo.erGangID}") ;
	
	if('${initMap.exhiInfo.erTotalID}' == '4'){
		for(var i = 0; i < 12 ; i ++){
			$("#exhibition_" + i).parent().hide() ;
		}			
		$("#erJieID").formValidator({});
		$("#erChorID").formValidator({});
		$("#erGangID").formValidator({});
	}
	
    var audio = '${initMap.exhiInfo.erAudio}';
    if(audio!=''){
    	$("input:radio[.erUpAudio]:eq(0)").attr("checked",'checked');
    }else{
    	$("input:radio[.erUpAudio]:eq(1)").attr("checked",'checked');
    }
    var erIsShare = '${initMap.exhiInfo.erIsShare}';
    
    if(erIsShare==1){
    	//alert(erIsShare);
    	$("#erIsShare").attr('checked',true);
    }
	//加载地区
	findChildArea(0) ;
	
	$("#showMap").click(function(){
		art.dialog.data('x', $("#erLongitude").val());
		art.dialog.data('y', $("#erLatitude").val());
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/module/enginev/MapBaidu.jsp',{width:462,height:442,title:'分布地区坐标(单击拾取坐标)'}) ;
	});
	
	var userType = "${s_userType}" ;//用户类型 管理员录入数据： 0 ，老师录入数据： 1
	var expentNum = "0000" ;	//未来扩展值
	var resBeginType = "er" ;
	
	$(".addcate").click(function(){
		$(this).siblings("span").show();
	});
	
	$(".addcateButton").click(function() {
		var n = $(this).parents("span").attr("upID");
		var changeselect = $(this).parents("span").attr("downID"); 
		var fieldName = $(this).parents("span").siblings("select").attr("id");
		var nid = $("#" + n).val();
		var npath = $("#" + n + " option[value=" + nid + "]").attr("catepath");
		var nevel = $("#" + n + " option[value=" + nid + "]").attr("catelevel");
		var ninput = $(this).siblings(".addcateInput").val();
		if (nid != "" && ninput != "") {
			$.ajax({
				url:		'ajaxAction.action?code=-1321&paramMap.cateIsChild=0&paramMap.cateParentID='+nid+'&paramMap.npath='+npath+'&paramMap.cateLevel='+(parseInt(nevel)+1)+'&paramMap.cateName=' + ninput,
				type:	    'post',
				timeout:	'60000',
				data:	Array(),
				dataType:	'json',
				beforeSend:function(request){},
				complete:function(request,textStatus){},
				success:function(jsonData,textStatus){
					if (textStatus == "success"){
						if(jsonData.data.length>0){
							alert("添加分类成功");
							$(".addcatespan").hide();
							$(".addcateButton").siblings(".addcateInput").val("");
							for (var i=0; i<1;i++){
								var cateID = jsonData.data[i].cateID;
								var cateName = jsonData.data[i].cateName;
								var catePath = jsonData.data[i].catePath;
								var cateLevel = jsonData.data[i].cateLevel;
								var option = $("<option>").text(cateName).val(cateID).attr("catepath",catePath).attr("catelevel",cateLevel);
								$("#" + fieldName).append(option).find("option[value='"+cateID+"']").attr("selected",true);
								var fieldName_f = fieldName.replace(/ID/g, "");
								$("#" + fieldName).val(cateID) ;
								$("#" + fieldName_f).val(cateName) ;
							}
							
							if(changeselect!=""){
								$("#"+changeselect)[0].selectedIndex = 0;	
							}
						}else{
							alert("分类名称重复");
						}
						
					}
				},
				
				error:function(request,textStatus,error){
					alert("添加分类失败");
				}
			});
		}
	});
	
	
	//上传资源文件
	$("#uploadBigFile").change(function(){
		$("#isUpload").val(null);
		$("#uploadBigFile").select();
		var realFile = $("#uploadBigFile").val() ;
		var date = new Date() ;
		var path = "upload/BLS/" + userType + "/" + expentNum + "/" ;
		var fileType = realFile.substring(realFile.lastIndexOf(".") + 1 ,realFile.length) ;
		
		if(fileType.toLowerCase().indexOf("jpg".toLowerCase()) > -1 || fileType.toLowerCase().indexOf("png".toLowerCase()) > -1 || fileType.toLowerCase().indexOf("gif".toLowerCase()) > -1){
			$(".subButton").show();	
		}else{
			alert("您上传的资源格式不正确,请确认");
			$(".subButton").hide();		
		}
		
		
		var fileName = date.getTime() + "." + fileType ; 
		$("#uploadFileName").val(fileName) ;
		$("#uploadFilePath").val(path) ;
		$("#erUpload").val(path + fileName);		
	}) ;
	
	$("#uploadFileType").change(function(){
		if($("#uploadFileType").val() == "handled" && $("#"+resBeginType+"Type").val() != "1084") {
			alert("只有高清视频才可以上传资源处理文件！") ;
			$("#uploadFileType").val("main") ;
		}
	});

	//点击是否上传音频Radio操作
    $(".erUpAudio").change(function(){   	
    	if($('input.erUpAudio:radio:checked').val()=="erUpYAudio"){
    		$("#rsyncUploadDiv").show();
    		$("#rsyncUploadBigFile").formValidator({onshow:"请上传音频（允许上传的格式为mp3）",onfocus:"请上传音频（允许上传的格式为mp3）",oncorrect:"请上传音频（允许上传的格式为mp3）"}).regexValidator({regexp:"audio",datatype:"enum",onerror:"音频格式不正确（允许上传的格式为mp3）"});
    	}else{
    		$("#rsyncUploadDiv").hide();	
    		$("#rsyncUploadBigFile").formValidator({});
    	}
    });   
		
    $("#rsyncUploadDiv").css("left",$("#rsyncUploadShowDiv").offset().left + 100);
    $("#rsyncUploadDiv").css("top",$("#rsyncUploadShowDiv").offset().top + 8);
	
    $(".uploadDiv").css("left",$("#uploadShowDiv").offset().left + 8);
    $(".uploadDiv").css("top",$("#uploadShowDiv").offset().top + 7);
    
    $("#enableUp").css("left",$("#uploadShowDiv").offset().left + 185);
    $("#enableUp").css("top","5");  
    
    //$("#uploadShowDivRecommen").append("<span>允许上传首页推荐展示图片格式包括：.jpg、.png</span>");
    
    //初始化推荐到首页操作
    var erRecommen = '${initMap.exhiInfo.erRecommen}';
    if(erRecommen!=null && erRecommen.indexOf("1")>-1){
    	$("input.erRecommen:checkbox").attr("checked",true);
    	$("#uploadShowDivRecommen input.Recommensize").show();
    	$("#uploadShowDivRecommen span").show();
    	
    	if(erRecommen.indexOf("11")>-1)
    		$("input.Recommensize:first").attr("checked",true);
    	else if(erRecommen.indexOf("22")>-1)
    		$("input.Recommensize:last").attr("checked",true);
   	}else{
		$("input.erRecommen:checkbox").attr("checked",false);
   	}
    
 	 //点击推荐到首页按钮操作
    $(".erRecommen").change(function(){   	
    	if($('input.erRecommen:checkbox:checked').val()=="0"){
    		$(".Recommensize").show();   
    		$("#uploadShowDivRecommen span").show(); 
    	}else{
    		$(".Recommensize").hide();	
    		$("#recommenFile").hide();
    		$("input.Recommensize:radio").attr("checked",false);
			$("#uploadShowDivRecommen span").hide();   
			
			$("#erRecommen").val("0");	
			$("#Recommensize").val("0");
			
			$("#recommenFile").siblings("font").remove();
    		$("#recommenFile").formValidator({});
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
    	$("#erRecommenFile").val($("#recommenFile").val());
    	$("#titleuploadRecommenFile").val("titleuploadRecommenFile");  
    });  
  	
    $("#relatedlinksfile").change(function(){    
    	$("#erRelatedLinks").val("1");
    	$("#relatedlinksfileFile").val("relatedlinksfileFile");
    	$(this).siblings("font").remove();
    	$(this).after("<font color='red'>*</font>");
    	$(this).formValidator({}).regexValidator({regexp:"word",datatype:"enum",onerror:"文件格式不正确（允许上传文件格式有doc、docx）"});
    });
  	
    $("#contentfile").change(function(){    
    	$("#titlecontentfileFile").val("titlecontentfileFile");
    	$(this).siblings("font").remove();
    	$(this).after("<font color='red'>*</font>");
    	$(this).formValidator({}).regexValidator({regexp:"word",datatype:"enum",onerror:"文件格式不正确（允许上传文件格式有doc、docx）"});
    });
  	
  	$("#rsyncUploadBigFile").change(function(){
		$("#rsyncUploadBigFile").select();
		var realFile = $("#rsyncUploadBigFile").val() ;
		var date = new Date() ;
		var path = "upload/BLS/" + userType + "/" + expentNum + "/" ;
		var fileType = realFile.substring(realFile.lastIndexOf(".") + 1 ,realFile.length) ;
		var fileName = date.getTime() + "." + fileType ; 
		
		if(fileType.toLowerCase().indexOf("mp3".toLowerCase()) > -1){
			$("#rsyncSubButton").show();	
		}else{
			alert("您上传的资源格式不正确,请确认");
			$("#rsyncSubButton").hide();
		}
		
		$("#rsyncUploadFileName").val(fileName) ;
		$("#rsyncUploadFilePath").val(path) ;
		$("#"+resBeginType+"Audio").val(path + fileName);
		
	}) ;
});

function onchangeUpload(uploadFile){
	$("#" + uploadFile).val("1") ;
}

/****************操作地区输入框****************/
var isInit = true ;
var erCountry = "${initMap.exhiInfo.erCountry}" ;
var erProvince = "${initMap.exhiInfo.erProvince}" ;
var erCity = "${initMap.exhiInfo.erCity}" ;
var erArea = "${initMap.exhiInfo.erArea}" ;
function findChildArea(level) {
	var parentID = 0 ;
	if(level == 1) {
		if(isInit){
			parentID = erCountry ;
		}else {
			parentID = $("#erCountry").val() ;
		}
		
		$("#erCountryName").val($("#erCountry").find("option:selected").text()) ;
		$("#erProvinceName").val("") ;
		$("#erCityName").val("") ;
		$("#erAreaName").val("") ;
	}else if(level == 2) {
		if(isInit){
			parentID = erProvince ;
		}else {
			parentID = $("#erProvince").val() ;
		}
		
		$("#erProvinceName").val($("#erProvince").find("option:selected").text()) ;
		$("#erCityName").val("") ;
		$("#erAreaName").val("") ;
	}else if(level == 3) {
		if(isInit){
			parentID = erCity ;
		}else {
			parentID = $("#erCity").val() ;
		}
		
		$("#erCityName").val($("#erCity").find("option:selected").text()) ;
		$("#erAreaName").val("") ;
	}else if(level == 4) {
		if(isInit){
			parentID = erArea ;
		}else {
			parentID = $("#erArea").val() ;
		}
		
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
	$.ajax({
		url:		'ajaxAction.action?code=003010008&paramMap.id=' + parentID,
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
			if(isInit) {
				
				if(level == 0) {
					//$("#erCountry").val(erCountry);
					setTimeout(function() {
						$("#erCountry option").attr("selected",true);
						$("#erCountry option[value='"+erCountry+"']").attr("selected",true);
					},1);
					if(erProvince == "") {
						isInit = false ;
					}else {
						document.getElementById("erProvince").disabled = false ;
						findChildArea(1);
					}
					
				}else if(level == 1) {
					//$("#erProvince").val(erProvince);
					setTimeout(function() {
						$("#erProvince option").attr("selected",true);
						$("#erProvince option[value='"+erProvince+"']").attr("selected",true);
					},1);
					if(erCity == "") {
						isInit = false ;
					}else {
						document.getElementById("erCity").disabled = false ;
						findChildArea(2);
					}
				}else if(level == 2) {
					//$("#erCity").val(erCity);
					setTimeout(function() {
						$("#erCity option").attr("selected",true);
						$("#erCity option[value='"+erCity+"']").attr("selected",true);
					},1);
					if(erArea == "") {
						isInit = false ;
					}else {
						document.getElementById("erArea").disabled = false ;
						findChildArea(3);
					}
				}else if(level == 3) {
					//$("#erArea").val(erArea);
					setTimeout(function() {
						$("#erArea option").attr("selected",true);
						$("#erArea option[value='"+erArea+"']").attr("selected",true);
					},1);
					isInit = false ;
				}
			}
		},
		
		error:function(request,textStatus,error){}
	});
	
}
//推荐触发事件
function Change(_this){
	
	if(_this.checked==true){
		
		//判断 是否填写关键字 没有填写关键字  或者是否 选择创建资源的分类目录
		var keyWords=$("#erKeywords").val();		 
		var erTotal =  $('#erTotalID').val();
		var erJie =  $('#erJieID').val();
		var erChor =  $('#erChorID').val();
		var erGang =  $('#erGangID').val();
		
		
		keyWords = encodeURI(keyWords);
		keyWords = encodeURI(keyWords); 
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/forwardAction.action?code=-110001&paramMap.erTotalID='+erTotal+'&paramMap.erJieID='+erJie+'&paramMap.erGangID='+erGang+'&paramMap.erChorID='+erChor+'&paramMap.keyWords='+keyWords+'&paramMap.roomtype='+$("#roomtype").val()+'&paramMap.resType=1011&paramMap.offsetAbout=10&paramMap.start=0',{width:1000,height:574,title:'资源推荐',lock:'true',background:'#000000',opacity: '0.15'}) ;
	
	}
}
function attr(y){
	var reg = /^\s+$/;
	return (typeof y != 'undefined' && y != '' && y != null && !reg.test(y) && y!='null');
}
/****************操作地区输入框****************/
</script>
</head>
<body>
<div id="layout_mainbody" >
<input type="hidden" id="roomtype" value="exhibition">
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top: 0; width: 190px;"></ul>
</div>
<div id="menuContentArea" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeAreaDemo" class="ztree" style="margin-top: 0; width: 160px;"></ul>
</div>
<input type="hidden" name="code" value="${code}"> 
<input name="paramMap.isUpdate" type="hidden" id="isUpdate" value="xiugai"/>
<input name="paramMap.erID" type="hidden" id="erID" value="${initMap.exhiInfo.erID}"/>
<input type="hidden" name="imitateStep" value="${pmsIndex.my_resource_mgr.imitationStep}">
<input name="paramMap.resType" type="hidden" value="exhibition"/>
<input name="paramMap.erType" type="hidden" value="1011"/>
<input name="paramMap.Old1011InThum" type="hidden" value="${initMap.exhiInfo.erInThum}"/>
<input name="paramMap.Old1011Thumbnail" type="hidden" value="${initMap.exhiInfo.erThumbnail}"/>
<input name="paramMap.modifycateJieID" type="hidden" value="${initMap.exhiInfo.erJieID}"/>
<input name="paramMap.modifycateChorID" type="hidden" value="${initMap.exhiInfo.erChorID}"/>
<input name="paramMap.modifycateGangID" type="hidden" value="${initMap.exhiInfo.erGangID}"/>
<input name="paramMap.modifycateOrderID" type="hidden" value="${initMap.exhiInfo.erOrderID}"/>
<input name="paramMap.modifycateforyID" type="hidden" value="${initMap.exhiInfo.erCategory}"/>
<input name="paramMap.erAbout" type="hidden" id="relations" value="${initMap.exhiInfo.erAbout}"/>
<input name="paramMap.erRelation" type="hidden" id="setRelations" value="${initMap.exhiInfo.erRelation}"/>
<input name="paramMap.thecode" type="hidden" value="${initMap.exhiInfo.erCode}"/>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td valign="top" style="padding:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_6">
					  <tr>
						<td width="100%" bgcolor="#E8E8E8" valign="top">
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_9">
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源名称：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.erName" value="${initMap.exhiInfo.erName}" type="text" maxlength="180" id="erName" style="width: 200px;" />&nbsp;
 										<font color="red">*</font><span id="erNameTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">搜索关键词：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.erKeywords" type="text" id="erKeywords" style="width: 200px;" value="${initMap.exhiInfo.erKeywords }"/>&nbsp;
										<font color="red">*</font><span id="erKeywordsTip" style="position:absolute;height:22px;width:297px"></span>
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.erTotal" id="erTotal" value="${initMap.exhiInfo.erTotal}">
											<select name="paramMap.erTotalID" id="erTotalID">
													<option>----请选择----</option>
												<s:iterator value="initMap.resCategoryList" id="cate" status="ind">
													<option catepath="${cate.catePath}" catelevel="${cate.cateLevel}" value="${cate.cateID}" ${initMap.exhiInfo.erTotalID eq cate.cateID ? 'selected':'' }>${cate.cateName}</option>
												</s:iterator>
											</select>
											<font color="red">*</font><span id="erTotalIDTip" style="position:absolute;height:22px;width:100px"></span>
											 
										</td>
								   	</tr>
								    <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源文件：</td>
										<td width="85%" class="tatd" align="left" id="uploadShowDiv">
										<input type="hidden" name="paramMap.oldResUpload" id="oldResUpload" value="${initMap.exhiInfo.erUpload}" >
										<input type="hidden" name="paramMap.erUpload" id="erUpload" value="${initMap.exhiInfo.erUpload}">
										<input type="hidden" name="paramMap.isUpload" id="isUpload" value="1">
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">是否上传音频：</td>
										<td width="85%" class="tatd" align="left"  id="rsyncUploadShowDiv">
											<input type="radio" name="paramMap.erUpAudio" class="erUpAudio" value="erUpYAudio"><span>是</span>
											<input type="radio" name="paramMap.erUpAudio" class="erUpAudio" value="erUpNAudio"><span>否</span>
																						
											<input type="hidden" name="paramMap.olderUpAudio" value="${initMap.exhiInfo.erAudio}">
											<input type="hidden" name="paramMap.erAudio" id="erAudio" value="${initMap.exhiInfo.erAudio}">
											<%-- <a href="downloadAction.action?code=-706&paramMap.resDownRoom=exhibition&paramMap.resDownType=${initMap.exhiInfo.erType}&paramMap.resPath=${initMap.exhiInfo.erAudio}" > <span>下载</span></a>--%>
										</td>
								   	</tr> 
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">推荐到首页：</td>
										<td width="85%" class="tatd" align="left" id="uploadShowDivRecommen">
											<input type="checkbox" name="erRec" value="0" class="erRecommen"> 

											<input type="radio" name="Recommensize" value="11" class="Recommensize" style="display: none;"><span style="display: none;">305*145</span>
											<input type="radio" name="Recommensize" value="22" class="Recommensize" style="display: none;"><span style="display: none;">143*145</span>
											
											<input type="file" name=upload id="recommenFile" onchange="onchangeUpload('erRecommen');" style="display: none;" />
											<span id="recommenFileTip" style="position:absolute;height:22px;width:297px"></span>
											<input type="hidden" name="paramMap.erRecommen" id="erRecommen" value="${initMap.exhiInfo.erRecommen}">
											<input type="hidden" name="paramMap.Recommensize" id="Recommensize" value="${initMap.exhiRecommen.reSize}">
											<input type="hidden" name="paramMap.OlderRecommenFile" id="OlderRecommenFile" value="${initMap.exhiRecommen.reRecoFileUP}">
											<input type="hidden" name="title" id="titleuploadRecommenFile" value="">
										</td>
									</tr>
									<tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">相关资源推荐：</td>
										<td width="85%" class="tatd" align="left" >
										<input type="checkbox"  id="outside" value="0" onclick="Change(this);" >
										</td>
									</tr>
									<tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">分享资源：</td>
										<td width="85%" class="tatd" align="left" >
										<input type="checkbox"  name="paramMap.erIsShare" id="erIsShare" value="1"  >
										</td>
									</tr>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_0">二级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.erJie" id="erJie" value="${initMap.exhiInfo.erJie}" >
											<select id="erJieID" name="paramMap.erJieID" disabled="disabled"><option>--请选择--</option></select>
											<font color="red">*</font><span id="erJieIDTip" style="position:absolute;height:22px;width:110px"></span>
											&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										
									    	&nbsp;<img src="images/add.png" border="0" height="20px;" class="addcate" style="position: absolute;z-index: 0;">
											<span upID="erTotalID" downID="erChorID" style="display: none;margin-left: 25px;" class="addcatespan">
												<input class="addcateInput" type="text" name="paramMap.addcateInput" width="150px">
												<input class="addcateButton" type="button" value="提交">
											</span>
											<span class="htmlspan"></span>
										</td>
								   	</tr>
								   	<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_1">三级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.erChor" id="erChor" value="${initMap.exhiInfo.erChor}" >
											<select id="erChorID" name="paramMap.erChorID" disabled="disabled"><option>--请选择--</option></select>
											&nbsp;
											<img src="images/add.png" border="0" height="20px;" class="addcate" style="position: absolute;z-index: 0;">
											
											<span upID="erJieID" downID="erGangID" style="display: none;margin-left: 25px;" class="addcatespan">
												<input class="addcateInput" type="text" name="paramMap.addcateInput" width="150px">
												<input class="addcateButton" type="button" value="提交">
											</span>
											<span class="htmlspan"></span>
										</td>
								   	</tr>
								   	<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_2">四级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.erGang" id="erGang" value="${initMap.exhiInfo.erGang}" >
											<select id="erGangID" name="paramMap.erGangID" disabled="disabled"><option>--请选择--</option></select>
											&nbsp;<img src="images/add.png" border="0" height="20px;" class="addcate" style="position: absolute;z-index: 0;">
											
											<span upID="erChorID" downID="" style="display: none;margin-left: 25px;" class="addcatespan">
												<input class="addcateInput" type="text" name="paramMap.addcateInput" width="150px">
												<input class="addcateButton" type="button" value="提交">
											</span>
											<span class="htmlspan"></span>
										</td>
								   	</tr>
									<%-- <tr bgcolor="#ae9b84" style="display: none;">
										<td width="15%" class="tatd" align="right" id="exhibition_3">五级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.erOrder" id="erOrder" value="${initMap.exhiInfo.erOrder}">
											<select id="erOrderID" name="paramMap.erOrderID" disabled="disabled"><option>--请选择--</option></select>
										</td>
								   	</tr> --%>
								   	<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_4">中文科名：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.erCategoryName" id="erCategoryName" value="${initMap.exhiInfo.erCategoryName}">
											<select id="erCategory" name="paramMap.erCategory" disabled="disabled"><option>--请选择--</option></select>
										</td>
								   	</tr> --%>
								   	<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_5">中文属名：</td>
										<td width="85%" class="tatd" align="left">
											<input type="text" name="paramMap.erGenus" id="erGenus" value="${initMap.exhiInfo.erGenus}">
										</td>
								   	</tr> --%>
								   	<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_6">俗名：</td>
										<td width="85%" class="tatd" align="left">
											<input type="text" name="paramMap.erCustom" id="erCustom" value="${initMap.exhiInfo.erCustom}">
										</td>
								   	</tr> --%>
								   	<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_7">拉丁学名：</td>
										<td width="85%" class="tatd" align="left">
											<input type="text" name="paramMap.erLatinName" id="erLatinName" value="${initMap.exhiInfo.erLatinName}">
										</td>
								   	</tr>
								   	<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_11">保存地：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.erBiologicalReserve" type="text" value="${initMap.exhiInfo.erBiologicalReserve}" maxlength="64" id="erBiologicalReserve" style="width: 200px;" />&nbsp;
										<span id="erBiologicalReserveTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">采集人：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.erHunters" type="text" value="${initMap.exhiInfo.erHunters}" maxlength="64" id="erHunters" style="width: 200px;" />&nbsp;
										<span id="erHuntersTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">采集号：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.erSpecimensNo" type="text" maxlength="16" id="erSpecimensNo" value="${initMap.exhiInfo.erSpecimensNo}" style="width: 200px;" />&nbsp;
										<span id="erSpecimensNoTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_21">采集日期：</td>
										<td width="85%" class="tatd" align="left">
											<input name="paramMap.erSpecimensDate" type="text" class="Wdate" maxlength="10" id="erSpecimensDate" value="<fmt:formatDate value='${initMap.exhiInfo.erSpecimensDate }' pattern='yyyy-MM-dd' />" style="width: 200px;" onFocus="WdatePicker({isShowWeek:true,dateFmt:'yyyy-MM-dd',readOnly:true});" />&nbsp;
											<span id="erSpecimensDateTip" style="position:absolute;height:22px;width:297px"></span>
										</td>
									</tr> --%>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_13">选择地区：</td>
										<td width="85%" class="tatd" align="left">
										<select id="erCountry" name="paramMap.erCountry" onchange="findChildArea(1);" >
											
										</select>
										<select id="erProvince" name="paramMap.erProvince" onchange="findChildArea(2);">
											
										</select>
										<select id="erCity" name="paramMap.erCity" onchange="findChildArea(3);" >
											
										</select>
										<select id="erArea" name="paramMap.erArea" onchange="findChildArea(4);" style="display:none;">
											
										</select>
										<input type="hidden" name="paramMap.erCountryName" id="erCountryName">
										<input type="hidden" name="paramMap.erProvinceName" id="erProvinceName">
										<input type="hidden" name="paramMap.erCityName" id="erCityName">
										<input type="hidden" name="paramMap.erAreaName" id="erAreaName">
										</td>
									</tr>
									<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_14">出土地：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.erPlaceName" type="text" value="${initMap.exhiInfo.erPlaceName}" id="erPlaceName" style="width: 200px;" />&nbsp;
										<span id="erPlaceNameTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr> --%>
									<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_16">分布地区坐标：</td>
										<td width="85%" class="tatd" align="left">
											<input name="paramMap.erLoLa" type="text" id="erLoLa" style="width: 366px;" value="${paramMap.erLoLa}"/>&nbsp;
											<input type="button" id="showMap" value="获取坐标">&nbsp;
										</td>
									</tr> --%>
									<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_8">生境：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.erHabitat" type="text" value="${initMap.exhiInfo.erHabitat}" id="erHabitat" style="width: 200px;" />&nbsp;
										<span id="erHabitatTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_9">性状：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.erCharacteristics" type="text" value="${initMap.exhiInfo.erCharacteristics}" id="erCharacteristics" style="width: 200px;" />&nbsp;
										<span id="erCharacteristicsTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr>
									
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_18">海拔：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.erElevation" type="text" value="${initMap.exhiInfo.erElevation}" maxlength="32" id="erElevation" style="width: 200px;" />&nbsp;
										<span id="erElevationTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_19">鉴定人：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.erIdentifier" type="text" value="${initMap.exhiInfo.erIdentifier}" maxlength="64" id="erIdentifier" style="width: 200px;" />&nbsp;
										<span id="erIdentifierTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_20">鉴定日期：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.erIdentifierDate" type="text" class="Wdate" maxlength="10" value="<fmt:formatDate value='${initMap.exhiInfo.erIdentifierDate }' pattern='yyyy-MM-dd' />" id="erIdentifierDate" style="width: 200px;" onFocus="WdatePicker({isShowWeek:true,dateFmt:'yyyy-MM-dd',readOnly:true});" />&nbsp;
										<span id="erIdentifierDateTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_10">用途：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.erUse" type="text" value="${initMap.exhiInfo.erUse}" id="erUse" style="width: 200px;" />&nbsp;
										<span id="erUseTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr> --%>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="exhibition_17">详细说明：</td>
										<td width="85%" class="tatd" align="left">
										<textarea cols="80" id="erDescription" name="paramMap.erDescription" rows="10">${initMap.exhiInfo.erDescription}</textarea>&nbsp;
										<span id="erDescriptionTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<%-- <tr bgcolor="#ae9b84" id="erContent" >
										<td width="15%" class="tatd" align="right">资源简介：</td>
										<td width="85%" class="tatd" align="left">
											<input type="file" name="upload" id="contentfile" >
 											<input type="hidden" name="title" id="titlecontentfileFile" value="">
 											<input type="hidden" name="paramMap.erContent" value='${initMap.exhiInfo.erContent}'>
 											<span id="contentfileTip" style="position:absolute;height:22px;width:293px"></span>
 										</td>
									</tr> --%>
									<%-- <tr bgcolor="#ae9b84" id="erContent" >
										<td width="15%" class="tatd" align="right">相关链接：</td>
										<td width="85%" class="tatd" align="left">
											<input type="file" name="upload" id="relatedlinksfile" >
 											<input type="hidden" name="title" id="relatedlinksfileFile" value="">
 											<input type="hidden" name="paramMap.erRelatedLinks" value='${initMap.exhiInfo.erRelatedLinks}'>
 											<span id="relatedlinksfileTip" style="position:absolute;height:22px;width:293px"></span>
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
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="303" <s:if test="initMap.exhiInfo.erGrade.indexOf('303') > -1">checked</s:if>><span>三年级</span>
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="304" <s:if test="initMap.exhiInfo.erGrade.indexOf('304') > -1">checked</s:if>><span>四年级</span>
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="305" <s:if test="initMap.exhiInfo.erGrade.indexOf('305') > -1">checked</s:if>><span>五年级</span>
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="306" <s:if test="initMap.exhiInfo.erGrade.indexOf('306') > -1">checked</s:if>><span>六年级</span> 
										</td>
									</tr> --%>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">初中分类：</td>
										<td width="85%" class="tatd" align="left">
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="311" <s:if test="initMap.exhiInfo.erGrade.indexOf('311') > -1">checked</s:if>><span>七年级</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="312" <s:if test="initMap.exhiInfo.erGrade.indexOf('312') > -1">checked</s:if>><span>八年级</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="313" <s:if test="initMap.exhiInfo.erGrade.indexOf('313') > -1">checked</s:if>><span>九年级</span>&nbsp;
										
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">高中分类：</td>
										<td width="85%" class="tatd" align="left">
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="321" <s:if test="initMap.exhiInfo.erGrade.indexOf('321') > -1">checked</s:if>><span>必修一</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="322" <s:if test="initMap.exhiInfo.erGrade.indexOf('322') > -1">checked</s:if>><span>必修二</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="323" <s:if test="initMap.exhiInfo.erGrade.indexOf('323') > -1">checked</s:if>><span>必修三</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="331" <s:if test="initMap.exhiInfo.erGrade.indexOf('331') > -1">checked</s:if>><span>选修一</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="332" <s:if test="initMap.exhiInfo.erGrade.indexOf('332') > -1">checked</s:if>><span>选修二</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="333" <s:if test="initMap.exhiInfo.erGrade.indexOf('333') > -1">checked</s:if>><span>选修三</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="334" <s:if test="initMap.exhiInfo.erGrade.indexOf('334') > -1">checked</s:if>><span>选修四</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="335" <s:if test="initMap.exhiInfo.erGrade.indexOf('335') > -1">checked</s:if>><span>选修五</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="336" <s:if test="initMap.exhiInfo.erGrade.indexOf('336') > -1">checked</s:if>><span>选修六</span>&nbsp;
										</td>
									</tr>
 									<%-- <tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">高中竞赛：</td>
										<td width="85%" class="tatd"  align="left">
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3241" <s:if test="initMap.exhiInfo.erContest.indexOf('3241') > -1">checked</s:if>><span>细胞生物学</span>
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3242" <s:if test="initMap.exhiInfo.erContest.indexOf('3242') > -1">checked</s:if>><span>植物解剖和生理</span>
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3243" <s:if test="initMap.exhiInfo.erContest.indexOf('3243') > -1">checked</s:if>><span>动物解剖和生理</span>
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3244" <s:if test="initMap.exhiInfo.erContest.indexOf('3244') > -1">checked</s:if>><span>动物行为学</span>
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3245" <s:if test="initMap.exhiInfo.erContest.indexOf('3245') > -1">checked</s:if>><span>遗传学与进化</span>
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3246" <s:if test="initMap.exhiInfo.erContest.indexOf('3246') > -1">checked</s:if>><span>生态学</span>
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3247" <s:if test="initMap.exhiInfo.erContest.indexOf('3247') > -1">checked</s:if>><span>生物系统学 </span>
										</td>
									</tr>  --%>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">备注：</td>
										<td width="85%" class="tatd" align="left">
										<textarea cols="80" id="erRemarks" name="paramMap.erRemarks" rows="10">${initMap.exhiInfo.erRemarks}</textarea>&nbsp;
										<span id="erRemarksTip" style="position:absolute;height:22px;width:297px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">日期：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.erCreateTime" type="text" class="Wdate" maxlength="10" value="${initMap.exhiInfo.erCreateTime }" id="erCreateTime" style="width: 200;" onFocus="WdatePicker({isShowWeek:true,dateFmt:'yyyy-MM-dd',readOnly:true});" />&nbsp;
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
		
		<span id="fileup">
			<input type="file" name="upload" id="uploadBigFile" > 
			<input type="button" class="subButton" value="上传">
		</span>
		<span id="enableUp"> （允许上传图片格式包括：.jpg、.png、gif）</span>
		&nbsp;<font color="red">*</font><span id="isUploadTip" style="position:absolute;height:22px;width:120px;"></span>
		&nbsp;<span style="margin-left:100px;">

<%-- 		<a href="downloadAction.action?code=-706&paramMap.resDownRoom=exhibition&paramMap.resDownType=${initMap.exhiInfo.erType}&paramMap.resPath=${initMap.exhiInfo.erUpload}" >下载</a>
 --%>		</span>

	</form>
</div>
<div id="progress" style="left: 140px;">
	<div id="title">
		<%-- <span id="text" class="fontStyle">上传进度</span> --%>
		<div id="close">关闭</div>
	</div>
	<div id="progressBar">
		<div id="uploaded"></div>
	</div>
	<div id="info"></div>
</div>
<div id="rsyncUploadDiv" style="position:absolute;display: none;">
	<iframe id='rsync_target_upload' name='rsync_target_upload' src='' style='display: none'></iframe>
	<form action="/dm/uploadFile/upload" id="rsyncUploadForm" enctype="multipart/form-data" method="post" target="target_upload">
		<input type="hidden" name="uploadFileName" id="rsyncUploadFileName">
		<input type="hidden" name="uploadFilePath" id="rsyncUploadFilePath">
		<input type="file" name="upload" id="rsyncUploadBigFile" > 
		<input type="button" id="rsyncSubButton" value="上传">&nbsp;<font color="red">*</font><span id="rsyncUploadBigFileTip" style="position:absolute;height:22px;width:297px"></span>
	</form>
</div>

<div id="rsyncProgress">
	<div id="rsyncTitle">
		<%-- <span id="rsyncText" class="fontStyle">上传进度</span> --%>
		<div id="rsyncClose">关闭</div>
	</div>
	<div id="rsyncProgressBar">
		<div id="rsyncUploaded"></div>
	</div>
	<div id="rsyncInfo"></div>
</div>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/scripts.js"></script>
</body>
</html>