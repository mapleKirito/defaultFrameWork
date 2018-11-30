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
		var st=localhostPaht+"/dm/show_page?id=${initMap.picDetail.orCode}&pageName=scanner";
		art.dialog.data('str', st);
		art.dialog.data('code', "${initMap.picDetail.orCode}");
		art.dialog.data('contextPath', '<%=request.getContextPath()%>');
		art.dialog.open('<%=request.getContextPath()%>/qrcode.jsp',{width:266,height:304,title:'二维码扫描(扫描二维码获取相关信息)',lock:'true',background:'#666666',opacity: '0.15'}) ;
	});
	
	//$("#revL").load("decorateForwardAction.action?code=-600604&paramMap.ptype=observation&paramMap.pid="+$("#reviewID").val()+"&paramMap.resURL="+$(".addFavorite").attr("id")+"&paramMap.userID=${paramMap.s_userID}&paramMap.userType=${paramMap.s_userType}");

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
<input type="hidden" class="roomname" value="observation">
<input type="hidden" id="orName" value="${initMap.picDetail.orName}">
<input type="hidden" id="orAudio" value="${initMap.picDetail.orAudio}">
<input type="hidden" id="orUpload" value="${initMap.picDetail.orUpload}">

<input type="hidden" id="orLongitude" value="${initMap.picDetail.orLongitude}">
<input type="hidden" id="orLatitude" value="${initMap.picDetail.orLatitude}">
 <div id="layout_mainbody">
 	 <div class="res-detail-info">
                    <h4><b>资源名称：</b>${initMap.picDetail.orName}</h4>
                    <ul class="res-controls">
                          <!-- 资源详细信息 -->
                        
                       <li title="下载">
		                  	<a href="javascript:void(0);" title="资源下载" data-type="rc-cloud-down" class="rc rc-cloud-down"></a>
		                  	<div class="hide-popup popup-rc-cloud-down rc-cloud-down">
		                          <i class="icon-up-arrow"></i>
		                          <div class="hide-popup-content">
		                              <table>
		                                  <tr>
		                                      <td class="key keya"><a href="downloadAction.action?code=-706&paramMap.resDownRoom=observation&paramMap.resDownType=${initMap.picDetail.orType}&paramMap.resPath=${initMap.picDetail.orUpload}">资源下载</a></td>
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
                        <li><a href="javascript:void(0);" title="评论" data-type="rc-comment" class="rc rc-comment" id="revR" ></a>
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
										<td width="75%" align="center" class="erCode">${initMap.picDetail.orCode}</td>
									</tr>
									<tr>
										<td width="25%" align="center">资源名称</td>
										<td width="75%" align="center" class="erName">${initMap.picDetail.orName}</td>
									</tr>
									<tr>
										<td width="25%" align="center">资源类型</td>
										<td width="75%" align="center" class="erType">${initMap.picDetail.orType eq "1011" ? '高清图片':'' }</td>
									</tr>
									<tr>
										<td width="25%" align="center">一级分类</td>
										<td width="75%" align="center" class="erTotal">${initMap.picDetail.orTotal}</td>
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
                           	 
                           	 <script type="text/javascript">
					  window.onload = function () {
				      var SCALE = 10;
				      var oImg = document.getElementById('img1');
				      var oTxt = document.getElementById('prog').getElementsByTagName('span')[0];
				      var oBar = document.getElementById('bar');
				      var aImg = [];
				     
				      var iImgCount=Count;
				      var iLoaded = 0;
				      var iNow = 0;
				      var i = 0;
				      var k = 0;
				      var mode='${initMap.picDetail.orModel}';
				      
				      var filefoldpath = '${initMap.picDetail.orFileSwf}';
				 	  var file = '${initMap.picDetail.orZip}';
					  var filearray = file.split(","); 
					  var _name = filearray[0];
					  var _suff = filearray[1];
					  var _count = filearray[2];
					 
					  var Count = _count;
					 
				      //加载所有资源
				      if (mode=='1'){  iImgCount=Count*2; }else{
				    	  iImgCount=Count
				      }
				      for (i = 0; i < Count; i++) {
				          (function (i) {
				              var oNewImg = new Image();
				              oNewImg.onload = function () {
				                  oTxt.innerHTML = oBar.style.width = Math.ceil(100 * iLoaded / iImgCount) + '%';
				                  oNewImg.onload = null;
				                  var oImg = document.createElement('img');
				                  oImg.src = this.src;
				                  oImg.style.display = 'none';
				                  document.getElementById('imgshow').appendChild(oImg);
				                  aImg[i] = oImg;
				                   if (++iLoaded == iImgCount) onLoad();
				              };
				              oNewImg.src = filefoldpath + '/'+_name+'(' + i + ')'+_suff;
				          })(i);
				      }

				     if (mode=='1'){
				     	for (k = i; k < iImgCount; k++) {
				      	var j=iImgCount-k-1;
				           (function (k) {
				               var oNewImg = new Image();
				               oNewImg.onload = function () {
				                   oTxt.innerHTML = oBar.style.width = Math.ceil(100 * iLoaded / iImgCount) + '%';
				                   oNewImg.onload = null;
				                   var oImg = document.createElement('img');
				                   oImg.src = this.src;
				                   oImg.style.display = 'none';
				                   document.getElementById('imgshow').appendChild(oImg);
				                   aImg[k] = oImg;
				                   if (++iLoaded == iImgCount) onLoad();
				               };
				               
				               oNewImg.src = filefoldpath + '/'+_name+'(' + j + ')'+_suff;
				           })(k);
				     	}
				    }
				     //效果
				     function onLoad() {
				         for (i = 0; i < iImgCount; i++) if (!aImg[i]) alert('资源加载失败，请刷新重试');
				         var lastImg = null;
				         document.getElementById('prog').style.display = document.getElementById('bg').style.display = 'none';
				         //document.body.removeChild(oImg);
				         var body = document.getElementById('imgshow');
				         oImg = null;
				         var timer = null;
				         var num = iNow;
				         var speed = 0;
				
				         aImg[0].style.display = '';
				         lastImg = aImg[0];
				         document.ontouchstart = function (ev) {
				             var oEvent = ev;
				             var startX = oEvent.targetTouches[0].clientX;
				             var lastX = startX;
				
				             if (body.setCapture) {
				                 body.ontouchmove = onMove;
				                 body.ontouchend = onUp;
				
				                 body.setCapture();
				             }
				             else {
				                 document.ontouchmove = onMove;
				                 document.ontouchend = onUp;
				             }
				
				             function onMove(ev) {
				                 var oEvent = ev;
				                 var i = -(oEvent.targetTouches[0].clientX - startX) / SCALE;
				
				                 num = (iNow + i + Math.abs(Math.floor(i / iImgCount)) * iImgCount) % iImgCount;
				
				                 if (lastImg != aImg[parseInt(num)]) {
				                     lastImg.style.display = 'none';
				                     aImg[parseInt(num)].style.display = '';
				                     lastImg = aImg[parseInt(num)];
				                 }
				
				                 speed = -(oEvent.targetTouches[0].clientX - lastX) / SCALE;
				                 lastX = oEvent.targetTouches[0].clientX;
				
				                 return false;
				             }
				
				             function onUp() {
				                 this.ontouchmove = null;
				                 this.ontouchend = null;
				
				                 if (body.releaseCapture) body.releaseCapture();
				
				                 iNow = num;
				
				                 startMove();
				             }
				
				             stopMove();
				
				             return false;
				         };
				         document.onmousedown = function (ev) {
				             var oEvent = ev || event;
				             var startX = oEvent.clientX;
				             var lastX = startX;
				
				             if (body.setCapture) {
				                 body.onmousemove = onMove;
				                 body.onmouseup = onUp;
				
				                 body.setCapture();
				             }
				             else {
				                 document.onmousemove = onMove;
				                 document.onmouseup = onUp;
				             }
				
				             function onMove(ev) {
				                 var oEvent = ev || event;
				                 var i = -(oEvent.clientX - startX) / SCALE;
				
				                 num = (iNow + i + Math.abs(Math.floor(i / iImgCount)) * iImgCount) % iImgCount;
				
				                 if (lastImg != aImg[parseInt(num)]) {
				                     lastImg.style.display = 'none';
				                     aImg[parseInt(num)].style.display = '';
				                     lastImg = aImg[parseInt(num)];
				                 }
				
				                 speed = -(oEvent.clientX - lastX) / SCALE;
				                 lastX = oEvent.clientX;
				
				                 return false;
				             }
				
				             function onUp() {
				                 this.onmousemove = null;
				                 this.onmouseup = null;
				
				                 if (body.releaseCapture) body.releaseCapture();
				
				                 iNow = num;
				
				                 startMove();
				             }
				
				             stopMove();
				
				             return false;
				         };
				
				         function startMove() {
				             timer = setInterval(function () {
				                 iNow = (iNow + speed + Math.abs(Math.floor(i / iImgCount)) * iImgCount) % iImgCount;
				                 lastImg.style.display = 'none';
				                 aImg[parseInt(iNow)].style.display = '';
				                 lastImg = aImg[parseInt(iNow)];
				
				                 speed *= 0.884;
				
				                 if (Math.abs(speed) <= 1) {
				                     clearInterval(timer);
				                     speed = 0;
				                 }
				             }, 30);
				         }
				
				         function stopMove() {
				             clearInterval(timer);
				         }
				      
				         $("#imgshow").css("height",$(window).innerHeight()-90).attr("title","需左右滑动");
				         
				         $("#imgshow img").each(function(){
				     		$(this).LoadImage(true,750,$(window).innerHeight()-110);
				        		
				         });
				         
				     }
				    
				 };
				</script>
                <div id="bg">
				  <div id="prog" style="margin-top:20%;color: #000000;">
				      <h1><span style="font-weight: bold;font-size: 35px;color: #000000;">载入中......0%</span></h1>
				      <div id="bar"></div>
				  </div>
				</div>
					<div id="imgshow" style="vertical-align: middle;margin-top:50px;"  ></div>           	 
                           	 
                           	 
                           	 
                            </a>
                          
                        </div>
                    </div>
                    <!--资源详细结束-->
                     <!--相关资源 -->
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