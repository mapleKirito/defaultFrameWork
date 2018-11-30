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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rsync_progress_bar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dataUtils.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/progressBar.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/res/category.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bodyfocus.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/codebase/GooUploader.css"/>
<script  type="text/javascript" src="<%=request.getContextPath()%>/codebase/GooUploader.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/codebase/swfupload/swfupload.js"></script>
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<script type="text/javascript">
var isInitOK = false ;

var demo2;
var post_params = {session_id:"f1423rwe543t4wrtwerwe"};
$(document).ready(function(){	
	
	//input验证
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){},onsuccess:function(){}});//表单提交 //表单提交 
	$("#orName").formValidator({onshow:"请输入中文名",onfocus:"请输入中文名",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("中文名不能为空,请确认");}});
	$("#orCategory").formValidator({onshow:"请选择资源分类",onfocus:"请选择资源分类",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源分类不能为空,请确认");}});
	$("#orType").formValidator({onshow:"请选择资源类型",onfocus:"请选择资源类型",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源类型不能为空,请确认");}});
	$("#orUpload").formValidator({onshow:"请上传资源文件",onfocus:"请上传资源文件",oncorrect:"上传正确"}).inputValidator({min:1,onerror:function(){alert("资源不能为空,请确认");}});
	$("#isUpload").formValidator({onshow:"请上传资源文件",onfocus:"请上传资源文件",oncorrect:"上传正确"}).inputValidator({min:1,onerror:function(){alert("资源不能为空,请确认");}});
	$("#enableUp").css("left",$("#uploadShowDiv").offset().left + 185);
    $("#enableUp").css("top","5");  
	
	$(".uploadDiv").css("left",$("#uploadShowDiv").offset().left + 8);
    $(".uploadDiv").css("top",$("#uploadShowDiv").offset().top + 7);
  
    /* //初始化缩略图行。该行只有当资源分类为高清图片时，才隐藏。
    var initThumbnail = '${initMap.obseInfo.orCategory}';
    if(initThumbnail!=null && initThumbnail=="1078"){
    	$("#orModelTr").show();
    	$("#obserstylemodify5").show();
    	$("#orType option[value='1011']").remove(); 
		$("#orType option[value='1022']").remove();
		$("#orType option[value='1084']").remove(); 
    }else{
    	$("#orModelTr").hide();
    	$("#obserstylemodify5").hide();
    	$("#orType option[value='4033']").remove(); 
    }
    
    var iniorUpload = '${initMap.obseInfo.orUpload}';
    if(iniorUpload!=null && (iniorUpload.indexOf("jpg") > -1 || iniorUpload.indexOf("png") > -1)){
    	//$("#obserstylemodify5 #upload").hide();
    	$("#obserstylemodify5").hide();
    	$("#orType option[value='4033']").remove(); 
    }else{
    	$("#obserstylemodify5").show();
    } */
    
    $("#obserstylemodify5 #upload").change(function(){
    	$("#obserstylemodify5 #thumformat").html("");
    	$(this).siblings("font").remove();
    	$(this).after("<font color='red'>*</font>");
		$(this).formValidator({}).regexValidator({regexp:"picture",datatype:"enum",onerror:"文件格式不正确（允许上传文件格式有jpg、gif、png）"});
	
    });
    
    /* //点击资源分类操作
    $("#orCategory").change(function(){   	
    	if($(this).val()=="1078"){
    		
    		$("#orType option[value='1011']").remove(); 
    		$("#orType option[value='1022']").remove(); 
    		
    		$("#orType").append($("<option>").text("RAR/ZIP").val("4033"));
    		$("#obserstylemodify5").show();    		
    		
    		$("#enableUp").html("（允许上传压缩格式包括：.rar、.zip）");
    	}else{
    		var indexlast = $("#orType option:last").attr("index");
    		if(typeof indexlast=='undefined'){
    			$("#orType option").remove();
    			$("#orType").append($("<option>").text("----请选择----").val("")).append($("<option>").text("高清图片").val("1011")).append($("<option>").text("3D图片").val("1022"));    			
    		}
    		
    		$("#obserstylemodify5").hide();
    		
    		$("#enableUp").html("（允许上传图片格式包括：.jpg、.png、.gif）");
    	}
    }); */
    
    //$("#uploadShowDivRecommen").append("<span>允许上传首页推荐展示图片格式包括：.jpg、.png</span>");
  	
  	//初始化推荐到首页操作
    var orRecommen = '${initMap.obseInfo.orRecommen}';
    if(orRecommen!=null && orRecommen.indexOf("1")>-1){
    	$("input.orRecommen:checkbox").attr("checked",true);
    	$("#uploadShowDivRecommen input.Recommensize").show();
    	$("#uploadShowDivRecommen span").show();
    	
    	if(orRecommen.indexOf("11")>-1)
    		$("input.Recommensize:first").attr("checked",true);
    	else if(orRecommen.indexOf("22")>-1)
    		$("input.Recommensize:last").attr("checked",true);
   	}else{
		$("input.orRecommen:checkbox").attr("checked",false);
   	}
    
 	 //点击推荐到首页按钮操作
    $(".orRecommen").change(function(){   	
    	if($('input.orRecommen:checkbox:checked').val()=="0"){
    		$(".Recommensize").show();   
    		$("#uploadShowDivRecommen span").show(); 
    	}else{
    		$(".Recommensize").hide();	
    		$("#recommenFile").hide();
    		$("input.Recommensize:radio").attr("checked",false);
			$("#uploadShowDivRecommen span").hide();   
			
			$("#recommenFile").siblings("font").remove();
    		$("#recommenFile").formValidator({});
    		
			$("#orRecommen").val("0");	
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
	
	var userType = "${s_userType}" ;//用户类型 管理员录入数据： 0 ，老师录入数据： 1
	var expentNum = "0000" ;	//未来扩展值
	var resBeginType = "or" ;
	
	
	//上传资源文件触发事件 
	$("#uploadBigFile").change(function(){
			$(".subButton").show();	
			$("#uploadBigFile").select();
			var realFile = $("#uploadBigFile").val() ;
			var date = new Date() ;
			path = "upload/YDS/" + userType + "/" + expentNum + "/" ;
			var fileType = realFile.substring(realFile.lastIndexOf(".") + 1 ,realFile.length) ;
			var fileName = date.getTime() + "." + fileType ; 
			$("#uploadFileName").val(fileName) ;
			$("#uploadFilePath").val(path) ;
			
			if($("#uploadFileType").val() == "handled"){
				var uploadFile = $("#"+resBeginType+"Upload").val() ;
				var upFileType = uploadFile.substring(uploadFile.lastIndexOf(".") + 1 ,uploadFile.length) ;
				
				var prs = RegExp("(.*)\\.(asx|asf|mpg|wmv|3gp|mp4|mov|avi|flv|rmvb|rm|rar|zip|ASX|ASF|MPG|WMV|3GP|MP4|MOV|AVI|FLV|RMVB|RM|RAR|ZIP)$");
				if(prs.test("."+fileType)){
					$(".subButton").show();	
					var file = $("#uploadBigFile");   
					$("#"+resBeginType+"FileSwf").val(path + fileName);
					file.after(file.clone().val(fileName));   
					file.remove();   
				}else{
					alert("您上传的资源格式不正确,请确认");
					$(".subButton").hide();		
				}
				
				
				if($("#"+resBeginType+"Type").val() != "1084"){
					alert("只有高清视频才能上传资源处理文件！！") ;
				}else if(uploadFile == "") {
					alert("请先上传资源主文件！") ;
				}else {
					$("#"+resBeginType+"FileSwf").val(path + fileName);
				}
			}else{
				$("#"+resBeginType+"Upload").val(path + fileName);
				var TypeValue = $("#orType").val();
				if(TypeValue == '1011'){
						$("#obserstylecreate5 #thumformat").html("");
						$("#obserstylecreate5 #thumformat").siblings("font").remove();
						$("#obserstylecreate5 #upload").formValidator({});
						
						if(fileType.toLowerCase().indexOf("jpg".toLowerCase()) > -1 || fileType.toLowerCase().indexOf("png".toLowerCase()) > -1 || fileType.toLowerCase().indexOf("gif".toLowerCase()) > -1){
							$(".subButton").show();	
						}else{
							alert("您上传的资源格式不正确,请确认");
							$(".subButton").hide();		
						}
				 }else
				 if(TypeValue == '1073'){
						var prs = RegExp("(.*)\\.(mp3|MP3)$");
						if(prs.test("."+fileType)){
							$(".subButton").show();	
						}else{
							alert("您上传的资源格式不正确,请确认");
							$(".subButton").hide();		
						}
				  }else
				  if(TypeValue == '4033'){

						$("#obserstylecreate5 #thumformat").html("");
						$("#obserstylecreate5 #thumformat").siblings("font").remove();
						$("#obserstylecreate5 #upload").formValidator({});
						
						if(fileType.toLowerCase().indexOf("rar".toLowerCase()) > -1 || fileType.toLowerCase().indexOf("zip".toLowerCase()) > -1 ){
							$(".subButton").show();	
						}else{
							alert("您上传的资源格式不正确,请确认");
							$(".subButton").hide();		
						}
					}else
					if(TypeValue == '2033' || TypeValue == '2041' || TypeValue == '2055'){
							
							
								if(TypeValue == '2033'){
									if (fileType.toLowerCase().indexOf("doc".toLowerCase()) > -1) {
										$(".subButton").show();	
									}else{
										alert("您上传的资源格式不正确,请确认");
										$(".subButton").hide();		
									}
								}
								
								if(TypeValue == '2041'){
									if (fileType.toLowerCase().indexOf("ppt".toLowerCase()) > -1) {
										$(".subButton").show();	
									}else{
										alert("您上传的资源格式不正确,请确认");
										$(".subButton").hide();		
									}
								}
								
								if(TypeValue == '2055'){
									if(fileType.toLowerCase().indexOf("pdf".toLowerCase()) > -1){
										$(".subButton").show();	
									}else{
										alert("您上传的资源格式不正确,请确认");
										$(".subButton").hide();		
									}
								}
								
					}else
					if(TypeValue == '2095'){
						if(fileType.toLowerCase().indexOf("swf".toLowerCase()) > -1){
							$(".subButton").show();	
						}else{
							alert("您上传的资源格式不正确,请确认");
							$(".subButton").hide();		
						}
					 }else
					 if(TypeValue == '1084'){
						var prs = RegExp("(.*)\\.(asx|asf|mpg|wmv|3gp|mp4|mov|avi|flv|rmvb|rm|ASX|ASF|MPG|WMV|3GP|MP4|MOV|AVI|FLV|RMVB|RM)$");
						if(prs.test("."+fileType)){
							$(".subButton").show();	
						}else{
							alert("您上传的资源格式不正确,请确认");
							$(".subButton").hide();		
						}
					}else{
						$(".subButton").hide();	
					}
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
			$("#enableUp").html("（允许视频格式：rmvb、wmv、mp4、flv、mpg等）");
		}
		
	});
	
	//点击是否上传音频Radio操作
    $(".orUpAudio").change(function(){   	
    	if($('input.orUpAudio:radio:checked').val()=="orUpYAudio"){
    		$("#rsyncUploadDiv").show();
    		$("#rsyncUploadBigFile").formValidator({onshow:"请上传音频（允许上传的格式为mp3）",onfocus:"请上传音频（允许上传的格式为mp3）",oncorrect:"请上传音频（允许上传的格式为mp3）"}).regexValidator({regexp:"audio",datatype:"enum",onerror:"音频格式不正确（允许上传的格式为mp3）"});
    	}else{
    		$("#rsyncUploadDiv").hide();	
    		$("#rsyncUploadBigFile").formValidator({});
    	}
    });   
	
    $("#rsyncUploadDiv").css("left",$("#rsyncUploadShowDiv").offset().left + 100);
    $("#rsyncUploadDiv").css("top",$("#rsyncUploadShowDiv").offset().top + 8);
	
    var audio = '${initMap.obseInfo.orAudio}';
    if(audio!=''){
    	//alert($("#rsyncUploadShowDiv .orUpAudio").html());
    	/* $("input:radio[.orUpAudio]:eq(0)").attr("checked",'checked'); */
    	document.getElementById("orUpYAudio").checked = true;
    }else{
    	/* $("input:radio[.orUpAudio]:eq(1)").attr("checked",'checked'); */
    	document.getElementById("orUpNAudio").checked = true;
    }
    
	//添加缩略图上传图片格式验证
   // $("#thumformat").html("允许上传缩略图文件格式包括：.jpg、.png");
	
	//初始化资源分类事件
	var cid = $("#orCategory").val();
	$.ajax({
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
						var ctempid = $("#orCateTwLevel").val();
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
    					$("#orCateTwLevel").val("");
    			    	$("#orCateTwLevelName").val("");	
					}
				} 
			}
		},
		error:function(request,textStatus,error){}
	});

	//点击资源分类时触发事件
    $("#jie").change(function(){
    	var sval = $(this).val();
    	var stxt = $(this).find("option:selected").text();
    	
    	$("#orCategory").val(sval) ;
    	$("#orCategoryName").val(stxt) ;
    
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
    					if(jsonData.data.length != 0){
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
	    					$("#orCateTwLevel").val("");
	    			    	$("#orCateTwLevelName").val("");	
	    				}
    				} 
    			}
    		},
    		error:function(request,textStatus,error){}
    	});
    });
	
    //点击二级分类时触发事件
    $("#jie2").change(function(){
    	var sval = $(this).val() ;
     	var stxt = $(this).find("option:selected").text() ;
    	//alert(sval + "---" + stxt);
    	if (sval){
    		$("#orCateTwLevel").val(sval);	
    	}
    	if (stxt){
    		$("#orCateTwLevelName").val(stxt);
    	}
    	
    });
    
    //初始化页面上传文件提示。
   
    var initOrType ='${initMap.obseInfo.orType}';
    //alert(initOrType);
	if(initOrType == '1011'){
		$("#enableUp").html("（允许上传高清图片格式包括：.jpg、.png）");
		document.getElementById("obserstylecreate5").style.display="none" ;
		$("#res_change_name").html("高清图片："); 
		$("#isUploadRadio").show();
	}else if(initOrType == '1073'){
		$("#enableUp").html("（允许音频格式：MP3）");
		document.getElementById("obserstylecreate5").style.display="" ;
		$("#res_change_name").html("音频："); 
		$("#isUploadRadio").hide();
	}else if(initOrType == '1084'){
		$("#enableUp").html("（允许视频格式：rmvb、wmv、mp4、flv、mpg等）");
		document.getElementById("obserstylecreate5").style.display="" ;
		$("#res_change_name").html("高清视频："); 
		$("#isUploadRadio").hide();
	}else if(initOrType == '2095'){
		$("#enableUp").html("（允许上传动画类格式包括：.swf）");
		document.getElementById("obserstylecreate5").style.display="none" ;
		$("#res_change_name").html("动画类资源："); 
		$("#isUploadRadio").hide();
	}else if(initOrType == '2033'){
		$("#enableUp").html("（允许上传文档格式包括：.doc  .docx）");
		document.getElementById("obserstylecreate5").style.display="" ;
		$("#res_change_name").html("word文档：");
		$("#isUploadRadio").hide();
	}else if(initOrType == '2041'){
		$("#enableUp").html("（允许上传文档格式包括：.ppt  .pptx）");
		document.getElementById("obserstylecreate5").style.display="" ;
		$("#res_change_name").html("ppt文档：");
		$("#isUploadRadio").hide();
	}else if(initOrType == '2055'){
		$("#enableUp").html("（允许上传文档格式包括：.pdf）");
		document.getElementById("obserstylecreate5").style.display="" ;
		$("#res_change_name").html("pdf文档：");
		$("#isUploadRadio").hide();
	}else if(initOrType == '4033'){
		$("#enableUp").html("（允许上传压缩格式包括：.rar、.zip）");
		document.getElementById("obserstylecreate5").style.display="" ;
		$("#res_change_name").html("压缩包资源：");
		$("#isUploadRadio").hide();
	}else if(initOrType == '2095'){
		$("#enableUp").html("（允许上传文件格式包括：.swf）");
		document.getElementById("obserstylecreate5").style.display="" ;
		$("#res_change_name").html("swf文件：");
		$("#isUploadRadio").hide();
	}
    
    //点击资源类型时,页面上传文件提示操作
    $("#"+resBeginType+"Type").change(function(){ 
    	$(".subButton").hide();		
		var ty = $(this).val();
		if(ty == '1011'){
			$("#enableUp").html("（允许上传高清图片格式包括：.jpg、.png、.gif）");
			$("#res_change_name").html("高清图片："); 
			$("#obserstylemodify5").hide();
			$("#obserstylemodify5 #upload").siblings("font").remove();
			$("#obserstylemodify5 #upload").formValidator({});
			$("#audioisshow").show();
		}else if(ty == '1084'){
			$("#enableUp").html("（允许视频格式：rmvb、wmv、mp4、flv、mpg等）");
			$("#res_change_name").html("高清视频：");
			$("#obserstylemodify5").show();
			$("#audioisshow").hide();
		}else if(ty == '4033'){
			$("#enableUp").html("（允许上传压缩格式包括：.rar、.zip）");
			$("#res_change_name").html("压缩包：");
			$("#obserstylemodify5").show();
			$("#audioisshow").hide();
		}else if(ty == '1073'){
			$("#enableUp").html("（允许上传音频格式包括：.mp3）");
			$("#res_change_name").html("音频：");
			$("#obserstylemodify5").show();
			$("#audioisshow").hide();
		}else if(ty == '2033'){
			$("#enableUp").html("（允许文档格式：doc）");
			$("#res_change_name").html("word文档：");
			$("#obserstylemodify5").show();
			$("#audioisshow").hide();
		}else if(ty == '2041'){
			$("#enableUp").html("（允许上传的文档格式包括：.ppt）");
			$("#res_change_name").html("文档：");
			$("#obserstylemodify5").show();
			$("#audioisshow").hide();
		}else if(ty == '2055'){
			$("#enableUp").html("（允许上传的文档格式包括：.pdf）");
			$("#res_change_name").html("文档：");
			$("#obserstylemodify5").show();
			$("#audioisshow").hide();
		}else if(ty == '2095'){
			$("#enableUp").html("（允许上传文件格式包括：.swf）");
			document.getElementById("obserstylemodify5").style.display="none" ;
			$("#res_change_name").html("swf文件：");
			$("#audioisshow").hide();
		}
	});

});

function onchangeUpload(uploadFile){
	$("#" + uploadFile).val("1") ;
	$("#title" + uploadFile).val("title" + uploadFile) ;

	//资源分类为多为观察时,添加缩略图验证需用到。
	if($("#orUpload").val() != $("#oldResUpload").val() && $("#orType").val() == '4033' ){
		$("#orThumbnailVali").val("--");
	}
	
	
}

/****************下拉输入框****************/
function filter(treeId, parentNode, childNodes) {
	if (!childNodes) return null;
	if (childNodes.data){
		childNodes = childNodes.data;
	}
	return childNodes;
}
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
function beforeAsync(treeId, treeNode) {
	return treeNode ? treeNode.level < 10 : true;
}
function attr(y){
	var reg = /^\s+$/;
	return (typeof y != 'undefined' && y != '' && y != null && !reg.test(y) && y!='null');
}
/****************下拉输入框****************/

</script>
</head>
<body>
<div id="layout_mainbody" >
<input type="hidden" id="roomtype" value="observation">
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<input type="hidden" name="code" value="${code}"> 
<input name="paramMap.orIsShare" type="hidden" id="IsShare" value="1"/>
<input name="paramMap.isUpdate" type="hidden" id="isUpdate" value="xiugai"/>
<input name="paramMap.orID" type="hidden" id="orID" value="${initMap.obseInfo.orID}"/>
<input type="hidden" name="imitateStep" value="${pmsIndex.res_observation_room_mgr.imitationStep}">
<input name="paramMap.resType" type="hidden" value="observation"/>
<s:if test="initMap.obseInfo.orType == '1011' ">
	<input name="paramMap.Old1011InThum" type="hidden" value="${initMap.obseInfo.orInThum}"/>
	<input name="paramMap.Old1011Thumbnail" type="hidden" value="${initMap.obseInfo.orThumbnail}"/>
</s:if>

<input name="paramMap.status" id="status"  type="hidden"  value="isCreate"/>
<input name="paramMap.referResLen" id="referResLen"  type="hidden"  />
<input name="paramMap.resType" type="hidden" value="observation"/>
<input name="paramMap.referismodi" id="referismodi"  type="hidden"  value="istrue"/>

<input name="paramMap.orAbout" type="hidden" id="relations" value="${initMap.obseInfo.orAbout}"/>
<input name="paramMap.orRelation" type="hidden" id="setRelations" value="${initMap.obseInfo.orRelation}"/>

<input name="paramMap.thecode" type="hidden" value="${initMap.obseInfo.orNO}"/>
<input name="paramMap.modifycateerorCategory" type="hidden" value="${initMap.obseInfo.orCategory}"/>
<input name="paramMap.modifycateerorCateTwLevel" type="hidden" value="${initMap.obseInfo.orCateTwLevel}"/>

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
										<td width="85%" class="tatd" align="left"><input name="paramMap.orName" type="text" value="${initMap.obseInfo.orName}" maxlength="180" id="orName" style="width: 200px;" />&nbsp;
										<font color="red">*</font><span id="orNameTip" style="position:absolute;height:22px;width:270px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">搜索关键词：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.orKeywords" type="text" id="orKeywords" style="width: 200px;" value="${initMap.obseInfo.orKeywords}"/>&nbsp;
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源分类：</td>
										<td width="85%" class="tatd" align="left">
										  	<input type="hidden" name="paramMap.orCategory" id="orCategory" value="${initMap.obseInfo.orCategory}" maxlength="180" style="width: 200px;">
											<input type="hidden" name="paramMap.orCategoryName" id="orCategoryName" value="${initMap.obseInfo.orCategoryName}" maxlength="180" style="width: 200px;">
											<select name="jie" id="jie">
												<s:iterator value="initMap.resCategoryList" id="cate" status="ind">
													<option value="${cate.cateID}" ${initMap.obseInfo.orCategory eq cate.cateID ? 'selected':'' }>${cate.cateName}</option>
												</s:iterator>
											</select>
											<font color="red">*</font><span id="orCategoryTip" style="position:absolute;height:22px;width:270px"></span>
										</td>
									</tr>
								   	<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源类型：</td>
										<td width="85%" class="tatd" align="left">
											<select name="paramMap.orType" id="orType">
												<option value="">----请选择----</option>

												<option value="1011" ${initMap.obseInfo.orType eq "1011" ? 'selected':'' }>高清图片</option>
												<option value="1073" ${initMap.obseInfo.orType eq "1073" ? 'selected':'' }>音频</option>
												<option value="1084" ${initMap.obseInfo.orType eq "1084" ? 'selected':'' }>高清视频</option>
												<option value="4033" ${initMap.obseInfo.orType eq "4033" ? 'selected':'' }>压缩包</option>
												<option value="2095" ${initMap.obseInfo.orType eq "2095" ? 'selected':'' }>swf课件</option>
												<option value="2033" ${initMap.obseInfo.orType eq "2033" ? 'selected':'' }>WORD课件</option>
												<option value="2041" ${initMap.obseInfo.orType eq "2041" ? 'selected':'' }>PPT课件</option>
												<option value="2055" ${initMap.obseInfo.orType eq "2055" ? 'selected':'' }>PDF课件</option>
											</select>
											&nbsp;<font color="red">*</font><span id="orTypeTip" style="position:absolute;height:22px;width:100px"></span>
											<input type="hidden" name="paramMap.oldResType" id="oldResType" value="${initMap.obseInfo.orType}" >
										</td>
								   	</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right" id="res_change_name">资源文件：</td>
										<td width="85%" class="tatd" align="left" id="uploadShowDiv">
										<input type="hidden" name="paramMap.oldResUpload" id="oldResUpload" value="${initMap.obseInfo.orUpload}" >
										<input type="hidden" name="paramMap.orUpload" id="orUpload" value="${initMap.obseInfo.orUpload}">
										<input type="hidden" name="paramMap.isUpload" id="isUpload" value="1">
										<s:if test="initMap.obseInfo.orType == '4033' || initMap.obseInfo.orType == '1084' ">
											<input type="hidden" name="paramMap.orFileSwf" id="orFileSwf" value="${initMap.obseInfo.orFileSwf}">
											
										</s:if>
									</tr>
									<tr bgcolor="#ae9b84" id="fileAssistUpload" style="display: none;">
										<td width="15%" class="tatd" align="right">文件上传</td>
										<td width="85%" class="tatd" align="left" >
											<div style="padding: 5px;border: 1px solid #d0d4d5;width: 600px;height: 300px;  " class="deupload" >
											<div id="demo2" ></div></div>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" id="obserstylecreate5">
										<td width="15%" class="tatd" align="right">缩略图：</td>
										<td width="85%" class="tatd" align="left">
										<img alt="" src="${initMap.obseInfo.orThumbnail}" width="50px" height="50px">
										<input type="file" name=upload id="upload" class="thumUpload" onchange="onchangeUpload('uploadThumFile');" value="${initMap.obseInfo.orThumbnail}"/>
										<span id="uploadTip" style="position:absolute;height:22px;width:270px"></span>
										<input type="hidden" name="paramMap.uploadThumFile" id="uploadThumFile" value="0">
										<input type="hidden" name="paramMap.olduploadThumFile" id="olduploadThumFile" value="${initMap.obseInfo.orThumbnail}">
										<input type="hidden" name="title" id="titleuploadThumFile" value="">
										<input type="hidden" name="paramMap.orThumbnail" id="orThumbnail" value="${initMap.obseInfo.orThumbnail}">
										<input type="hidden" id="orThumbnailVali" value="">
										<span id="thumformat"></span>
										<span id="thumrarzipmust"></span>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" id="orModelTr" style="display: none;">
										<td width="15%" class="tatd" align="right">展示模式：</td>
										<td width="85%" class="tatd" align="left" >
											<input type="radio" name="paramMap.orModel" value="0" class="ormode" ${initMap.obseInfo.orModel eq "0" ? 'checked="checked"':'' }><span>循环模式（指360度旋转观察。如：静态标本旋转观察。）</span>
											<input type="radio" name="paramMap.orModel" value="1" class="ormode" ${initMap.obseInfo.orModel eq "1" ? 'checked="checked"':'' }><span>非循环模式（指以时间变化或空间变化。如：树叶生长过程、白天到黑夜。）</span>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" id="isUploadRadio">
										<td width="15%" class="tatd" align="right">是否上传音频：</td>
										<td width="85%" class="tatd" align="left"  id="rsyncUploadShowDiv">
											<input type="radio" name="paramMap.orUpAudio" class="orUpAudio" id="orUpYAudio" value="orUpYAudio"><span>是</span>
											<input type="radio" name="paramMap.orUpAudio" class="orUpAudio" id="orUpNAudio" value="orUpNAudio"><span>否</span>
																						
											<input type="hidden" name="paramMap.olderUpAudio" value="${initMap.obseInfo.orAudio}">
											<input type="hidden" name="paramMap.orAudio" id="orAudio" value="${initMap.obseInfo.orAudio}">
											<%-- <a href="downloadAction.action?code=-706&paramMap.resDownRoom=observation&paramMap.resDownType=${initMap.obseInfo.orType}&paramMap.resPath=${initMap.obseInfo.orAudio}" ><span>下载</span></a> --%>
										</td>
								   	</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">推荐到首页：</td>
										<td width="85%" class="tatd" align="left" id="uploadShowDivRecommen">
											<input type="checkbox" name="orRec" value="0" class="orRecommen"> 

											<input type="radio" name="Recommensize" value="11" class="Recommensize" style="display: none;"><span style="display: none;">305*145</span>
											<input type="radio" name="Recommensize" value="22" class="Recommensize" style="display: none;"><span style="display: none;">143*145</span>
											
											<input type="file" name=upload id="recommenFile" onchange="onchangeUpload('orRecommen');" style="display: none;" />
											<span id="recommenFileTip" style="position:absolute;height:22px;width:270px"></span>
											<input type="hidden" name="paramMap.orRecommen" id="orRecommen" value="${initMap.obseInfo.orRecommen}">
											<input type="hidden" name="paramMap.Recommensize" id="Recommensize" value="${initMap.obseRecommen.reSize}">
											<input type="hidden" name="paramMap.OldorRecommenFile" id="OldorRecommenFile" value="${initMap.obseRecommen.reRecoFileUP}">
											<input type="hidden" name="title" id="titleuploadRecommenFile" value="">
										</td>
									</tr>
									<tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">相关资源推荐：</td>
										<td width="85%" class="tatd" align="left" >
										<input type="checkbox"  id="outside" value="0" onclick="Change(this);" >
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">二级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.orCateTwLevel" id="orCateTwLevel" style="width: 200px;" value="${initMap.obseInfo.orCateTwLevel}">
											<input type="hidden" name="paramMap.orCateTwLevelName" id="orCateTwLevelName" style="width: 200px;" value="${initMap.obseInfo.orCateTwLevelName}">
											<select id="jie2" name="jie2"  style="width: 100;" ><option>----请选择----</option></select>
										</td>
									</tr>
									<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">俗名：</td>
										<td width="85%" class="tatd" align="left">
											<input type="text" name="paramMap.orCustom" id="orCustom" value="${initMap.obseInfo.orCustom}">
										</td>
								   	</tr> --%>
								   	<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">拉丁学名：</td>
										<td width="85%" class="tatd" align="left">
											<input type="text" name="paramMap.orLatinName" id="orLatinName" value="${initMap.obseInfo.orLatinName}">
										</td>
								   	</tr>
									
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">鉴定人：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.orIdentifier" type="text" value="${initMap.obseInfo.orIdentifier}" maxlength="64" id="orIdentifier" style="width: 200px;" />&nbsp;
										<span id="orIdentifierTip" style="position:absolute;height:22px;width:270px"></span></td>
									</tr> --%>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">详细说明：</td>
										<td width="85%" class="tatd" align="left">
										<textarea cols="80" id="orDescription" name="paramMap.orDescription" rows="10">${initMap.obseInfo.orDescription}</textarea>&nbsp;
										<span id="orDescriptionTip" style="position:absolute;height:22px;width:270px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<%-- <tr bgcolor="#ae9b84" id="orContent" >
										<td width="15%" class="tatd" align="right">资源简介：</td>
										<td width="85%" class="tatd" align="left">
										   <textarea cols="80" id="editor1" name="paramMap.orContent" rows="10">${initMap.obseInfo.orContent}</textarea>
										    <script type="text/javascript">
											CKEDITOR.replace('editor1',{ filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=observation&orno='+'${initMap.obseInfo.orNO}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=observation&orno='+'${initMap.obseInfo.orNO}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=observation&orno='+'${initMap.obseInfo.orNO}' } );
 											</script>
 											<input type="file" name="upload" id="contentfile" >
 											<input type="hidden" name="title" id="titlecontentfileFile" value="">
 											<input type="hidden" name="paramMap.orContent" value="${initMap.obseInfo.orContent}">
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
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="303" <s:if test="initMap.obseInfo.orGrade.indexOf('303') > -1">checked</s:if>><span>三年级</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="304" <s:if test="initMap.obseInfo.orGrade.indexOf('304') > -1">checked</s:if>><span>四年级</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="305" <s:if test="initMap.obseInfo.orGrade.indexOf('305') > -1">checked</s:if>><span>五年级</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="306" <s:if test="initMap.obseInfo.orGrade.indexOf('306') > -1">checked</s:if>><span>六年级</span>&nbsp; 
										</td>
									</tr> --%>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">初中分类：</td>
										<td width="85%" class="tatd" align="left">
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="311" <s:if test="initMap.obseInfo.orGrade.indexOf('311') > -1">checked</s:if>>七年级&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="312" <s:if test="initMap.obseInfo.orGrade.indexOf('312') > -1">checked</s:if>>八年级&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="313" <s:if test="initMap.obseInfo.orGrade.indexOf('313') > -1">checked</s:if>>九年级&nbsp;
										
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
											<td width="15%" class="tatd" align="right">高中分类：</td>
											<td width="85%" class="tatd" align="left">
											
											 <input type="checkbox" name="paramMap.grGrades" id="grGrades" value="321" <s:if test="initMap.obseInfo.orGrade.indexOf('321') > -1">checked</s:if>><span>必修一</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="322" <s:if test="initMap.obseInfo.orGrade.indexOf('322') > -1">checked</s:if>><span>必修二</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="323" <s:if test="initMap.obseInfo.orGrade.indexOf('323') > -1">checked</s:if>><span>必修三</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="331" <s:if test="initMap.obseInfo.orGrade.indexOf('331') > -1">checked</s:if>><span>选修一</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="332" <s:if test="initMap.obseInfo.orGrade.indexOf('332') > -1">checked</s:if>><span>选修二</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="333" <s:if test="initMap.obseInfo.orGrade.indexOf('333') > -1">checked</s:if>><span>选修三</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="334" <s:if test="initMap.obseInfo.orGrade.indexOf('334') > -1">checked</s:if>><span>选修四</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="335" <s:if test="initMap.obseInfo.orGrade.indexOf('335') > -1">checked</s:if>><span>选修五</span>&nbsp;
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="336" <s:if test="initMap.obseInfo.orGrade.indexOf('336') > -1">checked</s:if>><span>选修六</span>&nbsp;
							
											
											
											
										</td>
									</tr>
 									<!-- <tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">高中竞赛：</td>
										<td width="85%" class="tatd"  align="left">
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3241" <s:if test="initMap.obseInfo.orContest.indexOf('3241') > -1">checked</s:if>>细胞生物学&nbsp;
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3242" <s:if test="initMap.obseInfo.orContest.indexOf('3242') > -1">checked</s:if>>植物解剖和生理&nbsp;
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3243" <s:if test="initMap.obseInfo.orContest.indexOf('3243') > -1">checked</s:if>>动物解剖和生理&nbsp;
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3244" <s:if test="initMap.obseInfo.orContest.indexOf('3244') > -1">checked</s:if>>动物行为学&nbsp;
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3245" <s:if test="initMap.obseInfo.orContest.indexOf('3245') > -1">checked</s:if>>遗传学与进化&nbsp;
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3246" <s:if test="initMap.obseInfo.orContest.indexOf('3246') > -1">checked</s:if>>生态学&nbsp;
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3247" <s:if test="initMap.obseInfo.orContest.indexOf('3247') > -1">checked</s:if>>生物系统学 &nbsp;
										</td>
									</tr>  -->
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">备注：</td>
										<td width="85%" class="tatd" align="left">
										<textarea cols="80" id="orRemarks" name="paramMap.orRemarks" rows="10">${initMap.obseInfo.orRemarks}</textarea>&nbsp;
										<span id="orRemarksTip" style="position:absolute;height:22px;width:270px"></span></td>
									</tr>
						 			<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">日期：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.orCreateTime" type="text" class="Wdate" maxlength="10" value="${initMap.obseInfo.orCreateTime }" id="orCreateTime" style="width: 200;" onFocus="WdatePicker({isShowWeek:true,dateFmt:'yyyy-MM-dd',readOnly:true});" />&nbsp;
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
		<span id="enableUp" >（允许上传图片格式包括：.jpg、.png、.gif）</span>
		&nbsp;<font color="red">*</font><span id="isUploadTip" style="position:absolute;height:22px;"></span>
		&nbsp;<span style="margin-left:100px;">
		<%-- <a href="downloadAction.action?code=-706&paramMap.resDownRoom=observation&paramMap.resDownType=${initMap.obseInfo.orType}&paramMap.resPath=${initMap.obseInfo.orUpload}" >下载</a> --%>
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
<div id="rsyncUploadDiv" style="position:absolute;display: none;">
	<iframe id='rsync_target_upload' name='rsync_target_upload' src='' style='display: none'></iframe>
	<form action="/dm/uploadFile/upload" id="rsyncUploadForm" enctype="multipart/form-data" method="post" target="target_upload">
		<input type="hidden" name="uploadFileName" id="rsyncUploadFileName">
		<input type="hidden" name="uploadFilePath" id="rsyncUploadFilePath">
		<input type="file" name="upload" id="rsyncUploadBigFile" > 
		<input type="button" id="rsyncSubButton" value="上传">&nbsp;<font color="red">*</font><span id="rsyncUploadBigFileTip" style="position:absolute;height:22px;width:297px;color:#ffffff;"></span>
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