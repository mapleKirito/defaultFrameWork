<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title></title>
<link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<script type="text/javascript">
$(document).ready(function(){	
	
	fieldControl();
	
	$(".res-detail").height($(window).innerHeight()-40);
	$(".res-detail_x img").height($(window).innerHeight()-110);
	$(".res-detail_x img").css("margin-top","10px").css("margin-bottom","60px");
	$(".res-detail_x img").height($(window).innerHeight()-110); 
	
	$("#centermiddleimg").LoadImage(true,$("#mainFramewidth",parent.document).val(),$("#mainFrameheight",parent.document).val()).parent().parent().css("height",$("#mainFrameheight",parent.document).val());
	
	//   #revM  评论信息模块
	
	$(".relative-res-body .imgresource a").click(function(){
		var i_ = $(this).attr("name");
		var resid = i_.substring(i_.indexOf("erID")+5,i_.indexOf("&"));
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
				$("#erCode").html(jsonData.ER_Code);
				$("#centermiddleimg").attr("src",jsonData.ER_InThum);
			}}
		});
	});
	
	$(".rc-position").click(function(){
		$("#revM").hide();
		art.dialog.data('erlalo', '${paramMap.erLoLa}');
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/module/enginev/MapBaidu2.jsp',{width:611,height:374,title:'高清图片分布地区展示'}) ;
	});
	
	$(".rc-qrcode").click(function(){
		$("#revM").hide();
		var curWwwPath=window.document.location.href; 
		var pathName=window.document.location.pathname; 
		var pos=curWwwPath.indexOf(pathName); 
		var localhostPaht=curWwwPath.substring(0,pos); 
		var code = $("#erCode").val();
		var st=localhostPaht+"/dm/show_page?id="+code+"&pageName=scanner";
		art.dialog.data('str', st);
		art.dialog.data('code', erCode);
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/qrcode.jsp',{width:266,height:304,title:$(".res-detail-info h4 label").html()+'-二维码扫描',lock:'true',background:'#666666',opacity: '0.15'}) ;
	});
	
	
	//评论，模块
//	//$("#revL").load("decorateForwardAction.action?code=-600604&paramMap.ptype=laboratory&paramMap.pid="+$("#reviewID").val()+"&paramMap.resURL="+$(".addFavorite").attr("id")+"&paramMap.userID=${paramMap.s_userID}&paramMap.userType=${paramMap.s_userType}");
	
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

   //音频控制
    var ua = navigator.userAgent.toLowerCase();   
    if(ua.match(/iPad/i)=="mise" ){
	   $("#bgm").html('<embed src="${initMap.picDetail.erAudio}" id="mp" style="height:0px;width:0px;" autostart="false" loop="true">');
	}else{
		$("#bgm").html('<audio src="${initMap.picDetail.erAudio}" id="mp"></audio>');
	}	
    
    
    $.ajax({
		url:		'ajaxAction.action?suiji='+new Date().getTime()+'&code=${code}&paramMap.roomtype=exhibition&paramMap.erID=${initMap.picDetail.erID}',
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
						pname="erID";
						broomname="er";
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

function fieldControl(){
	
	if(isFieldNull('${initMap.picDetail.erCode}')) $(".erCode").parent().remove();
    
	if(isFieldNull('${initMap.picDetail.erTotal}')) $(".erTotal").parent().remove();
	
	if(isFieldNull('${initMap.picDetail.erJie}')) $(".erJie").parent().remove();
	 
    if(isFieldNull('${paramMap.erLoLaName}')) $(".erLoLaName").parent().remove();
    
    if(isFieldNull('${initMap.picDetail.erChor}')) $(".erChor").parent().remove();
    
    if(isFieldNull('${initMap.picDetail.erGang}')) $(".erGang").parent().remove();
    
    if(isFieldNull('${initMap.picDetail.erOrder}')) $(".erOrder").parent().remove();
    
    if(isFieldNull('${initMap.picDetail.erCategoryName}')) $(".erCategoryName").parent().remove();
    
    if(isFieldNull('${initMap.picDetail.erCustom}')) $(".erCustom").parent().remove();
    
    if(isFieldNull('${initMap.picDetail.erLatinName}')) $(".erLatinName").parent().remove();
    
    //初始化 保存地 tr
    if(isFieldNull('${initMap.picDetail.erBiologicalReserve}')) $(".erBiologicalReserve").parent().remove();
    
    //初始化 采集人 tr
    if(isFieldNull('${initMap.picDetail.erHunters}')) $(".erHunters").parent().remove();
    
    //初始化 采集编号 tr
    if(isFieldNull('${initMap.picDetail.erSpecimensNo}')) $(".erSpecimensNo").parent().remove();
    
    //初始化 国家 tr
    if(isFieldNull('${initMap.picDetail.erSpecimensDate}')) $(".erCountryName").parent().remove();
    
    //初始化 省份 tr
    if(isFieldNull('${initMap.picDetail.erProvinceName}')) $(".erProvinceName").parent().remove();
    
    //初始化 市县区 tr
    if(isFieldNull('${initMap.picDetail.erCity}') || isFieldNull('${initMap.picDetail.erCity}')==isFieldNull('${initMap.picDetail.erProvinceName}')) $(".erCity").parent().remove();
    
    //初始化 出土地 tr
    if(isFieldNull('${initMap.picDetail.erPlaceName}')) $(".erPlaceName").parent().remove();
    
    //初始化 生境 tr
    if(isFieldNull('${initMap.picDetail.erHabitat}')) $(".erHabitat").parent().remove();
    
    //初始化 性状 tr
    if(isFieldNull('${initMap.picDetail.erCharacteristics}')) $(".erCharacteristics").parent().remove();
    
    //初始化 描述 tr
    if(isFieldNull('${initMap.picDetail.erDescription}')) $(".erDescription").parent().remove();
    
    //初始化 海拔 tr
    if(isFieldNull('${initMap.picDetail.erElevation}')) $(".erElevation").parent().remove();
    
    //初始化 鉴定人 tr
    if(isFieldNull('${initMap.picDetail.erIdentifier}')) $(".erIdentifier").parent().remove();
    
    //初始化 鉴定日期 tr
    if(isFieldNull('${initMap.picDetail.erIdentifierDate}')) $(".erIdentifierDate").parent().remove();
    
    //初始化 用途 tr
    if(isFieldNull('${initMap.picDetail.erUse}')) $(".erUse").parent().remove();
    
    //初始化 备注 tr
    if(isFieldNull('${initMap.picDetail.erRemarks}')) $(".erRemarks").parent().remove();

}

function isFieldNull(fieldName){
	var reg = /^\s+$/;
    if(typeof fieldName == 'undefined' || fieldName == '' || reg.test(fieldName)){
    	  return true;
    }
    return false;
}
function isNull(filename){
	if(typeof filename != 'undefined' && filename != '' && filename != null){
  	  return true;
	}
	return false;
}

</script>  
</head>
<body>
<input type="hidden" class="image_w" value="">
<input type="hidden" class="image_h" value="">
<input type="hidden" class="roomname" id="roomname" value="exhibition">
<input type="hidden" id="erCode" value="${initMap.picDetail.erCode}">
<input type="hidden" id="erName" value="${initMap.picDetail.erName}">
<input type="hidden" id="erAudio" value="${initMap.picDetail.erAudio}">

<input type="hidden" id="erUpload" value="${initMap.picDetail.erUpload}">
<input type="hidden" id="erLongitude" value="${initMap.picDetail.erLongitude}">
<input type="hidden" id="erLatitude" value="${initMap.picDetail.erLatitude}">
<div id="layout_mainbody">
 	 <div class="res-detail-info">
                    <h4><b>资源名称：</b><label>${initMap.picDetail.erName}</label></h4>
                    <ul class="res-controls">
                       
                       <!-- 放大镜 -->
                       <li><a href="javascript:void(0);" data-type="rc-zoomplus" class="rc rc-zoomplus" onclick="BigImg('er')"></a></li>
                      
                       <s:if test="initMap.picDetail.erAudio != '' "> 
                      	 <li title="音频播放"><a href="javascript:void(0);" onclick="music();" data-type="rc-media" class="rc rc-media" id="rc-media">
                      	 </a>
                      	<div id="bgm" style="display: none;"></div>
                      	 </li>
                    	 </s:if>
                       
                       <li title="下载">
		                  	<a href="javascript:void(0);" data-type="rc-cloud-down" class="rc rc-cloud-down"></a>
		                  	<div class="hide-popup popup-rc-cloud-down">
		                          <i class="icon-up-arrow"></i>
		                          <div class="hide-popup-content">
		                              <table>
		                                 
		                                 <s:if test="initMap.picDetail.erAudio != '' "> <tr>
		                                      <td class="key keya"><a href="downloadAction.action?code=-706&paramMap.resDownRoom=exhibition&paramMap.resDownType=1073&paramMap.resPath=${initMap.picDetail.erAudio}">音频下载</a></td>
		                                  </tr>
		                                  </s:if>
		                                  <tr>
		                                      <td class="key keya"><a id="download" href="downloadAction.action?code=-706&paramMap.resDownRoom=exhibition&paramMap.resDownType=1011&paramMap.resPath=${initMap.picDetail.erUpload}">资源下载</a></td>
		                                  </tr>
		                              </table>
		                          </div>
		                      </div>
		                  </li>
		                
		                
		                <s:if test="session.s_userType != 3 and paramMap.st == 1 and session.s_userType != 5">
                  			 <li>
                  			 	<a  data-type="rc-query" onclick="window.parent.insert_fav(this)" class="addFavorite rc rc-query"  href="javascript:void(0);"  id="${code}|${paramMap.path}|exhibition|${paramMap.st}|${initMap.picDetail.erName}|${initMap.picDetail.erType}|${initMap.picDetail.erID}" class="">
                  				</a>  
                  			</li>
                  		</s:if>
		                
		                                     
                        <!-- 地图定位 -->
                        <li><a href="javascript:void(0);" data-type="rc-position" class="rc rc-position"></a></li>
                        
                        <!-- 二维码 -->
                        <li><a href="javascript:void(0);" data-type="rc-qrcode" class="rc rc-qrcode"></a></li>
                       
                         <s:if test="session.s_userType != 3 and paramMap.st == 1 and session.s_userType != 5">
                  	 		 <!-- 评论 -->
	                        <li><a href="javascript:void(0);" data-type="rc-comment" class="rc rc-comment" id="revR" ></a>
	                       		 <div id="revM" class="hide-popup popup-rc-comment" style="display: none;">
									
									
									<i class="icon-up-arrow"></i>
									<div  class="hide-popup-comment" id="revL" style="width:360px;height:290px;float: left;overflow-x:hidden;overflow-y:scroll; background-color: #ae9b84;position: relative;">评论加载中...</div>
								</div>
	                       	
	                       	</li>
                       </s:if>
                       		<input type="hidden" id="reviewID" value="${initMap.picDetail.erID}">
                       
                        <!-- 资源详细信息 -->
                        <li>
                            <a href="javascript:void(0);" data-type="rc-info" class="rc rc-info"></a>
                            <div class="hide-popup popup-rc-info">
                                <i class="icon-up-arrow"></i>
                                <div class="hide-popup-content">
                                  
                                 <table>
                                 <tr>
										<td width="25%" align="center">资源编号</td>
										<td width="75%" align="center" class="erCode">${initMap.picDetail.erCode}</td>
									</tr>
									<tr>
										<td width="25%" align="center">资源名称</td>
										<td width="75%" align="center" class="erName">${initMap.picDetail.erName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">资源类型</td>
										<td width="75%" align="center" class="erType">${initMap.picDetail.erType eq "1011" ? '高清图片':'' }</td>
									</tr>
									<tr>
										<td width="25%" align="center">一级分类</td>
										<td width="75%" align="center" class="erTotal">${initMap.picDetail.erTotal}</td>
									</tr>
									<tr>
										<td width="25%" align="center">二级分类</td>
										<td width="75%" align="center" class="erJie">${initMap.picDetail.erJie}</td>
									</tr> 
									<tr>
										<td width="25%" align="center">三级分类</td>
										<td width="75%" align="center" class="erChor">${initMap.picDetail.erChor}</td>
									</tr> 
									<tr>
										<td width="25%" align="center">四级分类</td>
										<td width="75%" align="center" class="erGang">${initMap.picDetail.erGang}</td>
									</tr>
									<tr>
										<td width="25%" align="center">五级分类</td>
										<td width="75%" align="center" class="erOrder">${initMap.picDetail.erOrder}</td> 
									</tr>
									<tr>
										<td width="25%" align="center">六级分类</td>
										<td width="75%" align="center" class="erCategoryName">${initMap.picDetail.erCategoryName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">俗名</td>
										<td width="75%" align="center" class="erCustom">${initMap.picDetail.erCustom}</td>
									</tr>
									<tr>
										<td width="25%" align="center">拉丁学名</td>
										<td width="75%" align="center" class="erLatinName">${initMap.picDetail.erLatinName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">保存地</td>
										<td width="75%" align="center" class="erBiologicalReserve">${initMap.picDetail.erBiologicalReserve}</td>
									</tr>
									<tr>
										<td width="25%" align="center">采集人</td>
										<td width="75%" align="center" class="erHunters">${initMap.picDetail.erHunters}</td>
									</tr>
									<tr>
										<td width="25%" align="center">采集编号</td>
										<td width="75%" align="center" class="erSpecimensNo">${initMap.picDetail.erSpecimensNo}</td>
									</tr>
									<tr>
										<td width="25%" align="center">国家</td>
										<td width="75%" align="center" class="erCountryName">${initMap.picDetail.erCountryName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">省份</td>
										<td width="75%" align="center" class="erProvinceName">${initMap.picDetail.erProvinceName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">市区县</td>
										<td width="75%" align="center" class="erCity">${initMap.picDetail.erCityName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">出土地</td>
										<td width="75%" align="center" class="erPlaceName">${initMap.picDetail.erPlaceName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">分布地区</td>
										<td width="75%" align="center" class="erLoLaName">${paramMap.erLoLaName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">生境</td>
										<td width="75%" align="center" class="erHabitat">${initMap.picDetail.erHabitat}</td>
									</tr>
									<tr>
										<td width="25%" align="center">性状</td>
										<td width="75%" align="center" class="erCharacteristics">${initMap.picDetail.erCharacteristics}</td>
									</tr>
									<tr>
										<td width="25%" align="center">描述</td>
										<td width="75%" align="center" class="erDescription">${initMap.picDetail.erDescription}</td>
									</tr>
									<tr>
										<td width="25%" align="center">海拔</td>
										<td width="75%" align="center" class="erElevation">${initMap.picDetail.erElevation}</td>
									</tr>
									<tr>
										<td width="25%" align="center">鉴定人</td>
										<td width="75%" align="center" class="erIdentifier">${initMap.picDetail.erIdentifier}</td>
									</tr>
									<tr>
										<td width="25%" align="center">鉴定日期</td>
										<td width="75%" align="center" class="erIdentifierDate">${initMap.picDetail.erIdentifierDate}</td>
									</tr>
									<tr>
										<td width="25%" align="center">用途</td>
										<td width="75%" align="center" class="erUse">${initMap.picDetail.erUse}</td>
									</tr>
									<tr>
										<td width="25%" align="center">备注</td>
										<td width="75%" align="center" class="erRemarks">${initMap.picDetail.erRemarks}</td>
									</tr>
                                  
                              </table>
                                </div>
                            </div>
                        </li>
                       
                    </ul>
                </div>
                <!--弹出菜单数据-->
                
                <div class="page-container">
                 	    <a href="javascript:void(0);" class="icon-respre"><i class="icon-pre-res"></i></a>
                        <a href="javascript:void(0);" class="icon-resnext disable"><i class="icon-next-res"></i></a>
                      
                    <!--资源详细开始-->
                    <div class="res-detail_x">
                     	 	<a href="javascript:void(0);"  onclick="preImg(0,this)" class="icon-respre"><i class="icon-pre-res"></i></a>
                        	<a href="javascript:void(0);"  onclick="preImg(1,this)" class="icon-resnext disable"><i class="icon-next-res"></i></a>
                      
                        <div class="controll">
                            <a href="javascript:void(0);" data-type="pre" class="btn pre"><i class="res-scroll-pre"></i></a>
                            <a href="javascript:void(0);" data-type="next" class="btn next"><i class="res-scroll-next"></i></a>
                            </div> 
                            <div  class="controll" style="display: none;">
                            <a href="javascript:void(0);" data-type="pre_x" class="btn_x pre_x"><i class="res-scroll-pre_x"></i></a>
                            <a href="javascript:void(0);" data-type="next_x" class="btn_x next_x"><i class="res-scroll-next_x"></i></a>
                           </div>
                           <div class="res-detail-container">
                          
                            <a href="javascript:void(0);" onclick="BigImg('er')">
                           	 <img   id="resView" src="${initMap.picDetail.erInThum}" upload='${initMap.picDetail.erUpload}'  _index="0" />
                            </a>
                        </div>
                    </div>
                    <!--资源详细结束-->

                    <!--相关资源-->
                    <div class="relative-res">
                        <div class="relative-res-title">
                            <a class="tab on" href="javascript:void(0);">图片资源</a>
                            <a class="tab" href="javascript:void(0);">相关资源</a>
                            <span class="toggle">
                                <a href="javascript:void(0);"><i></i><b>展开</b></a>
                            </span>
                        </div>
                        <div class="relative-res-body">
                           <div class="controll">
                            <a href="javascript:void(0);" data-type="pre" class="btn pre"><i class="res-scroll-pre"></i></a>
                            <a href="javascript:void(0);" data-type="next" class="btn next"><i class="res-scroll-next"></i></a>
                            </div> 
                            <div  class="controll" style="display: none;">
                            <a href="javascript:void(0);" data-type="pre_x" class="btn_x pre_x"><i class="res-scroll-pre_x"></i></a>
                            <a href="javascript:void(0);" data-type="next_x" class="btn_x next_x"><i class="res-scroll-next_x"></i></a>
                           </div>
                           
                            <div class="relative-res-container">
                            	<!-- 图片资源 -->
                            	
                                <ul class="res_t" id="relative-res-body_res_t">
                                   <s:iterator value="initMap.resView" id="fv" status="fvindx">
										<s:if test="#fv.thumbnail!=null">										
						     				<li idInfo='${fv.id}'>
							     				<a href="javascript:void(0);"   name="${fv.name}"  reviewID="${fv.id}" code="${fv.code}" upload="${fv.upload}"  inThum="${fv.inThum}"  params="paramMap.path=${fv.path}&paramMap.erType=${fv.fileType}&paramMap.fileType=${fv.fileType}&paramMap.erID=${fv.id}&paramMap.st=1&paramMap.temppname=erID&paramMap.temppid=${fv.id }&paramMap.name=${fv.name}&paramMap.roomtype=exhibition" >
							     					<img src="${fv.thumbnail}" onclick="preImg(2,this)"  _index="${fvindx.index }"  alt="${fv.name}"  width="145" height="110"/> 
							     				</a>
							     				<span>
								     				<s:if test="#fv.name.length() > 4"><s:property value="#fv.name.substring(0,4)" />...</s:if>
								     				<s:else><s:property value="#fv.name" /></s:else>
								     			</span>
						     				</li>		
										</s:if>
									</s:iterator>
                                   
                                </ul>
                            </div>
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
					                  				<img src="images/ajax-loader.gif" width="145" height="110"/>
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
	
	
 	<script src="js/jquery-1.7.2.min.js"></script>
    <script src="js/tweenmax.min.js"></script>
    <script src="js/scripts.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
</body>
</html>