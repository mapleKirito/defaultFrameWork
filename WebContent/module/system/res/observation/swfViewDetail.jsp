<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title></title>
<link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
 	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
 	<script type="text/javascript" src="<%=request.getContextPath()%>/js/tweenmax.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
 	<script type="text/javascript" src="<%=request.getContextPath()%>/js/scripts.js"></script>  
  	<script type="text/javascript" src="<%=request.getContextPath()%>/js/flexpaper_flash_debug.js"></script>
<style type="text/css">
.popup-rc-comment{right: 130px;}
.popup-rc-comment .icon-up-arrow{right: 150px;}
</style>
<script type="text/javascript">
$(document).ready(function(){	
	fieldControl();
	$(".res-detail").height($(window).innerHeight()-80);
	$("#viewerPlaceHolder").height($(window).innerHeight()-50).css("margin-top","10px");
	
	$("#centermiddleimg").LoadImage(true,$("#mainFramewidth",parent.document).val(),$("#mainFrameheight",parent.document).val()).parent().parent().css("height",$("#mainFrameheight",parent.document).val());
	
	//   #revM  评论信息模块
	
	$(".relative-res-body .imgresource a").click(function(){
		var i_ = $(this).attr("name");
		var resid = i_.substring(i_.indexOf("orID")+5,i_.indexOf("&"));
		var roomtype = i_.substring(i_.indexOf("roomtype")+9,i_.lastIndexOf("&"));

		$.ajax({
		  	url:		'SmallServlet/ser?ID='+resid+'&roomname='+roomtype,
			type:	    'post',
			timeout:	'60000',
			data:	Array(),
			dataType:	'json',
			beforeSend:function(request){},
			complete:function(request,textStatus){},
			success:function(jsonData,textStatus){
			if (textStatus == "success"){
				$("#orCode").html(jsonData.LR_Code);
				$("#centermiddleimg").attr("src",jsonData.LR_InThum);
			}}
		});
	});
	
		$(".rc-qrcode").click(function(){
		$("#revM").hide();
		var curWwwPath=window.document.location.href; 
		var pathName=window.document.location.pathname; 
		var pos=curWwwPath.indexOf(pathName); 
		var localhostPaht=curWwwPath.substring(0,pos); 
		//var st=localhostPaht+"/dm/show_page?id=${initMap.videoDetail.orNo}&pageName=scanner";
		var st=localhostPaht+"/dm/page/scanner/"+code+"/scanner.html";
		art.dialog.data('str', st);
		art.dialog.data('code', "${initMap.videoDetail.orNo}");
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/qrcode.jsp',{width:266,height:304,title:'二维码扫描(扫描二维码获取相关信息)',lock:'true',background:'#666666',opacity: '0.15'}) ;
	});
	
	//$("#revL").load("decorateForwardAction.action?code=-600604&paramMap.ptype=observation&paramMap.pid="+$("#reviewID").val()+"&paramMap.resURL="+$(".addFavorite").attr("id")+"&paramMap.userID=${paramMap.s_userID}&paramMap.userType=${paramMap.s_userType}");
	 $("#revR").click(function(){
		//$("#revL").load("decorateForwardAction.action?code=-600604&paramMap.ptype=exhibition&paramMap.pid="+$("#reviewID").val()+"&paramMap.resURL="+$(".addFavorite").attr("id")+"&paramMap.userID=${paramMap.s_userID}&paramMap.userType=${paramMap.s_userType}");
		art.dialog.data('ptype', "observation");
		art.dialog.data('reviewID', $("#reviewID").val());
		art.dialog.data('resURL', $(".addFavorite").attr("id"));
		$("#isOpen",window.parent.document).attr("value",1);
		art.dialog.open('<%=request.getContextPath()%>/module/enginev/pinglun.jsp',{width:611,height:374,title:'资源评论详情'}) ;
	});
	
	 /*资源详细页面JS*/
    $(".res-controls li>a.rc").mouseover(function () {
        $(this).addClass("hover");
        $("div.hide-popup").fadeOut();
        $("div.popup-" + $(this).attr("data-type")).fadeIn();
    });
    $("div.hide-popup").mouseleave(function () {
        $(".res-controls li>a.rc").removeClass("hover");
        $("div.hide-popup").fadeOut();
    });

    $('#revL,.hide-popup-content').rollbar({ zIndex: 10, pathPadding: "0px" });

    $.ajax({
		url:		'ajaxAction.action?suiji='+new Date().getTime()+'&code=${code}&paramMap.roomtype=observation&paramMap.orID=${initMap.videoDetail.orID}',
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},//ajax执行前调用函数
		complete:function(request,textStatus){},//ajax请求完成后调用函数
		success:function(jsonData,textStatus){//ajax请求成功调用函数
			if (textStatus == "success"){
				//alert(jsonData.list.length);
				for(var i=0;i<jsonData.list.length;i++){
					var resType=jsonData.list[i].resType;
					var pname="";
					var broomname="";
					var pcode="";
					if(resType=="exhibition"){
						pname="erID";
						broomname="er";
						pcode="-701003";
						if(jsonData.list[i].fileType=="1011"){
							pcode="-701001";
						}else if(jsonData.list[i].fileType=="1073"||jsonData.list[i].fileType=="1084"){
							pcode="-701002";
						}else if(jsonData.list[i].fileType=="2041"||jsonData.list[i].fileType=="2033"||jsonData.list[i].fileType=="2055"){
							pcode="-701018";
						}
					}else if(resType=="observation"){
						pname="orID";
						broomname="or";
						pcode="-701006";
						if(jsonData.list[i].fileType=="1011"||jsonData.list[i].fileType=="1022"){
							pcode="-701004";
						}else if(jsonData.list[i].fileType=="4033"){
							pcode="-701023";
						}else if(jsonData.list[i].fileType=="1073"||jsonData.list[i].fileType=="1084"){
							pcode="-701005";
						}else if(jsonData.list[i].fileType=="2041"||jsonData.list[i].fileType=="2033"||jsonData.list[i].fileType=="2055"){
							pcode="-701019";
						}
					}else if(resType=="laboratory"){
						pname="lrID";
						broomname="lr";
						pcode="-701009";
						if(jsonData.list[i].fileType=="1011"||jsonData.list[i].fileType=="1022"){
							pcode="-701007";
						}else if(jsonData.list[i].fileType=="1073"||jsonData.list[i].fileType=="1084"){
							pcode="-701008";
						}else if(jsonData.list[i].fileType=="2041"||jsonData.list[i].fileType=="2033"||jsonData.list[i].fileType=="2055"){
							pcode="-701020";
						}
					}else if(resType=="projection"){
						pname="prID";
						broomname="pr";
						pcode="-701012";
						if(jsonData.list[i].fileType=="1011"||jsonData.list[i].fileType=="1022"){
							pcode="-701010";
						}else if(jsonData.list[i].fileType=="1073"||jsonData.list[i].fileType=="1084"){
							pcode="-701011";
						}else if(jsonData.list[i].fileType=="2041"||jsonData.list[i].fileType=="2033"||jsonData.list[i].fileType=="2055"){
							pcode="-701021";
						}
					}else if(resType=="lovely"){
						pname="crID";
						broomname="cr";
						pcode="-701013";
						if(jsonData.list[i].fileType=="1011"||jsonData.list[i].fileType=="1022"){
							pcode="-701016";
						}else if(jsonData.list[i].fileType=="1073"||jsonData.list[i].fileType=="1084"){
							pcode="-701017";
						}else if(jsonData.list[i].fileType=="2041"||jsonData.list[i].fileType=="2033"||jsonData.list[i].fileType=="2055"){
							pcode="-701022";
						}else if(jsonData.list[i].fileType=="3036"){
							pcode="-701030";
						}
					}
					
					//alert(jsonData.list[i].id);
					var hreft="decorateForwardAction.action?code="+pcode+"&path="+jsonData.list[i].path+"&paramMap."+broomname+"Type="+jsonData.list[i].fileType+"&paramMap.fileType="+jsonData.list[i].fileType+"&paramMap."+pname+"="+jsonData.list[i].id+"&paramMap.st=1&paramMap.temppname="+pname+"&paramMap.temppid="+jsonData.list[i].id+"&paramMap.name="+jsonData.list[i].name+"&paramMap.roomtype="+jsonData.list[i].resType;
					//alert($("#resAll_"+jsonData.list[i].id).html());
					$(".resAll_"+jsonData.list[i].id).find("a").attr("hreft",hreft);
					$(".resAll_"+jsonData.list[i].id).find("a").find("img").attr("src",jsonData.list[i].thumbnail)
					
				}
				
			}
		},
		//ajax请求错误后调用函数
		error:function(request,textStatus,error){}
	}); 
  
});
function reflushSwfPlayer(path){
	var fp = new FlexPaperViewer(	
			 '<%=request.getContextPath()%>/online_read_module/FlexPaperViewer',
			 'viewerPlaceHolder', { config : {
			 SwfFile : path,
			 Scale : 1.3, 
			 ZoomTransition : 'easeOut',
			 ZoomTime : 0.5,
			 ZoomInterval : 0.2,
			 FitPageOnLoad : false,
			 FitWidthOnLoad : false,
			 PrintEnabled : true,
			 FullScreenAsMaxWindow : false,
			 ProgressiveLoading : false,
			 MinZoomSize : 0.2,
			 MaxZoomSize : 5,
			 SearchMatchAll : false,
			 InitViewMode : 'Portrait',
			 ViewModeToolsVisible : true,
			 ZoomToolsVisible : true,
			 NavToolsVisible : true,
			 CursorToolsVisible : true,
			 SearchToolsVisible : true,
				 localeChain: 'en_US'
			 }});
}
function fieldControl(){
	
	if(isFieldNull('${initMap.videoDetail.orNO}')) $(".erCode").parent().remove();
    
    if(isFieldNull('${initMap.videoDetail.orCategoryName}')) $(".orCategoryName").parent().remove();
    
    if(isFieldNull('${initMap.videoDetail.orCateTwLevelName}')) $(".orCateTwLevelName").parent().remove();
    
    if(isFieldNull('${initMap.videoDetail.orCateTHLevelName}')) $(".orCateTHLevelName").parent().remove();
    
    if(isFieldNull('${initMap.videoDetail.orCateFoLevelName}')) $(".orCateFoLevelName").parent().remove();
    
    
    //初始化 国家 tr
    if(isFieldNull('${initMap.videoDetail.orCountryName}')) $(".orCountryName").parent().remove();
    
    //初始化 省份 tr
    if(isFieldNull('${initMap.videoDetail.orProvinceName}')) $(".orProvinceName").parent().remove();
    
    //初始化 市县区 tr
    if(isFieldNull('${initMap.videoDetail.orCity}') || isFieldNull('${initMap.videoDetail.orCity}')==isFieldNull('${initMap.videoDetail.orProvinceName}')) $(".orCity").parent().remove();
    
    //初始化 出土地 tr
    if(isFieldNull('${initMap.videoDetail.orPlaceName}')) $(".orPlaceName").parent().remove();
    
    
    //初始化 备注 tr
    if(isFieldNull('${initMap.videoDetail.orRemarks}')) $(".orRemarks").parent().remove();

}
function isFieldNull(fieldName){
	var reg = /^\s+$/;
    if(typeof fieldName == 'undefined' || fieldName == '' || reg.test(fieldName)){
    	  return true;
    }
    return false;
}
</script> 
<style type="text/css">
.hide-popup{float: right;left:40px;}
.hide-popup i.icon-up-arrow{left: 230px;}
.popup-rc-info{left: 150px;}
.popup i.icon-up-arrow {left: 130px;}
.popup-rc-cloud-down {left: 180px;}
.rc-cloud-down i.icon-up-arrow {left: 100px;}

.hide-popup.popup-rc-cloud-down.rc-cloud-down i{left: 100px;}
</style> 
</head>
<body>
<input type="hidden" class="image_w" value="">
<input type="hidden" class="image_h" value="">
<input type="hidden" class="roomname" value="observation">
<input type="hidden" id="orName" value="${initMap.videoDetail.orName}">
<input type="hidden" id="orUpload" value="${initMap.videoDetail.orUpload}">
<input type="hidden" id="orNo" value="${initMap.videoDetail.orNo}">
<input type="hidden" id="resURL" value="${code}|${paramMap.path}|observation|${paramMap.st}|${initMap.videoDetail.orName}|${initMap.videoDetail.orType}|${initMap.videoDetail.orID}">
<input type="hidden" id="userID" value="${paramMap.s_userID}">
<input type="hidden" id="userType" value="${paramMap.s_userType}">
 <div id="layout_mainbody">
 	 <div class="res-detail-info">
                    <h4><b>资源名称：</b>${initMap.videoDetail.orName}</h4>
                    <ul class="res-controls">
                       <li title="下载">
		                  	<a href="javascript:void(0);" title="资源下载" data-type="rc-cloud-down" class="rc rc-cloud-down"></a>
		                  	<div class="hide-popup popup-rc-cloud-down rc-cloud-down">
		                          <i class="icon-up-arrow"></i>
		                          <div class="hide-popup-content">
		                              <table>
		                                  <tr>
		                                      <td class="key keya"><a href="downloadAction.action?code=-706&paramMap.resDownRoom=observation&paramMap.resDownType=${initMap.videoDetail.orType}&paramMap.resPath=${initMap.videoDetail.orUpload}">资源下载</a></td>
		                                  </tr>
		                              </table>
		                          </div>
		                      </div>
		                  </li>
		              
		               <s:if test="session.s_userType != 3 and paramMap.st == 1 and session.s_userType != 5">
                  			 <li>
                  			 	<a  data-type="rc-query" title="加入收藏" onclick="window.parent.insert_fav(this)" class="addFavorite rc rc-query"  href="javascript:void(0);"   id="${code}|${paramMap.path}|observation|${paramMap.st}|${initMap.videoDetail.orName}|${initMap.videoDetail.orType}|${initMap.videoDetail.orID}" >
                  				</a>  
                  			</li>
                  		</s:if>
		                  
                        
		              
                        <!-- 二维码 -->
                        <li><a href="javascript:void(0);" title="二维码" data-type="rc-qrcode" class="rc rc-qrcode"></a></li>
                       
                       
                        <!-- 评论 -->
                        <li><a href="javascript:void(0);" title="评论" data-type="rc-comment" class="rb rc-comment" id="revR" ></a>
                       		 <div id="revM" class="hide-popup popup-rc-comment" style="display: none;">
								
								
								<i class="icon-up-arrow"></i>
								<div  class="hide-popup-comment" id="revL" style="width:360px;height:290px;float: left;overflow-x:hidden;overflow-y:scroll; background-color: #ae9b84;position: relative;">评论加载中...</div>
								<input type="hidden" id="reviewID" value="${initMap.videoDetail.orID}">
							</div>
                       	
                       	</li>
                       
                        <!-- 资源详细信息 -->
                        <li>
                            <a href="javascript:void(0);" title="资源详细信息" data-type="rc-info" class="rc rc-info"></a>
                            <div class="hide-popup popup-rc-info">
                                <i class="icon-up-arrow"></i>
                                <div class="hide-popup-content">
                                  
                                 <table>
                                 <tr>
										<td width="25%" align="center">资源编号</td>
										<td width="75%" align="center" class="erCode">${initMap.videoDetail.orNO}</td>
									</tr>
									<tr>
										<td width="25%" align="center">资源名称</td>
										<td width="75%" align="center" class="erName">${initMap.videoDetail.orName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">资源类型</td>
										<td width="75%" align="center" class="erType">
											    ${initMap.videoDetail.orType eq "1011" ? '高清图片':'' }
												${initMap.videoDetail.orType eq "1022" ? '3D图片':'' }
												${initMap.videoDetail.orType eq "1073" ? '音频':'' }
												${initMap.videoDetail.orType eq "1084" ? '高清视频':'' }
												${initMap.videoDetail.orType eq "1005" ? '动画类素材':'' }
												${initMap.videoDetail.orType eq "1006" ? '其他素材':'' }
												${initMap.videoDetail.orType eq "2041" ? 'PPT课件':'' }
												${initMap.videoDetail.orType eq "2002" ? '动画类课件':'' }
												${initMap.videoDetail.orType eq "2033" ? 'WORD课件':'' }
												${initMap.videoDetail.orType eq "2055" ? 'PDF课件':'' }
												${initMap.videoDetail.orType eq "2004" ? '其他课件':'' }
												${initMap.videoDetail.orType eq "3031" ? '环球百科':'' }
												${initMap.videoDetail.orType eq "3032" ? '文学报告':'' }
												${initMap.videoDetail.orType eq "3033" ? '论文资料':'' }
												${initMap.videoDetail.orType eq "3034" ? '资料图书':'' }
												${initMap.videoDetail.orType eq "3035" ? '适用学段、年级与大纲':'' }
												${initMap.videoDetail.orType eq "3036" ? '其他资料':'' }
										
										</td>
									</tr>
									<tr>
										<td width="25%" align="center">一级分类</td>
										<td width="75%" align="center" class="erTotal">${initMap.videoDetail.orCategoryName}</td>
									</tr>
								    	<tr>
										<td width="25%" align="center">二级分类</td>
										<td width="75%" align="center" class="orCateTwLevelName">${initMap.videoDetail.orCateTwLevelName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">三级分类</td>
										<td width="75%" align="center" class="orCateTHLevelName">${initMap.videoDetail.orCateTHLevelName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">四级分类</td>
										<td width="75%" align="center" class="orCateFoLevelName">${initMap.videoDetail.orCateFoLevelName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">国家</td>
										<td width="75%" align="center" class="orCountryName">${initMap.videoDetail.orCountryName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">省份</td>
										<td width="75%" align="center" class="orProvinceName">${initMap.videoDetail.orProvinceName}</td>
									</tr> 
									 <tr>
										<td width="25%" align="center">市区县</td>
										<td width="75%" align="center" class="orCity">${initMap.videoDetail.orCityName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">出土地</td>
										<td width="75%" align="center" class="orPlaceName">${initMap.videoDetail.orPlaceName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">备注</td>
										<td width="75%" align="center" class="orRemarks">${initMap.videoDetail.orRemarks}</td>
									</tr>
								
                                  
                              </table>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <!--弹出菜单数据-->
                
                <div class="page-container">
                    <!--资源详细开始-->
                    <div class="res-detail_x">
                        <div class="controll">
                            <a href="javascript:void(0);" data-type="pre" class="btn pre"><i class="res-scroll-pre"></i></a>
                            <a href="javascript:void(0);" data-type="next" class="btn next"><i class="res-scroll-next"></i></a>
                          </div> 
                          <div  class="controll" style="display: none;">
                            <a href="javascript:void(0);" data-type="pre_x" class="btn_x pre_x"><i class="res-scroll-pre_x"></i></a>
                            <a href="javascript:void(0);" data-type="next_x" class="btn_x next_x"><i class="res-scroll-next_x"></i></a>
                           </div>
                           <div class="res-detail-container">
                           <a href="javascript:void(0);">
                           	 <img src=""  style="display:none;"/> 
                          	<div id="viewerPlaceHolder"  style="display:block" > 
                          	</div>
						        <script type="text/javascript"> 
						       	var swfPath = "<%=request.getContextPath()%>/${initMap.videoDetail.orFileSwfPath}";
								var fp = new FlexPaperViewer(	
										 '<%=request.getContextPath()%>/online_read_module/FlexPaperViewer',
										 'viewerPlaceHolder', { config : {
										 SwfFile : swfPath,
										 Scale : 1.3, 
										 ZoomTransition : 'easeOut',
										 ZoomTime : 0.5,
										 ZoomInterval : 0.2,
										 FitPageOnLoad : false,
										 FitWidthOnLoad : false,
										 PrintEnabled : true,
										 FullScreenAsMaxWindow : false,
										 ProgressiveLoading : false,
										 MinZoomSize : 0.2,
										 MaxZoomSize : 5,
										 SearchMatchAll : false,
										 InitViewMode : 'Portrait',
										 ViewModeToolsVisible : true,
										 ZoomToolsVisible : true,
										 NavToolsVisible : true,
										 CursorToolsVisible : true,
										 SearchToolsVisible : true,
					 						 localeChain: 'en_US'
										 }});
						 
						        </script>	                                         	
											
                            </a>
                        </div>
                    </div>
                    <!--资源详细结束-->

                    <!--相关资源-->
                    <div class="relative-res">
                         <div class="relative-res-title">
                            <!-- <a class="tab on" href="javascript:void(0);">参考资源</a> -->
                            <a class="tab" href="javascript:void(0);">相关资源</a>
                            <span class="toggle">
                                <a href="javascript:void(0);"><i></i><b>展开</b></a>
                            </span>
                        </div>
                         <div class="relative-res-body">
                           <!-- <div class="controll">
                            <a href="javascript:void(0);" data-type="pre" class="btn pre"><i class="res-scroll-pre"></i></a>
                            <a href="javascript:void(0);" data-type="next" class="btn next"><i class="res-scroll-next"></i></a>
                            </div> --> 
                            <div  class="controll" style="display: none;">
                            <a href="javascript:void(0);" data-type="pre_x" class="btn_x pre_x"><i class="res-scroll-pre_x"></i></a>
                            <a href="javascript:void(0);" data-type="next_x" class="btn_x next_x"><i class="res-scroll-next_x"></i></a>
                           </div>
                           
                           <%--  <div class="relative-res-container">
                            	<!-- 图片资源 -->
                            	
                                <ul class="res_t" id="relative-res-body_res_t">
                                    <li>
										<a href="javascript:void(0)" onclick="reflushSwfPlayer('${initMap.videoDetail.orFileSwfPath}')">
										        <img src="${initMap.videoDetail.orThumbnail}"  title="主资源"  height="110" width="145"/>
										</a>
									</li>
									<s:iterator value="initMap.refer" id="fv" status="fvindx">
										<li >
				                  			<a href="javascript:void(0);" onclick="reflushSwfPlayer('${fv.referFileSwfPath}')">
				                  				<img src="${fv.thumbnail}" width="145" height="110"/>
				                  			</a>
			                  			<span>
			                  				<s:if test="#fv.name.length() > 4"><s:property value="#fv.name.substring(0,4)" />...</s:if><s:else><s:property value="#fv.name" /></s:else>
			                  			</span>
			                  			</li>
										
									</s:iterator>
                                   
                                </ul>
                            </div> --%>
                            <div class="relative-res-container" style="display:none">
                               <!-- 相关资源 -->
                                <ul class="res_x" id="relative-res-body_res_x">
                                
	                              <s:iterator value="initMap.resAllView" id="fv" status="fvindx">
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
				                   			<s:if test="#fv.fileType == '1073' || #fv.fileType == '1084'">
				                   				<s:set name="pcode" value="'-701011'" />
				                   			</s:if>
				                   			<s:if test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
				                   				<s:set name="pcode" value="'-701021'" />
				                   			</s:if>
				                   		</s:if>
				                   		<s:if test="#fv.resType == 'lovely'">
				                   			<s:set name="pcode" value="'-701013'" />
				                   			<s:set name="pname" value="'crID'" />
				                   			<s:set name="broomname" value="'cr'" />
				                   			<s:if test="#fv.fileType == '1011' || #fv.fileType == '1022'">
				                   				<s:set name="pcode" value="'-701016'" />
				                   			</s:if>
				                   			<s:if test="#fv.fileType == '1073' || #fv.fileType == '1084'">
				                   				<s:set name="pcode" value="'-701017'" />
				                   			</s:if>
				                   			<s:if test="#fv.fileType == '2041' || #fv.fileType == '2033' || #fv.fileType == '2055'">
				                   				<s:set name="pcode" value="'-701022'" />
				                   			</s:if>
				                    		<s:if test="#fv.fileType == '3036'">
				                    			<s:set name="pcode" value="'-701030'" />
				                    		</s:if>
				                   		</s:if>
				                   		<s:if test="#expurl == ''">
				                  			<li class="resAll_${fv.id}">
					                  			<a href="javascript:void(0);" onclick="otherRes(this)" hreft="decorateForwardAction.action?code=${pcode}&path=${fv.path}&paramMap.${broomname}Type=${fv.fileType}&paramMap.fileType=${fv.fileType}&paramMap.${pname}=${fv.id}&paramMap.st=1&paramMap.temppname=${pname}&paramMap.temppid=${fv.id}&paramMap.name=${fv.name}&paramMap.roomtype=${fv.resType}">
					                  				<img src="images/ajax-loader.gif" width="145" height="110" title="${fv.name}"/>
					                  			</a>
				                  			<span>
				                  				<s:if test="#fv.name.length() > 4"><s:property value="#fv.name.substring(0,4)" />...</s:if><s:else><s:property value="#fv.name" /></s:else>
				                  			</span>
				                  			</li>		
				                  		</s:if>					     							
								</s:iterator>
                               
                         	   </ul>
                      	  </div>
                   	  </div>
               	  </div>
            	</div>
			</div>
	
	</body>
</html>