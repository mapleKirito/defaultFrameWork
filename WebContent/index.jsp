<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<META http-equiv=Content-Type content="text/x-component; charset=UTF-8">
<title><s:text name="systemName" />
</title> 
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.js" type="text/javascript"></script>

<script type="text/javascript" src="PIE_IE678.js"></script>

<link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" />
<script language="JavaScript">

document.onreadystatechange = function () {
    if(document.readyState=="complete") {   	
    	document.getElementById('load').style.display='none';
        document.getElementById('info').style.display='block';

    } ;
};
$(function() {
	if (window.PIE) {
		$('.rounded').each(function() {
			PIE.attach(this);
		});
	}
}); 
jQuery(document).ready(function(){
	if(IEversion()<= 8){
	
		$(".page-login a.pl-logo ").css("top","20%");
		$(".userinfo").css({
			"padding-left":"50px",
			"width":"305px",
			"line-height":"60px",
			"text-indent":"0px"
		});
		}else if(IEversion()== 9 ){
		$(".page-login a.pl-logo ").css("top","40%");
		$(".userinfo").css({
			"padding-left":"50px",
			"width":"305px",
			"line-height":"60px",
			"text-indent":"0px"
		});
	}
	$("#load").css({
		"width":$(window).width(),
		"height":$(window).height(),
		"line-height":$(window).height()+'px'
	});
    jQuery("input").keyup(function(e){
            var keycode=e.which;
            if(keycode==13){                                
                 jQuery("#loginbutton").click();
             }
    });
});

function IEversion(){
	var browser=navigator.appName; 
	var b_version=navigator.appVersion;
	var version=b_version.split(";"); 
	if(version.length>1){
		var trim_Version=version[1].replace(/[ ]/g,"");
	}else{
		var trim_Version="";
	}
	 
	
	if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0") 
	{ 
		return "6.0";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0") 
	{ 
		return "7.0";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0") 
	{ 
		return "8.0";
	} 
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0") 
	{ 
		return "9.0";
	} 
}
function loginniu(){
	//alert(123);
	if(document.getElementById("account").value==""||document.getElementById("password").value==""){
		$("#msg").html("用户名或密码不能为空");
		return false;
	}
	//获取访问ip与端口
	var curWwwPath=window.document.location.href; 
	var pathName=window.document.location.pathname; 
	var pos=curWwwPath.indexOf(pathName); 
	var localhostPaht=curWwwPath.substring(0,pos); 
	
	
	var heiht_img = $(window).height()-158;
	var width_img=$(window).width()-400;
	var currentTime= new Date().getTime();
	$.ajax({
		url:		'ajaxAction.action?code=-100&paramMap.account='+ document.getElementById("account").value +'&paramMap.password='+ document.getElementById("password").value+'&paramMap.IP='+localhostPaht +'&paramMap.width_img='+width_img+'&paramMap.heiht_img='+heiht_img+'&paramMap.logColumn=s_userLoginAccount,currentDate&suiji='+currentTime,
		type:	    'post',
		timeout:	'60000',
		data:	Array(),
		dataType:	'json',
		beforeSend:function(request){},
		complete:function(request,textStatus){},
		success:function(jsonData,textStatus){
			if (textStatus == "success"){
				if(!jsonData.is2){
					if(!jsonData.is3){
						if(jsonData.is4){
							$("#msg").html("用户名不存在");
						}else{
							if(!jsonData.is1){

								 var url=window.location.href;
							 	 var startoint = url.indexOf("//");
							 	 var endPoint = url.indexOf("8086");
							 	 var ip= url.substring(startoint, endPoint+4);
							 	
							 	if(jsonData.is5 == 1){
									window.location.href = '<%=request.getContextPath()%>/flash/flash.swf?&suiji='+currentTime;
								}else{
									window.location.href = '<%=request.getContextPath()%>/forwardAction.action?code=-1700&paramMap.flash=0&id=0&suiji='+currentTime;
								} 
								
									
								
								//于齐紫   修改   不需提交

							}else{
								$("#msg").html("用户名或密码错误");
							}
						}
					}else{
						window.location.href = '/dm/overclick.jsp';
					}
				}else{
					window.location.href = '/dm/overtime.jsp';
			}
			}
		},
		error:function(request,textStatus,error){}
	});
}
</script>
<style type="text/css">
</style>
</head>
<body class="page-login rounded">
<input type="hidden" name="code" value="-100" >
<div style="font-size: 20px;text-align: center;color: white;" id="load"> 加载中,请稍后。。。</div>
<a class="pl-logo"><img src="images/his/biglogo.png" width="221px"  /></a>
<div class="pl-form" id="info" style="display: none;">
    <div class="pl-form-inner"  >
       <div class="pl-input"  >
            <input type="text" name="paramMap.account" id="account" class="userinfo" placeholder="用户名"   />
            <input type="password" name="paramMap.password" id="password" class="userinfo"  placeholder="密码"   />
            <input class="pl-button" type="button" id="loginbutton" onclick="loginniu();" value="登录"   />
            <i class="pl-input-people"></i>
            <p><a href="commonForwardAction.action?code=-1501"  >忘记密码</a></p>
       
           
            <i class="pl-input-pass"></i>
            <p align="right">还没账号，<a href="commonForwardAction.action?code=-1401" class="red"  > 请注册</a></p>
            <p id="msg" style="color: red;"></p>
        </div>
       
    </div>
</div>
</body>
</html>