<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title></title>
<link href="css/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
<script type="text/javascript">
$(document).ready(function(){	
	

	$(".res-detail").height($(window).innerHeight()-40);
	
	//初始化 资源大小
	
	$("#many_res").css({
		'height':($(window).innerHeight()-40),
		'width':($(window).innerWidth()-100),
		'margin-left':'auto',
		'margin-right':'auto',
		'z-index':0
		
	});

	//加载  flash文件信息
	var object_play = '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0"  height= '+($(window).innerHeight()-100)+' width='+($(window).innerWidth()-100)+'><param name="movie" value="/dm/'+'${initMap.fileDetail.lrFileSwfPath}'+'" /><param name="quality" value="high" />  <param name="wmode" value="transparent" /><embed  pluginspage="http://www.macromedia.com/go/getflashplayer" src="/dm/'+'${initMap.fileDetail.lrFileSwfPath}'+'" type="application/x-shockwave-flash" height= '+($(window).innerHeight()-100)+' width='+($(window).innerWidth()-100)+' quality="high" wmode="Opaque"  ></embed></object>';
	$("#many_res").html(object_play);	
	
	
	$("#centermiddleimg").LoadImage(true,$("#mainFramewidth",parent.document).val(),$("#mainFrameheight",parent.document).val()).parent().parent().css("height",$("#mainFrameheight",parent.document).val());
	
	//   #revM  评论信息模块
	
	$(".relative-res-body .imgresource a").click(function(){
		var i_ = $(this).attr("name");
		var resid = i_.substring(i_.indexOf("lrID")+5,i_.indexOf("&"));
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
				$("#lrCode").html(jsonData.LR_Code);
				$("#centermiddleimg").attr("src",jsonData.LR_InThum);
			}}
		});
	});
	
	$(".rc-position").click(function(){
		$("#revM").hide();
		art.dialog.data('lrlalo', '${paramMap.lrLoLa}');
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/module/enginev/MapBaidu2.jsp',{width:611,height:374,title:'高清图片分布地区展示'}) ;
	});
	
	$(".rc-qrcode").click(function(){
		$("#revM").hide();
		var curWwwPath=window.document.location.href; 
		var pathName=window.document.location.pathname; 
		var pos=curWwwPath.indexOf(pathName); 
		var localhostPaht=curWwwPath.substring(0,pos); 
		var st=localhostPaht+"/dm/show_page?id=${initMap.fileDetail.lrCode}&pageName=scanner";
		art.dialog.data('str', st);
		art.dialog.data('code', "${initMap.fileDetail.lrCode}");
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/qrcode.jsp',{width:266,height:304,title:'二维码扫描(扫描二维码获取相关信息)',lock:'true',background:'#666666',opacity: '0.15'}) ;
	});
	
	//$("#revL").load("decorateForwardAction.action?code=-600604&paramMap.ptype=laboratory&paramMap.pid="+$("#reviewID").val()+"&paramMap.resURL="+$(".addFavorite").attr("id")+"&paramMap.userID=${paramMap.s_userID}&paramMap.userType=${paramMap.s_userType}");
	
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

    
    
	
	
});

</script> 
<style type="text/css">
.hide-popup{float: right;left:40px;}
.hide-popup i.icon-up-arrow{left: 130px;}
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
<input type="hidden" class="roomname" value="laboratory">
<input type="hidden" id="lrName" value="${initMap.fileDetail.lrName}">
<input type="hidden" id="lrAudio" value="${initMap.fileDetail.lrAudio}">
<input type="hidden" id="lrUpload" value="${initMap.fileDetail.lrUpload}">

<input type="hidden" id="lrLongitude" value="${initMap.fileDetail.lrLongitude}">
<input type="hidden" id="lrLatitude" value="${initMap.fileDetail.lrLatitude}">
 <div id="layout_mainbody">
 	 <div class="res-detail-info">
                    <h4><b>资源名称：</b>${initMap.fileDetail.lrName}</h4>
                    <ul class="res-controls">
                    
                       <li title="下载">
		                  	<a href="javascript:void(0);" title="资源下载" data-type="rc-cloud-down" class="rc rc-cloud-down"></a>
		                  	<div class="hide-popup popup-rc-cloud-down rc-cloud-down">
		                          <i class="icon-up-arrow"></i>
		                          <div class="hide-popup-content">
		                              <table>
		                                  <tr>
		                                      <td class="key keya"><a href="downloadAction.action?code=-706&paramMap.resDownRoom=laboratory&paramMap.resDownType=${initMap.fileDetail.lrType}&paramMap.resPath=${initMap.picDetail.lrUpload}">资源下载</a></td>
		                                  </tr>
		                              </table>
		                          </div>
		                      </div>
		                  </li>    
		                  <s:if test="session.s_userType != 3 and paramMap.st == 1 and session.s_userType != 5">
	                  			 <li>
	                  			 	<a  data-type="rc-query" title="加入收藏" onclick="window.parent.insert_fav(this)" class="addFavorite rc rc-query"  href="javascript:void(0);"  id="${code}|${paramMap.path}|laboratory|${paramMap.st}|${initMap.fileDetail.lrName}|${initMap.fileDetail.lrType}|${initMap.fileDetail.lrID}" >
	                  				</a>  
	                  			</li>
	                  		</s:if>
		                                   
                           <!-- 二维码 -->
                        <li><a href="javascript:void(0);" title="二维码" data-type="rc-qrcode" class="rc rc-qrcode"></a></li>
                       
                       
                        <!-- 评论 -->
                         <%-- <s:if test="session.s_userType != 3 and paramMap.st == 1 and session.s_userType != 5"> --%>
	                        <li><a href="javascript:void(0);" title="评论" data-type="rc-comment" class="rc rc-comment" id="revR" ></a>
	                       		 <div id="revM" class="hide-popup popup-rc-comment" style="display: none;">
									
									
									<i class="icon-up-arrow"></i>
									<div  class="hide-popup-comment" id="revL" style="width:360px;height:290px;float: left;overflow-x:hidden;overflow-y:scroll; background-color: #ae9b84;position: relative;">评论加载中...</div>
									
								</div>
	                       	
	                       	</li>
	                      <%-- </s:if> --%><input type="hidden" id="reviewID" value="${initMap.picDetail.lrID}">
                       
                        <!-- 资源详细信息 -->
                        <li>
                            <a href="javascript:void(0);" title="资源详细信息" data-type="rc-info" class="rc rc-info"></a>
                            <div class="hide-popup popup-rc-info">
                                <i class="icon-up-arrow"></i>
                                <div class="hide-popup-content">
                                  
                                 <table>
                                 <tr>
										<td width="25%" align="center">资源编号</td>
										<td width="75%" align="center" class="erCode">${initMap.picDetail.lrCode}</td>
									</tr>
									<tr>
										<td width="25%" align="center">资源名称</td>
										<td width="75%" align="center" class="erName">${initMap.picDetail.lrName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">资源类型</td>
										<td width="75%" align="center" class="erType">${initMap.picDetail.lrType eq "1011" ? '高清图片':'' }</td>
									</tr>
									<tr>
										<td width="25%" align="center">一级分类</td>
										<td width="75%" align="center" class="erTotal">${initMap.picDetail.lrTotal}</td>
									</tr>
								
                                  <tr>
										<td width="25%" align="center">二级分类</td>
										<td width="75%" align="center" class="lrCateTwLevelName">${initMap.picDetail.lrCateTwLevelName}</td>
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
                            <a href="javascript:void(0);" >
                           	 <img src=""  style="display:none;"/>
                        		<div id="many_res" ></div>
                           	 
                            </a>
                          </div>
                    </div>
                    <!--资源详细结束-->

                    <!--相关资源-->
                    <div class="relative-res">
                        <div class="relative-res-title">
                            <!-- <a class="tab on" href="javascript:void(0);">图片资源</a> -->
                            <a class="tab on" href="javascript:void(0);">相关资源</a>
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
                            	<!-- 相关资源 -->
                            	
                                <ul class="res_t" id="relative-res-body_res_t">
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
				                  			<li >
					                  			<a href="javascript:void(0);" onclick="otherRes(this)" hreft="decorateForwardAction.action?code=${pcode}&path=${fv.path}&paramMap.${broomname}Type=${fv.fileType}&paramMap.fileType=${fv.fileType}&paramMap.${pname}=${fv.id}&paramMap.st=1&paramMap.temppname=${pname}&paramMap.temppid=${fv.id}&paramMap.name=${fv.name}&paramMap.roomtype=${fv.resType}">
					                  				<img src="${fv.thumbnail}" width="145" height="110"/>
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