<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title></title>
<link href="css/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/artDialog/artDialog.css">
 	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.min.js"></script>
 	<script type="text/javascript" src="<%=request.getContextPath()%>/js/tweenmax.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/artDialog.4.1.4.js?skin=default"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/artDialog/iframeTools.4.1.4.js"></script>
 	<script src="<%=request.getContextPath()%>/js/scripts.js"></script>  
  	<script type="text/javascript" src="<%=request.getContextPath()%>/js/flexpaper_flash_debug.js"></script>

<script type="text/javascript">
$(document).ready(function(){	
	
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
				$("#orCode").html(jsonData.OR_Code);
				$("#centermiddleimg").attr("src",jsonData.OR_InThum);
			}}
		});
	});
	

	
	$(".rc-qrcode").click(function(){
		$("#revM").hide();
		var curWwwPath=window.document.location.href; 
		var pathName=window.document.location.pathname; 
		var pos=curWwwPath.indexOf(pathName); 
		var localhostPaht=curWwwPath.substring(0,pos); 
		var st=localhostPaht+"/dm/show_page?id=${initMap.fileDetail.orCode}&pageName=scanner";
		art.dialog.data('str', st);
		art.dialog.data('code', "${initMap.fileDetail.orCode}");
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/qrcode.jsp',{width:266,height:304,title:'二维码扫描(扫描二维码获取相关信息)',lock:'true',background:'#666666',opacity: '0.15'}) ;
	});
	
	//$("#revL").load("decorateForwardAction.action?code=-600604&paramMap.ptype=observation&paramMap.pid="+$("#reviewID").val()+"&paramMap.resURL="+$(".addFavorite").attr("id")+"&paramMap.userID=${paramMap.s_userID}&paramMap.userType=${paramMap.s_userType}");
	
	
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
<input type="hidden" id="orName" value="${initMap.fileDetail.orName}">
<input type="hidden" id="orUpload" value="${initMap.fileDetail.orUpload}">

 <div id="layout_mainbody">
 	 <div class="res-detail-info">
                    <h4><b>资源名称：</b>${initMap.fileDetail.orName}</h4>
                    <ul class="res-controls">
                       <li title="下载">
		                  	<a href="javascript:void(0);" title="资源下载" data-type="rc-cloud-down" class="rc rc-cloud-down"></a>
		                  	<div class="hide-popup popup-rc-cloud-down rc-cloud-down">
		                          <i class="icon-up-arrow"></i>
		                          <div class="hide-popup-content">
		                              <table>
		                                  <tr>
		                                      <td class="key keya"><a href="downloadAction.action?code=-706&paramMap.resDownRoom=observation&paramMap.resDownType=${initMap.fileDetail.orType}&paramMap.resPath=${initMap.fileDetail.orUpload}">资源下载</a></td>
		                                  </tr>
		                              </table>
		                          </div>
		                      </div>
		                  </li>
		              
		               <s:if test="session.s_userType != 3 and paramMap.st == 1 and session.s_userType != 5">
                  			 <li>
                  			 	<a  data-type="rc-query" title="加入收藏" onclick="window.parent.insert_fav(this)" class="addFavorite rc rc-query"  href="javascript:void(0);"   id="${code}|${paramMap.path}|observation|${paramMap.st}|${initMap.fileDetail.orName}|${initMap.fileDetail.orType}|${initMap.fileDetail.orID}" >
                  				</a>  
                  			</li>
                  		</s:if>
		                  
                        
		              
                        <!-- 二维码 -->
                        <li><a href="javascript:void(0);" title="二维码" data-type="rc-qrcode" class="rc rc-qrcode"></a></li>
                       
                       
                        <!-- 评论 -->
                        <li><a href="javascript:void(0);" title="评论" data-type="rc-comment" class="rc rc-comment" id="revR" ></a>
                       		 <div id="revM" class="hide-popup popup-rc-comment" style="display: none;">
								
								
								<i class="icon-up-arrow"></i>
								<div  class="hide-popup-comment" id="revL" style="width:360px;height:290px;float: left;overflow-x:hidden;overflow-y:scroll; background-color: #ae9b84;position: relative;">评论加载中...</div>
								<input type="hidden" id="reviewID" value="${initMap.fileDetail.orID}">
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
										<td width="75%" align="center" class="erCode">${initMap.fileDetail.orNo}</td>
									</tr>
									<tr>
										<td width="25%" align="center">资源名称</td>
										<td width="75%" align="center" class="erName">${initMap.fileDetail.orName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">资源类型</td>
										<td width="75%" align="center" class="erType">
											    ${initMap.fileDetail.orType eq "1011" ? '高清图片':'' }
												${initMap.fileDetail.orType eq "1022" ? '3D图片':'' }
												${initMap.fileDetail.orType eq "1073" ? '音频':'' }
												${initMap.fileDetail.orType eq "1084" ? '高清视频':'' }
												${initMap.fileDetail.orType eq "1005" ? '动画类素材':'' }
												${initMap.fileDetail.orType eq "1006" ? '其他素材':'' }
												${initMap.fileDetail.orType eq "2041" ? 'PPT课件':'' }
												${initMap.fileDetail.orType eq "2002" ? '动画类课件':'' }
												${initMap.fileDetail.orType eq "2033" ? 'WORD课件':'' }
												${initMap.fileDetail.orType eq "2055" ? 'PDF课件':'' }
												${initMap.fileDetail.orType eq "2004" ? '其他课件':'' }
												${initMap.fileDetail.orType eq "3031" ? '环球百科':'' }
												${initMap.fileDetail.orType eq "3032" ? '文学报告':'' }
												${initMap.fileDetail.orType eq "3033" ? '论文资料':'' }
												${initMap.fileDetail.orType eq "3034" ? '资料图书':'' }
												${initMap.fileDetail.orType eq "3035" ? '适用学段、年级与大纲':'' }
												${initMap.fileDetail.orType eq "3036" ? '其他资料':'' }
										
										</td>
									</tr>
									<tr>
										<td width="25%" align="center">一级分类</td>
										<td width="75%" align="center" class="erTotal">${initMap.fileDetail.orTotal}</td>
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
						       	var swfPath = "<%=request.getContextPath()%>/${initMap.fileDetail.orFileSwfPath}";
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
                           <%--  <span class="title"><b>资源名称：</b>${initMap.fileDetail.orName}</span> --%>
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
                           <div class="controll">
                            <a href="javascript:void(0);" data-type="pre" class="btn pre"><i class="res-scroll-pre"></i></a>
                            <a href="javascript:void(0);" data-type="next" class="btn next"><i class="res-scroll-next"></i></a>
                            </div> 
                            <div  class="controll" style="display: none;">
                            <a href="javascript:void(0);" data-type="pre_x" class="btn_x pre_x"><i class="res-scroll-pre_x"></i></a>
                            <a href="javascript:void(0);" data-type="next_x" class="btn_x next_x"><i class="res-scroll-next_x"></i></a>
                           </div>
                           
                            <%-- <div class="relative-res-container">
                            	<!-- 图片资源 -->
                            	
                                <ul class="res_t" id="relative-res-body_res_t">
                                    <li>
										<a href="javascript:void(0)" onclick="reflushSwfPlayer('${initMap.fileDetail.orFileSwfPath}')">
										        <img src="${initMap.fileDetail.orThumbnail}"  title="主资源"   height="110" width="145"/>
										</a>
									</li>
									
                                   
                                </ul>
                            </div> --%>
                            <div class="relative-res-container" style="display:none">
                               <!-- 相关资源 -->
                                <ul class="res_x" id="relative-res-body_res_x">
                                
	                             
                               
                         	   </ul>
                      	  </div>
                   	  </div>
               	  </div>
            	</div>
			</div>
	
	</body>
</html>