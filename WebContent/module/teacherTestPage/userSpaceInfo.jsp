<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>数字历史管主页</title>
    <link href="qc/css/style.css" rel="stylesheet" />
    <link href="qc/css/gallery.css" rel="stylesheet" />
    <style type="text/css">
.tag { 
margin-left: 19px;
font-size: 20px;
}
#attention p{
width: 80px;
background: #ae9b84;
margin: 0 auto;
margin-top: 4px;
height: 22px;
}
    </style>
    
 <script type="text/javascript">
 	$(document).ready(function() {
		$('.left  img').each(function() {
			if ($(this).attr('src') == '') {
				$(this).attr('src', 'images/default/default_img.jpg');
			}
		});
	});
 
 
 </script>   
</head>
<body>
<input type="hidden" id="uid" value="${paramMap.userID }" >
<div id="layout_mainbody">
   	 <div class="page-container ssjh">
     	<div id="layout_top">
     	<div style="padding-top: 17px;">
     		<a target="childrenMain" class="tag" href="decorateForwardAction.action?code=${pmsIndex.user_dynamimc.code}&paramMap.userID=${paramMap.userID }&paramMap.isShare=1">最新动态</a>
           <s:if test="initMap.userInfo.userType==1">
            <a target="childrenMain" class="tag" href="decorateForwardAction.action?code=${pmsIndex.share_resource.code}&paramMap.userID=${paramMap.userID }&paramMap.isShare=1&paramMap.personalShare=1">分享资源</a>
          </s:if>
<!--             <a class="tag">文章</a> -->
            <a target="childrenMain" class="tag" href="decorateForwardAction.action?code=${pmsIndex.share_images.code}&paramMap.userID=${paramMap.userID }&paramMap.gaShare=1">图库</a>
            </div>
        </div>
        <div id="layout_main">
            <div class="ssjh-grxx">
				<div class="left">
				<div style="padding-top: 10px;height: 245px;text-align: center;">
				<img style="width: 128px;height: 128px;" src="${initMap.userInfo.userImg }" onerror="this.src='images/default/default_img.jpg'" />
				<%-- <p>名称：${initMap.userInfo.userName}</p> --%>
				
				<s:if test="initMap.userInfo.userName.length() > 5">
					<p>名称：<span title="${initMap.userInfo.userName}"><s:property value="initMap.userInfo.userName.substring(0,5)" /> ...</span></p>
                </s:if>
				<s:else>
					<p>名称：<span title="${initMap.userInfo.userName}"><s:property value="initMap.userInfo.userName" /></span></p>
			 	</s:else>
				
                <p>类型：${(initMap.userInfo.userType==1)?'老师':(initMap.userInfo.userType==2?'学生':'管理员')}</p>
                <p>财富值：${initMap.userInfo.wealth}</p>
                <s:if test="initMap.userInfo.qq !=''||initMap.userInfo.qq !=null">
                <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${initMap.userInfo.qq}&site=qq&menu=yes"><img border="0" src="images/qqLink.gif" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
                </s:if>
                <div id="attention" attention="${initMap.userInfo.attention}" style="cursor:pointer;">
                <%-- <p>${(initMap.userInfo.attention==1)?'已关注':'关注'}</p> --%>
                <p>${(initMap.userInfo.attention!=0)?'已关注':'关注'}</p>
                </div>
				</div>
					<dl>
						<dt style="position: relative;">
							TA关注的人<i class="icon-menu"></i>
						</dt>
						<dd>
							<div class="body">
                                    <ul class="group-user-list">
	                                    <s:iterator id="t" value="initMap.userList">
	                                   		<li style="margin-top: 0px;margin-bottom: 35px;">
	                                   			<a href="javascript:void(0)"><img style="width: 82px;height: 82px;display: block;" src="${t.userImg}"></a>
	                                   			<%-- <span>${t.userName }</span> --%>
	                                   			
	                                   			<s:if test="#t.userName.length() gt 5">
	                                                <span title="${t.userName }" style="cursor:pointer;"><s:property value="#t.userName.substring(0,5)+'...'" /></span>
                                               	</s:if>
                                               	<s:else>
	                                               	<span title="${t.userName }" style="cursor:pointer;"><s:property value="#t.userName" /></span>
	                                            </s:else>
	                                   			
	                                   			
	                                   		</li>
	                                    </s:iterator>
                                    </ul>
                            </div>
						</dd>
					</dl>
				</div>
				<div class="right">
					<iframe id="childrenMain" name="childrenMain" scrolling="no" marginheight="0" marginwidth="0" frameborder="0" src="decorateForwardAction.action?code=${pmsIndex.user_dynamimc.code}&paramMap.userID=${paramMap.userID }&paramMap.isShare=1" width="715px"   ></iframe>
				</div>
				
			</div>
        </div>
       </div>
       </div>
    <script src="qc/js/jquery-1.7.2.min.js"></script>
    <script src="qc/js/tweenmax.min.js"></script>
    <script src="qc/js/jquery.bxslider.min.js"></script>
    <script src="qc/js/scripts.js"></script>
    <script type="text/javascript">
    
    
    	
        $(document).ready(function () {
        	$("#childrenMain").height($(".left").height()+40);
            $(".rs-slider>ul").bxSlider({
                controls: true,
                nextText: "",
                prevText: "",
                auto: true,
                autoStart:true,
                prevSelector: "em.rs-prev",
                nextSelector: "em.rs-next",
                pager:false
            });
            
            $("#attention").hover(function(){
            	if($(this).attr("attention")==0){
            		$("#attention p").css({"background": "#e64747"});
            	}
            },function(){
            	$("#attention p").css({"background": "#ae9b84"});
            });
            
            $("#attention").die().live("click",function(){
        		var uid=$("#uid").val();
        		var currentUserId=$("#currentUserId").val();
        		var liObj=$(this);
        		if(uid==currentUserId){
        			alert("您不能关注您自己！");
        		}else{
        		var attention=$("#attention").attr("attention");
        		if(attention==0){
        			$.ajax({
            			url:		'ajaxAction.action?code=002032004001&paramMap.attentionType=add&paramMap.targetID='+uid,
            			type:	    'post',
            			timeout:	'60000',
            			data:	Array(),
            			dataType:	'json',
            			beforeSend:function(request){},
            			complete:function(request,textStatus){},
            			success:function(jsonData,textStatus){
            				if (textStatus == "success"){
            					//alert(jsonData.flag);
            					if(jsonData.flag>0){
            						//liObj.remove();
            						$("#attention p").html("已关注");
            						$("#attention").attr("attention",1);
            					}
            				}
            			}
            		}); 
        		}else{
        			alert("你已关注过此用户了！");
        		}
        		
        		 }
        	})
        });
    </script>
</body>
</html>
