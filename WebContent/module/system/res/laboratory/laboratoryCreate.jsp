<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<html>
<title></title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/progressBar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dataUtils.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/progressBar.css">
<%-- <script  type="text/javascript" src="<%=request.getContextPath()%>/codebase/jquery-1.3.2.min.js"></script> --%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/codebase/GooUploader.css"/>
<script  type="text/javascript" src="<%=request.getContextPath()%>/codebase/GooUploader.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/codebase/swfupload/swfupload.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />
 
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
.table_9 #fileAssistUpload td div{ -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; CCborderRadius: 5px; }
</style>
<script type="text/javascript">
var demo2;
var post_params = {session_id:"f1423rwe543t4wrtwerwe"};
$(document).ready(function(){	
	//初始化定位上传插件坐标
	$(".uploadDiv").css("left",$("#uploadShowDiv").offset().left + 8);
    $(".uploadDiv").css("top",$("#uploadShowDiv").offset().top + 7);
   
	//input验证
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){},onsuccess:function(){}});//表单提交 
	$("#lrName").formValidator({onshow:"请输入中文名",onfocus:"请输入中文名",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("中文名不能为空,请确认");}});
	$("#total").formValidator({onshow:"请选择资源分类",onfocus:"请选择资源分类",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源分类不能为空,请确认");}});
	$("#cateTwLevel").formValidator({onshow:"请选择二级分类",onfocus:"请选择二级分类",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("二级分类不能为空,请确认");}});
	$("#lrType").formValidator({onshow:"请选择资源类型",onfocus:"请选择资源类型",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源类型不能为空,请确认");}});
	$("#isUpload").formValidator({onshow:"请上传资源文件",onfocus:"请上传资源文件",oncorrect:"上传正确"}).inputValidator({min:1,onerror:function(){alert("资源不能为空,请确认");}});
	
	var d = new Date(), datestr = '';
	datestr += d.getFullYear() + '-';
	datestr += d.getMonth() + 1 + '-';
	datestr += d.getDate();
	$("#lrCreateTime").val(datestr);
	
	var userType = "${s_userType}" ;//用户类型 管理员录入数据： 0 ，老师录入数据： 1
	var expentNum = "0000" ;	//未来扩展值
	var resBeginType = "lr" ;
	var path = "";
	
	
	//上传资源文件触发事件 
	$("#uploadBigFile").change(function(){
		
		$(".subButton").show();	
		$("#uploadBigFile").select();
		var realFile = $("#uploadBigFile").val() ;
		var date = new Date() ;
		path = "upload/YJS/" + userType + "/" + expentNum + "/" ;
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
			
			var TypeValue = $("#lrType").val();
			
			if(TypeValue == '1011'){
				$("#laborstylecreate6 #thumformat").html("");
				$("#laborstylecreate6 #thumformat").siblings("font").remove();
				$("#laborstylecreate6 #upload").formValidator({});
				
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
	
					$("#laborstylecreate6 #thumformat").html("");
					$("#laborstylecreate6 #thumformat").siblings("font").remove();
					$("#laborstylecreate6 #upload").formValidator({});
					
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
			$("#enableUp").html("（允许上传视频格式包括：.mp4）");
		}
	});
	
	$("#laborstylecreate6 #upload").change(function(){
    	$("#laborstylecreate6 #thumformat").html("");
    	$(this).siblings("font").remove();
    	$(this).after("<font color='red'>*</font>");
		$(this).formValidator({}).regexValidator({regexp:"picture",datatype:"enum",onerror:"文件格式不正确（允许上传文件格式有jpg、gif、png）"});
	
    });
	
	//$("#uploadShowDivRecommen").append("<span>允许上传首页推荐展示图片格式包括：.jpg、.png</span>");
	
	//点击推荐到首页按钮操作
    $(".lrRecommen").change(function(){   	
    	$("#lrRecommen").val("1");
    	$("#uploadShowDivRecommen span").show();
    	if($('input.lrRecommen:checkbox:checked').val()=="0"){
    		$(".Recommensize").show();   
    	}else{
    		$(".Recommensize").hide();   
    		$("#recommenFile").hide();
    		$("input.Recommensize:radio").attr("checked",false);
    		$("#uploadShowDivRecommen span").hide();    	
    		$("#recommenFile").siblings("font").remove();
    		$("#recommenFile").formValidator({});
    	}
    });
    
    $(".Recommensize").change(function(){    			
		$("#recommenFile").show();
		$("#Recommensize").val($('input.Recommensize:radio:checked').val());
		$("#recommenFile").siblings("font").remove();
		$("#recommenFile").after("<font color='red'>*</font>");
		$("#recommenFile").formValidator({onshow:"请选择文件",onfocus:"请选择文件",oncorrect:"请选择文件"}).regexValidator({regexp:"picture",datatype:"enum",onerror:"文件格式不正确"});
   	});
    
    $("#recommenFile").change(function(){    
    	$("#lrRecommenFile").val($("#recommenFile").val());
    	$("#titleuploadRecommenFile").val("titleuploadRecommenFile");   	
    });
    
    $("#contentfile").change(function(){    
    	$("#contentHelp").val("1");
    	$("#titlecontentfileFile").val("titlecontentfileFile");
    	$(this).siblings("font").remove();
    	$(this).after("<font color='red'>*</font>");
    	$(this).formValidator({}).regexValidator({regexp:"word",datatype:"enum",onerror:"文件格式不正确（允许上传文件格式有doc、docx）"});
    });
    
    //点击资源分类触发事件
    $("#total").change(function(){
    	var sval = $(this).val();
    	var stxt = $(this).find("option:selected").text();

    	if(sval!=""){
    		$("#lrCategory").val(sval) ;	
    	}else{
    		$("#lrCategory").val("") ;
    	}
    	
    	if(stxt!=""){
    		$("#lrCategoryName").val(stxt) ;	
    	}else{
    		$("#lrCategoryName").val("") ;
    	}
    	
    	if(sval == 204){
	   		$("#enableUp").html("（允许上传文档格式包括：.ppt、.doc、.pdf、.pptx、.docx）");
			document.getElementById("laborstylecreate6").style.display="" ;
		
			$("#lrType  option[index!='0']").remove();
			$("#lrType").append($("<option>").text("PPT课件").val("2041")).append($("<option>").text("WORD课件").val("2033")).append($("<option>").text("PDF课件").val("2055"));
		}
		
		if(sval == 205){
			$("#enableUp").html("（允许视频格式：rmvb、wmv、mp4、flv、mpg等）");
			document.getElementById("laborstylecreate6").style.display="" ;
			
			$("#lrType  option[index!='0']").remove();
			$("#lrType").append($("<option>").text("高清视频").val("1084"));
		}
		
		if(sval == 206){
			$("#enableUp").html("（允许上传图片格式包括：.jpg、.png、gif）");
			document.getElementById("laborstylecreate6").style.display="none" ;
			
			$("#lrType  option[index!='0']").remove();
			$("#lrType").append($("<option>").text("高清图片").val("1011"));
		}
    	
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
    						document.getElementById("cateTwLevel").disabled=false;
	    					var $cobj = $("#cateTwLevel"); 
	    					$cobj.find("option").remove();
	    					$cobj.append($("<option></option>").attr("value","").text("----请选择----"));
		    				for (var i=0; i<jsonData.data.length;i++){
	    						var cateID = jsonData.data[i].cateID;
	    						var cateName = jsonData.data[i].cateName;
	    						$cobj.append($("<option></option>").attr("value",cateID).text(cateName));
	    					}

	    				}else{
	    					document.getElementById("cateTwLevel").disabled=true;
	    					var $cobj = $("#cateTwLevel"); 
	    					$cobj.find("option").remove();
	    					$cobj.append($("<option></option>").attr("value","").text("----请选择----"));
	    					$("#lrCateTwLevel").val("");
	    			    	$("#lrCateTwLevelName").val("");

	    				}
    				} 
    			}
    		},
    		error:function(request,textStatus,error){}
    	});
    	
    	
    });
    
 	 //添加缩略图上传图片格式验证
    $("#thumformat").html("允许上传缩略图文件格式包括：.jpg、.png");
    
    //点击二级分类时触发事件
    $("#cateTwLevel").change(function(){
    	var sval = $(this).val() ;
    	var stxt = $(this).find("option:selected").text() ;  	
    	$("#lrCateTwLevel").val(sval);
    	$("#lrCateTwLevelName").val(stxt);	
    });
    
    //点击资源类型时,页面上传文件提示操作
     
   //点击资源类型触发事件 
    $("#"+resBeginType+"Type").change(function(){ 
    	$(".subButton").hide();	
		var ty = $(this).val();
		if(ty == '1011'){
			$("#enableUp").html("（允许上传高清图片格式包括：.jpg、.png）");
			document.getElementById("laborstylecreate6").style.display="none" ;
			$("#res_change_name").html("高清图片："); 
			$("#isUploadRadio").show();
		}else if(ty == '1073'){
			$("#enableUp").html("（允许音频格式：MP3）");
			document.getElementById("laborstylecreate6").style.display="" ;
			$("#res_change_name").html("音频："); 
			$("#isUploadRadio").hide();
		}else if(ty == '1084'){
			$("#enableUp").html("（允许视频格式：rmvb、wmv、mp4、flv、mpg等）");
			document.getElementById("laborstylecreate6").style.display="" ;
			$("#res_change_name").html("高清视频："); 
			$("#isUploadRadio").hide();
		}else if(ty == '2095'){
			$("#enableUp").html("（允许上传动画类格式包括：.swf）");
			document.getElementById("laborstylecreate6").style.display="none" ;
			$("#res_change_name").html("动画类资源："); 
			$("#isUploadRadio").hide();
		}else if(ty == '2033'){
			$("#enableUp").html("（允许上传文档格式包括：.doc .docx）");
			document.getElementById("laborstylecreate6").style.display="" ;
			$("#res_change_name").html("word文档：");
			$("#isUploadRadio").hide();
		}else if(ty == '2041'){
			$("#enableUp").html("（允许上传文档格式包括：.ppt .pptx）");
			document.getElementById("laborstylecreate6").style.display="" ;
			$("#res_change_name").html("ppt文档：");
			$("#isUploadRadio").hide();
		}else if(ty == '2055'){
			$("#enableUp").html("（允许上传文档格式包括：.pdf）");
			document.getElementById("laborstylecreate6").style.display="" ;
			$("#res_change_name").html("pdf文档：");
			$("#isUploadRadio").hide();
		}else if(ty == '4033'){
			$("#enableUp").html("（允许上传压缩格式包括：.rar、.zip）");
			document.getElementById("laborstylecreate6").style.display="none" ;
			$("#res_change_name").html("压缩包资源：");
			$("#isUploadRadio").hide();
			$("#laborstylecreate6").hide();
		}
	});
  
});

function onchangeUpload(uploadFile){
	$("#" + uploadFile).val("1") ;	
	$("#ThumfilediFile").val("--");
	$("#title" + uploadFile).val("title" + uploadFile) ;
}

function attr(y){
	var reg = /^\s+$/;
	return (typeof y != 'undefined' && y != '' && y != null && !reg.test(y) && y!='null');
}

//推荐触发事件
function Change(_this){
	
	if(_this.checked==true){
		
		//判断 是否填写关键字 没有填写关键字  或者是否 选择创建资源的分类目录
		var keyWords=$("#lrKeywords").val();		 
		var category=$("#lrCategory").val();
		var cateTwLevel=$("#lrCateTwLevel").val();
		
		
		keyWords = encodeURI(keyWords);
		keyWords = encodeURI(keyWords); 
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/forwardAction.action?code=-110001&paramMap.lrCategory='+category+'&paramMap.lrCateTwLevel='+cateTwLevel+'&paramMap.keyWords='+keyWords+'&paramMap.roomtype='+$("#roomtype").val()+'&paramMap.resType=1011&paramMap.offsetAbout=10&paramMap.start=0',{width:1000,height:574,title:'资源推荐',lock:'true',background:'#000000',opacity: '0.15'}) ;
	
	}
}
</script>
</head>
<body>
<div id="layout_mainbody" >
<input type="hidden" id="roomtype" value="laboratory">
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<input name="paramMap.lrAbout" type="hidden" id="relations" value=""/>
<input name="paramMap.lrIsShare" type="hidden" id="lrIsShare" value="1"/>
<input name="paramMap.lrRelation" type="hidden" id="setRelations" value=""/>
<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
	<ul id="treeDemo" class="ztree"></ul>
</div>
<input type="hidden" name="code" value="${code}"> 
<input type="hidden" name="imitateStep" value="${pmsIndex.res_laboratory_room_mgr.imitationStep}">
<input name="paramMap.status" id="status"  type="hidden"  value="isCreate"/>
<input name="paramMap.referResLen" id="referResLen"  type="hidden"  />
<input name="paramMap.resType" type="hidden" value="laboratory"/>
<input name="paramMap.referismodi" id="referismodi"  type="hidden"  value="istrue"/>
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
										<td width="85%" class="tatd" align="left"><input name="paramMap.lrName" type="text" maxlength="180" id="lrName" style="width: 200px;" />&nbsp;
										<font color="red">*</font><span id="lrNameTip" style="position:absolute;height:22px;"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">搜索关键词：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.lrKeywords" type="text" id="lrKeywords" style="width: 200px;" />&nbsp;
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.lrCategory" id="lrCategory" maxlength="180" style="width: 200px;">
											<input type="hidden" name="paramMap.lrCategoryName" id="lrCategoryName" maxlength="180" style="width: 200px;">
											<select name="total" id="total">
												<option>----请选择----</option>
												<s:iterator value="initMap.resCategoryList" id="cate" status="ind">
													<s:if test="#cate.cateName !='集体备课'">
													<option value="${cate.cateID}">${cate.cateName}</option>
													</s:if>
												</s:iterator>
											</select>
											<font color="red">*</font><span id="totalTip" style="position:absolute;height:22px;"></span>
										</td>
									</tr>
									
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">二级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.lrCateTwLevel" id="lrCateTwLevel" style="width: 200px;">
											<input type="hidden" name="paramMap.lrCateTwLevelName" id="lrCateTwLevelName" style="width: 200px;">
											<select id="cateTwLevel" name="cateTwLevel" ><option>----请选择----</option></select>
											<font color="red">*</font><span id="cateTwLevelTip" style="position:absolute;height:22px;"></span>
										</td>
										
									</tr>
									
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源类型：</td>
										<td width="85%" class="tatd" align="left">
											<select name="paramMap.lrType" id="lrType">
												<option value="">----请选择----</option>
												<option value="1011">高清图片</option>
												<option value="1084">高清视频</option>
												<option value="4033">压缩包</option>
												<option value="2095">swf课件</option>
												<option value="2033">WORD课件</option>
												<option value="2041">PPT课件</option>
												<option value="2055">PDF课件</option>
											</select>
											<font color="red">*</font><span id="lrTypeTip" style="position:absolute;height:22px;"></span>
										</td>
								   	</tr>
									<tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right" id="res_change_name">资源文件：</td>
										<td width="85%" class="tatd" align="left" id="uploadShowDiv">
											<input type="hidden" name="paramMap.lrUpload" id="lrUpload">
											<input type="hidden" name="paramMap.isUpload" id="isUpload">
											<input type="hidden" name="paramMap.lrFileSwf" id="lrFileSwf">
										</td>
									</tr>
									<tr bgcolor="#ae9b84" id="laborstylecreate6">
										<td width="15%" class="tatd" align="right">缩略图：</td>
										<td width="85%" class="tatd" align="left">
										
										<span id="manythumspan"> <input type="file" name=upload id="upload" onchange="onchangeUpload('uploadThumFile');"/> </span>
										<span id="uploadTip" style="position:absolute;height:22px;width:299px"></span>
										<input type="hidden" name="paramMap.uploadThumFile" id="uploadThumFile" value="0">
										<input type="hidden" name="paramMap.uploadThumFile" id="ThumfilediFile" value="">
										<input type="hidden" name="title" id="titleuploadThumFile" value="">
										<span id="thumformat"></span>
										<span id="Thum"></span>
									</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">推荐到首页：</td>
										<td width="85%" class="tatd" align="left" id="uploadShowDivRecommen">
											<input type="checkbox" name="lrRec" value="0" class="lrRecommen">
											
											<input type="radio" name="Recommensize" value="11" class="Recommensize" style="display: none;"><span style="display: none;">305*145</span>
											<input type="radio" name="Recommensize" value="22" class="Recommensize" style="display: none;"><span style="display: none;">143*145</span>
											
											<input type="file" name=upload id="recommenFile" style="display: none;" />
											<span id="recommenFileTip" style="position:absolute;height:22px;width:293px"></span>
											<input type="hidden" name="paramMap.lrRecommen" id="lrRecommen" value="0">
											<input type="hidden" name="paramMap.lrRecommenFile" id="lrRecommenFile" >
											<input type="hidden" name="paramMap.Recommensize" id="Recommensize" >
											<input type="hidden" name="title" id="titleuploadRecommenFile" value="">
										</td>
									</tr>
									<tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">相关资源推荐：</td>
										<td width="85%" class="tatd" align="left" >
										<input type="checkbox"  id="outside" value="0" onclick="Change(this);" >
										</td>
									</tr>
									<tr bgcolor="#ae9b84" id="fileAssistUpload" style="display: none;">
										<td width="15%" class="tatd" align="right">文件上传</td>
										<td width="85%" class="tatd" align="left" >
											<div style="padding: 5px;border: 1px solid #d0d4d5;width: 600px;height: 300px;  " class="deupload" >
											<div id="demo2" ></div></div>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">详细说明：</td>
										<td width="85%" class="tatd" align="left">
										<textarea cols="80" id="lrDescription" name="paramMap.lrDescription" rows="10"></textarea>&nbsp;
										<span id="lrDescriptionTip" style="position:absolute;height:22px;width:293px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<%-- <tr bgcolor="#ae9b84" id="lrContent" >
										<td width="15%" class="tatd" align="right">资源简介：</td>
										<td width="85%" class="tatd" align="left">
										
 											
 											<input type="file" name="upload" id="contentfile" >
 											<input type="hidden" name="title" id="titlecontentfileFile" value="">
 											<input type="hidden" name="paramMap.contentHelp" id="contentHelp" value="0">
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
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="303"><span>三年级</span>
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="304"><span>四年级</span>
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="305"><span>五年级</span>
											<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="306"><span>六年级</span>
										</td>
									</tr> --%>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">初中分类：</td>
										<td width="85%" class="tatd" align="left">
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="311"><span>七年级</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="312"><span>八年级</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="313"><span>九年级</span>&nbsp;
										</td>					
									</tr>
 									<tr bgcolor="#ae9b84">
 										<td width="15%" class="tatd" align="right">高中分类：</td>
 										<td width="85%" class="tatd" align="left">
 										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="321"><span>必修一</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="322"><span>必修二</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="323"><span>必修三</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="331"><span>选修一</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="332"><span>选修二</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="333"><span>选修三</span>&nbsp;<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="334"><span>选修四</span>&nbsp;<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="335"><span>选修五</span>&nbsp;<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="336"><span>选修六</span>&nbsp;
 										</td>
 									</tr>
									<!-- <tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">高中竞赛：</td>
										<td width="85%" class="tatd"  align="left">
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3241">细胞生物学
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3242">植物解剖和生理
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3243">动物解剖和生理
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3244">动物行为学
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3245">遗传学与进化
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3246">生态学
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3247">生物系统学 
										</td>
									</tr>	 -->
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">备注：</td>
										<td width="85%" class="tatd" align="left">
											<textarea cols="80" id="lrRemarks" name="paramMap.lrRemarks" rows="10"></textarea>&nbsp;
											<span id="lrRemarksTip" style="position:absolute;height:22px;width:293px"></span>
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">日期：</td>
										<td width="85%" class="tatd" align="left"><input name="paramMap.lrCreateTime" type="text" class="Wdate" maxlength="10" id="lrCreateTime" style="width: 200;" onFocus="WdatePicker({isShowWeek:true,dateFmt:'yyyy-MM-dd',readOnly:true});" />&nbsp;
										</td>
									</tr>
									<tr bgcolor="#ae9b84" align="center">
										<td colspan="4"><input type="submit"  name="BtnOk" value="创建" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
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
	</form>
</div>
<div id="progress">
	<div id="title">
		<span id="text" class="fontStyle"><!-- 上传进度 --></span>
		<div id="close">关闭</div>
	</div>
	<div id="progressBar">
		<div id="uploaded"></div>
	</div>
	<div id="info"></div>
</div>
</div>
<%-- <script src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/date/date.js"></script>
<script src="js/tweenmax.min.js"></script>
<script src="js/scripts.js"></script>
</body>
</html>