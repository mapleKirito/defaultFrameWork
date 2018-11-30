<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath();%>
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
<%-- <script  type="text/javascript" src="<%=request.getContextPath()%>/codebase/jquery-1.3.2.min.js"></script>
 --%><link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/codebase/GooUploader.css"/>
<script  type="text/javascript" src="<%=request.getContextPath()%>/codebase/GooUploader.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/codebase/swfupload/swfupload.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />
<style type="text/css">
body, ul, li{ margin:0; padding:0; font-size:12px;}
ul, li{list-style-type:none;}
</style>
<script type="text/javascript">
var demo2;
var post_params = {session_id:"f1423rwe543t4wrtwerwe"};
$(document).ready(function(){	
	
	//初始化定位上传插件坐标
	$(".uploadDiv").css("left",$("#uploadShowDiv").offset().left + 8);
    $(".uploadDiv").css("top",$("#uploadShowDiv").offset().top + 7);
	
	 //初始化定位上传插件验证语坐标
    $("#enableUp").css("left",$("#uploadShowDiv").offset().left + 98);
	$("#enableUp").css("top","5");  
	
	//input验证
	//表单提交 
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){},onsuccess:function(){}});//表单提交 
	$("#lrName").formValidator({onshow:"请输入中文名",onfocus:"请输入中文名",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("中文名不能为空,请确认");}});
	$("#lrCategory").formValidator({onshow:"请选择资源分类",onfocus:"请选择资源分类",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源分类不能为空,请确认");}});
	$("#lrType").formValidator({onshow:"请选择资源类型",onfocus:"请选择资源类型",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源类型不能为空,请确认");}});
	$("#lrUpload").formValidator({onshow:"请上传资源文件",onfocus:"请上传资源文件",oncorrect:"上传正确"}).inputValidator({min:1,onerror:function(){alert("资源不能为空,请确认");}});
	$("#isUpload").formValidator({onshow:"请上传资源文件",onfocus:"请上传资源文件",oncorrect:"上传正确"}).inputValidator({min:1,onerror:function(){alert("资源不能为空,请确认");}});
	var userType = "${s_userType}" ;//用户类型 管理员录入数据： 0 ，老师录入数据： 1
	var expentNum = "0000" ;	//未来扩展值
	var resBeginType = "lr" ;
	 var lrIsShare = '${initMap.laboInfo.lrIsShare}';
	 
	    if(lrIsShare==1){
	    	//alert(lrIsShare);
	    	$("#lrIsShare").attr('checked',true);
	    }
	
	var lrNo = '${initMap.laboInfo.lrNO}';
		lrNo = lrNo.substring(lrNo.length - 4);

	if($("#lrCategory").val()==46){
    	/* $("#fileAssistUpload").show(); */
    	var property2={ width:600, height:300, multiple:true, file_types:"*.ppt;*.doc;*.pdf", post_params:post_params, btn_add_text:"添加", btn_up_text:"上传",  btn_cancel_text:"放弃", btn_clean_text:"清空", op_del_text:"单项删除", op_fail_text:"上传失败", op_ok_text:"上传成功", op_no_text:"取消上传", upload_url:"uploadImage.action?roomname=laboratory&"+"filename="+new Date().getTime() + "&path=upload/YJS/" + userType + "/" + expentNum + "/" + "&NoNum=" + lrNo};
		demo2=$.createGooUploader($(".table_9 tr td #demo2"),property2);
		
		var $conLI = $("#demo2 > .total_bg > .content");
		var referOld = "";
		<s:iterator value="initMap.laboRefer" id="refer" status="indref">
			var referUp = '${refer.referUpload}';
			referOld += $("#referOldbefor").val() + "," + referUp;
			$conLI.append("<li class=\"refermodiLI\" style=\"padding:6px 0 0 0 ;\"><img src=\""+"${refer.referThumbnail}"+"\" width=\"18\" height=\"18\" style=\"margin:0px 0px 0px 5px;\" >" + referUp.substring(referUp.lastIndexOf('/')).replace('/', '') + "<b class=\"delmodi\" style=\"float:right;margin:-3px 1px;background:url(codebase/img/icon_upload_btn.gif) no-repeat 0px -73px;cursor:pointer;\"  title=\"单项删除\" ></b><input name=\"paramMap.referbeforemodi\" class=\"referbeforemodi"+${indref.index+1}+"\"  type=\"hidden\" value=\""+referUp+" \"/><a href=\"downloadAction.action?code=-706&paramMap.resPath=${refer.referUpload}\" ><img src=\"\images/downaxui.png\" width=\"18\" height=\"18\" title=\"资源下载\" style=\"float:right;\";></a></li>");
		</s:iterator>
	
		$("#referOldbefor").val(referOld.replace(/,/,""));
		$("#referbefor").val(referOld.replace(/,/,""));
		
		var index = 0;
		$(".delmodi").each(function(){
			$(this).click(function(){
				index = $(".refermodiLI").index($(this).closest("li"))+1;
				var RA = $("#referbefor").val().split(",");
				alert(".referbeforemodi"+index);
				var cli = $(".referbeforemodi"+index).val().replace(/(^\s*)|(\s*$)/g, "");
    	    	RA.splice($.inArray(cli,RA),1);
		    	$("#referbefor").val(RA);
		    	$(this).parent().css("display","none");
		    	
		    });
		});
	}
	
	$("#demo2 > .total_bg > .oper > .upload_btn > div > b.upload").click(function(){
    	$("#referafter").val($("li[class!='refermodiLI']").length);
		var conTotalLI = $("#demo2 > .total_bg > .content > li").length;
		$("#referResTotalLen").val(conTotalLI);
		$("#referResLen").val(conTotalLI);
		$("#referismodi").val("istrue");
	});
    
    $("#demo2 > .total_bg > .oper > .upload_btn > div > b.clean").click(function(){
    	$("#demo2 > .total_bg > .content > li.refermodiLI").remove();  
    	$("#referResTotalLen").val("0");
   	});
	
    $("#laborstylecreate6 #upload").change(function(){
    	$("#laborstylecreate6 #thumformat").html("");
    	$(this).siblings("font").remove();
    	$(this).after("<font color='red'>*</font>");
		$(this).formValidator({}).regexValidator({regexp:"picture",datatype:"enum",onerror:"文件格式不正确（允许上传文件格式有jpg、gif、png）"});
	});
	
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
				if(TypeValue == '2033' || TypeValue == '2041' || TypeValue == '2055' ){
						
						
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
			$("#enableUp").html("（允许上传视频格式包括：.wmv）");
		}
		
	});
	
	//添加缩略图上传图片格式验证
    $("#thumformat").html("允许上传缩略图文件格式包括：.jpg、.png");
    
    //$("#uploadShowDivRecommen").append("<span>允许上传首页推荐展示图片格式包括：.jpg、.png</span>");
	
  	//初始化推荐到首页事件
    var lrRecommen = '${initMap.laboInfo.lrRecommen}';
    if(lrRecommen!=null && lrRecommen.indexOf("1")>-1){
    	$("input.lrRecommen:checkbox").attr("checked",true);
    	$("#uploadShowDivRecommen input.Recommensize").show();
    	$("#uploadShowDivRecommen span").show();
    	
    	if(lrRecommen.indexOf("11")>-1)
    		$("input.Recommensize:first").attr("checked",true);
    	else if(lrRecommen.indexOf("22")>-1)
    		$("input.Recommensize:last").attr("checked",true);
   	}else{
		$("input.lrRecommen:checkbox").attr("checked",false);
   	}
    
 	 //点击推荐到首页按钮操作
    $(".lrRecommen").change(function(){   	
    	if($('input.lrRecommen:checkbox:checked').val()=="0"){
    		$(".Recommensize").show();   
    		$("#uploadShowDivRecommen span").show(); 
    	}else{
    		$(".Recommensize").hide();	
    		$("#recommenFile").hide();
    		$("input.Recommensize:radio").attr("checked",false);
			$("#uploadShowDivRecommen span").hide();   
			
			$("#recommenFile").siblings("font").remove();
    		$("#recommenFile").formValidator({});
			
			$("#lrRecommen").val("0");	
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
  	
  	//初始化资源分类和二级分类 
    var cid = $("#lrCategory").val();
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
						var $cobj = $("#cateTwLevel"); 
						$cobj.find("option").remove();
						var ctempid = $("#lrCateTwLevel").val();
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
    
    
 	//点击资源分类触发事件
    $("#total").change(function(){
    	var sval = $(this).val();
    	var stxt = $(this).find("option:selected").text();
    	
    	$("#lrCategory").val(sval) ;
    	$("#lrCategoryName").val(stxt) ;

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
    
  	//点击二级分类触发事件
    $("#cateTwLevel").change(function(){
    	var sval = $(this).val() ;
    	var stxt = $(this).find("option:selected").text() ;
    	//alert(sval + "---" + stxt);
    	if (sval){
    		$("#lrCateTwLevel").val(sval);	
    	}
    	if (stxt){
    		$("#lrCateTwLevelName").val(stxt);
    	}  	
    });
  	
  //初始化页面上传文件提示操作
    var labotype = '${initMap.laboInfo.lrType}';
    if(labotype == '1011'){
		$("#enableUp").html("（允许上传高清图片格式包括：.jpg、.png）");
		document.getElementById("laborstylecreate6").style.display="none" ;
		$("#res_change_name").html("高清图片："); 
		$("#isUploadRadio").show();
	}else if(labotype == '1073'){
		$("#enableUp").html("（允许音频格式：MP3）");
		document.getElementById("laborstylecreate6").style.display="" ;
		$("#res_change_name").html("音频："); 
		$("#isUploadRadio").hide();
	}else if(labotype == '1084'){
		$("#enableUp").html("（允许视频格式：rmvb、wmv、mp4、flv、mpg等）");
		document.getElementById("laborstylecreate6").style.display="" ;
		$("#res_change_name").html("高清视频："); 
		$("#isUploadRadio").hide();
	}else if(labotype == '2095'){
		$("#enableUp").html("（允许上传动画类格式包括：.swf）");
		document.getElementById("laborstylecreate6").style.display="none" ;
		$("#res_change_name").html("动画类资源："); 
		$("#isUploadRadio").hide();
	}else if(labotype == '2033'){
		$("#enableUp").html("（允许上传文档格式包括：.doc .docx）");
		document.getElementById("laborstylecreate6").style.display="" ;
		$("#res_change_name").html("word文档：");
		$("#isUploadRadio").hide();
	}else if(labotype == '2041'){
		$("#enableUp").html("（允许上传文档格式包括：.ppt .pptx）");
		document.getElementById("laborstylecreate6").style.display="" ;
		$("#res_change_name").html("ppt文档：");
		$("#isUploadRadio").hide();
	}else if(labotype == '2055'){
		$("#enableUp").html("（允许上传文档格式包括：.pdf）");
		document.getElementById("laborstylecreate6").style.display="" ;
		$("#res_change_name").html("pdf文档：");
		$("#isUploadRadio").hide();
	}else if(labotype == '4033'){
		$("#enableUp").html("（允许上传压缩格式包括：.rar、.zip）");
		document.getElementById("laborstylecreate6").style.display="none" ;
		$("#res_change_name").html("压缩包资源：");
		$("#isUploadRadio").hide();
		$("#laborstylecreate6").hide();
	}
    
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
			$("#enableUp").html("（允许上传文档格式包括：.doc  .docx）");
			document.getElementById("laborstylecreate6").style.display="" ;
			$("#res_change_name").html("word文档：");
			$("#isUploadRadio").hide();
		}else if(ty == '2041'){
			$("#enableUp").html("（允许上传文档格式包括：.ppt  .pptx）");
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
			document.getElementById("laborstylecreate6").style.display="" ;
			$("#res_change_name").html("压缩包资源：");
			$("#isUploadRadio").hide();
		}else if(ty == '2095'){
			$("#enableUp").html("（允许上传文件格式包括：.swf）");
			document.getElementById("laborstylecreate6").style.display="" ;
			$("#res_change_name").html("swf文件：");
			$("#isUploadRadio").hide();
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
<input name="paramMap.status" id="status"  type="hidden"  value="ismodify"/>
<input type="hidden" name="code" value="${code}"> 
<input name="paramMap.lrID" type="hidden" id="lrID" value="${initMap.laboInfo.lrID}"/>
<input name="paramMap.resType" type="hidden" value="laboratory"/>
<input type="hidden" name="imitateStep" value="${pmsIndex.my_resource_mgr.imitationStep}">
<input name="paramMap.lrNO" type="hidden" value="${initMap.laboInfo.lrNO}"/>
<input name="paramMap.thecode" type="hidden" value="${initMap.laboInfo.lrNO}"/>
<input name="paramMap.referResLen" id="referResLen"  type="hidden" value="${fn:length(initMap.laboRefer)}"/>
<input name="paramMap.referResTotalLen" id="referResTotalLen"  type="hidden" value=""/>

<input name="paramMap.lrAbout" type="hidden" id="relations" value="${initMap.laboInfo.lrAbout}"/>
<input name="paramMap.lrRelation" type="hidden" id="setRelations" value="${initMap.laboInfo.lrRelation}"/>

<input name="paramMap.referOldbefor" id="referOldbefor"  type="hidden" value=""/>
<input name="paramMap.referbefor" id="referbefor"  type="hidden" value=""/>
<input name="paramMap.referafter" id="referafter"  type="hidden" value=""/>
<input name="paramMap.referismodi" id="referismodi"  type="hidden"  value="isfalse"/>
<input name="paramMap.lrReferType" id="lrReferType"  type="hidden"  value="${initMap.laboInfo.lrReferType}"/>

<s:if test="initMap.laboInfo.lrType == '1011' ">
	<input name="paramMap.Old1011InThum" type="hidden" value="${initMap.laboInfo.lrInThum}"/>
	<input name="paramMap.Old1011Thumbnail" type="hidden" value="${initMap.laboInfo.lrThumbnail}"/>
</s:if>

<input name="paramMap.modifycateerlrCategory" type="hidden" value="${initMap.laboInfo.lrCategory}"/>
<input name="paramMap.modifycateerlrCateTwLevel" type="hidden" value="${initMap.laboInfo.lrCateTwLevel}"/>
<%-- <input type="hidden" name="paramMap.lrCateTwLevel" id="lrCateTwLevel" style="width: 200px;" value="${initMap.laboInfo.lrCateTwLevel}">
<input type="hidden" name="paramMap.lrCateTwLevelName" id="lrCateTwLevelName" style="width: 200px;" value="${initMap.laboInfo.lrCateTwLevelName}"> --%>
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
										<td width="85%" class="tatd" align="left"><input name="paramMap.lrName" type="text" value="${initMap.laboInfo.lrName}" maxlength="180" id="lrName" style="width: 200px;" />&nbsp;
										<font color="red">*</font><span id="lrNameTip" style="position:absolute;height:22px;"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">搜索关键词：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.lrKeywords" type="text" id="lrKeywords" style="width: 200px;" value="${initMap.laboInfo.lrKeywords }" />&nbsp;
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源分类：</td>
										<td width="85%" class="tatd" align="left">
										  	<input type="hidden" name="paramMap.lrCategory" id="lrCategory" value="${initMap.laboInfo.lrCategory}" maxlength="180" style="width: 200px;">
											<input type="hidden" name="paramMap.lrCategoryName" id="lrCategoryName" value="${initMap.laboInfo.lrCategoryName}" maxlength="180" style="width: 200px;">
											<select name="total" id="total">
												<option value="">----请选择----</option>
												<s:iterator value="initMap.resCategoryList" id="cate" status="ind">
													<option value="${cate.cateID}" ${initMap.laboInfo.lrCategory eq cate.cateID ? 'selected':'' }>${cate.cateName}</option>
												</s:iterator>
											</select>
											<font color="red">*</font><span id="lrCategoryTip" style="position:absolute;height:22px;"></span>
										</td>
									</tr>
									 <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">二级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.lrCateTwLevel" id="lrCateTwLevel" style="width: 200px;">
											<input type="hidden" name="paramMap.lrCateTwLevelName" id="lrCateTwLevelName" style="width: 200px;">
											<select id="cateTwLevel" name="cateTwLevel" ><option>----请选择----</option></select>
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源类型：</td>
										<td width="85%" class="tatd" align="left">
											<select name="paramMap.lrType" id="lrType">
												<option value="">----请选择----</option>
												<option value="1011" ${initMap.laboInfo.lrType eq "1011" ? 'selected':'' }>高清图片</option>
												<option value="1084" ${initMap.laboInfo.lrType eq "1084" ? 'selected':'' }>高清视频</option>		
												<option value="4033" ${initMap.laboInfo.lrType eq "4033" ? 'selected':'' }>压缩包</option>	
												<option value="2095" ${initMap.laboInfo.lrType eq "2095" ? 'selected':'' }>swf课件</option>									
												<option value="2033" ${initMap.laboInfo.lrType eq "2033" ? 'selected':'' }>WORD课件</option>
												<option value="2041" ${initMap.laboInfo.lrType eq "2041" ? 'selected':'' }>PPT课件</option>
												<option value="2055" ${initMap.laboInfo.lrType eq "2055" ? 'selected':'' }>PDF课件</option>
											</select>
											<input type="hidden" name="paramMap.oldResType" id="oldResType" value="${initMap.laboInfo.lrType}" >											
											&nbsp;<font color="red">*</font><span id="lrTypeTip" style="position:absolute;height:22px;"></span>
										</td>
								   	</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" height="30px" class="tatd" align="right" id="res_change_name">资源文件：</td>
										<td width="85%" class="tatd" align="left" id="uploadShowDiv">
										<input type="hidden" name="paramMap.oldResUpload" id="oldResUpload" value="${initMap.laboInfo.lrUpload}" >
										<input type="hidden" name="paramMap.lrUpload" id="lrUpload" value="${initMap.laboInfo.lrUpload}">
										<input type="hidden" name="paramMap.lrFileSwf" id="lrFileSwf" value="${initMap.laboInfo.lrFileSwf}">
										<input type="hidden" name="paramMap.lrNewUpload" id="lrNewUpload" value="${initMap.laboInfo.lrUpload}">
										<input type="hidden" name="paramMap.isUpload" id="isUpload" value="1">
										</td>
									</tr>
									<tr bgcolor="#ae9b84" id="laborstylecreate6">
										<td width="15%" class="tatd" align="right">缩略图：</td>
										<td width="85%" class="tatd" align="left">
										<img alt="" src="${initMap.laboInfo.lrThumbnail}" width="50px" height="50px">
										<input type="file" name=upload id="upload" class="thumUpload" onchange="onchangeUpload('uploadThumFile');"  value="${initMap.laboInfo.lrThumbnail}"/>
										<span id="uploadTip" style="position:absolute;height:22px;width:299px"></span>
										<input type="hidden" name="paramMap.uploadThumFile" id="uploadThumFile" value="0">
										<input type="hidden" name="paramMap.uploadThumFile" id="ThumfilediFile" value="">
										<input type="hidden" name="paramMap.lrThumbnail" id="lrThumbnail" value="${initMap.laboInfo.lrThumbnail}">
										<input type="hidden" name="paramMap.lrInThum"  value="${initMap.laboInfo.lrInThum}">
										<input type="hidden" name="title" id="titleuploadThumFile" value="">
										<span id="thumformat"></span>
										<span id="Thum"></span>
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">推荐到首页：</td>
										<td width="85%" class="tatd" align="left" id="uploadShowDivRecommen">
											<input type="checkbox" name="orRec" value="0" class="lrRecommen"> 

											<input type="radio" name="Recommensize" value="11" class="Recommensize" style="display: none;"><span style="display: none;">305*145</span>
											<input type="radio" name="Recommensize" value="22" class="Recommensize" style="display: none;"><span style="display: none;">143*145</span>
											
											<input type="file" name=upload id="recommenFile" onchange="onchangeUpload('lrRecommen');" style="display: none;" />
											<span id="recommenFileTip" style="position:absolute;height:22px;width:293px"></span>
											<input type="hidden" name="paramMap.lrRecommen" id="lrRecommen" value="${initMap.laboInfo.lrRecommen}">
											<input type="hidden" name="paramMap.Recommensize" id="Recommensize" value="${initMap.laboRecommen.reSize}">
											<input type="hidden" name="paramMap.OldlrRecommenFile" id="OldlrRecommenFile" value="${initMap.laboRecommen.reRecoFileUP}">
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
										<input type="checkbox"  name="paramMap.lrIsShare" id="lrIsShare" value="1"  >
										</td>
									</tr>
									<tr bgcolor="#ae9b84" id="fileAssistUpload" style="display: none;">
										<td width="15%" class="tatd" align="right">文件上传</td>
										<td width="85%" class="tatd" align="left" >
											<div style="padding: 5px;border: 1px solid #FFFFFF;width: 600px;height: 300px;  ">
											<div id="demo2" ></div></div>
										</td>
									</tr>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">二级分类：</td>
										<td width="85%" class="tatd" align="left">
											
											<select id="cateTwLevel" name="cateTwLevel"  ><option>----请选择----</option></select>
										</td>
									</tr> --%>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">详细说明：</td>
										<td width="85%" class="tatd" align="left">
										<textarea cols="80" id="lrDescription" name="paramMap.lrDescription" rows="10">${initMap.laboInfo.lrDescription}</textarea>&nbsp;
										<span id="lrDescriptionTip" style="position:absolute;height:22px;width:270px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<%-- <tr bgcolor="#ae9b84" id="lrContent" >
										<td width="15%" class="tatd" align="right">资源简介：</td>
										<td width="85%" class="tatd" align="left">
											<textarea cols="80" id="editor1" name="paramMap.lrContent" rows="10">${initMap.laboInfo.lrContent}</textarea>
										    <script type="text/javascript">
											CKEDITOR.replace('editor1',{ filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=laboratory&lrno='+'${initMap.laboInfo.lrNO}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=laboratory&lrno='+'${initMap.laboInfo.lrNO}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=laboratory&lrno='+'${initMap.laboInfo.lrNO}' });
 											</script>
 											
 											<input type="file" name="upload" id="contentfile" >
 											<input type="hidden" name="title" id="titlecontentfileFile" value="">
 											<input type="hidden" name="paramMap.lrContent" value="${initMap.laboInfo.lrContent}">
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
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">初中分类：</td>
										<td width="85%" class="tatd" align="left">
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="311" <s:if test="initMap.laboInfo.lrGrade.indexOf('311') > -1">checked</s:if>>七年级
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="312" <s:if test="initMap.laboInfo.lrGrade.indexOf('312') > -1">checked</s:if>>八年级
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="313" <s:if test="initMap.laboInfo.lrGrade.indexOf('313') > -1">checked</s:if>>九年级
										
										</td>				
									</tr>
 									 <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">高中分类：</td>
										<td width="85%" class="tatd" align="left">
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="321" <s:if test="initMap.laboInfo.lrGrade.indexOf('321') > -1">checked</s:if>><span>必修一</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="322" <s:if test="initMap.laboInfo.lrGrade.indexOf('322') > -1">checked</s:if>><span>必修二</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="323" <s:if test="initMap.laboInfo.lrGrade.indexOf('323') > -1">checked</s:if>><span>必修三</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="331" <s:if test="initMap.laboInfo.lrGrade.indexOf('331') > -1">checked</s:if>><span>选修一</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="332" <s:if test="initMap.laboInfo.lrGrade.indexOf('332') > -1">checked</s:if>><span>选修二</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="333" <s:if test="initMap.laboInfo.lrGrade.indexOf('333') > -1">checked</s:if>><span>选修三</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="334" <s:if test="initMap.laboInfo.lrGrade.indexOf('334') > -1">checked</s:if>><span>选修四</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="335" <s:if test="initMap.laboInfo.lrGrade.indexOf('335') > -1">checked</s:if>><span>选修五</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="336" <s:if test="initMap.laboInfo.lrGrade.indexOf('336') > -1">checked</s:if>><span>选修六</span>&nbsp;
							     	</td>
									</tr>
 									<!-- <tr bgcolor="#ae9b84" >
										<td width="15%" class="tatd" align="right">高中竞赛：</td>
										<td width="85%" class="tatd"  align="left">
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3241" <s:if test="initMap.laboInfo.lrContest.indexOf('3241') > -1">checked</s:if>>细胞生物学
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3242" <s:if test="initMap.laboInfo.lrContest.indexOf('3242') > -1">checked</s:if>>植物解剖和生理
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3243" <s:if test="initMap.laboInfo.lrContest.indexOf('3243') > -1">checked</s:if>>动物解剖和生理
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3244" <s:if test="initMap.laboInfo.lrContest.indexOf('3244') > -1">checked</s:if>>动物行为学
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3245" <s:if test="initMap.laboInfo.lrContest.indexOf('3245') > -1">checked</s:if>>遗传学与进化
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3246" <s:if test="initMap.laboInfo.lrContest.indexOf('3246') > -1">checked</s:if>>生态学
											<input type="checkbox" name="paramMap.grJingsai" id="grGrades" value="3247" <s:if test="initMap.laboInfo.lrContest.indexOf('3247') > -1">checked</s:if>>生物系统学 
										</td>
									</tr> -->
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">备注：</td>
										<td width="85%" class="tatd" align="left">
										<textarea cols="80" id="lrRemarks" name="paramMap.lrRemarks" rows="10">${initMap.laboInfo.lrRemarks}</textarea>&nbsp;
										<span id="lrRemarksTip" style="position:absolute;height:22px;width:270px"></span></td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">日期：</td>
										<td width="85%" class="tatd" align="left">
										<input name="paramMap.lrCreateTime" type="text" class="Wdate" maxlength="10" value="${initMap.laboInfo.lrCreateTime }" id="lrCreateTime" style="width: 200;" onFocus="WdatePicker({isShowWeek:true,dateFmt:'yyyy-MM-dd',readOnly:true});" />&nbsp;
										</td>
									</tr>
									<tr bgcolor="#ae9b84" align="center">
										<td colspan="3"><input type="submit" name="BtnOk" value="修改" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" />&nbsp;&nbsp;<input type="button" name="BtnOk" value="返回" id="BtnOk" class="SkyButtonBlur" onMouseOut="this.className='SkyButtonBlur'" onMouseOver="this.className='SkyButtonFocus'" onclick="window.history.back();" /></td>
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
		<br>
		<span id="enableUp"></span> 
		
		<%-- <a href="downloadAction.action?code=-706&paramMap.resDownRoom=laboratory&paramMap.resDownType=${initMap.laboInfo.lrType}&paramMap.resPath=${initMap.laboInfo.lrUpload}" >下载</a> --%>
		&nbsp;<font color="red">*</font><span id="isUploadTip" style="position:absolute;height:22px;width:200px;"></span>
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
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/scripts.js"></script>
</body>
</html>