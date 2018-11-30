<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title></title>
<link href="css/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<style type="text/css">
.popup-rc-comment{right: 180px;}
.popup-rc-comment .icon-up-arrow{right: 150px;}
.hide-popup i.icon-up-arrow{left: 100px;}

.res-detail-container{
position: relative;
margin:0 auto;
/* width: ${session.imgWidth}px; */
height: ${session.imgHeight}px;
background: #f3f3f3;

/*非IE的主流浏览器识别的垂直居中的方法*/ 
/* display: table-cell;  */
vertical-align:middle; 
/*设置水平居中*/ 
text-align:center; 
/* 针对IE的Hack */ 
*display: block; 
*font-size: 175px;/*约为高度的0.873，200*0.873 约为175*/ 
*font-family:Arial;/*防止非utf-8引起的hack失效问题，如gbk编码*/ 
}
.res-detail-container img{
/*设置图片垂直居中*/ 
vertical-align:middle; 
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	
		
	fieldControl();
	
	$("#centermiddleimg").LoadImage(true,$("#mainFramewidth",parent.document).val(),$("#mainFrameheight",parent.document).val()).parent().parent().css("height",$("#mainFrameheight",parent.document).val());
	//   #revM  评论信息模块
	$(".res-detail_x").height($(window).innerHeight()-40);
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
				$("#orCode").html(jsonData.OR_Code);
				$("#centermiddleimg").attr("src",jsonData.OR_InThum);
			}}
		});
	});
	
	$(".rc-position").click(function(){
		$("#revM").hide();
		art.dialog.data('orlalo', '${paramMap.orLoLa}');
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/module/enginev/MapBaidu2.jsp',{width:611,height:374,title:'高清图片分布地区展示'}) ;
	});
	
	$(".rc-qrcode").click(function(){
		$("#revM").hide();
		var curWwwPath=window.document.location.href; 
		var pathName=window.document.location.pathname; 
		var pos=curWwwPath.indexOf(pathName); 
		var localhostPaht=curWwwPath.substring(0,pos); 
		//var st=localhostPaht+"/dm/show_page?id=${initMap.picDetail.orCode}&pageName=scanner";
		var st=localhostPaht+"/dm/page/scanner/"+code+"/scanner.html";
		art.dialog.data('str', st);
		art.dialog.data('code', "${initMap.picDetail.orCode}");
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
    
  //音频控制
    var ua = navigator.userAgent.toLowerCase();   
    if(ua.indexOf("msie")>0){
	   $("#bgm").html('<embed src="${initMap.picDetail.orAudio}" id="mp" style="height:0px;width:0px;" autostart="false" loop="true">');
	}else{
		$("#bgm").html('<audio src="${initMap.picDetail.orAudio}" id="mp"></audio>');
	}	

   
    $.ajax({
		url:		'ajaxAction.action?suiji='+new Date().getTime()+'&code=${code}&paramMap.roomtype=observation&paramMap.orID=${initMap.picDetail.orID}',
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
							pcode="-701019";
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


function fieldControl(){
	
	if(isFieldNull('${initMap.picDetail.orCode}')) $(".erCode").parent().remove();
    
    if(isFieldNull('${initMap.picDetail.orCategoryName}')) $(".orCategoryName").parent().remove();
    
    if(isFieldNull('${initMap.picDetail.orCateTwLevelName}')) $(".orCateTwLevelName").parent().remove();
    
    if(isFieldNull('${initMap.picDetail.orCateTHLevelName}')) $(".orCateTHLevelName").parent().remove();
    
    if(isFieldNull('${initMap.picDetail.orCateFoLevelName}')) $(".orCateFoLevelName").parent().remove();
    
    
    //初始化 国家 tr
    if(isFieldNull('${initMap.picDetail.orCountryName}')) $(".orCountryName").parent().remove();
    
    //初始化 省份 tr
    if(isFieldNull('${initMap.picDetail.orProvinceName}')) $(".orProvinceName").parent().remove();
    
    //初始化 市县区 tr
    if(isFieldNull('${initMap.picDetail.orCity}') || isFieldNull('${initMap.picDetail.orCity}')==isFieldNull('${initMap.picDetail.orProvinceName}')) $(".orCity").parent().remove();
    
    //初始化 出土地 tr
    if(isFieldNull('${initMap.picDetail.orPlaceName}')) $(".orPlaceName").parent().remove();
    
    
    //初始化 备注 tr
    if(isFieldNull('${initMap.picDetail.orRemarks}')) $(".orRemarks").parent().remove();

}

function isFieldNull(fieldName){
	var reg = /^\s+$/;
    if(typeof fieldName == 'undefined' || fieldName == '' || reg.test(fieldName)){
    	  return true;
    }
    return false;
}
</script>  
</head>
<body>

<input type="hidden" class="image_w" value="">
<input type="hidden" class="image_h" value="">
<input type="hidden" class="roomname" id="roomname" value="observation">
<input type="hidden" id="orName" value="${initMap.picDetail.orName}">
<input type="hidden" id="erTotal" value="${initMap.picDetail.orCateTwLevelName}">
<input type="hidden" id="orUpload" value="${initMap.picDetail.orUpload}">
<input type="hidden" id="resURL" value="${code}|${paramMap.path}|observation|${paramMap.st}|${initMap.picDetail.orName}|${initMap.picDetail.orType}|${initMap.picDetail.orID}">
<input type="hidden" id="userID" value="${paramMap.s_userID}">
<input type="hidden" id="userType" value="${paramMap.s_userType}">

 <div id="layout_mainbody"> 
 	 <div class="res-detail-info">
                    <h4><b>资源名称：</b><label>${initMap.picDetail.orName}</label></h4>
                    <ul class="res-controls">
                         <!-- 资源详细信息 -->
                        
                     <s:if test="initMap.picDetail.orType != '1073' "> 
                        <!-- 放大镜 -->
                       <li><a href="javascript:void(0);" title="查看大图" data-type="rc-zoomplus" class="rc rc-zoomplus" onclick="BigImg('or')"></a></li>
                      </s:if>
                      	<s:if test="initMap.picDetail.orAudio != '' "> 
                      	 <li title="音频播放"><a href="javascript:void(0);" title="音频控制" onclick="music();" data-type="rc-media" class="rc rc-media" id="rc-media">
                      	 </a>
                      	<div id="bgm" style="display: none;"></div>
                      	 </li>
                    	 </s:if>
                      
                       <li title="下载">
		                  	<a href="javascript:void(0);" title="资源下载" data-type="rc-cloud-down" class="rc rc-cloud-down"></a>
		                  	<div class="hide-popup popup-rc-cloud-down">
		                          <i class="icon-up-arrow"></i>
		                          <div class="hide-popup-content">
		                              <table>
		                              	<s:if test="initMap.picDetail.orAudio != ''&&initMap.picDetail.orType!='1073' "> <tr>
		                                      <td class="key keya"><a href="downloadAction.action?code=-706&paramMap.resDownRoom=observation&paramMap.resDownType=1073&paramMap.resPath=${initMap.picDetail.orAudio}">音频下载</a></td>
		                                  </tr>
		                                  </s:if>
		                                   <tr>
		                                      <td class="key keya"><a  id="download" href="downloadAction.action?code=-706&paramMap.resDownRoom=observation&paramMap.resDownType=${initMap.picDetail.orType}&paramMap.resPath=${initMap.picDetail.orUpload}">资源下载</a></td>
		                                  </tr>
		                              </table>
		                          </div>
		                      </div>
		                  </li>
		              
                         <s:if test="session.s_userType != 3 and paramMap.st == 1 and session.s_userType != 5">
                  			 <li>
                  			 	<a  data-type="rc-query" title="加入收藏" onclick="window.parent.insert_fav(this)" class="addFavorite rc rc-query"  href="javascript:void(0);"   id="${code}|${paramMap.path}|observation|${paramMap.st}|${initMap.picDetail.orName}|${initMap.picDetail.orType}|${initMap.picDetail.orID}" >
                  				</a>  
                  			</li>
                  		</s:if>
		                <!-- 二维码 -->
                        <li><a href="javascript:void(0);" title="二维码" data-type="rc-qrcode" class="rc rc-qrcode"></a></li>
                       
                       
                        <!-- 评论 -->
                        <li>
                        	<a href="javascript:void(0);" title="评论" data-type="rc-comment" class="rb rc-comment" id="revR" ></a>
                       		 <div id="revM" class="hide-popup popup-rc-comment" style="display: none;">
								
								
								<i class="icon-up-arrow"></i>
								<div  class="hide-popup-comment" id="revL" style="width:360px;height:290px;float: left;overflow-x:hidden;overflow-y:scroll; background-color: #ae9b84;position: relative;">评论加载中...</div>
								<input type="hidden" id="reviewID" value="${initMap.picDetail.orID}">
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
										<td width="75%" align="center" class="orCode">${initMap.picDetail.orNO}</td>
									</tr>
									<tr>
										<td width="25%" align="center">资源名称</td>
										<td width="75%" align="center" class="orName">${initMap.picDetail.orName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">资源类型</td>
										<td width="75%" align="center" class="orType">${initMap.picDetail.orType eq "1011" ? '高清图片':(initMap.picDetail.orType eq "1073" ? '音频':(initMap.picDetail.orType eq "4033" ? '压缩包':'PDF')) }</td>
									</tr>
									<tr>
										<td width="25%" align="center">一级分类</td>
										<td width="75%" align="center" class="orCategoryName">${initMap.picDetail.orCategoryName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">二级分类</td>
										<td width="75%" align="center" class="orCateTwLevelName">${initMap.picDetail.orCateTwLevelName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">三级分类</td>
										<td width="75%" align="center" class="orCateTHLevelName">${initMap.picDetail.orCateTHLevelName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">四级分类</td>
										<td width="75%" align="center" class="orCateFoLevelName">${initMap.picDetail.orCateFoLevelName}</td>
									</tr>
									 <tr>
										<td width="25%" align="center">国家</td>
										<td width="75%" align="center" class="orCountryName">${initMap.picDetail.orCountryName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">省份</td>
										<td width="75%" align="center" class="orProvinceName">${initMap.picDetail.orProvinceName}</td>
									</tr> 
									<%--  <tr>
										<td width="25%" align="center">市区县</td>
										<td width="75%" align="center" class="orCity">${initMap.picDetail.orCityName}</td>
									</tr>  --%>
									<tr>
										<td width="25%" align="center">出土地</td>
										<td width="75%" align="center" class="orPlaceName">${initMap.picDetail.orPlaceName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">备注</td>
										<td width="75%" align="center" class="orRemarks">${initMap.picDetail.orRemarks}</td>
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
                          <c:if test="${initMap.picDetail.orType==1011}">
                         <a href="javascript:void(0);"  onclick="preImg(0,this)" class="icon-respre"><i class="icon-pre-res"></i></a>
                         <a href="javascript:void(0);"  onclick="preImg(1,this)" class="icon-resnext disable"><i class="icon-next-res"></i></a>
                          </c:if>
                        <div class="res-detail-container">
                            <a href="javascript:void(0);" onclick="BigImg('or')">
                           	 <img onload="if(this.width >= ${session.imgWidth}){this.height=(this.height/this.width)*${session.imgWidth};this.width = ${session.imgWidth};}if(this.height >= ${session.imgHeight}){this.width=(this.width/this.height)*${session.imgHeight};this.height = ${session.imgHeight};}" src="${initMap.picDetail.orInThum}"  id="resView" upload='${initMap.picDetail.orUpload}'  _index="0"/>
                            </a>
                        </div>
                    </div>
                    <!--资源详细结束-->

                    <!--相关资源-->
                    <div class="relative-res">
                        <div class="relative-res-title">
                         <c:if test="${initMap.picDetail.orType==1011}">
                            <a class="tab on" href="javascript:void(0);">图片资源</a>
                            </c:if>
                            <a class="tab" href="javascript:void(0);">相关资源</a>
                            <span class="toggle">
                                <a href="javascript:void(0);"><i></i><b>展开</b></a>
                            </span>
                        </div>
                        <div class="relative-res-body">
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
                            <c:if test="${initMap.picDetail.orType==1011}">
                            <div class="relative-res-container">
                            	<!-- 图片资源 -->
                            	
                                <ul class="res_t" id="relative-res-body_res_t">
                                
                                  <li idInfo='${initMap.picDetail.orID}'>
					     				<a href="javascript:void(0);" audio="${initMap.picDetail.orAudio}" position="${initMap.picDetail.orCityName}"  name="${initMap.picDetail.orName}"  reviewID="${initMap.picDetail.orID}" code="${initMap.picDetail.orCode}" upload="${initMap.picDetail.orUpload}"  inThum="${initMap.picDetail.orInThum}"  params="paramMap.path=${initMap.picDetail.orPath}&paramMap.erType=${initMap.picDetail.orFileType}&paramMap.fileType=${initMap.picDetail.orFileType}&paramMap.erID=${initMap.picDetail.orID}&paramMap.st=1&paramMap.temppname=erID&paramMap.temppid=${initMap.picDetail.orID}&paramMap.name=${initMap.picDetail.orName}&paramMap.roomtype=exhibition" >
					     					<img src="${initMap.picDetail.orThumbnail}" onclick="preImg(2,this)"  _index="0"  alt="${initMap.picDetail.orName}"  width="145" height="110"/> 
					     				</a>
					     				<span>
						     				<s:if test="#initMap.picDetail.orName.length() > 4"><s:property value="#initMap.picDetail.orName.substring(0,4)" />...</s:if>
						     				<s:else><s:property value="#initMap.picDetail.orName" /></s:else>
						     			</span>
				     				</li>	
                                   <s:iterator value="initMap.resView" id="fv" status="fvindx">
										<s:if test="#fv.thumbnail!=null">										
						     				<li idInfo='${fv.id}'>
						     				<a href="javascript:void(0);" audio="${fv.audio}"   name="${fv.name}"  reviewID="${fv.id}" code="${fv.code}" upload="${fv.upload}"  inThum="${fv.inThum}"  params="paramMap.path=${fv.path}&paramMap.orType=${fv.fileType}&paramMap.fileType=${fv.fileType}&paramMap.orID=${fv.id}&paramMap.st=1&paramMap.temppname=orID&paramMap.temppid=${fv.id }&paramMap.name=${fv.name}&paramMap.roomtype=observation" >
						     					<img src="${fv.thumbnail}"  onclick="preImg(2,this)" _index="${fvindx.index+1 }" title="${fv.name}" width="145" height="110"/> 
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
                            </c:if>
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
				                   				<s:set name="pcode" value="'-701019'" />
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
		
 	<script src="js/jquery-1.7.2.min.js"></script>
    <script src="js/tweenmax.min.js"></script>
    <script src="js/scripts.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
</body>
</html>