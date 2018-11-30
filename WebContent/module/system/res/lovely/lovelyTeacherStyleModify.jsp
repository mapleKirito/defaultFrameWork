<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="/WEB-INF/taglib/fn.tld"%>
<% String basePath = "http://" + request.getLocalAddr() + ":" + request.getLocalPort() + request.getContextPath(); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<title>${promptInfo.totalDescInfo}</title>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ztree.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.core-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.excheck-3.0.js" type="text/javascript"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree/jquery.ztree.exedit-3.0.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/progressBar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dataUtils.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/progressBar.css">
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
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
	$.formValidator.initConfig({formid:"actionForm",onerror:function(){},onsuccess:function(){}});//表单提交 //表单提交 
	$("#crName").formValidator({onshow:"请输入名称",onfocus:"请输入名称",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("名称不能为空,请确认");}});
	$("#crType").formValidator({onshow:"请选择资源类型",onfocus:"请选择资源类型",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源类型不能为空,请确认");}});
	$("#total").formValidator({onshow:"请输入资源类型",onfocus:"请输入资源类型",oncorrect:"输入正确"}).inputValidator({min:1,onerror:function(){alert("资源类型不能为空,请确认");}});
	$("#crUpload").formValidator({onshow:"请上传资源文件",onfocus:"请上传资源文件",oncorrect:"上传正确"}).inputValidator({min:1,onerror:function(){alert("资源不能为空,请确认");}});
	$("#isUpload").formValidator({onshow:"请上传资源文件",onfocus:"请上传资源文件",oncorrect:"上传正确"}).inputValidator({min:1,onerror:function(){alert("资源不能为空,请确认");}});


	var userType = "${s_userType}" ;//用户类型 管理员录入数据： 0 ，老师录入数据： 1
	var expentNum = "0000" ;	//未来扩展值
	var resBeginType = "cr" ;
    var crIsShare = '${initMap.lovelyInfo.crIsShare}';
    
    if(crIsShare==1){
   
    	$("#crIsShare").attr('checked',true);
    }
	var erNo = '${initMap.lovelyInfo.crNo}';
	erNo = erNo.substring(erNo.length - 4);

	/* $("#fileAssistUpload").show(); */
	var property2={ width:600, height:300, multiple:true, file_types:"*.ppt;*.doc;*.pdf", post_params:post_params, btn_add_text:"添加", btn_up_text:"上传",  btn_cancel_text:"放弃", btn_clean_text:"清空", op_del_text:"单项删除", op_fail_text:"上传失败", op_ok_text:"上传成功", op_no_text:"取消上传", upload_url:"uploadImage.action?roomname=lovely&"+"filename="+new Date().getTime() + "&path=upload/XJY/" + userType + "/" + expentNum + "/" + "&NoNum=" + erNo};
	demo2=$.createGooUploader($(".table_9 tr td #demo2"),property2);
	
	var $conLI = $("#demo2 > .total_bg > .content");
	var referOld = "";
	<s:iterator value="initMap.expaRefer" id="refer" status="indref">
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
			var cli = $(".referbeforemodi"+index).val().replace(/(^\s*)|(\s*$)/g, "");
	    	RA.splice($.inArray(cli,RA),1);
	    	$("#referbefor").val(RA);
	    	$(this).parent().css("display","none");
	    	
	    });
	});		
			 
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
	
	//上传资源文件触发事件 
	$("#uploadBigFile").change(function(){
		$("#isUpload").val(null);
		$(".subButton").show();	
		$("#uploadBigFile").select();
		var realFile = $("#uploadBigFile").val() ;
		var date = new Date() ;
		path = "upload/XJY/" + userType + "/" + expentNum + "/" ;
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
			
			var TypeValue = $("#crType").val();
			if(TypeValue == '1011'){
				$("#lovelystylecreate6 #thumformat").html("");
				$("#lovelystylecreate6 #thumformat").siblings("font").remove();
				$("#lovelystylecreate6 #upload").formValidator({});
				
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
	
					$("#lovelystylecreate6 #thumformat").html("");
					$("#lovelystylecreate6 #thumformat").siblings("font").remove();
					$("#lovelystylecreate6 #upload").formValidator({});
					
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
	
	$("#lovelymodify6 #upload").change(function(){
    	$("#lovelymodify6 #thumformat").html("");
    	$(this).siblings("font").remove();
    	$(this).after("<font color='red'>*</font>");
		$(this).formValidator({}).regexValidator({regexp:"picture",datatype:"enum",onerror:"文件格式不正确（允许上传文件格式有jpg、gif、png）"});
	
    });
	
	//$("#uploadShowDivRecommen").append("<span>允许上传首页推荐展示图片格式包括：.jpg、.png</span>");
	
	//初始化推荐到首页事件
    var erRecommen = '${initMap.lovelyInfo.crRecommen}';
    if(erRecommen!=null && erRecommen.indexOf("1")>-1){
    	$("input.crRecommen:checkbox").attr("checked",true);
    	$("#uploadShowDivRecommen input.Recommensize").show();
    	$("#uploadShowDivRecommen span").show();
    	
    	if(erRecommen.indexOf("11")>-1)
    		$("input.Recommensize:first").attr("checked",true);
    	else if(erRecommen.indexOf("22")>-1)
    		$("input.Recommensize:last").attr("checked",true);
   	}else{
		$("input.crRecommen:checkbox").attr("checked",false);
   	}
    
 	 //点击推荐到首页按钮操作
    $(".crRecommen").change(function(){   	
    	if($('input.crRecommen:checkbox:checked').val()=="0"){
    		$(".Recommensize").show();   
    		$("#uploadShowDivRecommen span").show(); 
    	}else{
    		$(".Recommensize").hide();	
    		$("#recommenFile").hide();
    		$("input.Recommensize:radio").attr("checked",false);
			$("#uploadShowDivRecommen span").hide();   
			
			$("#recommenFile").siblings("font").remove();
    		$("#recommenFile").formValidator({});  //..
			
			$("#crRecommen").val("0");	
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
    var cid = $("#crResType").val();
    $.ajax({
		url:		'ajaxAction.action?code=003006008&paramMap.cateID=' + cid,
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},//ajax执行前调用函数
		complete:function(request,textStatus){},//ajax请求完成后调用函数
		success:function(jsonData,textStatus){//ajax请求成功调用函数
			if (textStatus == "success"){
				if (jsonData.data){
					if(jsonData.data.length != 0){
						var $cobj = $("#cateTwLevel"); 
						$cobj.find("option").remove();
						var ctempid = $("#crCateTwLevel").val();
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
    					$("#crCateTwLevel").val("");
    			    	$("#crCateTwLevelName").val("");	
					}
				} 
			}
		},
		error:function(request,textStatus,error){}
	});
    
    /* if(parseInt(cid) == 5891){
		$("#crType option[value='1011']").remove();
		$("#crType option[value='1084']").remove();
		$("#crType option[value='2033']").remove();
		$("#crType option[value='2041']").remove();
		$("#crType option[value='2055']").remove();
	} */
    
    
  //添加缩略图上传图片格式验证
    $("#thumformat").html("允许上传缩略图文件格式包括：.jpg、.png");
    
    
 	//点击资源分类触发事件
    $("#total").change(function(){
    	var sval = $(this).val();
    	var stxt = $(this).find("option:selected").text();
    	
    	$("#crResType").val(sval) ;
    	$("#crResTypeName").val(stxt) ;
    	
    	if(parseInt(sval) == 5891){
    		$("#crType option[value='1011']").remove();
    		$("#crType option[value='1084']").remove();
    		$("#crType option[value='2033']").remove();
    		$("#crType option[value='2041']").remove();
    		$("#crType option[value='2055']").remove();
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
        					$("#crCateTwLevel").val("");
        			    	$("#crCateTwLevelName").val("");	
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
    		$("#crCateTwLevel").val(sval);	
    	}
    	if (stxt){
    		$("#crCateTwLevelName").val(stxt);
    	}  	
    	
    	var erResType_id = $("#crResType").val();
    	var erCateTwLevel_id = $("#crCateTwLevel").val();
    	if(erResType_id=='1118' && (erCateTwLevel_id=='1119' || erCateTwLevel_id=='1121' || erCateTwLevel_id=='1122')){
    		$("#crType option[value='1011']").remove(); 
    		$("#crType option[value='1084']").remove(); 
    		$("#crType option[value='2095']").remove(); 
    	}else{
    		$("#crType option").remove();
    		$("#crType").append($("<option>").text("----请选择----").val("")).append($("<option>").text("swf文件").val("2095")).append($("<option>").text("高清图片").val("1011")).append($("<option>").text("虚拟仿真实验").val("2095")).append($("<option>").text("高清视频").val("1084")).append($("<option>").text("PPT课件").val("2041")).append($("<option>").text("WORD课件").val("2033")).append($("<option>").text("PDF课件").val("2055")); 
    	}
    }); 
	
  	
  	//初始化页面上传文件提示操作
    var expatype = '${initMap.lovelyInfo.crType}';
    if(expatype == 1011){
    	$("#lovelymodify6").hide();
    	$("#enableUp").html("（允许上传高清图片格式包括：.jpg、.png）");
    	$("#res_change_name").html("高清图片：");
    	$("#fileAssistUpload").hide();
    }else if(expatype == '1022'){
		$("#enableUp").html("（允许上传3D图片格式包括：.jpg、.png）");
		$("#fileAssistUpload").hide();
		$("#res_change_name").html("3D图片资源：");
	}else if(expatype == '1073'){
		$("#enableUp").html("（允许上传音频格式包括：.mp3）");
		$("#fileAssistUpload").hide();
		$("#res_change_name").html("音频资源：");
	}else if(expatype == '1084'){
		$("#enableUp").html("（允许视频格式：rmvb、wmv、mp4、flv、mpg等）");
		$("#fileAssistUpload").hide();
		$("#res_change_name").html("高清视频：");
	}else if(expatype == '4033'){
		$("#enableUp").html("（允许上传压缩格式包括：.rar、.zip）");
		$("#fileAssistUpload").hide();
		$("#res_change_name").html("压缩包：");
	}else if(expatype == '2095'){
		$("#enableUp").html("（允许上传动画类格式包括：.swf）");
		$("#fileAssistUpload").hide();
		$("#res_change_name").html("swf资源：");
	}else if(expatype == '2033'){
		$("#enableUp").html("（允许上传文档格式包括：.doc  .docx）");
		$("#res_change_name").html("doc文档：");
	}else if(expatype == '2041'){
		$("#enableUp").html("（允许上传文档格式包括：.ppt  .pptx）");
		$("#res_change_name").html("ppt文档：");
	}else if(expatype == '2055'){
		$("#enableUp").html("（允许上传文档格式包括：.pdf）");
		$("#res_change_name").html("pdf文档：");
	}else if(expatype == '2095'){
		$("#enableUp").html("（允许上传文件格式包括：.swf）");
		$("#res_change_name").html("swf文件：");
		$("#fileAssistUpload").hide();
	}else if(expatype == '3036'){
		$("#enableUp").html("");
		$("#res_change_name").html("其他课件：");
	}
  //点击资源类型触发事件 
    $("#"+resBeginType+"Type").change(function(){ 
    	$(".subButton").hide();	
		var ty = $(this).val();
		if(ty == '1011'){
			$("#enableUp").html("（允许上传高清图片格式包括：.jpg、.png）");
			document.getElementById("lovelystylecreate6").style.display="none" ;
			$("#res_change_name").html("高清图片："); 
			$("#isUploadRadio").show();
		}else if(ty == '1073'){
			$("#enableUp").html("（允许音频格式：MP3）");
			document.getElementById("lovelystylecreate6").style.display="" ;
			$("#res_change_name").html("音频："); 
			$("#isUploadRadio").hide();
		}else if(ty == '1084'){
			$("#enableUp").html("（允许视频格式：rmvb、wmv、mp4、flv、mpg等）");
			document.getElementById("lovelystylecreate6").style.display="" ;
			$("#res_change_name").html("高清视频："); 
			$("#isUploadRadio").hide();
		}else if(ty == '2095'){
			$("#enableUp").html("（允许上传动画类格式包括：.swf）");
			document.getElementById("lovelystylecreate6").style.display="" ;
			$("#res_change_name").html("动画类资源："); 
			$("#isUploadRadio").hide();
		}else if(ty == '2033'){
			$("#enableUp").html("（允许上传文档格式包括：.doc  .docx）");
			document.getElementById("lovelystylecreate6").style.display="" ;
			$("#res_change_name").html("word文档：");
			$("#isUploadRadio").hide();
		}else if(ty == '2041'){
			$("#enableUp").html("（允许上传文档格式包括：.ppt  .pptx）");
			document.getElementById("lovelystylecreate6").style.display="" ;
			$("#res_change_name").html("ppt文档：");
			$("#isUploadRadio").hide();
		}else if(ty == '2055'){
			$("#enableUp").html("（允许上传文档格式包括：.pdf）");
			document.getElementById("lovelystylecreate6").style.display="" ;
			$("#res_change_name").html("pdf文档：");
			$("#isUploadRadio").hide();
		}else if(ty == '4033'){
			$("#enableUp").html("（允许上传压缩格式包括：.rar、.zip）");
			document.getElementById("lovelystylecreate6").style.display="" ;
			$("#res_change_name").html("压缩包资源：");
			$("#isUploadRadio").hide();
		}else if(ty == '2095'){
			$("#enableUp").html("（允许上传文件格式包括：.swf）");
			document.getElementById("lovelystylecreate6").style.display="" ;
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
		var keyWords=$("#crKeywords").val();		 
		var category=$("#crCategory").val();
		var cateTwLevel=$("#crCateTwLevel").val();
		
		
		keyWords = encodeURI(keyWords);
		keyWords = encodeURI(keyWords); 
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/forwardAction.action?code=-110001&paramMap.crCategory='+category+'&paramMap.crCateTwLevel='+cateTwLevel+'&paramMap.keyWords='+keyWords+'&paramMap.roomtype='+$("#roomtype").val()+'&paramMap.resType=1011&paramMap.offsetAbout=10&paramMap.start=0',{width:1000,height:574,title:'资源推荐',lock:'true',background:'#000000',opacity: '0.15'}) ;
	
	}
}

</script>
</head>
<body>
<div id="layout_mainbody" >
<input type="hidden" id="roomtype" value="lovely">
<form name="actionForm" method="post" id="actionForm" enctype="multipart/form-data"  action="uploadDataAction.action">
<input type="hidden" name="code" value="${code}"> 
<input name="paramMap.status" id="status"  type="hidden"  value="ismodify"/>
<input name="paramMap.crID" type="hidden" id="crID" value="${initMap.lovelyInfo.crID}"/>
<input type="hidden" name="imitateStep" value="${pmsIndex.my_resource_mgr.imitationStep}">
<input name="paramMap.resType" type="hidden" value="lovely"/>

<input name="paramMap.crAbout" type="hidden" id="relations" value="${initMap.lovelyInfo.crAbout}"/>
<input name="paramMap.crRelation" type="hidden" id="setRelations" value="${initMap.lovelyInfo.crRelation}"/>

<input name="paramMap.crNO" type="hidden" value="${initMap.lovelyInfo.crNo}"/>
<input name="paramMap.referResLen" id="referResLen"  type="hidden" value="${fn:length(initMap.expaRefer)}"/>
<input name="paramMap.referResTotalLen" id="referResTotalLen"  type="hidden" value=""/>
<input name="paramMap.referOldbefor" id="referOldbefor"  type="hidden" value=""/>
<input name="paramMap.referbefor" id="referbefor"  type="hidden" value=""/>
<input name="paramMap.referafter" id="referafter"  type="hidden" value=""/>
<input name="paramMap.referismodi" id="referismodi"  type="hidden"  value="isfalse"/>
<input name="paramMap.crReferType" id="crReferType"  type="hidden"  value="${initMap.lovelyInfo.crReferType}"/>

<s:if test="initMap.lovelyInfo.crType == '1011' ">
	<input name="paramMap.Old1011InThum" type="hidden" value="${initMap.lovelyInfo.crInThum}"/>
	<input name="paramMap.Old1011Thumbnail" type="hidden" value="${initMap.lovelyInfo.crThumbnail}"/>
</s:if>

<input name="paramMap.thecode" type="hidden" value="${initMap.lovelyInfo.crNo}"/>

<input name="paramMap.modifycateerResType" type="hidden" value="${initMap.lovelyInfo.crResType}"/>
<input name="paramMap.modifycateerCateTwLevel" type="hidden" value="${initMap.lovelyInfo.crCateTwLevel}"/>

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
										<td width="85%" class="tatd" align="left"><input name="paramMap.crName" type="text" value="${initMap.lovelyInfo.crName}" id="crName" style="width: 200px;" />&nbsp;
										<font color="red">*</font><span id="crNameTip" style="position:absolute;height:22px;"></span></td>
									</tr>
									
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.crResType" id="crResType" value="${initMap.lovelyInfo.crResType}" maxlength="180" style="width: 200px;">
											<input type="hidden" name="paramMap.crResTypeName" id="crResTypeName" value="${initMap.lovelyInfo.crResTypeName}" maxlength="180" style="width: 200px;">
											<select name="total" id="total">
												<option value="">----请选择----</option>
												<s:iterator value="initMap.resCategoryList" id="cate" status="ind">
													<option value="${cate.cateID}" ${initMap.lovelyInfo.crResType eq cate.cateID ? 'selected':'' }>${cate.cateName}</option>
												</s:iterator>
											</select>
											<font color="red">*</font><span id="totalTip" style="position:absolute;height:22px;"></span>
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">二级分类：</td>
										<td width="85%" class="tatd" align="left">
											<input type="hidden" name="paramMap.crCateTwLevel" id="crCateTwLevel" style="width: 200px;" value="${initMap.lovelyInfo.crCateTwLevel}">
											<input type="hidden" name="paramMap.crCateTwLevelName" id="crCateTwLevelName" style="width: 200px;" value="${initMap.lovelyInfo.crCateTwLevelName}">
											<select id="cateTwLevel" name="cateTwLevel"  ><option>----请选择----</option></select>
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">资源类型：</td>
										<td width="85%" class="tatd" align="left">
											<select name="paramMap.crType" id="crType">
												<option value="">----请选择----</option>
												<option value="1011" ${initMap.lovelyInfo.crType eq "1011" ? 'selected':'' }>高清图片</option>
												<option value="1084" ${initMap.lovelyInfo.crType eq "1084" ? 'selected':'' }>高清视频</option>
												<option value="4033" ${initMap.lovelyInfo.crType eq "4033" ? 'selected':'' }>压缩包</option>
												<option value="2041" ${initMap.lovelyInfo.crType eq "2041" ? 'selected':'' }>PPT文件</option>
												<option value="2033" ${initMap.lovelyInfo.crType eq "2033" ? 'selected':'' }>WORD文件</option>
												<option value="2055" ${initMap.lovelyInfo.crType eq "2055" ? 'selected':'' }>PDF文件</option>
												<option value="3036" ${initMap.lovelyInfo.crType eq "3036" ? 'selected':'' }>其他文件</option>
												<option value="2095" ${initMap.lovelyInfo.crType eq "2095" ? 'selected':'' }>swf文件</option>
											</select>
											<input type="hidden" name="paramMap.oldResType" id="oldResType" value="${initMap.lovelyInfo.crType}" >											
											&nbsp;<font color="red">*</font><span id="crTypeTip" style="position:absolute;height:22px;"></span>
										</td>
								   	</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" height="30px" align="right" id="res_change_name">资源文件：</td>
										<td width="85%" class="tatd" align="left" id="uploadShowDiv">
										<input type="hidden" name="paramMap.oldResUpload" id="oldResUpload" value="${initMap.lovelyInfo.crUpload}" >
										<input type="hidden" name="paramMap.crUpload" id="crUpload" value="${initMap.lovelyInfo.crUpload}">
										<input type="hidden" name="paramMap.crFileSwf" id="crFileSwf" value="${initMap.lovelyInfo.crFileSwf}">
										<input type="hidden" name="paramMap.crNewUpload" id="crNewUpload" value="${initMap.lovelyInfo.crUpload}">
										<input type="hidden" name="paramMap.isUpload" id="isUpload" value="1">
										</td>
									</tr>
									<tr bgcolor="#ae9b84" id="lovelycreate6">
										<td width="15%" class="tatd" align="right">缩略图：</td>
										<td width="85%" class="tatd" align="left">
										<img alt="" src="${initMap.lovelyInfo.crThumbnail}" width="50px" height="50px">
										<input type="file" name=upload id="upload" class="thumUpload" onchange="onchangeUpload('uploadThumFile');"  />
										<span id="uploadTip" style="position:absolute;height:22px;width:299px"></span>
										<input type="hidden" name="paramMap.uploadThumFile" id="uploadThumFile" value="0">
										<input type="hidden" name="paramMap.uploadThumFile" id="ThumfilediFile" value="">
										<input type="hidden" name="paramMap.crThumbnail" id="crThumbnail" value="${initMap.lovelyInfo.crThumbnail}">
										<input type="hidden" name="paramMap.crInThum"  value="${initMap.lovelyInfo.crInThum}">
										<input type="hidden" name="title" id="titleuploadThumFile" value="">
										<span id="thumformat"></span>
										<span id="Thum"></span>
										</td>
									</tr>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">推荐到首页：</td>
										<td width="85%" class="tatd" align="left" id="uploadShowDivRecommen">
											<input type="checkbox" name="orRec" value="0" class="erRecommen"> 

											<input type="radio" name="Recommensize" value="11" class="Recommensize" style="display: none;"><span style="display: none;">305*145</span>
											<input type="radio" name="Recommensize" value="22" class="Recommensize" style="display: none;"><span style="display: none;">143*145</span>
											
											<input type="file" name=upload id="recommenFile" onchange="onchangeUpload('erRecommen');" style="display: none;" />
											<span id="recommenFileTip" style="position:absolute;height:22px;width:293px"></span>
											<input type="hidden" name="paramMap.crRecommen" id="crRecommen" value="${initMap.lovelyInfo.crRecommen}">
											<input type="hidden" name="paramMap.Recommensize" id="Recommensize" value="${initMap.expaRecommen.reSize}">
											<input type="hidden" name="paramMap.OlderRecommenFile" id="OlderRecommenFile" value="${initMap.expaRecommen.reRecoFileUP}">
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
										<input type="checkbox"  name="paramMap.crIsShare" id="crIsShare" value="1"  >
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
									<%-- <tr bgcolor="#ae9b84" id="crContent" >
										<td width="15%" class="tatd" align="right">资源简介：</td>
										<td width="85%" class="tatd" align="left">
											<textarea cols="80" id="editor1" name="paramMap.crContent" rows="10">${initMap.lovelyInfo.crContent}</textarea>
										    <script type="text/javascript">
											CKEDITOR.replace('editor1',{ filebrowserUploadUrl : 'ckeditor/uploader?Type=File&TypeRoom=lovely&erno='+'${initMap.lovelyInfo.crNo}', filebrowserImageUploadUrl : 'ckeditor/uploader?Type=Image&TypeRoom=lovely&erno='+'${initMap.lovelyInfo.crNo}', filebrowserFlashUploadUrl : 'ckeditor/uploader?Type=Flash&TypeRoom=lovely&erno='+'${initMap.lovelyInfo.crNo}'});
 											</script>
 											<input type="file" name="upload" id="contentfile" >
 											<input type="hidden" name="title" id="titlecontentfileFile" value="">
 											<input type="hidden" name="paramMap.crContent" value="${initMap.lovelyInfo.crContent}">
 											<span id="contentfileTip" style="position:absolute;height:22px;width:293px"></span>
										</td>
									</tr> --%>
									<tr bgcolor="#ae9b84" height="30">
										<td width="15%" class="tatd" align="right" style="border-right: 1px"></td>
										<td width="85%" class="tatd" align="left" ></td>
									</tr>
									<%-- <tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">小学分类：</td>
										<td width="85%" class="tatd" align="left">
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="303" <s:if test="initMap.lovelyInfo.crGrade.indexOf('303') > -1">checked</s:if>><span>三年级</span>
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="304" <s:if test="initMap.lovelyInfo.crGrade.indexOf('304') > -1">checked</s:if>><span>四年级</span>
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="305" <s:if test="initMap.lovelyInfo.crGrade.indexOf('305') > -1">checked</s:if>><span>五年级</span>
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="306" <s:if test="initMap.lovelyInfo.crGrade.indexOf('306') > -1">checked</s:if>><span>六年级</span> 
										</td>
									</tr> --%>
									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">初中分类：</td>
										<td width="85%" class="tatd" align="left">
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="311" <s:if test="initMap.lovelyInfo.crGrade.indexOf('311') > -1">checked</s:if>>七年级
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="312" <s:if test="initMap.lovelyInfo.crGrade.indexOf('312') > -1">checked</s:if>>八年级
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="313" <s:if test="initMap.lovelyInfo.crGrade.indexOf('313') > -1">checked</s:if>>九年级
										</td>				
									</tr>
 									<tr bgcolor="#ae9b84">
										<td width="15%" class="tatd" align="right">高中分类：</td>
										<td width="85%" class="tatd" align="left">
										 <input type="checkbox" name="paramMap.grGrades" id="grGrades" value="321" <s:if test="initMap.lovelyInfo.crGrade.indexOf('321') > -1">checked</s:if>><span>必修一</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="322" <s:if test="initMap.lovelyInfo.crGrade.indexOf('322') > -1">checked</s:if>><span>必修二</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="323" <s:if test="initMap.lovelyInfo.crGrade.indexOf('323') > -1">checked</s:if>><span>必修三</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="331" <s:if test="initMap.lovelyInfo.crGrade.indexOf('331') > -1">checked</s:if>><span>选修一</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="332" <s:if test="initMap.lovelyInfo.crGrade.indexOf('332') > -1">checked</s:if>><span>选修二</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="333" <s:if test="initMap.lovelyInfo.crGrade.indexOf('333') > -1">checked</s:if>><span>选修三</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="334" <s:if test="initMap.lovelyInfo.crGrade.indexOf('334') > -1">checked</s:if>><span>选修四</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="335" <s:if test="initMap.lovelyInfo.crGrade.indexOf('335') > -1">checked</s:if>><span>选修五</span>&nbsp;
										<input type="checkbox" name="paramMap.grGrades" id="grGrades" value="336" <s:if test="initMap.lovelyInfo.crGrade.indexOf('336') > -1">checked</s:if>><span>选修六</span>&nbsp;
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
		
		<%-- <a href="downloadAction.action?code=-706&paramMap.resDownRoom=lovely&paramMap.resDownType=${initMap.lovelyInfo.crType}&paramMap.resPath=${initMap.lovelyInfo.crUpload}" >下载</a> --%>
		&nbsp;<font color="red">*</font><span id="isUploadTip" style="position:absolute;height:22px;width:200px;"></span>
	</form>
</div>
<div id="progress" style="left: 140px;">
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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/scripts.js"></script>
</body>
</html>